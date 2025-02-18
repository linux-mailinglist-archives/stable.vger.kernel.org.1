Return-Path: <stable+bounces-116652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5844FA39161
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 04:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6426D18865A1
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 03:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D1186295;
	Tue, 18 Feb 2025 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OtJJqPat"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D2B17C77
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849991; cv=none; b=XRH3j8SOrwoQn5+VfyouvT5DLO7O8FMyWKXSAyUd5G+71WQq+ekll3SdALCEaOJfd5d1SBSv1UahZGQq9iuB+GSJynDPw/Ss8RVI2RDb8YVbFO0SJ1TrWHvkaSMVBfGgAzfZxJQzGkHFNQpWw5PF2YO9UfQzBWPyEPOX+c8bvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849991; c=relaxed/simple;
	bh=W/ic38uQBT84QtIWa2M9han5NMpIHQESZqLcvdalbyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6eYmgdjC4K1kh/mGkR4Jt7vZ8NK0xUanOUj7z+AIEabVMXcyUZ+n1ia/8dtgV3p3koYaqqXJ6IhuSCooDiEJE6PQiBqRUZfGb2x7CKgpD8nJqis/rbeQouTW1mBENAU2dEskRccjPGl4mSUw/oaKh6ynoZhKO6lloh/C6Z+56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OtJJqPat; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-521b1b8cdb6so262189e0c.2
        for <stable@vger.kernel.org>; Mon, 17 Feb 2025 19:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739849988; x=1740454788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qjmw5Rm4KYZA71wMiijLi2JH14HWbP3oSUSVV8yJPws=;
        b=OtJJqPats6SaaAfv3bFERIOc3Xzs1FJ8yHB1eb8RnptVw/Fn+OHisT+pqPFkiSlPYm
         EK9fRWkjtw8KK0+lc5X/VAXo7G6uMgehXy53zyX3v+RiAv+mtXLCqJPlRlskpeTrcKaP
         ByOcsWk0HYWzzDNziIOYU6bg++85FNmURjlSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739849988; x=1740454788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjmw5Rm4KYZA71wMiijLi2JH14HWbP3oSUSVV8yJPws=;
        b=nco8ARhVNJ6sIJqelZj2tOYO3/dZkFFoc4cWXxu8J/hOQY/qFLCxtrZfT1jYuQk6nQ
         e8F519U5aqA1iL9tUCKeQpiRLcTbp2+KzCbLfoy+kd6NjJ0GuGNoFwfmV6zImyqRArev
         ab9Pz8+UITRepSc1DeuftIGNdmT8HZHamOVKW+2tw6mGxLA4pbMVZEF3EthPeC8qttqW
         vYHwUvVLWW3uffnB8zs7sUSb+SdH3FIo66t5kqsKz9+7FSK7CtCIhqiH9CgqUTn39Kds
         j6q2FLCqboQLG7IvXpjyGUQbeW3JkZY3qfmGPbCpdR7myU7hdSNkkpq6URfdCjuLkzEW
         FzSA==
X-Forwarded-Encrypted: i=1; AJvYcCW3vXCFd07U0lCv2Q/uHUxigN76DxJ244yc2lgeVK26gs8PSMyBlP3lqneh8HhRpAIxlbiiU2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2URi8YXuWq4XsaDYunmvZmZo/7cBDA+u6ujjcH6abrX36Gdt
	nDUBYYsI0eiPtOlDGobOrZeFst4yK6/YwyRnhuSE5XigTBBAci1Ab57zYhd4sw1Kg+wwVeMVh7p
	brb+gmWW7tY1nWQJGFccwRrYLsuIoW8sFrh3H
X-Gm-Gg: ASbGncsEtgSqK8fP9fRUb4SjlxG8C9YhgPOO8HJOQVdfnNf5yaciYnQQ7eBaNbSEYL9
	JiaijqPnQUfh9LTJZaHwcz+oT0kPRL1hZsmHFlxGbcM0y2kdAdBQv/mMIRgUtiiUoamY070ml9Q
	==
X-Google-Smtp-Source: AGHT+IGGfqQH2vJHuqpI3ZMLBNLypMfkPudXXq+FQ9pZyzdAjlk/phz14/ygY0ILOg03U7l1Rfseilm3e+SRIb5L3IY=
X-Received: by 2002:a05:6122:338b:b0:520:5f0a:b5a5 with SMTP id
 71dfb90a1353d-5209dd94048mr6299968e0c.6.1739849987974; Mon, 17 Feb 2025
 19:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218030409.2425798-1-haoxiang_li2024@163.com>
In-Reply-To: <20250218030409.2425798-1-haoxiang_li2024@163.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 18 Feb 2025 09:09:35 +0530
X-Gm-Features: AWEUYZmCS5ROY9SnA4yvR_D28IBkvxGjovMHfqichKVoslhSPwH890y6meTGNRk
Message-ID: <CAH-L+nNhDaGLPbA5hLNjbRw2m8aF5BP8-P3rURxoGRJTrVYdiA@mail.gmail.com>
Subject: Re: [PATCH net v3] nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: kuba@kernel.org, louis.peens@corigine.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, qmo@kernel.org, 
	daniel@iogearbox.net, bpf@vger.kernel.org, oss-drivers@corigine.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000869ea1062e6264ed"

--000000000000869ea1062e6264ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 8:56=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.co=
m> wrote:
>
> Add check for the return value of nfp_app_ctrl_msg_alloc() in
> nfp_bpf_cmsg_alloc() to prevent null pointer dereference.
>
> Fixes: ff3d43f7568c ("nfp: bpf: implement helpers for FW map ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v3:
> - modify a spell error. Thanks, Kalesh!
> Changes in v2:
> - remove the bracket for one single-statement. Thanks, Guru!
> ---
>  drivers/net/ethernet/netronome/nfp/bpf/cmsg.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/=
ethernet/netronome/nfp/bpf/cmsg.c
> index 2ec62c8d86e1..59486fe2ad18 100644
> --- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
> +++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
> @@ -20,6 +20,8 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned in=
t size)
>         struct sk_buff *skb;
>
>         skb =3D nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
> +       if (!skb)
> +               return NULL;
>         skb_put(skb, size);
>
>         return skb;
> --
> 2.25.1
>
>
You should wait 24 hours before posting a new version of the patch.

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-revi=
ew

--=20
Regards,
Kalesh AP

--000000000000869ea1062e6264ed
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
AQkEMSIEIMD7ApcbSV+YDQnhB0wthBkvSD31B2OQyXY35ZeriZiEMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIxODAzMzk0OFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA7cRO/xZwq
VI5PcZfvfXEhsJic39ggLPUU85V8ZKgBpKqGugiRF6MknudPC9/DFrPyF046LLWxA5wkWFUbf1Du
7dwvz8JWRP+dnGef6EoGPHaeKkmTRJusHXAfBNihoa+1zdTUOuKAJK5QuMXvZKTN09lJrx+HUGaN
UEwkyi66aLnOf6sBc5DeumnRH2e5XF4diqr/htHPZIU1SJT4mJ5EXTpS/YdtWUSSi2SffSdOKXNx
X2GWNt/GdXR4wj1D7e39Q6Ybwkxftit9qz5eto1HqYAomnjv1Y0jNUy/TMiGDI/fnJGMTzpozLid
Nqx+eyfQI2sG1AjElR6eSLff11mV
--000000000000869ea1062e6264ed--

