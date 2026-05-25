Return-Path: <stable+bounces-254143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADnmITdMFGpeMQcAu9opvQ
	(envelope-from <stable+bounces-254143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:18:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 292435CB010
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F241F302FB40
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933D1384253;
	Mon, 25 May 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MCNoBbTW"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57089384242;
	Mon, 25 May 2026 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715049; cv=none; b=nCkgAaksUWlT4A7TSEW9FgjdDRI9Ud1qAeCb0h40swJQAoeNtFZBQL56x9fz+CdzgfB7Rk3ptpc3ecWV7jMHOeyFO6BWqBpzbxrjxVZ03TKmPKUnE4ZEIRSLYt9GwKcEIOP1V8ZXYgBvoIbA8lsCa+DRLOOtahbvmJBlXfsP4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715049; c=relaxed/simple;
	bh=QorHf8uWcImAqMMqO5x76C7XL8LwP9/N3PTRJvT7EU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqM6fSqjMkmEwR6GY3qQ9hGz6wPYRC/qu+VNARQJ/IekzUaystn4PjvsWAMgkx/mXHWTFc66rD/YT9mgLTya2jECwqIQX+ETsjMcguFNLn/D+5pNBR0Y2lzfxHa6gtOYYy7ZzNBqdZBoVg7bDQGPgSRMZRE+7q4HMlW4bkTdBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MCNoBbTW; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=86
	fii1su2g58+wtz9DxkukiuP93cMf9YbhUSvNidWrs=; b=MCNoBbTWmnicWBf69p
	QP/NLfWc147ejS4QZmDawU/ZUSvlpQRO5faJbqVr9dPgFUKaY5ovENZmb4Tjvqbd
	x5MgrAMCvfol7aOeXuancwfTQdQcWvQEPfk95hsYlfYoMF9xfj5Odz03mAWCuA1z
	5iRHxrgjklHsDE6exApl5dAF4=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCn6zidSxRqC7WEDQ--.19334S5;
	Mon, 25 May 2026 21:16:32 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	louis.chauvet@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 6.18.y 3/5] drm/vkms: Convert to DRM's vblank timer
Date: Mon, 25 May 2026 21:16:08 +0800
Message-Id: <20260525131610.608273-4-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525131610.608273-1-w15303746062@163.com>
References: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
 <20260525131610.608273-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn6zidSxRqC7WEDQ--.19334S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw1UAw1ktF1DGFWxAFy5Arb_yoWxJr17pF
	sFyr97Kr4rtF1UW34DJF4kCw1F934Yyas7X3y8K3yav3WFkr13J3W8Ary3uFW3XF9rXw4a
	qF1xtw15Ar109F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jV-erUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDABCegmoUS7BDgwAA3J
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254143-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,suse.de:email]
X-Rspamd-Queue-Id: 292435CB010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Zimmermann <tzimmermann@suse.de>

Replace vkms' vblank timer with the DRM implementation. The DRM
code is identical in concept, but differs in implementation.

Vblank timers are covered in vblank helpers and initializer macros,
so remove the corresponding hrtimer in struct vkms_output. The
vblank timer calls vkms' custom timeout code via handle_vblank_timeout
in struct drm_crtc_helper_funcs.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://lore.kernel.org/r/20250916083816.30275-4-tzimmermann@suse.de
(cherry picked from commit 02e2681ffe1addde1fc8c35d05657b16bfa79613)
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 83 +++-----------------------------
 drivers/gpu/drm/vkms/vkms_drv.h  |  2 -
 2 files changed, 7 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index e60573e0f3e9..bd79f24686dc 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -7,25 +7,18 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_vblank_helper.h>
 
 #include "vkms_drv.h"
 
-static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
+static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
 {
-	struct vkms_output *output = container_of(timer, struct vkms_output,
-						  vblank_hrtimer);
-	struct drm_crtc *crtc = &output->crtc;
+	struct vkms_output *output = drm_crtc_to_vkms_output(crtc);
 	struct vkms_crtc_state *state;
-	u64 ret_overrun;
 	bool ret, fence_cookie;
 
 	fence_cookie = dma_fence_begin_signalling();
 
-	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
-					  output->period_ns);
-	if (ret_overrun != 1)
-		pr_warn("%s: vblank timer overrun\n", __func__);
-
 	spin_lock(&output->lock);
 	ret = drm_crtc_handle_vblank(crtc);
 	if (!ret)
@@ -57,55 +50,6 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 
 	dma_fence_end_signalling(fence_cookie);
 
-	return HRTIMER_RESTART;
-}
-
-static int vkms_enable_vblank(struct drm_crtc *crtc)
-{
-	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
-
-	hrtimer_setup(&out->vblank_hrtimer, &vkms_vblank_simulate, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL);
-	out->period_ns = ktime_set(0, vblank->framedur_ns);
-	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
-
-	return 0;
-}
-
-static void vkms_disable_vblank(struct drm_crtc *crtc)
-{
-	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
-
-	hrtimer_cancel(&out->vblank_hrtimer);
-}
-
-static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
-				      int *max_error, ktime_t *vblank_time,
-				      bool in_vblank_irq)
-{
-	struct vkms_output *output = drm_crtc_to_vkms_output(crtc);
-	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-
-	if (!READ_ONCE(vblank->enabled)) {
-		*vblank_time = ktime_get();
-		return true;
-	}
-
-	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
-
-	if (WARN_ON(*vblank_time == vblank->time))
-		return true;
-
-	/*
-	 * To prevent races we roll the hrtimer forward before we do any
-	 * interrupt processing - this is how real hw works (the interrupt is
-	 * only generated after all the vblank registers are updated) and what
-	 * the vblank core expects. Therefore we need to always correct the
-	 * timestampe by one frame.
-	 */
-	*vblank_time -= output->period_ns;
-
 	return true;
 }
 
@@ -159,9 +103,7 @@ static const struct drm_crtc_funcs vkms_crtc_funcs = {
 	.reset                  = vkms_atomic_crtc_reset,
 	.atomic_duplicate_state = vkms_atomic_crtc_duplicate_state,
 	.atomic_destroy_state   = vkms_atomic_crtc_destroy_state,
-	.enable_vblank		= vkms_enable_vblank,
-	.disable_vblank		= vkms_disable_vblank,
-	.get_vblank_timestamp	= vkms_get_vblank_timestamp,
+	DRM_CRTC_VBLANK_TIMER_FUNCS,
 	.get_crc_sources	= vkms_get_crc_sources,
 	.set_crc_source		= vkms_set_crc_source,
 	.verify_crc_source	= vkms_verify_crc_source,
@@ -213,18 +155,6 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 	return 0;
 }
 
-static void vkms_crtc_atomic_enable(struct drm_crtc *crtc,
-				    struct drm_atomic_state *state)
-{
-	drm_crtc_vblank_on(crtc);
-}
-
-static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
-				     struct drm_atomic_state *state)
-{
-	drm_crtc_vblank_off(crtc);
-}
-
 static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
 				   struct drm_atomic_state *state)
 	__acquires(&vkms_output->lock)
@@ -265,8 +195,9 @@ static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
 	.atomic_check	= vkms_crtc_atomic_check,
 	.atomic_begin	= vkms_crtc_atomic_begin,
 	.atomic_flush	= vkms_crtc_atomic_flush,
-	.atomic_enable	= vkms_crtc_atomic_enable,
-	.atomic_disable	= vkms_crtc_atomic_disable,
+	.atomic_enable	= drm_crtc_vblank_atomic_enable,
+	.atomic_disable	= drm_crtc_vblank_atomic_disable,
+	.handle_vblank_timeout = vkms_crtc_handle_vblank_timeout,
 };
 
 struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *primary,
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 8013c31efe3b..fb9711e1c6fb 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -215,8 +215,6 @@ struct vkms_output {
 	struct drm_crtc crtc;
 	struct drm_writeback_connector wb_connector;
 	struct drm_encoder wb_encoder;
-	struct hrtimer vblank_hrtimer;
-	ktime_t period_ns;
 	struct workqueue_struct *composer_workq;
 	spinlock_t lock;
 
-- 
2.34.1


