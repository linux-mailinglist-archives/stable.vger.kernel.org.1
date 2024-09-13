Return-Path: <stable+bounces-76101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095A97871A
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5551F22965
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CAF84A3E;
	Fri, 13 Sep 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fYM2siTo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6D81ACA
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249680; cv=none; b=lpieA8er8J0mJVHYjig+afHq0QYzQflCQYpiHwoifQj9SP8STP1hDouc5WrMuTabFSjpCVyCWJgqT8Vr4hgKmmPm/hCN69uoE4V9bp/Y/Hn/sY/FFEB+BMNQpxJyxmPbL2Vc/X+TAH7GlwpPSFxHVyNKfoYGZAxfbycbIxWCm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249680; c=relaxed/simple;
	bh=gd4U6lhjfa5SiS/0ILHhYNor4QZLTvpx0IBnAFnuPc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVDuz3kau027zrtSYx4+XFZvIblHpZbIqmlVy8LtBLNrtClqVzK7tJ2jy7CVgaD4DdNry2zVJh3gIoT2dyWVj8ATUsGaavSGH79M+2aav5lRQ031jRyk6OxZKtVClhlFk9N3R1QFhzmhErk9dC0YmiPEnZjbFU2WMOU6pOLHTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fYM2siTo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2053f6b8201so23052585ad.2
        for <stable@vger.kernel.org>; Fri, 13 Sep 2024 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726249678; x=1726854478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8IH/fKZ7WlUWd6MAHGKHHDTF08xKH8CLIu/uq2juW/g=;
        b=fYM2siToKs5b7tGUhzc4ruDZ0ZhXs4RvNdPK5JBjl61HBMlzbLEOK/dJTbSlrkChVO
         65hylTI2ZAAt0hKGAHIhppmOBFeQ7IzIUJxk09eVwYFp5XRjsqk95DeU1OYNi/SenudV
         2+b0lKiPciHCmNFa2tBK4q2cfA0ff6/3uBlvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249678; x=1726854478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IH/fKZ7WlUWd6MAHGKHHDTF08xKH8CLIu/uq2juW/g=;
        b=T+Q1Yobwqn2z/r6qJw2N3+gvXOIf5pSRXx4I4MGc/Vy1InhK2o1sEWJeaN8JmXxILw
         VvnGTDagKRN/uEFyi81y9pKdfiCu4x6mCtRV27EHkIuv0KlhjcZR8uaUeM6BhFDyvK/h
         qntp+k4aSWgR7CR/G+kMoAhpdXk2TVCjpymRVIoo6xL2z9cQHFBo1I/s8ouFBRTEswN5
         Yj11tmkCHwByq+CkGfHa/yY3X+bx1kUwKx1RCS4yPY3QIrzZdU1GbeSdwLLcPHwqA5Ls
         q9xauxqvkw8Yahd6pdpPrJDsMMPZKTqZZcqtFX/U8ebe0Ltr57RXSfdWvdWc1DrNEvho
         7IDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoI08iRNqg4euM1uhXyrYsSR2hmSPPMS/uMe4ri+aAOCW9S0WMpHicqr9YYjv+t+Uye4sWZmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+e+fFpe1TBEpM+SHfS7nNiKTX58mrfmr1bync4X2KRbpFwrDb
	Ks+o2m8a5f2ygXtGQGeRMKtbdmZK6g2EeyhVrHngHf11g8kx6ycbWgl1BEJ05Q==
X-Google-Smtp-Source: AGHT+IF/Z83uZ5DKsWYI6BIBnszLvyBcxjjxnEpt4x8DvN82ruG8ZaQekEMAasgPQ7k4gkSjUIiGcg==
X-Received: by 2002:a17:902:c946:b0:207:850c:2548 with SMTP id d9443c01a7336-207850c26e1mr44249585ad.22.1726249677812;
        Fri, 13 Sep 2024 10:47:57 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:8bb7:9bdd:6697:b2f7])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2076b01a742sm30385035ad.259.2024.09.13.10.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 10:47:57 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:47:54 -0700
From: Brian Norris <briannorris@chromium.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Julius Werner <jwerner@chromium.org>, Borislav Petkov <bp@alien8.de>,
	Hugues Bruant <hugues.bruant@gmail.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>,
	chrome-platform@lists.linux.dev,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [NOT A REGRESSION] firmware: framebuffer-coreboot: duplicate
 device name "simple-framebuffer.0"
Message-ID: <ZuR6yvqpCiV4Cjqf@google.com>
References: <CALvjV29jozswRtmYxDur2TuEQ=1JSDrM+uWVHmghW3hG5Y9F+w@mail.gmail.com>
 <20240909080200.GAZt6reI9c98c9S_Xc@fat_crate.local>
 <ZuCGkjoxKxpnhEh6@google.com>
 <87jzfhayul.fsf@minerva.mail-host-address-is-not-set>
 <CAODwPW8P+jcF0erUph5XyWoyQgLFbZWxEM6Ygi_LFCCTLmH89Q@mail.gmail.com>
 <87mskczv9l.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mskczv9l.fsf@minerva.mail-host-address-is-not-set>

Hi Javier,

On Thu, Sep 12, 2024 at 06:33:58PM +0200, Javier Martinez Canillas wrote:
> That's a very good point. I'm actually not familiar with Coreboot and I
> used an educated guess (in the case of DT for example, that's the main
> source of truth and I didn't know if a Core table was in a similar vein).
> 
> Maybe something like the following (untested) patch then?

Julius is more familiar with the Coreboot + payload ecosystem than me,
but his explanations make sense to me, as does this patch.

> From de1c32017006f4671d91b695f4d6b4e99c073ab2 Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javierm@redhat.com>
> Date: Thu, 12 Sep 2024 18:31:55 +0200
> Subject: [PATCH] firmware: coreboot: Don't register a pdev if screen_info data
>  is available
> 
> On Coreboot platforms, a system framebuffer may be provided to the Linux
> kernel by filling a LB_TAG_FRAMEBUFFER entry in the Coreboot table. But
> a Coreboot payload (e.g: SeaBIOS) could also provide this information to
> the Linux kernel.
> 
> If that the case, early arch x86 boot code will fill the global struct
> screen_info data and that data used by the Generic System Framebuffers
> (sysfb) framework to add a platform device with platform data about the
> system framebuffer.

Normally, these sorts of "early" and "later" ordering descriptions would
set alarm bells when talking about independent drivers. But I suppose
the "early arch" code has better ordering guaranteeds than drivers, so
this should be fine.

> But later then the framebuffer_coreboot driver will try to do the same
> framebuffer (using the information from the Coreboot table), which will
> lead to an error due a simple-framebuffer.0 device already registered:
> 
>     sysfs: cannot create duplicate filename '/bus/platform/devices/simple-framebuffer.0'
>     ...
>     coreboot: could not register framebuffer
>     framebuffer coreboot8: probe with driver framebuffer failed with error -17
> 
> To prevent the issue, make the framebuffer_core driver to not register a
> platform device if the global struct screen_info data has been filled.
> 
> Reported-by: Brian Norris <briannorris@chromium.org>
> Link: https://lore.kernel.org/all/ZuCG-DggNThuF4pj@b20ea791c01f/T/#ma7fb65acbc1a56042258adac910992bb225a20d2
> Suggested-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/firmware/google/framebuffer-coreboot.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
> index daadd71d8ddd..4e50da17cd7e 100644
> --- a/drivers/firmware/google/framebuffer-coreboot.c
> +++ b/drivers/firmware/google/framebuffer-coreboot.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/simplefb.h>
>  #include <linux/platform_device.h>
> +#include <linux/screen_info.h>
>  
>  #include "coreboot_table.h"
>  
> @@ -27,6 +28,7 @@ static int framebuffer_probe(struct coreboot_device *dev)
>  	int i;
>  	u32 length;
>  	struct lb_framebuffer *fb = &dev->framebuffer;
> +	struct screen_info *si = &screen_info;
>  	struct platform_device *pdev;
>  	struct resource res;
>  	struct simplefb_platform_data pdata = {
> @@ -36,6 +38,20 @@ static int framebuffer_probe(struct coreboot_device *dev)
>  		.format = NULL,
>  	};
>  
> +	/*
> +	 * If the global screen_info data has been filled, the Generic
> +	 * System Framebuffers (sysfb) will already register a platform

Did you mean 'platform_device'?

> +	 * and pass the screen_info as platform_data to a driver that
> +	 * could scan-out using the system provided framebuffer.
> +	 *
> +	 * On Coreboot systems, the advertise LB_TAG_FRAMEBUFFER entry

s/advertise/advertised/ ?

> +	 * in the Coreboot table should only be used if the payload did
> +	 * not set video mode info and passed it to the Linux kernel.

s/passed/pass/

> +	 */
> +	if (si->orig_video_isVGA == VIDEO_TYPE_VLFB ||
> +            si->orig_video_isVGA == VIDEO_TYPE_EFI)

This line is using spaces for indentation. It should use a tab, and then
spaces for alignment. But presumably this will change based on Thomas's
suggestions anyway.

> +		return -EINVAL;

Is EINVAL right? IIUC, that will print a noisier error to the logs. I
believe the "expected" sorts of return codes are ENODEV or ENXIO. (See
call_driver_probe().) ENODEV seems like a fine choice, similar to
several of the other return codes already used here.

Anyway, this seems along the right track. Thanks for tackling, and feel
free to carry a:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> +
>  	if (!fb->physical_address)
>  		return -ENODEV;
>  
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat
> 

