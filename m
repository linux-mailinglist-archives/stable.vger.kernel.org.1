Return-Path: <stable+bounces-42351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4078B7290
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1921C22D5B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72DE12C819;
	Tue, 30 Apr 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s6pb1v4T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499912C46E;
	Tue, 30 Apr 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475383; cv=none; b=Q7H2JjF8gSiIa6IscAzZEFOV+ba6YjJJoweGJ3V7YOQ9VWqM7UjlpKchf6jl2trSemBezLcl+Y5cYRbasoJf+jJMzSA5mVxt9bSy7Bt4rbJ4TdBaz/5K3MYZzphHVLY0vcCuqi/737n/C0uVxm9cZA5A5E74Bntr5S0oum/FnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475383; c=relaxed/simple;
	bh=Bhx+6794/OBijhD2M5mJDirQIkZ8XJLT2uEU/biYn9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dthi2qrXtxYiVkBOsnNvCIH7wzVGlhatI6REVTNzuPjKHs/aWLUGnW3kBHMiv7viF5ud2Ny+OycoRRwo3AtgNhYk5rZa/XyoWYFDwCBHEd47tn02UylwqRAZVbhUi8pxuKRTKH7CKndUavm8YbDjiLyzV8LekLmpGJUGz2rwXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s6pb1v4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8E4C4AF19;
	Tue, 30 Apr 2024 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475382;
	bh=Bhx+6794/OBijhD2M5mJDirQIkZ8XJLT2uEU/biYn9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6pb1v4TgtnChXoWAGHdPSvLUYtwQNcP9WaPhEDNdf91oPMMym8ypHZgCS612UX43
	 06RSdmqWfMkmfByhSBTq/kimmNmoLn+KaVagLeeuKGqcIl96AWRUVGC6a43U6jUqQR
	 z1u/bYIFN5EvyZMgiRVIGLzhTPt79J7hVx3hgprI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Enrico Bartky <enrico.bartky@gmail.com>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 040/186] drm/gma500: Remove lid code
Date: Tue, 30 Apr 2024 12:38:12 +0200
Message-ID: <20240430103059.195062556@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

[ Upstream commit 6aff4c26ed677b1f464f721fbd3e7767f24a684d ]

Due to a change in the order of initialization, the lid timer got
started before proper setup was made. This resulted in a crash during
boot.

The lid switch is handled by gma500 through a timer that periodically
polls the opregion for changes. These types of ACPI events shouldn't be
handled by the graphics driver so let's get rid of the lid code.  This
fixes the crash during boot.

Reported-by: Enrico Bartky <enrico.bartky@gmail.com>
Fixes: 8f1aaccb04b7 ("drm/gma500: Implement client-based fbdev emulation")
Tested-by: Enrico Bartky <enrico.bartky@gmail.com>
Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240415112731.31841-1-patrik.r.jakobsson@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gma500/Makefile     |  1 -
 drivers/gpu/drm/gma500/psb_device.c |  5 +-
 drivers/gpu/drm/gma500/psb_drv.h    |  9 ----
 drivers/gpu/drm/gma500/psb_lid.c    | 80 -----------------------------
 4 files changed, 1 insertion(+), 94 deletions(-)
 delete mode 100644 drivers/gpu/drm/gma500/psb_lid.c

diff --git a/drivers/gpu/drm/gma500/Makefile b/drivers/gpu/drm/gma500/Makefile
index 4f302cd5e1a6c..58fed80c7392a 100644
--- a/drivers/gpu/drm/gma500/Makefile
+++ b/drivers/gpu/drm/gma500/Makefile
@@ -34,7 +34,6 @@ gma500_gfx-y += \
 	  psb_intel_lvds.o \
 	  psb_intel_modes.o \
 	  psb_intel_sdvo.o \
-	  psb_lid.o \
 	  psb_irq.o
 
 gma500_gfx-$(CONFIG_ACPI) +=  opregion.o
diff --git a/drivers/gpu/drm/gma500/psb_device.c b/drivers/gpu/drm/gma500/psb_device.c
index dcfcd7b89d4a1..6dece8f0e380f 100644
--- a/drivers/gpu/drm/gma500/psb_device.c
+++ b/drivers/gpu/drm/gma500/psb_device.c
@@ -73,8 +73,7 @@ static int psb_backlight_setup(struct drm_device *dev)
 	}
 
 	psb_intel_lvds_set_brightness(dev, PSB_MAX_BRIGHTNESS);
-	/* This must occur after the backlight is properly initialised */
-	psb_lid_timer_init(dev_priv);
+
 	return 0;
 }
 
@@ -259,8 +258,6 @@ static int psb_chip_setup(struct drm_device *dev)
 
 static void psb_chip_teardown(struct drm_device *dev)
 {
-	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
-	psb_lid_timer_takedown(dev_priv);
 	gma_intel_teardown_gmbus(dev);
 }
 
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index 70d9adafa2333..bb1cd45c085cd 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -170,7 +170,6 @@
 
 #define PSB_NUM_VBLANKS 2
 #define PSB_WATCHDOG_DELAY (HZ * 2)
-#define PSB_LID_DELAY (HZ / 10)
 
 #define PSB_MAX_BRIGHTNESS		100
 
@@ -499,11 +498,7 @@ struct drm_psb_private {
 	/* Hotplug handling */
 	struct work_struct hotplug_work;
 
-	/* LID-Switch */
-	spinlock_t lid_lock;
-	struct timer_list lid_timer;
 	struct psb_intel_opregion opregion;
-	u32 lid_last_state;
 
 	/* Watchdog */
 	uint32_t apm_reg;
@@ -599,10 +594,6 @@ struct psb_ops {
 	int i2c_bus;		/* I2C bus identifier for Moorestown */
 };
 
-/* psb_lid.c */
-extern void psb_lid_timer_init(struct drm_psb_private *dev_priv);
-extern void psb_lid_timer_takedown(struct drm_psb_private *dev_priv);
-
 /* modesetting */
 extern void psb_modeset_init(struct drm_device *dev);
 extern void psb_modeset_cleanup(struct drm_device *dev);
diff --git a/drivers/gpu/drm/gma500/psb_lid.c b/drivers/gpu/drm/gma500/psb_lid.c
deleted file mode 100644
index 58a7fe3926360..0000000000000
--- a/drivers/gpu/drm/gma500/psb_lid.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/**************************************************************************
- * Copyright (c) 2007, Intel Corporation.
- *
- * Authors: Thomas Hellstrom <thomas-at-tungstengraphics-dot-com>
- **************************************************************************/
-
-#include <linux/spinlock.h>
-
-#include "psb_drv.h"
-#include "psb_intel_reg.h"
-#include "psb_reg.h"
-
-static void psb_lid_timer_func(struct timer_list *t)
-{
-	struct drm_psb_private *dev_priv = from_timer(dev_priv, t, lid_timer);
-	struct drm_device *dev = (struct drm_device *)&dev_priv->dev;
-	struct timer_list *lid_timer = &dev_priv->lid_timer;
-	unsigned long irq_flags;
-	u32 __iomem *lid_state = dev_priv->opregion.lid_state;
-	u32 pp_status;
-
-	if (readl(lid_state) == dev_priv->lid_last_state)
-		goto lid_timer_schedule;
-
-	if ((readl(lid_state)) & 0x01) {
-		/*lid state is open*/
-		REG_WRITE(PP_CONTROL, REG_READ(PP_CONTROL) | POWER_TARGET_ON);
-		do {
-			pp_status = REG_READ(PP_STATUS);
-		} while ((pp_status & PP_ON) == 0 &&
-			 (pp_status & PP_SEQUENCE_MASK) != 0);
-
-		if (REG_READ(PP_STATUS) & PP_ON) {
-			/*FIXME: should be backlight level before*/
-			psb_intel_lvds_set_brightness(dev, 100);
-		} else {
-			DRM_DEBUG("LVDS panel never powered up");
-			return;
-		}
-	} else {
-		psb_intel_lvds_set_brightness(dev, 0);
-
-		REG_WRITE(PP_CONTROL, REG_READ(PP_CONTROL) & ~POWER_TARGET_ON);
-		do {
-			pp_status = REG_READ(PP_STATUS);
-		} while ((pp_status & PP_ON) == 0);
-	}
-	dev_priv->lid_last_state =  readl(lid_state);
-
-lid_timer_schedule:
-	spin_lock_irqsave(&dev_priv->lid_lock, irq_flags);
-	if (!timer_pending(lid_timer)) {
-		lid_timer->expires = jiffies + PSB_LID_DELAY;
-		add_timer(lid_timer);
-	}
-	spin_unlock_irqrestore(&dev_priv->lid_lock, irq_flags);
-}
-
-void psb_lid_timer_init(struct drm_psb_private *dev_priv)
-{
-	struct timer_list *lid_timer = &dev_priv->lid_timer;
-	unsigned long irq_flags;
-
-	spin_lock_init(&dev_priv->lid_lock);
-	spin_lock_irqsave(&dev_priv->lid_lock, irq_flags);
-
-	timer_setup(lid_timer, psb_lid_timer_func, 0);
-
-	lid_timer->expires = jiffies + PSB_LID_DELAY;
-
-	add_timer(lid_timer);
-	spin_unlock_irqrestore(&dev_priv->lid_lock, irq_flags);
-}
-
-void psb_lid_timer_takedown(struct drm_psb_private *dev_priv)
-{
-	del_timer_sync(&dev_priv->lid_timer);
-}
-
-- 
2.43.0




