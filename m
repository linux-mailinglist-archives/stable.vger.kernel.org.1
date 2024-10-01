Return-Path: <stable+bounces-78310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86798B2B0
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 05:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0670C282417
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 03:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D018DF98;
	Tue,  1 Oct 2024 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J5QQpdva"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF018C925
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727753208; cv=none; b=JHK1dJLAuN+LlaqhL65SSc4HoCAsS/LXgFNORH0hc4VCnbncGm94jXRJo7Cc722BbCisBSbDszbHL8xblLsmr0UEiYXl3nxuhfMQ6fRF745TTY9s/9bXmYD9oHIixN0gwK36QXHvUsZbf3Vzaqru24zvcNDv+UhsnNKvwQ3Ujhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727753208; c=relaxed/simple;
	bh=B0le+i927WUErFlKdrUkvytl4gDaMhosIIRpruj1VPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdQtwnrlSGReiTVSHO0u5RbA4LltfLPMZdC8rhAAfvavh8fp7rk6TdHd+uBsGcm+VxzHi887lM+xwBoTGFGtl+cbWYyE+LfH0RSlnYRRYd+aEGjpv2ZzpZBc23MpmHs7r+ce+DPq0Z8zukIrZA1YGCyXti/WXsLhrlmNUgQwUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J5QQpdva; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5399651d21aso1363681e87.3
        for <stable@vger.kernel.org>; Mon, 30 Sep 2024 20:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727753203; x=1728358003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0le+i927WUErFlKdrUkvytl4gDaMhosIIRpruj1VPg=;
        b=J5QQpdvawtrbRrcdkSFLylcC2XFuxvpqR8gn48lhWm1BWpaE5ccZuDbDBQWyx3K7CZ
         Q0/mhmtY5r3HWQQs5JNy0MSohK0QRXh6egvwVbynyphsmeRO2VKToSXdgIO8niFmRUu4
         cr+zL5pf1kC9qeDTiDqvbrS0H7CFm4TCA8BbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727753203; x=1728358003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0le+i927WUErFlKdrUkvytl4gDaMhosIIRpruj1VPg=;
        b=DykSua4u5A44iCibl1Ecu5HAGirnencsUmphULfJBKNHgSkcT/CPQsDhuUpVbHy4Zl
         pb88axNy+SPgvepWi+28QEcL+LE99K/VQuXTePWerDG41TXqwQVImD3gi6Z92lWhVasG
         Zj5xm9Nwmm4fWJfCGQRD8vxlOKaYBlxFvGFsDmdOtlbDZTV5QYqqSbvIUkwHUiI6BvM0
         ywbwaa+5WGDAqtpv+Z74/sNItG7AIku+LxTWiVRa4pmOQDqdft5RD6s8psqzjlrEIJyy
         emVHPpZT75UtgxBLyp62R6MpSpBCKnS5WgOP+f3VEATnqqGeZzyahEqTjd2zMdG979qf
         ocJg==
X-Forwarded-Encrypted: i=1; AJvYcCXJEr6suxJdB8bnsMc/8hqdSRErlhVxnni433BRWg5rm6P77eSM6TGrSfPA05tVedKTDjgJ6WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvcku6UWzGl1Zk6dwoBp6IXEt6SOnW7vvJMgR349pvfnSArfm
	xzX9zSRu3PW/Wekm76FLqPC9vk3bcd/kNRoWe+9bOBg/y3bumbiienQiWEftJOg1VpElhQ+7M89
	EoVIWyA8fSKlPPiLtUj8GPo1Iihh1mYsug+Ti
X-Google-Smtp-Source: AGHT+IGPb7MBxKSdWklA8ZLGLRxF+phmFlMDd6aJYIP2o+oVSFu24s48nicURMzUM/QjfJdP3TrmKU7XI66jCVKhSU0=
X-Received: by 2002:a05:6512:158d:b0:536:545c:bbf6 with SMTP id
 2adb3069b0e04-5389fc30e6dmr6875426e87.1.1727753203486; Mon, 30 Sep 2024
 20:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com> <20240930223601.3137464-4-anthony.l.nguyen@intel.com>
In-Reply-To: <20240930223601.3137464-4-anthony.l.nguyen@intel.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 1 Oct 2024 08:56:31 +0530
Message-ID: <CAH-L+nP1kQWV9asJNFrw-pdxw64aAL6Mi8MnOgRA2NubfL0iWQ@mail.gmail.com>
Subject: Re: [PATCH net 03/10] ice: Fix improper handling of refcount in ice_sriov_set_msix_vec_count()
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, 
	Gui-Dong Han <hanguidong02@outlook.com>, baijiaju1990@gmail.com, stable@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Rafal Romanowski <rafal.romanowski@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fb98a9062361e3ab"

--000000000000fb98a9062361e3ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:06=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel.=
com> wrote:
>
> From: Gui-Dong Han <hanguidong02@outlook.com>
>
> This patch addresses an issue with improper reference count handling in t=
he
> ice_sriov_set_msix_vec_count() function.
>
> First, the function calls ice_get_vf_by_id(), which increments the
> reference count of the vf pointer. If the subsequent call to
> ice_get_vf_vsi() fails, the function currently returns an error without
> decrementing the reference count of the vf pointer, leading to a referenc=
e
> count leak. The correct behavior, as implemented in this patch, is to
> decrement the reference count using ice_put_vf(vf) before returning an
> error when vsi is NULL.
>
> Second, the function calls ice_sriov_get_irqs(), which sets
> vf->first_vector_idx. If this call returns a negative value, indicating a=
n
> error, the function returns an error without decrementing the reference
> count of the vf pointer, resulting in another reference count leak. The
> patch addresses this by adding a call to ice_put_vf(vf) before returning
> an error when vf->first_vector_idx < 0.
>
> This bug was identified by an experimental static analysis tool developed
> by our team. The tool specializes in analyzing reference count operations
> and identifying potential mismanagement of reference counts. In this case=
,
> the tool flagged the missing decrement operation as a potential issue,
> leading to this patch.
>
> Fixes: 4035c72dc1ba ("ice: reconfig host after changing MSI-X on VF")
> Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>



--=20
Regards,
Kalesh A P

--000000000000fb98a9062361e3ab
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIFzbvnvDmxJvk2GhALdeItGMaRVkiqd+RgaEljJXoftwMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAwMTAzMjY0M1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCwUQsSOq38
KMRpdcb6E1md6i2bASLJfLDJ655KrFo5XAyHA4Oct36fgV0U4VLWpRdfYiIReF0E39MywhrCA5sS
SlFxmShbFB6OkIklIhNwhulTEo9DmZQVxXCLmIBLBVY34E9Q2ZlluX2vapnN66n3tycFkzF1XiWY
TYRoqJIYhMIR7l3e/PF2upKsWhTJ2K2a1YfaovtF71Ar75cvFV+UXeApkqiWiQNGot/dWNPlGzJD
BWZLD4uGWhPbBJQKuvlWrOvOZxSVKQkp1uRqPdu2iLwHgSRRVC4fTFbGEAIX5VX+tyz6y7v/kPNo
faNAPPiXIgCxYl9Tjqc1Xc4fImxh
--000000000000fb98a9062361e3ab--

