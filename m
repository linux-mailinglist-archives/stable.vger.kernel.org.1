Return-Path: <stable+bounces-118688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A2EA410EC
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 19:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E27D3AE8F3
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAB70813;
	Sun, 23 Feb 2025 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J20rGIFS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A801459EA
	for <stable@vger.kernel.org>; Sun, 23 Feb 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740335689; cv=none; b=SOU9K1dTpejhV7kAkne7QPYmrMuN6jyoI0T9T1JYvHQvK3QSOf+5R54sXD9REnpHRO2wCd7gdUezaLreff3Fv4NJoPrlifa21fcCwoAxH9hD8R7O+218RQXT0ERUXu/CRJBI1xoCBUBOh+Len+3xqGaUsZFNH5J4GZigiRPPsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740335689; c=relaxed/simple;
	bh=Q7f0bptqboJdMiPWFy2P5hU0sfFsmUIydK6IWF+KPlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFjWgX6gru3SYtv64yPhtlnCT6wbtmZcAHqTAA49vtESTH1Zw0F/ri7vQypGoL7XB/KbOCK/EC+RR51VkUhNJc7g6crIyrdYlZOPkyxBzDkMVDhbMNJY0KUezeKkxDjeou1/Zm2w1A6Hc6DxHs4EziS/lbsKlmqGXh0KNNSIboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J20rGIFS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-546267ed92fso4361674e87.2
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740335685; x=1740940485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U0C+iu1WeNs+zRFQEZ4WEKG2Hv7tO/tPX0DsKYx3e/U=;
        b=J20rGIFS7GfkDw4xsRcjNBi9a/7AQDN+dZqpxwvv2gG4P2IphF7x/umr1L9V7Yr5Ul
         ysbU4OjKsUzVNDY/w3/GZKf96whJ/ovkBeC89v+o/SNdfw4TeSt/g2i7seJuKTEiNV98
         g0qfkgAxcpOEmID+WJhFyNk2+RO42MpWg8ppE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740335685; x=1740940485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0C+iu1WeNs+zRFQEZ4WEKG2Hv7tO/tPX0DsKYx3e/U=;
        b=qQ55jS2P0LXPR5n6nl8YuQFQ4DRSBWD/J1EATy/e7wIslyClPZvZRcaquvxyBuIDoj
         eIVHDIuFyoEwx99tEYkeSg9In6F6HfWWm4KQjFT2I+lOvlJwi1dJPTsEanaoIkH+NtH0
         3ADrXx1UIL0+LZHP58mTJT/VgLHTkIDp3WRz6kNaJqkUV6ITp+GpTI3I87CBKU37EaHp
         jW7pj+Az+UV71mdZhSE/AkH7Mu7jyuDqP+mcY+xnL+XT2rm7ZYZS5JmLzYEVm8GFOB9n
         Lezf1f9wOatwcUXX3edxAbMy9KJoz+nNF/lUZYlriZkVZDdfMvULHJSL4Rn2/UkMpEbS
         XbSw==
X-Forwarded-Encrypted: i=1; AJvYcCUDn28+RCDPtmP60NkE1rAu/LIZYQ6Ped9DIRex1kIpXqvTI2IxZsDlB5ElRvZqgvHlRaYWXCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzErCo8d02WVMx2on1tZx6kw1P+G6SY0tT5CEvcgWB47tlzp1
	xFOs5Dl9XnRMGqW0GUJTbHHRmfiimv9OZnUoXvIGN5cNZRB1ZaPwDRVIO431HEu9i2sB3bJ4vDY
	=
X-Gm-Gg: ASbGncvnO/AISSMrPM0ZUmPLVZBkTsG5zno6hDN1imCO4oh2p+ojifPXeyy5xq6vjWQ
	AfZuwVyJls84NqHvHKtz5K8HsLNXFvmg2S7JBJfnzWiFtbAXVFhytX70QuVXigxyBn/19aZIid9
	go4ZwOF4D1Su4FCWIodC8siPYN8KE06qBBFj4Rwy+IuzKheoL8E05JNiaNLz3mDOQVKLlq1eX5p
	+FqVySndJ+KYS/Au9JX1AIOtlnk7BYMIyKG5Cs0Ys4du1TyLqmGxMP/9pF2fbwfmL1811CCAkDY
	FcfGHbdC88ebkNSRvqoQG4PVqKBw1at8Mr4sgJFo5KzSoMPNKIjBOyOvbuxePv67W6S/
X-Google-Smtp-Source: AGHT+IG7VuJtTFvibIMkaTJBg72aX2y293yKkiac+OTri1geIK23z5AMQW2vwNZCpoSWin+lMYoZaA==
X-Received: by 2002:a05:6512:ba5:b0:545:c33:4099 with SMTP id 2adb3069b0e04-54838ef8982mr4286030e87.27.1740335685078;
        Sun, 23 Feb 2025 10:34:45 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54527b7961dsm2949145e87.46.2025.02.23.10.34.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 10:34:44 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a6bso38159781fa.1
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 10:34:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAILLP0fFce43I8tuTtmruJX/YlAF6bxaWDjYKK8lothCPO6fblcGloQm5+0WamNxgICmVnIg=@vger.kernel.org
X-Received: by 2002:a2e:b614:0:b0:308:f84b:6b34 with SMTP id
 38308e7fff4ca-30a5990b2ebmr35382051fa.20.1740335683340; Sun, 23 Feb 2025
 10:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org>
 <20250121-nuvoton-v1-1-1ea4f0cdbda2@chromium.org> <df5693d0-7747-4423-809e-ae081c9aae92@xs4all.nl>
 <dffc8e0b-2603-4e7e-ba64-15691c11ff7e@xs4all.nl>
In-Reply-To: <dffc8e0b-2603-4e7e-ba64-15691c11ff7e@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 19:34:30 +0100
X-Gmail-Original-Message-ID: <CANiDSCsMCSJMEsY3R=pnZ4XUTiEYuPz-N1kEX7y13yTzE6Dm5w@mail.gmail.com>
X-Gm-Features: AWEUYZkxdyzd_jgZvmXlXPTuqCYemf2QEgvVhq5WasLvpB-Xk2V4c6RpmAx6ZOg
Message-ID: <CANiDSCsMCSJMEsY3R=pnZ4XUTiEYuPz-N1kEX7y13yTzE6Dm5w@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: nuvoton: Fix reference handling of ece_pdev
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 10:18, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 21/02/2025 10:04, Hans Verkuil wrote:
> > Hi Ricardo,
> >
> > On 21/01/2025 22:14, Ricardo Ribalda wrote:
> >> When we obtain a reference to of a platform_device, we need to release
> >> it via put_device.
> >>
> >> Found by cocci:
> >> ./platform/nuvoton/npcm-video.c:1677:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> >> ./platform/nuvoton/npcm-video.c:1684:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> >> ./platform/nuvoton/npcm-video.c:1690:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> >> ./platform/nuvoton/npcm-video.c:1694:1-7: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> >
> > This driver uses this construct:
> >
> >                 struct device *ece_dev __free(put_device) = &ece_pdev->dev;
> >
> > to automatically call put_device. So this patch would 'put' the device twice.
> >
> > Does cocci understand constructs like this? If I hadn't looked closely at the
> > code first, I would just have merged it.
>
> Oh wait, now that I am reading the following patches I see that it was those later
> patches that add the __free code.
>
> This is far too confusing. Please post a v2 that just combines the 'fix references'
> and 'use cleanup.h macros' in a single patch. It makes no sense to have this two-phase
> approach.

I believe this is discouraged.

cleanup.h macros does not exist in old kernel versions, so makes it
impossible to backport the fix to them.

This is an example of other series following this policy:
https://lore.kernel.org/lkml/173608125422.1253657.3732758016133408588.stgit@devnote2/

They also mention the same here:
https://hackerbikepacker.com/kernel-auto-cleanup-1 .... I am pretty
sure that I read the policy in a more official location... but I
cannot find it right now :)


>
> Regards,
>
>         Hans
>
> >
> > Regards,
> >
> >       Hans
> >
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 46c15a4ff1f4 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
> >> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >> ---
> >>  drivers/media/platform/nuvoton/npcm-video.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
> >> index 024cd8ee1709..7b4c23dbe709 100644
> >> --- a/drivers/media/platform/nuvoton/npcm-video.c
> >> +++ b/drivers/media/platform/nuvoton/npcm-video.c
> >> @@ -1673,6 +1673,7 @@ static int npcm_video_ece_init(struct npcm_video *video)
> >>
> >>              regs = devm_platform_ioremap_resource(ece_pdev, 0);
> >>              if (IS_ERR(regs)) {
> >> +                    put_device(&ece_pdev->dev);
> >>                      dev_err(dev, "Failed to parse ECE reg in DTS\n");
> >>                      return PTR_ERR(regs);
> >>              }
> >> @@ -1680,11 +1681,13 @@ static int npcm_video_ece_init(struct npcm_video *video)
> >>              video->ece.regmap = devm_regmap_init_mmio(dev, regs,
> >>                                                        &npcm_video_ece_regmap_cfg);
> >>              if (IS_ERR(video->ece.regmap)) {
> >> +                    put_device(&ece_pdev->dev);
> >>                      dev_err(dev, "Failed to initialize ECE regmap\n");
> >>                      return PTR_ERR(video->ece.regmap);
> >>              }
> >>
> >>              video->ece.reset = devm_reset_control_get(&ece_pdev->dev, NULL);
> >> +            put_device(&ece_pdev->dev);
> >>              if (IS_ERR(video->ece.reset)) {
> >>                      dev_err(dev, "Failed to get ECE reset control in DTS\n");
> >>                      return PTR_ERR(video->ece.reset);
> >>
> >
> >
>


-- 
Ricardo Ribalda

