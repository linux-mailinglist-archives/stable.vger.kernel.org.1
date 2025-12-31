Return-Path: <stable+bounces-204367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8871CEC360
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 17:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B75B300C6E2
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D96217F31;
	Wed, 31 Dec 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UL2jx5o0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA91B0F19
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767196875; cv=none; b=frNz4koQ9OMfeJGeX6SuqqrHFDUZ3f1XRVkRDl/AOndmvRcv1fvTwwjmEWYO4ujKzvM10UF6ufmYoKN0JI5q7ipVKCn6+RhGmpRSWfgK4Rn5pRpV3JjyVkQBn7ONIiiuH75Tdr8Ve1OiYoU2LbmQn06f/hqRLDzkHRt4sbaNrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767196875; c=relaxed/simple;
	bh=Tz0akB7zNAb0PCPVIrDJZ1hN6RATQyizPnDXEW1CxOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbgc3qza7JRwyBylZogKvq9mzqJqwGJZejOo+F6xGw238wmHJn9ITR/3GZ4VOp4xDZzyY2q2KHqUUg51Y9sowgcrGK/eC7c5c52XRGKGHjFqKl4xRpVZNn0w9q833fzHR8CajvBb9rb/rnnohHrLSMRqklfj04t1YVk+hPE71Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UL2jx5o0; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a1388cdac3so101124715ad.0
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 08:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767196873; x=1767801673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxfw85Cwm4oyhD774x0PGA8LRbhpSJan2F10V2TOmfE=;
        b=dva3DI9gmmDLpqoZrDikOen6yZmxypPmpAGZs6xz/DEPRI4ROTIIbnB+3LLp/rQPy7
         qWRfh5Wm6sESdGbc+Ba6l2XMTH8w+eisRoH1ccA1kkTkC0Qb++iqlLUC491nD6dP+Ueb
         417qwW4EaImKcc9CNkdyIxp9UbBPm8PHSSPmlnQxaof5hZPVuyfoInYi3Naa7i1FDsuk
         eQFXV/0HElosOB2s5zA3GT9p5h9MBBerXK+WaixPEdLAnAQqPXUgL8Hc8U2wx/An7zjj
         MLcCZVIkOfGrnhUF5s1KvhAuLjyVxcsRSWpdKNlzhUNLmm/uOUX+Xi1zOkXDnvDX2mM9
         Xbtw==
X-Forwarded-Encrypted: i=1; AJvYcCUCuETfaLUxD0Ia2/ZyzFby0a7laFE/og17PA33S31/16ogKG+vYjPUUAjMvEr+OdJmbYyQjGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbcpEoUqn6YTB9DadHRLdW2gDrtIhdacs1YIJWtd3mAMW8gi8P
	fdQmaTtwebozPFYMnHpwiGWnFYvl4SUmmm4w9mLsRinM5GfRmIbJxZxu3okAdbfhKYGIJ7qhjKV
	ztElC5aVMdrxMRSNe0nTbjNmFK/pyqQ3w50TDHkAj2ME4DQQ8Nk+lyX8dXm9Ces933yK0WRUdTI
	79ntUGcl8ZdxXe+2YiCJtq/Z14zFvi8wboMsZKPh0zmWI7bKVHawscdQd7fGM62OqrYK1mDvauO
	0TvX7manEw=
X-Gm-Gg: AY/fxX5ZFwyubCCp/oEtIwqOD4p2US8Yay2lPp0BQrle66UlKFpVc0eVLPefToGSfqD
	P2jqJgpX7JtpuKv2Vlo0s1TaUGS95MSRFMHMWT2zplHDuR2KL54ByVT7dOS2F116X/LHq7aasbG
	vkXEGQKf0dgS82LJOUf2RbvBLB9ht88Ol8j6R2mS06s2HKB1d9XT3wl3YG7YyM6LPOQlLLG+OaO
	dqMbYePdS/1OnfaAgWNhFQ1uCtn4BSClx1gL9VqgKMt/tFa6Dyqu1lmshLDmawaPOAr+n9udQ2k
	/oBJIBvpBqdhFm4//5rDdgNwNdYv2gWUWQ40XrPi1Es+GdPTfYahiQaBNjRXJ9RoPtt+eUq/fYs
	R7Y8VfSBPi2yxA4nc8vERZcuNgc4o4Yp1SVHwEN9pZetsNCjoz/BrCopj3u3MOIVGAGC0Cc7+XD
	5/S/HO/6PK9n2rH9PPdR75veuoM9fy27g2wqwKjQu2SJ+d83I=
X-Google-Smtp-Source: AGHT+IG5V48ek2EVokzjqqqqTvSLSp3ERd8nSuEUAJ65+m4VabndOn+jtAv3GWUj4IhlPm5iTcBPi8OsNv5t
X-Received: by 2002:a17:903:2a8e:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-2a2f2426c79mr368320225ad.14.1767196872764;
        Wed, 31 Dec 2025 08:01:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3c7ffdbsm40430175ad.19.2025.12.31.08.01.12
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Dec 2025 08:01:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so23006351a91.3
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767196871; x=1767801671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kxfw85Cwm4oyhD774x0PGA8LRbhpSJan2F10V2TOmfE=;
        b=UL2jx5o0Dtbz61qXI2GQkyLziyzuHMdVzhw8gOdGFkQpZ+7+jrNivoyb233jbGuKjr
         FgqoiT4bsx3RliLM6SOWkqZsiRJQHPsZvlTNP76pdzYBmNq13e7InLS6v9Abxf63HKgK
         fmD1Cz8v3MgyOh85VuLU3mTz2WDrzCpXgUJUo=
X-Forwarded-Encrypted: i=1; AJvYcCXaJbdUmjU8U53Kn2ZxJ379vEVo+5xoewtQIOTD8q5OfIUykmjjKn+2c7JqN0y7/KSc8SPEE+Q=@vger.kernel.org
X-Received: by 2002:a17:90b:2251:b0:340:ad5e:cb with SMTP id 98e67ed59e1d1-34e9212f362mr31347245a91.8.1767196870292;
        Wed, 31 Dec 2025 08:01:10 -0800 (PST)
X-Received: by 2002:a17:90b:2251:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-34e9212f362mr31347171a91.8.1767196869587; Wed, 31 Dec 2025
 08:01:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-bnxt-v1-1-8f9cde6698b4@debian.org>
In-Reply-To: <20251231-bnxt-v1-1-8f9cde6698b4@debian.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 31 Dec 2025 21:30:57 +0530
X-Gm-Features: AQt7F2qBxre4gEx9lPoKL50XL6gs5aq-TJTnGLJtW2nYJSF0T9B6CCzo6Tdrpo4
Message-ID: <CALs4sv2qQuL0trq3ZB6SczPK5BmFMF6p2Ki-3q+4Xqc_qzauoQ@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
To: Breno Leitao <leitao@debian.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c45c830647419500"

--000000000000c45c830647419500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 6:35=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> When bnxt_init_one() fails during initialization (e.g.,
> bnxt_init_int_mode returns -ENODEV), the error path calls
> bnxt_free_hwrm_resources() which destroys the DMA pool and sets
> bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
> which invokes ptp_clock_unregister().
>
> Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
> disable events"), ptp_clock_unregister() now calls
> ptp_disable_all_events(), which in turn invokes the driver's .enable()
> callback (bnxt_ptp_enable()) to disable PTP events before completing the
> unregistration.
>
> bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin()
> and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
> function tries to allocate from bp->hwrm_dma_pool, causing a NULL
> pointer dereference:
>
>   bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized): bnxt_init_in=
t_mode err: ffffffed
>   KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
>   Call Trace:
>    __hwrm_req_init (drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c:72)
>    bnxt_ptp_enable (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:323 dri=
vers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:517)
>    ptp_disable_all_events (drivers/ptp/ptp_chardev.c:66)
>    ptp_clock_unregister (drivers/ptp/ptp_clock.c:518)
>    bnxt_ptp_clear (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1134)
>    bnxt_init_one (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16889)
>
> Lines are against commit f8f9c1f4d0c7 ("Linux 6.19-rc3")
>
> Fix this by checking if bp->hwrm_dma_pool is NULL at the start of
> bnxt_ptp_enable(). During error/cleanup paths when HWRM resources have
> been freed, return success without attempting to send commands since the
> hardware is being torn down anyway.
>
> During normal operation, the DMA pool is always valid so PTP
> functionality is unaffected.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable event=
s")
> Cc: stable@vger.kernel.org
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index a8a74f07bb54..a749bbfa398e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -482,6 +482,13 @@ static int bnxt_ptp_enable(struct ptp_clock_info *pt=
p_info,
>         int pin_id;
>         int rc;
>
> +       /* Return success if HWRM resources are not available.
> +        * This can happen during error/cleanup paths when DMA pool has b=
een
> +        * freed.
> +        */
> +       if (!bp->hwrm_dma_pool)

Thanks for the fix. While it's valid, just that to me, this check here
looks a bit odd.
Why not call bnxt_ptp_clear() before bnxt_free_hwrm_resources() in the
unwind path?

> +               return 0;
> +
>         switch (rq->type) {
>         case PTP_CLK_REQ_EXTTS:
>                 /* Configure an External PPS IN */
>
> ---
> base-commit: 80380f6ce46f38a0d1200caade2f03de4b6c1d27
> change-id: 20251231-bnxt-c54d317d8bfe
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>

--000000000000c45c830647419500
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAg1up4
mHRndmcHxBrnE/tmOpkSJTeYq0ao2c2XXUG3WDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEyMzExNjAxMTFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAYR4SS18tc1WZyR8mAKg1g5EkJo/oUDV2qyKrY97vA
LbW8HJoXRAylD+CrORoezQwBw4BFS3W61mJKOxiPEgB+H3AXsc5s5ksZ7KUFImw/hjBv+cjKld+h
i9K5a61cLLhaSH0iuz+ib/4ksv8k8avPqVYdNAktRYMsQLaF8rRmbf+tUIEErlmkywq+vwRJfBDF
TfdUsj/HN9b8g4bMP4HxmCdclMQhahYc6H2glROwIhqQxFRdJT/68xQzY6w34nbYPDg70WPK2vJx
qNpsO2saUhJJfRvkh9Vhdc8lOmZ3lly4Xa9KmXSxBECit/bw7SHR89tT5JSJvctPYzzSnKq9
--000000000000c45c830647419500--

