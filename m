Return-Path: <stable+bounces-254142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPdSFvdLFGpeMQcAu9opvQ
	(envelope-from <stable+bounces-254142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:17:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C93B75CAFC6
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0911A301CDB8
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9105D384231;
	Mon, 25 May 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KR0BIXzp"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFD3845CF;
	Mon, 25 May 2026 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715049; cv=none; b=XSJHGi8wpY65p/SnvMmSBCw/8vuGzBtCZaV1qOJBfV3i53Q5Oeks36Bej/o77qFTH4l86EgwMVPOfHSeAWLRsrzjcp9NFOJ0WCxAJ7948c/vUuKGm7bA1PZqOoNvro/rmvpz7r7el3gVJfkPeKRL8/cLJytWtLNzGg0I4R9/Ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715049; c=relaxed/simple;
	bh=ls2S3fjDJ1INFUBVCTe0L+cGm6YkQ6wKF2gXAdOWz3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9MFLnewkkT2PYWenMkoAATidS0naVBPhxf42IYWahIQAWuc+9kFBexSuj18SM4JKnd9/J9FJSpXeQaFAUAY1WY6+UuDmh9wVjagxFHdE56TnBJ0fOMYBZqwY++k5xweC9bn+Hz8qD35oUPv0COCxNU+vhbOBuXnIFvzUvIFTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KR0BIXzp; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qg
	fS2QcDKVCd5d3obLYCQplqPn/se69rr6mZX+NEuyc=; b=KR0BIXzpkfxhRY7Ghd
	oEjt9Z2WJnfHte+CaKdPcKig2jO0TpNxlIXZ2fzhrUDYVo6y12G/hLdeJxlTQICg
	/A256nvplhZzV4PsUZG6WEWbexXpjcF5gTSC0Lx2Nnuo9kYiroUxi8PozQcYcMo0
	YnvrNmjEnEEqNixz6lTVatUWI=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCn6zidSxRqC7WEDQ--.19334S4;
	Mon, 25 May 2026 21:16:30 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	louis.chauvet@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 6.18.y 2/5] drm/vblank: Add CRTC helpers for simple use cases
Date: Mon, 25 May 2026 21:16:07 +0800
Message-Id: <20260525131610.608273-3-w15303746062@163.com>
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
X-CM-TRANSID:_____wCn6zidSxRqC7WEDQ--.19334S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFyxZr4UWF15ur13JFyrWFg_yoW7uF47pF
	srGry5Kr4YqFW5W3sxJws2yw1ag3yFyas7XrykG343Z3Z5KrnxuF18AryxuF13XrnrJ3Wf
	X342yr15C3WrCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3miiUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4w6dgWoUS67YCgAA34
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,linux.intel.com,kernel.org,bootlin.com,lists.freedesktop.org,vger.kernel.org,redhat.com,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254142-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: C93B75CAFC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Zimmermann <tzimmermann@suse.de>

Implement atomic_flush, atomic_enable and atomic_disable of struct
drm_crtc_helper_funcs for vblank handling. Driver with no further
requirements can use these functions instead of adding their own.
Also simplifies the use of vblank timers.

The code has been adopted from vkms, which added the funtionality
in commit 3a0709928b17 ("drm/vkms: Add vblank events simulated by
hrtimers").

v3:
- mention vkms (Javier)
v2:
- fix docs

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/20250916083816.30275-3-tzimmermann@suse.de
(cherry picked from commit d54dbb5963bdbdf8559903fe2b2343e871adcb30)
---
 drivers/gpu/drm/drm_vblank_helper.c | 80 +++++++++++++++++++++++++++++
 include/drm/drm_vblank_helper.h     | 23 +++++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank_helper.c b/drivers/gpu/drm/drm_vblank_helper.c
index f94d1e706191..a04a6ba1b0ca 100644
--- a/drivers/gpu/drm/drm_vblank_helper.c
+++ b/drivers/gpu/drm/drm_vblank_helper.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: MIT
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
@@ -17,6 +18,12 @@
  * Drivers enable support for vblank timers by setting the vblank callbacks
  * in struct &drm_crtc_funcs to the helpers provided by this library. The
  * initializer macro DRM_CRTC_VBLANK_TIMER_FUNCS does this conveniently.
+ * The driver further has to send the VBLANK event from its atomic_flush
+ * callback and control vblank from the CRTC's atomic_enable and atomic_disable
+ * callbacks. The callbacks are located in struct &drm_crtc_helper_funcs.
+ * The vblank helper library provides implementations of these callbacks
+ * for drivers without further requirements. The initializer macro
+ * DRM_CRTC_HELPER_VBLANK_FUNCS sets them coveniently.
  *
  * Once the driver enables vblank support with drm_vblank_init(), each
  * CRTC's vblank timer fires according to the programmed display mode. By
@@ -25,6 +32,79 @@
  * struct &drm_crtc_helper_funcs.handle_vblank_timeout.
  */
 
+/*
+ * VBLANK helpers
+ */
+
+/**
+ * drm_crtc_vblank_atomic_flush -
+ *	Implements struct &drm_crtc_helper_funcs.atomic_flush
+ * @crtc: The CRTC
+ * @state: The atomic state to apply
+ *
+ * The helper drm_crtc_vblank_atomic_flush() implements atomic_flush of
+ * struct drm_crtc_helper_funcs for CRTCs that only need to send out a
+ * VBLANK event.
+ *
+ * See also struct &drm_crtc_helper_funcs.atomic_flush.
+ */
+void drm_crtc_vblank_atomic_flush(struct drm_crtc *crtc,
+				  struct drm_atomic_state *state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_pending_vblank_event *event;
+
+	spin_lock_irq(&dev->event_lock);
+
+	event = crtc_state->event;
+	crtc_state->event = NULL;
+
+	if (event) {
+		if (drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+	}
+
+	spin_unlock_irq(&dev->event_lock);
+}
+EXPORT_SYMBOL(drm_crtc_vblank_atomic_flush);
+
+/**
+ * drm_crtc_vblank_atomic_enable - Implements struct &drm_crtc_helper_funcs.atomic_enable
+ * @crtc: The CRTC
+ * @state: The atomic state
+ *
+ * The helper drm_crtc_vblank_atomic_enable() implements atomic_enable
+ * of struct drm_crtc_helper_funcs for CRTCs the only need to enable VBLANKs.
+ *
+ * See also struct &drm_crtc_helper_funcs.atomic_enable.
+ */
+void drm_crtc_vblank_atomic_enable(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state)
+{
+	drm_crtc_vblank_on(crtc);
+}
+EXPORT_SYMBOL(drm_crtc_vblank_atomic_enable);
+
+/**
+ * drm_crtc_vblank_atomic_disable - Implements struct &drm_crtc_helper_funcs.atomic_disable
+ * @crtc: The CRTC
+ * @state: The atomic state
+ *
+ * The helper drm_crtc_vblank_atomic_disable() implements atomic_disable
+ * of struct drm_crtc_helper_funcs for CRTCs the only need to disable VBLANKs.
+ *
+ * See also struct &drm_crtc_funcs.atomic_disable.
+ */
+void drm_crtc_vblank_atomic_disable(struct drm_crtc *crtc,
+				    struct drm_atomic_state *state)
+{
+	drm_crtc_vblank_off(crtc);
+}
+EXPORT_SYMBOL(drm_crtc_vblank_atomic_disable);
+
 /*
  * VBLANK timer
  */
diff --git a/include/drm/drm_vblank_helper.h b/include/drm/drm_vblank_helper.h
index 74a971d0cfba..fcd8a9b35846 100644
--- a/include/drm/drm_vblank_helper.h
+++ b/include/drm/drm_vblank_helper.h
@@ -6,8 +6,31 @@
 #include <linux/hrtimer_types.h>
 #include <linux/types.h>
 
+struct drm_atomic_state;
 struct drm_crtc;
 
+/*
+ * VBLANK helpers
+ */
+
+void drm_crtc_vblank_atomic_flush(struct drm_crtc *crtc,
+				  struct drm_atomic_state *state);
+void drm_crtc_vblank_atomic_enable(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state);
+void drm_crtc_vblank_atomic_disable(struct drm_crtc *crtc,
+				    struct drm_atomic_state *crtc_state);
+
+/**
+ * DRM_CRTC_HELPER_VBLANK_FUNCS - Default implementation for VBLANK helpers
+ *
+ * This macro initializes struct &drm_crtc_helper_funcs to default helpers
+ * for VBLANK handling.
+ */
+#define DRM_CRTC_HELPER_VBLANK_FUNCS \
+	.atomic_flush = drm_crtc_vblank_atomic_flush, \
+	.atomic_enable = drm_crtc_vblank_atomic_enable, \
+	.atomic_disable = drm_crtc_vblank_atomic_disable
+
 /*
  * VBLANK timer
  */
-- 
2.34.1


