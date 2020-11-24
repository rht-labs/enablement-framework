{{- define "gitlab.ldap.port" -}}
{{- if $.Values.gitlab.ldap.port -}}
{{ $.Values.gitlab.ldap.port }}
{{- else -}}
{{- $ldap := (index (lookup "config.openshift.io/v1" "OAuth" "" "cluster").spec.identityProviders 0) -}}
{{- $protocol := regexFind "^ldap[s]*" $ldap.ldap.url -}}
{{- if eq $protocol "ldap" }}
{{- print "389" -}}
{{- else -}}
{{- print "636" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "gitlab.ldap.base" -}}
{{- if $.Values.gitlab.ldap.base -}}
{{ $.Values.gitlab.ldap.base }}
{{- else -}}
{{ $ldap := (index (lookup "config.openshift.io/v1" "OAuth" "" "cluster").spec.identityProviders 0) }}
{{- $ldap_base_dn := regexReplaceAll "^ldap[s]*://" $ldap.ldap.url "${1}" | regexFind "/.*" | trimAll "/" | regexFind "^([^?]+)" }}
{{- printf "%s%s" "cn=accounts," $ldap_base_dn -}}
{{- end -}}
{{- end -}}

{{- define "gitlab.ldap.uri" -}}
{{- if $.Values.gitlab.ldap.uri -}}
{{ $.Values.gitlab.ldap.uri }}
{{- else -}}
{{ $ldap := (index (lookup "config.openshift.io/v1" "OAuth" "" "cluster").spec.identityProviders 0) }}
{{- regexReplaceAll "^ldap[s]*://" $ldap.ldap.url "${1}" | regexFind ".*/" | trimAll "/" | regexFind "^([^:]+)" }}
{{- end -}}
{{- end -}}

{{- define "gitlab.ldap.user_filter" -}}
{{ $.Values.gitlab.ldap.user_filter }}
{{- end -}}

{{- define "gitlab.ldap.encryption" -}}
{{- if $.Values.gitlab.ldap.encryption -}}
{{ $.Values.gitlab.ldap.encryption -}}
{{- else -}}
{{ $enc := include "gitlab.ldap.port" . }}
{{- if eq $enc "636" -}}
{{- print "simple_tls" -}}
{{- else -}}
{{- print "plain" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "gitlab.ldap.bind_password" -}}
{{- if (lookup "v1" "Secret" "openshift-config" $.Values.gitlab.ldap.secret_name ) }}
{{- print (lookup "v1" "Secret" "openshift-config" $.Values.gitlab.ldap.secret_name ).data.bindPassword | b64dec -}}
{{- end }}
{{- end }}

{{- define "gitlab.ldap.bind_dn" -}}
{{- if $.Values.gitlab.ldap.bind_dn -}}
{{ $.Values.gitlab.ldap.bind_dn }}
{{- else -}}
{{ $ldap := (index (lookup "config.openshift.io/v1" "OAuth" "" "cluster").spec.identityProviders 0) }}
{{- print $ldap.ldap.bindDN -}}
{{- end -}}
{{- end -}}

{{- define "do500.app_domain" -}}
{{- print (lookup "operator.openshift.io/v1" "IngressController" "openshift-ingress-operator" "default").status.domain -}}
{{- end -}}

{{- define "gitlab.root_password" -}}
{{- print (randAlphaNum 10) -}}
{{- end -}}

{{- define "gitlab.postgres.user" -}}
{{- print (randAlphaNum 10) -}}
{{- end -}}

{{- define "gitlab.postgres.password" -}}
{{- print (randAlphaNum 10) -}}
{{- end -}}

{{- define "gitlab.postgres.admin_password" -}}
{{- print (randAlphaNum 10) -}}
{{- end -}}
