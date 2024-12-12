Return-Path: <stable+bounces-103666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF729EF8DA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C020016FDA5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E75222D59;
	Thu, 12 Dec 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BlORJof9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E720A5EE;
	Thu, 12 Dec 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025247; cv=none; b=fS0NIiCUFlHa/yxUmh9gJs62dKdVALd9AFXFwao6iv0Zzphloq4DLsPq2k/phyryG7bfYMNccXZT6OUluwTpwDqzlKsYEFBHnrgst4VvTvqaH6X9G3V/hmjp2CbATJbnfa2u1F1KW26f2MbAJGR0v7+V6KPNH5i4wupjBqncK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025247; c=relaxed/simple;
	bh=Hqdx2vHuSAzKGefWMebn5a8XW5hJg5mtoPtSEl4R9Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9fH2zTvVbTnNH2y2xNin53gTwwg/dZFW/J9h7w3JhYs/WwxHLm6Qr8GYvcjr98i1af0ofl8kd/L/5la9k0Kl8v+loZ56YfjX+siBTy7HmQ01wqP1PyGq9zy6LA/Hm8gfBfffMiplDsSJwWMzHOFJSoKNW32P9bGdXyKVSABeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BlORJof9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC9CC4CECE;
	Thu, 12 Dec 2024 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025246;
	bh=Hqdx2vHuSAzKGefWMebn5a8XW5hJg5mtoPtSEl4R9Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BlORJof9RRiOHWft7Bkoivfg2mt68qIYojlXCwNa0xxtzpVLitTc9v25BaYQtCSuj
	 NHletEiw7yEV8MWMo5fAuWV3M6Fi33sn0vlnptihLeKGJ/ISvRPaF/HRqUEe00lTY1
	 act7hQIUzGD69XLGIHQLQJgKo0iPQj05symXDY7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 104/321] fbdev/sh7760fb: Alloc DMA memory from hardware device
Date: Thu, 12 Dec 2024 16:00:22 +0100
Message-ID: <20241212144234.097138457@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 8404e56f4bc1d1a65bfc98450ba3dae5e653dda1 ]

Pass the hardware device to the DMA helpers dma_alloc_coherent() and
dma_free_coherent(). The fbdev device that is currently being used is
a software device and does not provide DMA memory. Also update the
related dev_*() output statements similarly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230613110953.24176-28-tzimmermann@suse.de
Stable-dep-of: f89d17ae2ac4 ("fbdev: sh7760fb: Fix a possible memory leak in sh7760fb_alloc_mem()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sh7760fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sh7760fb.c b/drivers/video/fbdev/sh7760fb.c
index ab8fe838c7763..ac65163f40325 100644
--- a/drivers/video/fbdev/sh7760fb.c
+++ b/drivers/video/fbdev/sh7760fb.c
@@ -359,7 +359,7 @@ static void sh7760fb_free_mem(struct fb_info *info)
 	if (!info->screen_base)
 		return;
 
-	dma_free_coherent(info->dev, info->screen_size,
+	dma_free_coherent(info->device, info->screen_size,
 			  info->screen_base, par->fbdma);
 
 	par->fbdma = 0;
@@ -408,14 +408,14 @@ static int sh7760fb_alloc_mem(struct fb_info *info)
 	if (vram < PAGE_SIZE)
 		vram = PAGE_SIZE;
 
-	fbmem = dma_alloc_coherent(info->dev, vram, &par->fbdma, GFP_KERNEL);
+	fbmem = dma_alloc_coherent(info->device, vram, &par->fbdma, GFP_KERNEL);
 
 	if (!fbmem)
 		return -ENOMEM;
 
 	if ((par->fbdma & SH7760FB_DMA_MASK) != SH7760FB_DMA_MASK) {
 		sh7760fb_free_mem(info);
-		dev_err(info->dev, "kernel gave me memory at 0x%08lx, which is"
+		dev_err(info->device, "kernel gave me memory at 0x%08lx, which is"
 			"unusable for the LCDC\n", (unsigned long)par->fbdma);
 		return -ENOMEM;
 	}
@@ -486,7 +486,7 @@ static int sh7760fb_probe(struct platform_device *pdev)
 
 	ret = sh7760fb_alloc_mem(info);
 	if (ret) {
-		dev_dbg(info->dev, "framebuffer memory allocation failed!\n");
+		dev_dbg(info->device, "framebuffer memory allocation failed!\n");
 		goto out_unmap;
 	}
 
-- 
2.43.0




