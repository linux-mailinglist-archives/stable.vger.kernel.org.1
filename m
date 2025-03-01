Return-Path: <stable+bounces-119995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C88A4A881
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4243BA206
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B561519BE;
	Sat,  1 Mar 2025 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU7fTDU2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEF2C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802874; cv=none; b=XNFbRU6+5X78VaZ4e0C/lUnaFeIE76wvwfS/Uxv0tgJ9kxgwEdMXERgDqvbEGkVslz+1H/frcP4/6UtRf1QLVr+Sp/DlgjPpkmcnI8YAfL9t8O6tjaMgBYMeDX8FiVqw68wlAKUYahDsf654w6ktJiifIJY0fSjJmIlQYqNfbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802874; c=relaxed/simple;
	bh=cAW8XjCeVoQwhrvvFbW/LM4+bgLf9xCriCgwur6Tz+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsphdcn4Kh1b5wLEHaSZ5cK3n0ZX6iRG9V43OwQfUXdi3/k4UOFKX/NVisb6xMkVAoP6VoIVu78ylaT2wRmZQDjjY38qcSxTnQ8bxP0CHGtRzYF7tBZbhjVq9x4q07sgpUkqdDe9fmEK7FkkPpktVSQOu1xDVHI4NPR+62zPmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU7fTDU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0955C4CEF3;
	Sat,  1 Mar 2025 04:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802874;
	bh=cAW8XjCeVoQwhrvvFbW/LM4+bgLf9xCriCgwur6Tz+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DU7fTDU2uNsRVPQE71w0WHJ01lMNYyRhC7+6H90HdbUpYF/k04dCubw27fNtcXQGO
	 RVTxl7PsK9f/KukZwxzgIs3aJGfmx9+BAmPdEmhiB+eLE+9Yu9g7kDlMp6nbAlVJl+
	 jA0XeXu9QvvTKg4/Un8oFzaXmOTWgS7mLljAmmV73va1k+ZHWhlU+C+DX2RBq2Ngt+
	 cngFyZWVMJ6VpD61xPQKMUV/blACoOKBkarSdARdHQ594F4QLyhq2qpZa3LdHxLz+1
	 cDh+LYYl9uxZsaMVMr1gQFiowHrOtR5NWfLJY27Wpm14pq8fP9Gyj7Fib2Da3BaD4g
	 +I+LXLbrRyYhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] media: uvcvideo: Fix crash during unbind if gpio unit is in use
Date: Fri, 28 Feb 2025 23:20:50 -0500
Message-Id: <20250228183942-6ad8557249bfaaaa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228074607.2609635-1-ribalda@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

Found matching upstream commit: a9ea1a3d88b7947ce8cadb2afceee7a54872bbc5

Status in newer kernel trees:
6.13.y | Present (different SHA1: 5d2e65cbe53d)
6.12.y | Present (different SHA1: d2eac8b14ac6)
6.6.y | Present (different SHA1: 0b5e0445bc83)
6.1.y | Present (different SHA1: 644d4fe34bab)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a9ea1a3d88b79 ! 1:  4c6203668c8f2 media: uvcvideo: Fix crash during unbind if gpio unit is in use
    @@ Commit message
         Link: https://lore.kernel.org/r/20241106-uvc-crashrmmod-v6-1-fbf9781c6e83@chromium.org
         Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
         Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    +    (cherry picked from commit a9ea1a3d88b7947ce8cadb2afceee7a54872bbc5)
     
      ## drivers/media/usb/uvc/uvc_driver.c ##
     @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_gpio_parse(struct uvc_device *dev)
    @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_gpio_parse(struct uvc_device
      		return PTR_ERR_OR_ZERO(gpio_privacy);
      
      	irq = gpiod_to_irq(gpio_privacy);
    - 	if (irq < 0)
    --		return dev_err_probe(&dev->udev->dev, irq,
    +-	if (irq < 0) {
    +-		if (irq != EPROBE_DEFER)
    +-			dev_err(&dev->udev->dev,
    +-				"No IRQ for privacy GPIO (%d)\n", irq);
    +-		return irq;
    +-	}
    ++	if (irq < 0)
     +		return dev_err_probe(&dev->intf->dev, irq,
    - 				     "No IRQ for privacy GPIO\n");
    ++				     "No IRQ for privacy GPIO\n");
      
      	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
    + 				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
     @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_gpio_parse(struct uvc_device *dev)
      static int uvc_gpio_init_irq(struct uvc_device *dev)
      {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

