Return-Path: <stable+bounces-240583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDXDDUcu62mBJgAAu9opvQ
	(envelope-from <stable+bounces-240583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:48:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F245BB0C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 422C3301D687
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C247135CB7B;
	Fri, 24 Apr 2026 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwmeQZhx"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FF74C6C
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020472; cv=pass; b=goE4rrvbbeTNjw1Cl1/cilRS40NoGzFTUei7NdTNO7v5YlmpOK/j/ctknHq5U9awuhZyzuMqqvJP06EJXoT1+xlquJ0T6wn0TTOeTAH0HCExMsj6alS2FFcxb58oMNqgk+3iBRU/CZs6b+peU/PCPq8+U52jKeWDX9+Z4hOd5tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020472; c=relaxed/simple;
	bh=E1kQr2KYle8iRZ9+CzOqMvN/GhEwBvQfkY5p7Jo7O0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4ARTpFoXgWb+cQRTNjtpkfWJeEKCbWeax1HI9Vc2OCsgarkk7timDG/qHkamzivVqmGRKMKA26CPoEs81lvAe6bmr6ju7fKcpSf3xNj8Nm/SK382zTh9rauvaE/cwnwo847O7j962YikUx5B0pkGTAOPIpVrlhs9tY578RmuVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwmeQZhx; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-652f220595fso7908404d50.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020469; cv=none;
        d=google.com; s=arc-20240605;
        b=SciC5GjuwPqBfbUTeYBwbL21P9xDBAD+zsiCDPtDYquaZ/JIv4jxqwq7kS0stxhCby
         fdQ2v/g28spc8pukk0KjKXfCR/Mz8gpqC4wb8mVmzJ1t3a+hqy3uJPUD1qJrF+bmpTxV
         QcfvFdrbFPUl+VFq9R8yTqJwZojmVitY7yL3mONlaqyIn9Z9WxTys1tnLif8AXVkbQP+
         FS0pPzyAmxOPt58nEcmOxXkF1wb+CofyG6p9BLldTZMySBaJCNJa1zAxcbRk4D7eXLI7
         qLdvi3sPXhxvSXhvT6TGicJcvkJQ2c8CmCXUksc66CLnXkjGtWQ89leULfEU5NUqsSdl
         ugzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6X6FBpevR2jJBvwlKJsxHMc/LW+LNuSmstjH4HhlZlE=;
        fh=MiJC66Wf/yULvhONY0vP8YynSSozuPEvKJWKtryvvfk=;
        b=hMOVsLzsUI6MysgwMakM449q3AUzzIEcZ2iCHB+zSnLD7p1BqmZjTur62+oAaJFG45
         xcxJhzAEa7pvYkYUb60J9gUpRMvIbK5jd4mBPXb42U7yge2N4wYs1nWv4WExXH8VrCBX
         ClulboF3F595Ygg54QsYUzvsWc7OyUVWl0CwLeaxTJVKf7GKVIpMNLsRzFQ/QsEg5eOr
         qYi1Ggc3sUtXWzHGUGwvkwvWjsPR8MA1piLAtLZdLc1wrXfp9rq+mqStuomfHntS18Yv
         m6dVdGc25Dsc1VT+YpzdfN2+ZYhVX/6z4xEq6rHK9hdDBcuQGXmu+/R6wHAIoOMKqlBm
         DosQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020469; x=1777625269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6X6FBpevR2jJBvwlKJsxHMc/LW+LNuSmstjH4HhlZlE=;
        b=HwmeQZhx0yqwcgLuju2WmoAVFWO2p2xApQsFSurNZFHPRRX2NJkm9vxOn8DdQMRA4J
         mXBmBkV9iCSBibbREbOgGV+t/0Vshm4PmuRNO1ocpMPJpUdxorYuGPXBxkQl5roJm1ES
         F4wwmjTJMGCKJTUOcv+Y6l4z7PeLELNBW6quiFxPXK6GKx/k8tn03DTQbLjlFVPwXquy
         lgkwkoecvK8qlV+ygdq4pZuObU42jrtwICe8rlz9jd5U0iBuAcN5cL7ehU7ToAqTJJZx
         KMWqnjzJFa75XtV02ZBuXvUKkxwOTs0vlgs7jRe1V7rfmbdssRDvlUYDkUuryWDFoKZP
         blaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020469; x=1777625269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X6FBpevR2jJBvwlKJsxHMc/LW+LNuSmstjH4HhlZlE=;
        b=SjHLQHjJj3S5oGwoILKyXiclqvMPgk3EBFAKeUU/lDsv2GDabjceAdMq3kQI/ePR7u
         lrVP1EMcjp/z2eDCvYVOc3N5mjked3aKvHHuANWM5rJ4X3ZxKwlBzTMjI2q8MiVhs9nr
         Nf4vJemZjhQWalPhBMjDQAjb91vXSXGM58rl6iN41aZ40n79o/fRpuqdpVZPE7KhYdP5
         R6xdM3OmssyZ29O1hmx0HakocWtxj5qEHdeKvQYYP9LEDaL3VjfsnkyZxDdFkJT76hWz
         EEAOJ2dovABdXDIsUJfaBzfX4pGiSDbxrZvImjUjLnXSk11priWeyfpqVQ1ah+fEYnIT
         2Cjw==
X-Gm-Message-State: AOJu0YzLOJHHo6HrZ8Nqp3Z3tZ778UEeFj3HLX/aXu+0kNvgbM/iyiNK
	6+L866f3XjX3PIoHnbT9Kkj3QH3FweKkXhgPvHlIxb01z+LMrNnTnKj3QDVdQbARvjMjiGTNa33
	GPOX2qOdZyM3Ul8dzshHWlyndo425nlZdjsxRRl4=
X-Gm-Gg: AeBDietwuXlFEMg8Y8enP9odeJ8nHD39oQEe47jHZyFc1Sll+k6JPicW/KVjm4LfwJH
	RpfMRQkQe079ADpOaOoPGOmY/EQIZp2gdlqi0hSZo4lZcNqRcDU/pZEfehEgUhlz85Iw+T519YA
	BeNK/yuDwF5cyYpOwNtbSmxUFB0HhVjam7XWfS+0Xeusir87t1Y4dK+34TSJ/eK7Xc3QgXbThjG
	sjJIXnsoAOFj2vFf7hruIDPFciKN9xT1f+famQSUPcLhRF1Gw3DQ1oudcQCfCiVnkfx6UI0CpW1
	fjhqqXsFydp15K1msN0S
X-Received: by 2002:a05:690e:e89:b0:654:2838:7789 with SMTP id
 956f58d0204a3-65428387dd5mr19457117d50.19.1777020469629; Fri, 24 Apr 2026
 01:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415183002.3752935-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415183002.3752935-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:47:35 +0800
X-Gm-Features: AQROBzD9VPB99_HUqxe3kJ_u1LM7fMxeQL-UyLgjQtz5raXvqgz8yQ5xH6CNAas
Message-ID: <CANUHTR_rbojBBZhq2qp+6ZHJsL8gXu=-s+iSp94BCya_srSR1g@mail.gmail.com>
Subject: Re: [PATCH] ssb: fix reference leaks on failed flash device registration
To: Michael Buesch <m@bues.ch>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	"John W. Linville" <linville@tuxdriver.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8A9F245BB0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240583-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[bues.ch,gmail.com,tuxdriver.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 02:30, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in ssb_devices_register(), the
> embedded struct device in ssb_pflash_dev or ssb_sflash_dev has already
> been initialized by device_initialize(), but the failure paths only
> report the error and do not drop the device reference for the current
> platform device:
>
>   ssb_devices_register()
>     -> platform_device_register(&ssb_pflash_dev)
>        -> device_initialize(&ssb_pflash_dev.dev)
>        -> setup_pdev_dma_masks(&ssb_pflash_dev)
>        -> platform_device_add(&ssb_pflash_dev)
>
>   ssb_devices_register()
>     -> platform_device_register(&ssb_sflash_dev)
>        -> device_initialize(&ssb_sflash_dev.dev)
>        -> setup_pdev_dma_masks(&ssb_sflash_dev)
>        -> platform_device_add(&ssb_sflash_dev)
>
> This leads to reference leaks when platform_device_register() fails.
> Fix this by calling platform_device_put() after reporting the error.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: c7a4a9e3880cc ("ssb: register platform device for parallel flash")
> Fixes: 7b5d6043de312 ("ssb: register serial flash as platform device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/ssb/main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index b2d339eb57d5..5cdf612a8516 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -535,16 +535,20 @@ static int ssb_devices_register(struct ssb_bus *bus)
>  #ifdef CONFIG_SSB_DRIVER_MIPS
>         if (bus->mipscore.pflash.present) {
>                 err = platform_device_register(&ssb_pflash_dev);
> -               if (err)
> +               if (err) {
>                         pr_err("Error registering parallel flash\n");
> +                       platform_device_put(&ssb_pflash_dev);
> +               }
>         }
>  #endif
>
>  #ifdef CONFIG_SSB_SFLASH
>         if (bus->mipscore.sflash.present) {
>                 err = platform_device_register(&ssb_sflash_dev);
> -               if (err)
> +               if (err) {
>                         pr_err("Error registering serial flash\n");
> +                       platform_device_put(&ssb_sflash_dev);
> +               }
>         }
>  #endif
>
> --
> 2.43.0
>

After re-checking it, ssb_pflash_dev and ssb_sflash_dev are global
platform_device objects and they do not provide dev.release callbacks.
Therefore calling platform_device_put() on the platform_device_register()
failure paths is not appropriate here and can trigger the missing release
callback warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

