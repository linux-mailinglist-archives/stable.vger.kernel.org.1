Return-Path: <stable+bounces-254476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOkkBJdpFmq/mAcAu9opvQ
	(envelope-from <stable+bounces-254476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:48:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9BC5DF0BC
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E39C2300F1B3
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658317A31E;
	Wed, 27 May 2026 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a+n083D9"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC328686;
	Wed, 27 May 2026 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853715; cv=none; b=HsTMw1nr54Cxahc9vRa6Mq9zSdCWP5R6hLAbGH960l7RikxcaD0B8kru1vk1qKJxfUHbz6wjyqalNRnEykLHbqpnSBwOXJK8Hfcn4pJJNf8Vj3xMmJEMBWRy9J+6xaHjB1B42zlKC1oSbz0heEu2WHEdB/YRRB7AGROX8hnNhc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853715; c=relaxed/simple;
	bh=AmjjatGhEzdv+NEI8z644MF92MxP0GEthQFCwZEJjxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fa0CuCZP3x23SkQApEZNXtiu3vG+6MLqRYSyVh3lZ1PO2XBIBX1dYYqA4w7N+1fe/S87KC6eR/KYGVqPl0tqXIZdF8yJgukygu7V6O3WE8hQ3onb97inmDAf5do208/At8PviADnFpiadJ/lxOCBtkJI9RIWUdySxrUu4sSCP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a+n083D9; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+9
	4PQT49xTZArnmRTBiZ3JhWjPs1lnmosX2+YEOSBEc=; b=a+n083D9iRHfRwhNEq
	bL8WxBtj4EcA5DB3vnOiehTWZLtkBZBV55YPp3vCYmIDLIfEm4Lg0cDftf6ND1ht
	PmooPXPdhfUILnPmU6kDJkKCU3H7VwV6sHMQ5YXAREUiiZv7JIMHnniW6o1tY3mb
	2XNAjRzBd1Tp8kl+7GG5QbKYk=
Received: from 163.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3eu1WaRZq7vVUFQ--.205S2;
	Wed, 27 May 2026 11:47:39 +0800 (CST)
From: w15303746062@163.com
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vkms: sanitize display mode to prevent hrtimer livelock
Date: Wed, 27 May 2026 11:47:33 +0800
Message-Id: <20260527034733.701705-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3eu1WaRZq7vVUFQ--.205S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF43Kw4kurW7Kr45tw43Jrb_yoW5CF4Dpa
	17XryakFyUJFWxGan2yF1Sgr1akwn5JFyxKryDK3yav3WrtF43Ca4fZrW3WFW3Wr9rAay2
	qFyfJF98Gw109aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URmh7UUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5BuQdGoWaVvXdAAA32
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[bootlin.com,linux.intel.com,kernel.org,suse.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-254476-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,redhat.com,lists.freedesktop.org,vger.kernel.org,stu.xidian.edu.cn];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.987];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xidian.edu.cn:email]
X-Rspamd-Queue-Id: 7F9BC5DF0BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

SyzKaller reported an RCU stall caused by a livelock in
vkms_crtc_handle_vblank_timeout.

The root cause is that vkms derives its vblank timer period directly
from the display mode, but does not validate the mode parameters in
its atomic_check. A fuzzer or malicious user can pass a mode with
either an explicit vrefresh > 1000 Hz, or a combination of huge
crtc_clock and tiny htotal/vtotal that causes the computed vrefresh
to overflow or result in a frame duration close to zero.

When the period approaches zero, the hrtimer fires faster than it can
be handled, leading to an interrupt storm that deadlocks the CPU.

Fix this by rejecting modes in atomic_check where:
 - the explicit vrefresh exceeds 1000 Hz, or
 - the implied frame duration (derived from crtc_clock/htotal/vtotal)
   is less than 1 ms (equivalent to >1000 Hz).

This also protects against integer overflow in drm_mode_vrefresh().

SyzKaller logs snippet of the failure:
[  392.807933][    C2] vkms_vblank_simulate: vblank timer overrun
...
[  592.384301][    C3] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  592.438915][    C0] RIP: 0010:native_queued_spin_lock_slowpath+0x23e/0x9c0
[  592.440560][    C0] Call Trace:
[  592.440570][    C0]  <IRQ>
[  592.448399][    C0]  drm_handle_vblank+0x132/0xc70
[  592.449106][    C0]  __hrtimer_run_queues+0x1f5/0xb30

Fixes: 02e2681ffe1a ("drm/vkms: Convert to DRM's vblank timer")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 35ddc553a5e6..20b97dd0cc5f 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -116,9 +116,31 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
 									  crtc);
 	struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(crtc_state);
+	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct drm_plane *plane;
 	struct drm_plane_state *plane_state;
 	int i = 0, ret;
+	int vrefresh;
+	u64 frame_ns;
+
+	/*
+	 * Reject modes that would cause an hrtimer storm.
+	 * A virtual display cannot meaningfully refresh at >1000 Hz,
+	 * and an extremely high vrefresh (or a crafted combination of
+	 * crtc_clock/htotal/vtotal that overflows the vrefresh computation)
+	 * would produce a frame duration close to zero, locking the CPU
+	 * in an interrupt loop.
+	 */
+	if (crtc_state->enable) {
+		vrefresh = drm_mode_vrefresh(mode);
+		if (vrefresh > 1000)
+			return -EINVAL;
+		if (!mode->crtc_clock || !mode->htotal || !mode->vtotal)
+			return -EINVAL;
+		frame_ns = div_u64((u64)mode->htotal * mode->vtotal * 1000000ULL, mode->crtc_clock);
+		if (frame_ns < 1000000) /* <1 ms => refresh >1000 Hz */
+			return -EINVAL;
+	}
 
 	if (vkms_state->active_planes)
 		return 0;
-- 
2.34.1


