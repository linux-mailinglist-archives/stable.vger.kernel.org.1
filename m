Return-Path: <stable+bounces-89440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400639B81DB
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 18:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC856B230E9
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939D1C9DEB;
	Thu, 31 Oct 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cXfCp2IU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164C1C9B9F
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397258; cv=none; b=XuIIRmnuQQ9UdsQnc5HFzAouhRD9riONLAsGokFN9nFVkRcYO1TZUmDlYvmXdb0K5lhEk0bJHIFMJpYG4ufZuDGC8b6AL7DjJWNeTEM4gx46VI5OxLCVPPBr3tieCsM1vHvz3vZZSs85Yal+RdgZ3RD130w/12+SbWSogPQtKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397258; c=relaxed/simple;
	bh=VTFImBtjfa3Xbbp3wUMg7FyFbgsHm+DVI692PJ8fSzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2MDQXxNFY++2Qm86oSuofvsDmHLyl3czY90PBk42zi2C8AzoJEi1Vk0wQ6AbDcQVB/19q3keU2zAKtqXt6NbGx50z/Lj1LZS9sLRynHOuOi+JADAaPbS/jRxk7ElvvjWp5gGLxj2X9WgVlmSU+cDatV5t8V5gOn5B6K+XZ2vVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cXfCp2IU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso913780a91.1
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730397255; x=1731002055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzLeTFaQPU2zK2i8lwZ1wiywJneSl99jawTmnXVG05g=;
        b=cXfCp2IU/eI3LPppy4yljWvDQoNnxu2HripndaIRkJ3PwQX4lTepLXSJj2r6lnHcL8
         BaVAUZidAATrGbdjQ9Lrujf7C8x1XK+tIbgUWFrjJ82WWJmNutIhBBHm/J7NsKlDIxg6
         E2UJ0gc8KWxFRHM6nnkdU6Hv1hKVPj/PBnEjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397255; x=1731002055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzLeTFaQPU2zK2i8lwZ1wiywJneSl99jawTmnXVG05g=;
        b=UQ9sVOZKSEDZlOVkN/Qjpf0dGggVJmshUJr5WpQos0mK7tMALt4EuEMClOQvbhSpEv
         08whdd5WPPabUnhb+WhpOFoV8Bu0Z7gktsC3gT5NBk8E1Bs6A6Je6gu4MFFeCDkQo0WE
         /d3xGB2RHOxZQIXGkLe8emDnM1zxptwLRfjQMjmOZ1/bb1+7raR84mTXP8VjgJJRabzY
         s6S5V8ZcIV8qWb09qyeGM4rtvnOGU9jg6n/1oOH3MctOHv+2dVrZoJHQIjB3VGUl77ZO
         R8LH4bQ3+YrwwKipTAY5ev6hzfO7QE//tIN6RqwlEv15tV3+6MXQIDgj/HGx88bIXEOw
         2Bbw==
X-Forwarded-Encrypted: i=1; AJvYcCW71n731q21cGt3c5Rs04D3EE8xp4u9fgVo59bxBr725nXfo8bWsgB/EThKoaXwT6/8sJstrB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fq9EJXbwpFi63h6l5pCSsc0L+26geZDxiw/+aMXrH0yTkWFy
	eqvFFvByLbBoje3oTJ9D+vyh/ahcXW24dWk6PQK/YfcEysP8F+Q0bBYYy0NhLAEyxMY2JoLnToF
	CL4RdqLwiE7vlXVkOnzYOsTMZuM3Q6yCaurGo
X-Google-Smtp-Source: AGHT+IEdF3RPqy9UkvXszDP6R9LXbxBojRvFc+U2n5AuYQ3dPu3Hll7yZgkfqy6GHMvT4o1xP3uPwNq0etVaNYOj7hM=
X-Received: by 2002:a17:90a:a011:b0:2e9:2e69:ee10 with SMTP id
 98e67ed59e1d1-2e92e6a02dcmr7704912a91.19.1730397255195; Thu, 31 Oct 2024
 10:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031173232.1776-1-grurikov@gmail.com>
In-Reply-To: <20241031173232.1776-1-grurikov@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 31 Oct 2024 23:24:00 +0530
Message-ID: <CALs4sv0gjcu=ZTPY-CoHbJDErfGpytvriFNp1Sp5_jhaT4iuqQ@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: broadcom: Fix uninitialized lockal variable
To: George Rurikov <grurikov@gmail.com>
Cc: Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nithin Nayak Sujir <nsujir@broadcom.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c023120625c9816b"

--000000000000c023120625c9816b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 11:02=E2=80=AFPM George Rurikov <grurikov@gmail.com=
> wrote:
>
> I can't find any reason why it won't happen.
> In SERDES_TG3_SGMII_MODE, when current_link_up =3D=3D true and
> current_duplex =3D=3D DUPLEX_FULL, program execution will be transferred
> using the goto fiber_setup_done, where the uninitialized remote_adv
> variable is passed as the second parameter to the
> tg3_setup_flow_control function.

You mean the third parameter to the function.
BTW, does this argument not hold good for local_adv also?

>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 85730a631f0c ("tg3: Add SGMII phy support for 5719/5718 serdes")
> Cc: stable@vger.kernel.org
> Signed-off-by: George Rurikov <grurikov@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index 378815917741..b1c60851c841 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -5802,7 +5802,8 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, =
bool force_reset)
>         u32 current_speed =3D SPEED_UNKNOWN;
>         u8 current_duplex =3D DUPLEX_UNKNOWN;
>         bool current_link_up =3D false;
> -       u32 local_adv, remote_adv, sgsr;
> +       u32 local_adv, sgsr;
> +       u32 remote_adv =3D 0;
>
>         if ((tg3_asic_rev(tp) =3D=3D ASIC_REV_5719 ||
>              tg3_asic_rev(tp) =3D=3D ASIC_REV_5720) &&
> --
> 2.34.1
>

--000000000000c023120625c9816b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGtl8U/7TJL9mfb7nqg6ULoVWJajhZdI
8BIUnBkSVgUyMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAz
MTE3NTQxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQByV4c+4oHkB9gGpo7kJHRvEY1k1On07Gioh9PXFWsJbGlb8s48
Ll95/TM30DSBekYd3KXEu0tP0NeYtOfTz9b4t/Scxd8hJ578iZX5ZiVvYQtwvOFvHYHXdvemZyNK
ND8ew4nx8SCIE/DJr/9WHnVbjrDC7wcx0kqDZdYcwLgmE1/FiS32MUiZUoB4vWtawhTMYObbWR1H
x9aPPQ5C4OhsFpbVHPHJ9waNHx7Q/9VVUwr0bFtNdWh3DWR865vfOVCwfmkHvcDfdngZJGbDJ4Tn
K9cULWypBV36V0tYUE5m0MXbBLWENeoQZTAgMLaaJyOiAxjb7xpyksKfUOQdTy8A
--000000000000c023120625c9816b--

