Return-Path: <stable+bounces-116641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD810A390EB
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 03:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE5B1703DB
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4454E78F43;
	Tue, 18 Feb 2025 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KXYlHIeW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE31482E7
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739846704; cv=none; b=GKjl2/cI4iicejOravSiStcJqbrH2YnTM28hvtBLU/d8N56S2XSZQzUEaxVUwyag7pCboR88836H3jwMWVw6kNZdZsMeREmZM3RkrZwGFfEE0DjxRVPXwPoSQVMXeY0lMe1RWkV8bRJMSx405nsZo3caiHsxnKSpsgu6dm2cK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739846704; c=relaxed/simple;
	bh=FfrSMdks29J56bBWhFo0SgrZ344Qa6aXAMYRHDoTys8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtdHfaqCSC6NkFji/qq9/W4FwGT8/JBzC4oMa8HB5Dakus7YktwJAJdn7l0xIAGafCcWp7gREBRAiEc4ilxMjFTB55QhM17OpyBVuyy8nq/VNSwJDxnWjeR6WhuogEzFqTjtdsTA/rWThacc5KYI6XvJ6/+hiAc4dIe9LXgw0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KXYlHIeW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c665ef4cso72512905ad.3
        for <stable@vger.kernel.org>; Mon, 17 Feb 2025 18:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739846700; x=1740451500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yTMGWcW8d0e2TXjwWXi9zu9zUfftqeqmHlv5rzR57Mo=;
        b=KXYlHIeWyWHqOSSdhizZgwYlGD9T4OV1TBfzsYF0+0OCiIQbR/LEiriOc13IX73Nb4
         9LAOo3E3Ah0iZ4KwOd+wscssH5zGoaGeRaLk3deYq7CTQOdmP+oMu3u4tb9WqF8fPt7s
         81p/ftvC2pkZTITYt+PdliZ7ojBSLS6TWxtwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739846700; x=1740451500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTMGWcW8d0e2TXjwWXi9zu9zUfftqeqmHlv5rzR57Mo=;
        b=NptL/XGcjjBHIdJjeBT07rNqgoB7gncmzj3bXyFs6Pzg18zmmhx3VCPRI6OeKPNZv4
         pZl0ps3jaB5t7YYSpiOgw1cbLLFFBxVlpOQZgDwrex8qQLV91gAlIRd0h0ZR4wrmMebU
         C+YpPrvJO5U3diYj2gt01rRpCNICmffPd05US2KrHMMes3hheASDTMkJjxlYKHHIDLzH
         hGJOhPm5EXE4itsfCKx5D0Vta4wYG6Ok1tXSnWTtfNzWwhvrqfzFE5hW2h7NPc6BIVXa
         kMKG1lvMlGx1pMOWe6CZTJosmuHYo8p0ifpVprv8HpwHkY2euDjbmTooWdz4NwQm7eF6
         N5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEmVi5evT/++iqmN6SAkhlGf6N04SeFP2vUv9qF5YoppwnkmiVpUZT+pd9cutLLBXaflqERw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6AkWw48H4Qcf7BpMeJTHbxTQ9xW8sFUxzVuWVAVuOyofrwu++
	BCjb5KvcuMocXHb/vPqBFIknw+EigFoV7YtY6JHqJILyEXecPD7e5ni+XlJpMw8iJjAGS6VYjsp
	sUe6mJls3o6/wz6MH7Lb2qUG58AIjtuz6FNDU
X-Gm-Gg: ASbGncuvTSVPqqal4PI9zGA2VaBm4gzzUNK3YSXqwdJSm9P+VuLkmbPAcxagoi9XTh1
	Z6x7YJTEksxkn/hQeu7fLxNHjnBMUMQLOvHIlAiMWCc7JpQnpwYyx/KCIJTRq1Xss2dqK3MHmWw
	==
X-Google-Smtp-Source: AGHT+IHsgCgSm6nNg/txskIzPw5zW0u+BpByI87vZVJqw2vjhWcaYVR+RDYdoxGsO9EBsPszjEqfbHys3Yw2z0rS43E=
X-Received: by 2002:a05:6a21:6da7:b0:1ee:5d05:a18f with SMTP id
 adf61e73a8af0-1ee8cc25a7cmr22275576637.35.1739846700487; Mon, 17 Feb 2025
 18:45:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218011744.2397726-1-haoxiang_li2024@163.com>
In-Reply-To: <20250218011744.2397726-1-haoxiang_li2024@163.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 18 Feb 2025 08:14:49 +0530
X-Gm-Features: AWEUYZmy3Rk5IKS-p-8AmZQjs7wZFdI2edboezs4Z5so68a2cH5u9tcTn-tnvmc
Message-ID: <CAH-L+nP5w7hRbONxPNG7NJtJzb-A0JOEMSq1hKNepM9GpFkt-g@mail.gmail.com>
Subject: Re: [PATCH v2] nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: kuba@kernel.org, louis.peens@corigine.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, qmo@kernel.org, 
	daniel@iogearbox.net, bpf@vger.kernel.org, oss-drivers@corigine.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000090db94062e61a025"

--00000000000090db94062e61a025
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 6:49=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.co=
m> wrote:
>
> Add check for the return value of nfp_app_ctrl_msg_alloc() in
> nfp_bpf_cmsg_alloc() to prevent null pointer dereference.
>
> Fixes: ff3d43f7568c ("nfp: bpf: implement helpers for FW map ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - remove the bracket for one single-statement. Thanks, Guru!
> ---
>  drivers/net/ethernet/netronome/nfp/bpf/cmsg.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/=
ethernet/netronome/nfp/bpf/cmsg.c
> index 2ec62c8d86e1..b02d5fbb8c8c 100644
> --- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
> +++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
> @@ -20,6 +20,8 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned in=
t size)
>         struct sk_buff *skb;
>
>         skb =3D nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
> +       if (!skp)
> +               return NULL;
It looks like you did not compile this change.

Also, next time you push a new version, please modify the subject as:
"[PATCH net v3] xxxx"
>         skb_put(skb, size);
>
>         return skb;
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh AP

--00000000000090db94062e61a025
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
AQkEMSIEIOJYaTfb/q6TQz9E0jZB6K1GoH+C3oW4TtVP2hbSJtLpMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIxODAyNDUwMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAl3iTWxMLr
qU7RGfuZzuM/pGrUT5NZbyX83GtqUbLz6kOlyeYfa+i+vv3W6N+fRJUkFaotJ9Y/kxWrV6s/wt/f
60YMPLEL+zDpDRsDSz+ORHhqHsLqHh9lMxgfUdOMVNP85MEtZPb4d+6HXA3XV21M/JH6vHYzylzx
vzxKbmxuixHCsQo1pkRXrwyLhSImaLXVLnPTGKKRMfxBsfcv+bJJCWOu1Jg/yK/8Apu2B2zkLnVs
BznEqB97n265GQvJZpC1jcu9TSHkTauv/Sz73j0l0ntdqf6wHhnTECBBHTMKH91j3UhNiogZ0HpJ
EIVReC+14wZOzV/nIPl3MdjDccoz
--00000000000090db94062e61a025--

