Return-Path: <stable+bounces-76012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40855976ED1
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 18:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D121F22AEB
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602918787F;
	Thu, 12 Sep 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHyXS37M"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE3186E4F
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158846; cv=none; b=Zs0M0BDVfiEhxM5LiS/kE1WlfNb0vJF6Qa8NgwerBCHBEff/jnM/Rq9ihf1AXW6wfIja4nfwkmHSGDI6gWg3xfaUJJ4H2b6ERwUPv8sLi2HU2ZFwJGYm3a7Bbl6TQA7S7kDFMCzURB8V0YmuuS8xEHFNHzevf66CcWCzPOlDgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158846; c=relaxed/simple;
	bh=XQG7wonhC6R1YdTQNDlE3VJtJ10vFf+cAJlA/RvoZf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTe4DLDc3WfUj8/8XndS0Tan9ZBZU6OzV4pUdDCHhsPP9y1yaiZA8zFtck8vJwslZB35L8D/e5Tqi3b8SjdD+8smzDs17dmYqXMm77r1AzYK0T2gV1CTuwHC8+Z80K9fN83NLKYosmev4lOw5shMeUnA/S0Ct0w8g4Hlbf6BKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHyXS37M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726158843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EOmdO+b7gYLR4VAcBUs89Ub1sXD9TFu8fmoSrmDCcEU=;
	b=DHyXS37McYLD8iW4fcBsEVDN1OKuoJ+eL7QusXLyqwBa93UTo29jVUQghok8sVpfRz0Ljm
	dAUh4S9nibBDrhAEOKTDzaprxk4rCHXy8ksdWJKWLT5qPajeaN+vUOgFQUMrcKpctep5En
	pW1xdd0nXOvWU+7WUq/kKSzY6f0Y6us=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-4_52PFNqOI-9kNRfJmcG-Q-1; Thu, 12 Sep 2024 12:34:01 -0400
X-MC-Unique: 4_52PFNqOI-9kNRfJmcG-Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c294d841so5943f8f.1
        for <stable@vger.kernel.org>; Thu, 12 Sep 2024 09:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158840; x=1726763640;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOmdO+b7gYLR4VAcBUs89Ub1sXD9TFu8fmoSrmDCcEU=;
        b=B1iwm1PbdTczXv3b8yecjayMtq5OdfwdqtvsJWOHdqypRSwmWHibNAg9uNCnvB+z61
         veybBy09hBmJHzx16xK9kMpOb1UiFNrzfjFbtkwZ3AQS6CtAlXKDnP8wMog51/CponZK
         pWkOeV7JK2jx7+hTCpTSJi+EOcHjrJypoexM5s8RYk1BLdF88UMZKOcBpm9WsRRKTgLK
         +FMZPedvKOrJAQQiSsPgfMcWIR2Cv1f4nogcxBcy+cjNXGbYtdBYaXgptvr1lEWRJEFg
         RWryXzdyd6aRk0wGM75QVU0aRRwnMfqjm+qoq+wqgmk5cu3ouBw7WtjA2jqgTFkE2NxL
         a+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvnVZvbJTx5mkZrf7WdHrhX2duXbFGPAO6My2Y5HsUALvgVg8f3MiIkfJIcU5j4VK8id47FT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xoKsrpaBHTHTgx6siJUNJOLs8ocCgc+usUgqfGzgigI2aiBs
	+MBzhlIGgkorx5FP5oNsDLWhEJ72MA+KYHHHgA0xIZwk47Jgb+QQlMU+tIQJUPo+A0wjZNxV6Sx
	+FoQmYbJrv41wf7yPogtsK2XphuJ9DaDH/ajmPr6eO8I8bGBRDX+i4rqEMBOTnA==
X-Received: by 2002:a05:6000:c81:b0:374:bde8:66af with SMTP id ffacd0b85a97d-378c2d581camr2869423f8f.57.1726158840261;
        Thu, 12 Sep 2024 09:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHykV9DHzv3qV6R6EuPD0pzt9S/Yjo+tEE1Jd7G9+MiD3zDj61TCo7+RJHhLaEraT38VncGGg==
X-Received: by 2002:a05:6000:c81:b0:374:bde8:66af with SMTP id ffacd0b85a97d-378c2d581camr2869405f8f.57.1726158839736;
        Thu, 12 Sep 2024 09:33:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653f9sm14798656f8f.31.2024.09.12.09.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 09:33:59 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Borislav Petkov <bp@alien8.de>,
 Hugues Bruant <hugues.bruant@gmail.com>, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org, Fenghua Yu
 <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Tony
 Luck <tony.luck@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>, Julius
 Werner <jwerner@chromium.org>, chrome-platform@lists.linux.dev, Jani
 Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [NOT A REGRESSION] firmware: framebuffer-coreboot: duplicate
 device name "simple-framebuffer.0"
In-Reply-To: <CAODwPW8P+jcF0erUph5XyWoyQgLFbZWxEM6Ygi_LFCCTLmH89Q@mail.gmail.com>
References: <CALvjV29jozswRtmYxDur2TuEQ=1JSDrM+uWVHmghW3hG5Y9F+w@mail.gmail.com>
 <20240909080200.GAZt6reI9c98c9S_Xc@fat_crate.local>
 <ZuCGkjoxKxpnhEh6@google.com>
 <87jzfhayul.fsf@minerva.mail-host-address-is-not-set>
 <CAODwPW8P+jcF0erUph5XyWoyQgLFbZWxEM6Ygi_LFCCTLmH89Q@mail.gmail.com>
Date: Thu, 12 Sep 2024 18:33:58 +0200
Message-ID: <87mskczv9l.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Julius Werner <jwerner@chromium.org> writes:

Hello Julius,

>> On Coreboot platforms, a system framebuffer may be provided to the Linux
>> kernel by filling a LB_TAG_FRAMEBUFFER entry in the Coreboot table. But
>> it seems SeaBIOS payload can also provide a VGA mode in the boot params.
>>
>> [...]
>>
>> To prevent the issue, make the framebuffer_core driver to disable sysfb
>> if there is system framebuffer data in the Coreboot table. That way only
>> this driver will register a device and sysfb would not attempt to do it
>> (or remove its registered device if was already executed before).
>
> I wonder if the priority should be the other way around? coreboot's
> framebuffer is generally only valid when coreboot exits to the payload
> (e.g. SeaBIOS). Only if the payload doesn't touch the display
> controller or if there is no payload and coreboot directly hands off
> to a kernel does the kernel driver for LB_TAG_FRAMEBUFFER make sense.
> But if there is some other framebuffer information passed to the
> kernel from a firmware component running after coreboot, most likely
> that one is more up to date and the framebuffer described by the
> coreboot table doesn't work anymore (because the payload usually
> doesn't modify the coreboot tables again, even if it changes hardware
> state). So if there are two drivers fighting over which firmware
> framebuffer description is the correct one, the coreboot driver should
> probably give way.
>

That's a very good point. I'm actually not familiar with Coreboot and I
used an educated guess (in the case of DT for example, that's the main
source of truth and I didn't know if a Core table was in a similar vein).

Maybe something like the following (untested) patch then?

From de1c32017006f4671d91b695f4d6b4e99c073ab2 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 12 Sep 2024 18:31:55 +0200
Subject: [PATCH] firmware: coreboot: Don't register a pdev if screen_info data
 is available

On Coreboot platforms, a system framebuffer may be provided to the Linux
kernel by filling a LB_TAG_FRAMEBUFFER entry in the Coreboot table. But
a Coreboot payload (e.g: SeaBIOS) could also provide this information to
the Linux kernel.

If that the case, early arch x86 boot code will fill the global struct
screen_info data and that data used by the Generic System Framebuffers
(sysfb) framework to add a platform device with platform data about the
system framebuffer.

But later then the framebuffer_coreboot driver will try to do the same
framebuffer (using the information from the Coreboot table), which will
lead to an error due a simple-framebuffer.0 device already registered:

    sysfs: cannot create duplicate filename '/bus/platform/devices/simple-framebuffer.0'
    ...
    coreboot: could not register framebuffer
    framebuffer coreboot8: probe with driver framebuffer failed with error -17

To prevent the issue, make the framebuffer_core driver to not register a
platform device if the global struct screen_info data has been filled.

Reported-by: Brian Norris <briannorris@chromium.org>
Link: https://lore.kernel.org/all/ZuCG-DggNThuF4pj@b20ea791c01f/T/#ma7fb65acbc1a56042258adac910992bb225a20d2
Suggested-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/firmware/google/framebuffer-coreboot.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index daadd71d8ddd..4e50da17cd7e 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
+#include <linux/screen_info.h>
 
 #include "coreboot_table.h"
 
@@ -27,6 +28,7 @@ static int framebuffer_probe(struct coreboot_device *dev)
 	int i;
 	u32 length;
 	struct lb_framebuffer *fb = &dev->framebuffer;
+	struct screen_info *si = &screen_info;
 	struct platform_device *pdev;
 	struct resource res;
 	struct simplefb_platform_data pdata = {
@@ -36,6 +38,20 @@ static int framebuffer_probe(struct coreboot_device *dev)
 		.format = NULL,
 	};
 
+	/*
+	 * If the global screen_info data has been filled, the Generic
+	 * System Framebuffers (sysfb) will already register a platform
+	 * and pass the screen_info as platform_data to a driver that
+	 * could scan-out using the system provided framebuffer.
+	 *
+	 * On Coreboot systems, the advertise LB_TAG_FRAMEBUFFER entry
+	 * in the Coreboot table should only be used if the payload did
+	 * not set video mode info and passed it to the Linux kernel.
+	 */
+	if (si->orig_video_isVGA == VIDEO_TYPE_VLFB ||
+            si->orig_video_isVGA == VIDEO_TYPE_EFI)
+		return -EINVAL;
+
 	if (!fb->physical_address)
 		return -ENODEV;
 
-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


