Return-Path: <stable+bounces-247776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMxoBD4lB2oEsQIAu9opvQ
	(envelope-from <stable+bounces-247776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:53:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F20550CDE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46CD8304BF03
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4498344D88;
	Fri, 15 May 2026 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SCeh9EG0"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F830CDAB;
	Fri, 15 May 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851204; cv=none; b=UW5+wIbudb11F6qPidovRMcsX8mlFvbKDt683JJzF6WCabGAeK090Wxm8siCsDG7IgGJ0fKVsnwbaD5MBiMNQwCwn2M9BrxINQAp6b/R+f/QdwNRnS6JGFgDysyAJi929KhfWJel1JsNd9OFeKOtotlg7HAd70SWduePGgHe+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851204; c=relaxed/simple;
	bh=cN1fpyZ4kPEdeTQSl1LMMS1O1F0D7s2Si2D16O3zNJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQleU+hHiPjjCuYUmUll9Q0V1Yh1OLEg8XSJQ+QOygSt3MLDo6sUtSP67CllavLwjaU1/vyVutQl+CfQL+qtc49jgnQcoDnVKTSzLnM6FbdceWA7sDLzpr+y74BUJDlaPoxebRbgd3+mLM5GK0AQkdSVtQxer8OLO7Gv9/Rt38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SCeh9EG0; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ja
	kKlb9ExpJdgqCHlw9NFJhDcPtPdk/qyu1krp2LcQM=; b=SCeh9EG0GlI+i173Py
	DM1m5RDvvgqKtAPu1WYYXwTSlf0zoiUt1nldNOhrevDL5nwjOzRUs427XR4Tl0hz
	CjDahfvgmr0egogM48AGWK9MbmsVTy6qAYJlkdWSQbyzrpx7QKR/9c97lHSciiuQ
	XsM0TEr/4yuJJ9RKXAGmj7AzU=
Received: from 163.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDX30gjHQdq0w7KEg--.17981S2;
	Fri, 15 May 2026 21:18:39 +0800 (CST)
From: <w15303746062@163.com>
To: louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable and timer callback
Date: Fri, 15 May 2026 21:18:26 +0800
Message-Id: <20260515131826.388154-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDX30gjHQdq0w7KEg--.17981S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrW8ZF4kur4kWF4xtFWDArb_yoW5Wr48pw
	s2vryxtr1UZF1jv3ZrAF4kur1S934fXFyfJrW0g34Yyw1rCF4xCFy8ta4agFW5Xr9rZa12
	qr4xtr15Zr1jkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeg4fUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAA+ukmoHHS9FGQAA3w
X-Rspamd-Queue-Id: 68F20550CDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[163.com:s=s110527];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247776-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	DKIM_TRACE(0.00)[163.com:+];
	TAGGED_RCPT(0.00)[stable];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.195];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xidian.edu.cn:email]
X-Rspamd-Action: add header
X-Spam: Yes

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

[Note: This patch addresses a legacy VKMS implementation deadlock specific
to older stable trees (e.g., 6.18.y). Mainline has removed this code during
the generic DRM_CRTC_VBLANK_TIMER_FUNCS refactoring.]

During local fuzzing with Syzkaller, an RCU preempt stall (soft lockup)
was observed. This is caused by an ABBA deadlock between the
drm_vblank_disable_and_save() function and the vkms_vblank_simulate()
hrtimer callback.

The race condition occurs as follows:

Thread A (CPU 3 - DRM_IOCTL_MODE_SETCRTC):
  - drm_vblank_disable_and_save() acquires `&dev->vblank_time_lock`.
  - Calls __disable_vblank() -> vkms_disable_vblank().
  - Calls hrtimer_cancel() to synchronously stop the vblank timer.
  - BLOCK: hrtimer_cancel() spins indefinitely waiting for the timer
    callback to finish executing on CPU 0.

Thread B (CPU 0 - hrtimer interrupt):
  - Executes the hrtimer callback vkms_vblank_simulate().
  - Calls drm_crtc_handle_vblank() -> drm_handle_vblank().
  - BLOCK: drm_handle_vblank() tries to acquire `&dev->vblank_time_lock`
    and spins forever because Thread A is holding it.

This patch fixes the deadlock by replacing hrtimer_cancel() with
hrtimer_try_to_cancel(). If the timer callback is running, try_to_cancel()
will safely return -1 and allow Thread A to proceed and release the lock.

Additionally, vkms_vblank_simulate() is modified to conditionally return
HRTIMER_NORESTART if drm_crtc_handle_vblank() fails (which it will,
because Thread A sets `vblank->enabled = false` immediately after
try_to_cancel). This acts as a self-destruct mechanism, preventing the
timer from blindly re-arming itself and causing an infinite loop of
DRM_ERROR messages.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index e60573e0f3e9..a62153b73548 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -57,7 +57,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 
 	dma_fence_end_signalling(fence_cookie);
 
-	return HRTIMER_RESTART;
+	return ret ? HRTIMER_RESTART : HRTIMER_NORESTART;
 }
 
 static int vkms_enable_vblank(struct drm_crtc *crtc)
@@ -77,7 +77,7 @@ static void vkms_disable_vblank(struct drm_crtc *crtc)
 {
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 
-	hrtimer_cancel(&out->vblank_hrtimer);
+	hrtimer_try_to_cancel(&out->vblank_hrtimer);
 }
 
 static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
-- 
2.34.1


