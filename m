Return-Path: <stable+bounces-119994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7CA4A880
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1AF189C3A8
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3AE192B82;
	Sat,  1 Mar 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxmCMXXF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D12C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802872; cv=none; b=CeVb7EfNrYng8NnpvoQYFCEHplAI/M2YCCpmD/I1SGb4+WHp+yHFIWcA2NaOaLiJvYIXqYKbeHkf8RLBEBD2aMM1b+cXB6Ivg/F/CoKK6+MQfp63vSbonwX4KObtw4KDo/wRPMCiB4+S3hHietd//m9QL1EvLX8VUyofWMMXKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802872; c=relaxed/simple;
	bh=4+HsVcTWEuU5EFegAhRd812hp2Cu03Scqu0Xsu32p8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSzNbr+5Ecm3cTWcALa+O3bRtvNQfofN1YiPS+f/HRHZ163k6vTq7FHegJAF5XffYiMuJbRQcE0aBz74LwQ5X7omrWMUOddwhSqO7T7tzPMCWogbCtmho47yizTb/cTdYO+89Kbn7z8h+LWzahNtcs0N9eu/JIJE35ZurTL6j6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxmCMXXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305E0C4CEF3;
	Sat,  1 Mar 2025 04:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802872;
	bh=4+HsVcTWEuU5EFegAhRd812hp2Cu03Scqu0Xsu32p8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxmCMXXF92XfX9YobFCrnHZgUDOW52GemheprsrJeXVZYVbE4vgOIWpg8e2Xve5LD
	 jf1SMe+Uotyw953u2IC4ND0nMrpdnh+b3wo1Hvqhdq+9F3r9mvfFvIdLlFywNMh7Uw
	 sdhH/PU66o4xghrB4+SfuSz2toZmZCFuZjqejHoJhxgbGRSuXcqmf9kXf6L7Rf+rzb
	 ZwEKz00LPT4Yyg5hj7zif6bpJQ34d4ESPO9jlWJ3FJuZgjnQRjiu+/fJb1akTKBcTb
	 q0MbNpzt16Fn2g8kOxiZoAk7wk/cCLrLlQWnIyxVrTj43a8i80fDhhbVUFRoDd99ji
	 BanWZLlsB/uJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: uvcvideo: Fix crash during unbind if gpio unit is in use
Date: Fri, 28 Feb 2025 23:20:49 -0500
Message-Id: <20250228171523-c7b680aa3c63684f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228075228.2623486-1-ribalda@chromium.org>
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

Found matching upstream commit: a9ea1a3d88b7947ce8cadb2afceee7a54872bbc5

Status in newer kernel trees:
6.13.y | Present (different SHA1: 5d2e65cbe53d)
6.12.y | Present (different SHA1: d2eac8b14ac6)
6.6.y | Present (different SHA1: 0b5e0445bc83)

Note: The patch differs from the upstream commit:
---
1:  a9ea1a3d88b79 ! 1:  459a9ebcbed5f media: uvcvideo: Fix crash during unbind if gpio unit is in use
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
      
    - 	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
    + 	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
    + 	if (!unit)
     @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_gpio_parse(struct uvc_device *dev)
      static int uvc_gpio_init_irq(struct uvc_device *dev)
      {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

