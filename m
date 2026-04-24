Return-Path: <stable+bounces-240586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCClHY0x62lfJwAAu9opvQ
	(envelope-from <stable+bounces-240586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:02:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D86DD45BD2C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E8D33019812
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ECB318EC5;
	Fri, 24 Apr 2026 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDSppFHJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE226AA93
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021218; cv=pass; b=kWpDhJXyBoqU3IbD33v7FMLHk2+TSL2r6z4CO92TR1/FTIcTAmaWTwcNM+xB0mFTOiolAAneTyPZMwtYKAk0LVLmWW59Y9mT4htimIuwKxLUwYwiHvWD069kdLJVvh9jl54mEIflGT8lEsfhgbyJmteyUUA0WMXG76dJ2O4puh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021218; c=relaxed/simple;
	bh=b5Fu7zRQK6EautvTkFiYuCIJyBfEfmoqNLBoHhdoHa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayrwy/Tyt7xMI8ell4kix0LA7BbPlw2s/E3K9MBru5Q6BKuCxlgFeuXpQiPYGLEpiZte47wxHu3ixPm8prbyV15c49JLQkCAlDJYbMEqyqHHi0FjQbt4eHVX+Q6q5q74RzWjPoUIsedFDWatMkbamh/dSJQuEepC9Merhc6NFHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDSppFHJ; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65492d097acso1313420d50.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 02:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021216; cv=none;
        d=google.com; s=arc-20240605;
        b=UsiGvv04Q3vW7KhC1fXrKz6mQ75dzuUNaC18+hEP+I3zoWh7oaGFlyDo3N24lVZhU4
         A5t/qScJXIZ947Z0f3Kgi8k99OV84fyIp2Mg3ZgIArVmbxTdzSeRsaZKfBUo4izrI68k
         R2hyBLve7ZgAMpZHT6bAFFhY0vzldcDapHAjUUn+JkNpt+xx7cpSJOsGI7KwiOJmNOmt
         t+ehCpLUuuk6F/UEZIXApbgy/qX03sRQPKIBSNiim8qvX9wpDkxCErJcUEGNjg62JrZ6
         vb1ST+0BBYswM3BLVVH9bJEXlWBBwp4ep4tNk32BNDR4s/59dDs/qyLnC2Nsfk1+ZuME
         FO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WMhVWR0mg6d0bsMxu4OxDI/s6SgSzPlLJoRVMia7Nt4=;
        fh=tJchRh0J/Gvc3EdOZRhtB+mTqSuYUJ1sjQxFATLp2gE=;
        b=akWyqS1tVpcFVl5nilgH/jj2Hu+JBU4XqIidnNk68lvlNz9cO4vJNKolf8bGU3PXnV
         33jxfGr8+GPtuK7R5ubB/3zeut2HsM9qI4WcNFjyHYVGoNY6QBucOZMG68PDrU/UPa2P
         WNAN+29zUFQ5/+2dFMhtH1kJ6ewiVB2HI4u5CBebMehJx7giSYR2TwKjit09C0PJbeLw
         vuJu3xq0wB0b00/YQ1yj+ezc9Y+Ou0tqi6mF7GGvI8ooh3s3r7fASurxUUv3phO1Zewt
         xXi4V+h7HQPW4CgG0UJpV9TBBDjdeazEZ/GvvS9Q04Qc2OHZIB1jpmXL0sWGquE2lQCu
         oG9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777021216; x=1777626016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WMhVWR0mg6d0bsMxu4OxDI/s6SgSzPlLJoRVMia7Nt4=;
        b=KDSppFHJJrEtlZmOEbhrxJVHGUjeky2voipfmH19o3E4M5p1vy/Py0CgkVUbfd0nE3
         pARzgBW5jAPzIspY8xcijbisoi7jhIzsjpINEayv5kW+20Lymq1NTqON3lbCzSs6ZUEc
         sjnwPrpoxiKNmzdeFCuW+dOrz9oSrsvM6dNIGFpQLsBWxgsKMjjDlMsX6NCvp8Xyehgi
         zTjZaI0uOAjGJpMnUqAbT5g8BmIncILHDTRUpSBPdnVi4wmlxwgsSuEmeOufDQffAzG4
         pmlHULZoAQGDCStXgYYTMBs9ln9bMyFNG1HQKHxVMr73Xmwx3oK7bMOsdNjif4QpS28n
         oDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021216; x=1777626016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMhVWR0mg6d0bsMxu4OxDI/s6SgSzPlLJoRVMia7Nt4=;
        b=iEMA6nIGbn3vnSsxH71RJm5iOmiYWalcbFT2Z9D6wsy+l6NZPu+v/qa3exIwbAIPq2
         8SGbjfDDfhV3iCwNznCT/Njkf20uDRxkmIu2Tg8w8CkMDyBUhF0p55JuY2xcETqW7M2z
         ZuVD3QmeWb9JqBSRTNRsfTyICh/yji+nSiF39vRrpNGcRgdtA9RDyAshT9y8a2PqgR/1
         HpMfSEhcOQxYDSVrVZsuVpGkv76z9lJNej8ssplNONiNvS//kwE8K9JVtWiWa02T4E9x
         fJGgL0fMIf7LUy4k0o5w9WCo7FuQUwFOyCrzi8U5qU3BRg0WvhoI1MAaVfu0XjDSL37W
         7Nug==
X-Gm-Message-State: AOJu0YwFUEgZ79lK/yWI0lmPNp+IYDTczhpcoSQUTR1ca3CTGZ/jgZsU
	59E2rN+eet//dYRkSav2/yFtVnqOTQ0a8ca5GHjUMAhBfaKfsyJzlopFm3Ki8xtbW4E3oKvfszI
	CQ6zQCrAidm2On30sd+0tlBkKayYzLDQ=
X-Gm-Gg: AeBDies8PxZOZox+KFpNuFjmCaLmpoWIehJ1Y9gWWZTNuwYlq0rqgCYVzgeGE+QjI6W
	nrHLh22QG6I4JsVRMaik0ae941DRALj+QBF/sghopt76gU4IrKRWTzxT2m91pKJ6HdX3SXMyF53
	fvQdUXApqqXSwg5d8YI/bKiFyc+Rcx8butCws6vbWXd+brbvc+2RtQEwarrEfCFO9hFy+q16+fX
	qTlAj8GRL85lXE/AGMrY5yJMUBrU7Ne80cMDhXGE83wDU54m6OsSEsIq1GzjjaDfa6WLQYcQVjv
	nu2aJCoguLqdsuori7v9
X-Received: by 2002:a05:690e:d0a:b0:653:1945:8fab with SMTP id
 956f58d0204a3-65319459b3cmr27855758d50.43.1777021216403; Fri, 24 Apr 2026
 02:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415191003.3829558-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415191003.3829558-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 17:00:01 +0800
X-Gm-Features: AQROBzDRuc7ifOf5Jk1J9tOCgnKOvndIrCp42i0bqZ5GOvl-P0LF9lO5bb2Mf9k
Message-ID: <CANUHTR_2RuqR95v3zRzqBsy2txTq2nBghi9PhMj_ek4VEBCHdQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: hitfb: fix reference leak on failed device registration
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>, 
	Andriy Skulysh <askulysh@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D86DD45BD2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240586-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com,linux-sh.org,vger.kernel.org,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 03:10, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in hitfb_init(), the embedded
> struct device in hitfb_device has already been initialized by
> device_initialize(), but the failure path only unregisters the platform
> driver and does not drop the device reference for the current platform
> device:
>
>   hitfb_init()
>     -> platform_device_register(&hitfb_device)
>        -> device_initialize(&hitfb_device.dev)
>        -> setup_pdev_dma_masks(&hitfb_device)
>        -> platform_device_add(&hitfb_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before unregistering the
> platform driver.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: 048839dc548a5 ("video: hitfb suspend/resume and updates.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/video/fbdev/hitfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
> index 97db325df2b4..29708c2d506d 100644
> --- a/drivers/video/fbdev/hitfb.c
> +++ b/drivers/video/fbdev/hitfb.c
> @@ -495,8 +495,10 @@ static int __init hitfb_init(void)
>         ret = platform_driver_register(&hitfb_driver);
>         if (!ret) {
>                 ret = platform_device_register(&hitfb_device);
> -               if (ret)
> +               if (ret) {
> +                       platform_device_put(&hitfb_device);
>                         platform_driver_unregister(&hitfb_driver);
> +               }
>         }
>         return ret;
>  }
> --
> 2.43.0
>

After re-checking it, hitfb_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

