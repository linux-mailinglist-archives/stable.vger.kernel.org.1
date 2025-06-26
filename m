Return-Path: <stable+bounces-158695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED33AEA070
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C2A7B9BEC
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0C28724A;
	Thu, 26 Jun 2025 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R72cZiMr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF028A406;
	Thu, 26 Jun 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947780; cv=none; b=VFwAOCj9pa7an+zBMA1IdTjQUp/YovWLtybS7sbDRkY7Fvlr8tZ0Co+QIZjM19Uxo8qZg7xvm90D6gqwhimaabUkVO8tVV13cDAgh48mZCz+g1xUbBeOdfIn7d0ANcW4SNqenq/30FHauslIOGVsIEw9LYVtDz4Hn+RUiomdIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947780; c=relaxed/simple;
	bh=VnAzg56f+hysQJZPOLXhBXL0My2caz2gxoa80MYeNr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZvWkwpvBX9/oTrMw3iTfVlgOhg/nPzk9YBPWWM41+0Mogm/pQFGxL6BMxxDaBAAraf5hqzhaf+RZCsoYL6SB2jB1w5xnj+F/cJlL5Bk6wwFADtB4ik/2OcOJ71ucVPhaXTolQ/tpxfnX6hLbz7i6bLK3+xySxW7ujNP+lS8htQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R72cZiMr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748ece799bdso803380b3a.1;
        Thu, 26 Jun 2025 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750947777; x=1751552577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMM3xSjjvtkN9sNymINSQ4aTR9MjXM5qmSlYZv1dEyw=;
        b=R72cZiMrUn1Yg46TQ01+OOADGD+vTSQNHOLq+DQ7S9X3AFM3yVCYjNK5du6a+zB4Iu
         V/Qu8l+3Ca02Q1W1B7+IbLyUs9d68nAiUytxv2gsNwttHExbuEwfPURkPPaxx+tKZvzM
         mJE8qktorpTLGZTE1Ba5+/bQOFILvj0KSkYqxc9+UVkAaUHp+5cbUBniYnO6fCMWuORE
         6zpR+fS5beq70aC+97bcj3Tg2L6dxulv0xv9BXk4SyGMG1TgK4jABlDDAAtyAFi6knC7
         p5X5ebbpUX1F+TWKGd0fqHeN2WcdOpSfeuphh/CgigGENyARawx+5MNfW3klFiIQaa3n
         unNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750947777; x=1751552577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMM3xSjjvtkN9sNymINSQ4aTR9MjXM5qmSlYZv1dEyw=;
        b=URpyLtsdBF3eEsvaoAOdmTo0u1Dwr37jdUgq+54WUoW65VZ38IXNunkmKjw+u4nG/w
         BTpQiHCpZfDGQ45gZKSEwv8eZZ8YY9OEcNTqlOS7kXSTaIVzJ/Y+4ne4uv4uwDehmoyz
         mx4Lez2NWoVyVMukOuiaxPcWOQ/3gZViyHUclbtwAGCiiRIdII8S/kwUdkllCyWFukBX
         /h7mzoQg6kSuYYQCzYnFL1K27fsB01SpVHSacKqyEElJUnsEoSL9UIpPJqh89Wbp5giz
         KkH39Zh115WHY+ZRk78vg/KqQceKXuXDxdjjTiIoObBKjiB6PiahrpoxuJ8Kmk6fFJ+v
         LOKw==
X-Forwarded-Encrypted: i=1; AJvYcCWPUOoQq+Zv/7rXY3pHCgu3/B9Qq+e6XRpjBkiP6ZFtdmK+FQ/8r5K013iUTMFcm8BMkePY/RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJynMYLTp8RTCu1g0I0TTa94VMhmV7duw7pnyM9vkD9GlBx6A
	JYKWB0zWz0UUVVUB4Kt6G7rxMxRlbOc/de2+31DJdo0gZphWk9jbXqWuwGcfmE+0
X-Gm-Gg: ASbGncvX1EXTeQt70hDIt+tOMHADwqfhGOR/nWSVb9LJ/+BGe/aWnqCA5bolKuLJCft
	8XGG+st3n2h/QZqui+Gr/Pj45jhPnlW1MeR3rg9/9nKiEBfFEh3ceGMSG9xn2CePnBbpPUzcumm
	/SKYmho/ZcdTV2nzdMY9cZlHm4uNTBX0qv+lhgexZU24Ny0ekOw/Monh0sKNmC9cPex7CGkX3lC
	GjZFVCdnTK2UYAr/VSN9wYBOglepFEzCqnPySr/nIN2WnDxEdUCKssnH4KCm8OkAecwbZBD+tcy
	cZwsewS1oYwrBlTRsAYq4pkefgANt8aC7XWLyX7CHOL7ha7TRMsJLUMw24cK/sRsIWthpjIzp0n
	xxMoUn/DNmgoB7e0ecQ==
X-Google-Smtp-Source: AGHT+IHvPgEXqKwWC3H8FLqec238NOxqpv7452gpGXmtMjCrr6s266Ccdd9P8x3NxP0Pg4hK8zFHVA==
X-Received: by 2002:a05:6a21:3298:b0:1f5:591b:4f7a with SMTP id adf61e73a8af0-2207f31ac43mr11593474637.38.1750947777297;
        Thu, 26 Jun 2025 07:22:57 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c67:6116:afb5:b6ab:2dc8:4a21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8872629sm7129288b3a.164.2025.06.26.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 07:22:56 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	daniel@ffwll.ch,
	airlied@linux.ie,
	mcanal@igalia.com,
	arthurgrillo@riseup.net,
	mairacanal@riseup.net,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] drm/vkms: Fix race-condition between the hrtimer and the atomic commit
Date: Thu, 26 Jun 2025 19:52:43 +0530
Message-ID: <20250626142243.19071-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit a0e6a017ab56936c0405fe914a793b241ed25ee0 ]

Currently, it is possible for the composer to be set as enabled and then
as disabled without a proper call for the vkms_vblank_simulate(). This
is problematic, because the driver would skip one CRC output, causing CRC
tests to fail. Therefore, we need to make sure that, for each time the
composer is set as enabled, a composer job is added to the queue.

In order to provide this guarantee, add a mutex that will lock before
the composer is set as enabled and will unlock only after the composer
job is added to the queue. This way, we can have a guarantee that the
driver won't skip a CRC entry.

This race-condition is affecting the IGT test "writeback-check-output",
making the test fail and also, leaking writeback framebuffers, as the
writeback job is queued, but it is not signaled. This patch avoids both
problems.

[v2]:
    * Create a new mutex and keep the spinlock across the atomic commit in
      order to avoid interrupts that could result in deadlocks.

[ Backport to 5.15: context cleanly applied with no semantic changes.
Build-tested. ]

Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20230523123207.173976-1-mcanal@igalia.com
Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 9 +++++++--
 drivers/gpu/drm/vkms/vkms_crtc.c     | 9 +++++----
 drivers/gpu/drm/vkms/vkms_drv.h      | 4 +++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 9e8204be9a14..77fced36af55 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -332,10 +332,15 @@ void vkms_set_composer(struct vkms_output *out, bool enabled)
 	if (enabled)
 		drm_crtc_vblank_get(&out->crtc);
 
-	spin_lock_irq(&out->lock);
+	mutex_lock(&out->enabled_lock);
 	old_enabled = out->composer_enabled;
 	out->composer_enabled = enabled;
-	spin_unlock_irq(&out->lock);
+
+	/* the composition wasn't enabled, so unlock the lock to make sure the lock
+	 * will be balanced even if we have a failed commit
+	 */
+	if (!out->composer_enabled)
+		mutex_unlock(&out->enabled_lock);
 
 	if (old_enabled)
 		drm_crtc_vblank_put(&out->crtc);
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 57bbd32e9beb..1b02dee8587a 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -16,7 +16,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_crtc_state *state;
 	u64 ret_overrun;
-	bool ret, fence_cookie;
+	bool ret, fence_cookie, composer_enabled;
 
 	fence_cookie = dma_fence_begin_signalling();
 
@@ -25,15 +25,15 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 	if (ret_overrun != 1)
 		pr_warn("%s: vblank timer overrun\n", __func__);
 
-	spin_lock(&output->lock);
 	ret = drm_crtc_handle_vblank(crtc);
 	if (!ret)
 		DRM_ERROR("vkms failure on handling vblank");
 
 	state = output->composer_state;
-	spin_unlock(&output->lock);
+	composer_enabled = output->composer_enabled;
+	mutex_unlock(&output->enabled_lock);
 
-	if (state && output->composer_enabled) {
+	if (state && composer_enabled) {
 		u64 frame = drm_crtc_accurate_vblank_count(crtc);
 
 		/* update frame_start only if a queued vkms_composer_worker()
@@ -293,6 +293,7 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 
 	spin_lock_init(&vkms_out->lock);
 	spin_lock_init(&vkms_out->composer_lock);
+	mutex_init(&vkms_out->enabled_lock);
 
 	vkms_out->composer_workq = alloc_ordered_workqueue("vkms_composer", 0);
 	if (!vkms_out->composer_workq)
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index d48c23d40ce5..666997e2bcab 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -83,8 +83,10 @@ struct vkms_output {
 	struct workqueue_struct *composer_workq;
 	/* protects concurrent access to composer */
 	spinlock_t lock;
+	/* guarantees that if the composer is enabled, a job will be queued */
+	struct mutex enabled_lock;
 
-	/* protected by @lock */
+	/* protected by @enabled_lock */
 	bool composer_enabled;
 	struct vkms_crtc_state *composer_state;
 
-- 
2.49.0


