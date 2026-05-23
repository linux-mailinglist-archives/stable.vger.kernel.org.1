Return-Path: <stable+bounces-253875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA4QJFYYEWqvhAYAu9opvQ
	(envelope-from <stable+bounces-253875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:00:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E883E5BCD62
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C8B3011C6A
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 02:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185902BEC27;
	Sat, 23 May 2026 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JgmS8NBN"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86F376025;
	Sat, 23 May 2026 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779504999; cv=none; b=GhxwTa4+1mBPnr+LZIqtvQkH/1Od1DOdCqmxfZ5YlW835647sMQMppJJb9g2jLebG6oLVwk03Y73sYcLmS0zKTLaNolaObpH6zwUjM49mNyRk2bUv6AQ6UJAXIqiPP9koWhUfIDWcAt/2BjQxWMYPizTv6ge+opc8VrQAN28QX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779504999; c=relaxed/simple;
	bh=GQzWw35zrqinDylvGH03fx1AQCiTiKXE5635iwV3taw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JK++YsvxvPSU3ddL0nO849kWQDLcIEAwEVxhflnT5/1h7fi68ZADVPBjXUELf6vJbl+262kZdkkxTCEDeiYc+htkIHbUYcV6mTTLkzmOBixsyrZfFDDEqyd7bmMtqYuASU5zqHx+VVNcq/mMYW85BnmCoemrJxo4iTHZUWrWrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JgmS8NBN; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iZ
	Q+09JvOw3FhUhCj63h5crYb6sZ7MTeftkWrJHDQkE=; b=JgmS8NBNb/vhbstIKo
	2AvacCfgxIHZMBg/6gjFgDeORXUguI/FLSXz9Ms+fT7+9+uxruxhLV0b1kTMEAQr
	vYR1/GKGgdEhbUmswXSI8N00I3Oart58+8SG7YtzRFHq9CIM1DHbZLTELlok6DaD
	ms3Dx2im/Zae2ZqJazviSdI3g=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCn74P5FhFqeFviCw--.57260S2;
	Sat, 23 May 2026 10:55:05 +0800 (CST)
From: w15303746062@163.com
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] drm/vblank: Reject 0-period timers to prevent hrtimer storm
Date: Sat, 23 May 2026 10:54:47 +0800
Message-Id: <20260523025447.581709-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fa91ccc0-7660-44fc-92a8-ab569ebe3a7c@suse.de>
References: <fa91ccc0-7660-44fc-92a8-ab569ebe3a7c@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn74P5FhFqeFviCw--.57260S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4UKry7tF4xZw1rur47CFg_yoW5JF1kpr
	s7Gryayry0yF4agFnrA3Z3ZFyFkasYqF4xKFyDGw43Aw1DKFy2yr1FkFW3KF47GrsrAw4a
	q3Z3XF4ruas8CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5EfOUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-wmmimoRFwmBcQAA3P
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
	TAGGED_FROM(0.00)[bounces-253875-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E883E5BCD62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Fuzzers like Syzkaller can submit extremely malicious display modes
through DRM_IOCTL_MODE_SETCRTC. If userspace passes a mode with a
massive pixel clock (crtc_clock) and small resolution (htotal/vtotal),
the integer division in drm_calc_timestamping_constants() truncates
the resulting frame duration (vblank->framedur_ns) to 0.

When virtual display drivers (such as vmwgfx or vkms) rely on the DRM
core's software vblank simulation, drm_crtc_vblank_start_timer() is
called. It blindly converts this 0-ns framedur_ns into a ktime interval
and starts the hrtimer. An hrtimer with a 0-period fires instantly and
continuously. Since hrtimer_forward_now() cannot advance time for a
0-period, the CPU gets locked in an infinite hard-IRQ loop, starving
the system and causing massive RCU stalls.

Fix this DoS vulnerability by adding a defensive sanity check in
drm_crtc_vblank_start_timer() to reject a 0-ns frame duration, allowing
the DRM core to gracefully reject the malicious mode.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
- Moved the defensive check from vmwgfx to drm_vblank.c. The timer
  logic was refactored into the DRM core, so placing the check here
  protects all drivers relying on the core software vblank timer.
- Dropped WARN_ON_ONCE() to prevent unprivileged userspace from easily
  triggering kernel panics on systems with panic_on_warn enabled.

 drivers/gpu/drm/drm_vblank.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..b38d0b30a651 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2241,6 +2241,16 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
+	/*
+	 * DEFENSIVE CHECK:
+	 * drm_calc_timestamping_constants() truncates framedur_ns to 0 if
+	 * userspace provides a malicious mode with a huge crtc_clock and
+	 * small htotal/vtotal. Prevent an infinite hard-IRQ loop from a
+	 * 0-period hrtimer by rejecting such modes.
+	 */
+	if (unlikely(vblank->framedur_ns == 0))
+		return -EINVAL;
+
 	spin_lock_irqsave(&vtimer->interval_lock, flags);
 	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
 	spin_unlock_irqrestore(&vtimer->interval_lock, flags);
-- 
2.34.1


