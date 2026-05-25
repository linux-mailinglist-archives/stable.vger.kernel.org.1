Return-Path: <stable+bounces-254140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ODIDwhMFGpeMQcAu9opvQ
	(envelope-from <stable+bounces-254140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:18:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 983095CAFD6
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82A3C3020D77
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACBC383C64;
	Mon, 25 May 2026 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TNGTNuAC"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A23845DA;
	Mon, 25 May 2026 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715046; cv=none; b=SikYc3OtjHqoesa3BY1YabS6wIduXFDI8kMeE97S7TjMCgGdn77l/8RoxmoxUmTk3dXQUequjIpJwlZoY9xCjPRNpNUrDz4m4fGHAeN/S+w+tc9EK7EjW2GLqBj6I3WAmL/zv9Q3ZmHkg0pUZpOTHpOQm83JK8naUuEkrfevZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715046; c=relaxed/simple;
	bh=OUW9bl26bb+Q+oa1tnBK5tR+NvBRu2xiNJkSjug3MMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QD955of7kpcvSApAteblEBW1sJN/xFAjEf6QcC+roLnuaarrF9jluh7/TIZ4h/yJNlf6qa6RrQ0MT5kERXbiqfvzBbinHo212ckm8b5AtO+zDVs//3nnogTeu+yELtgiCL5LPnM0pi03lpks7jk0Tpxiki4K4RWBtph63IZAe78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TNGTNuAC; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=jkxJ5f3f/j7/q+DreNfcQpbMX/8ZUWY7GFS2AQQxBHw=;
	b=TNGTNuACXLxB+XvxOVOwkK0oG+tUYCilxGpS/48j87BUFSmrmM7vI45no8xn+Z
	s+jMMK7oxqp3ccMcJ2Q7kMq024YeugT0JIiqe6R9esnYf1FLm0lVApEeO0Zaw9f1
	Mbr63usa33chDhzX9v6+/5T6V/2NPEl1xb/E8rTWN2hQY=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCn6zidSxRqC7WEDQ--.19334S6;
	Mon, 25 May 2026 21:16:33 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	louis.chauvet@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+fcede535e7eb57cf5b43@syzkaller.appspotmail.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 6.18.y 4/5] drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks()
Date: Mon, 25 May 2026 21:16:09 +0800
Message-Id: <20260525131610.608273-5-w15303746062@163.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn6zidSxRqC7WEDQ--.19334S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW8Cw4kKrykXF13ZrWUArb_yoW8Cry8pF
	srKFW7trsYqF4Dt3srAa1kZa4Y93y3XFyIg3s7tw1fuw4qyr90yF1FvrW3GFyUZrsrWr4a
	vas7tr13Cr15CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz4E_UUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5BKegmoUS7LN8wAA3T
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254140-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,fcede535e7eb57cf5b43];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,intel.com:email,appspotmail.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 983095CAFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Zimmermann <tzimmermann@suse.de>

Increase the timeout for vblank events from 100 ms to 1000 ms. This
is the same fix as in commit f050da08a4ed ("drm/vblank: Increase
timeout in drm_wait_one_vblank()") for another vblank timeout.

After merging generic DRM vblank timers [1] and converting several
DRM drivers for virtual hardware, these drivers synchronize their
vblank events to the display refresh rate. This can trigger timeouts
within the DRM framework.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/dri-devel/20250904145806.430568-1-tzimmermann@suse.de/ # [1]
Reported-by: syzbot+fcede535e7eb57cf5b43@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/dri-devel/69381d6c.050a0220.4004e.0017.GAE@google.com/
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Link: https://patch.msgid.link/20251209143325.102056-1-tzimmermann@suse.de
(cherry picked from commit 79ae8510b5b81b9500370f89c619b50ca9c0990f)
---
 drivers/gpu/drm/drm_atomic_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index d5ebe6ea0acb..f9d328dcaed8 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1837,7 +1837,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 		ret = wait_event_timeout(dev->vblank[i].queue,
 					 state->crtcs[i].last_vblank_count !=
 						drm_crtc_vblank_count(crtc),
-					 msecs_to_jiffies(100));
+					 msecs_to_jiffies(1000));
 
 		WARN(!ret, "[CRTC:%d:%s] vblank wait timed out\n",
 		     crtc->base.id, crtc->name);
-- 
2.34.1


