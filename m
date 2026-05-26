Return-Path: <stable+bounces-254357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMX7LvGiFWprWwcAu9opvQ
	(envelope-from <stable+bounces-254357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:41:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 169805D6AFC
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95EC631D95F8
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5173FDBE9;
	Tue, 26 May 2026 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hq6wihak"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33EE3FD133;
	Tue, 26 May 2026 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802381; cv=none; b=bDObms9aFWklH1sNP0MRPY2aBLJ/3MGAeN1qy1UVG23heT5piPXxJysAoE5YBcQOzVHWz4ulz+mFPrzrLKXEVeeilF1ny8bhRWoLS+bp8fkVAFsnyttowxAm1FLZzthFvZWXAGM2coklDAB7pwWOMywy2+OuoeSitd1L6IOYB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802381; c=relaxed/simple;
	bh=96sdcHFIzygI3sTd332mCW5JQKGfjIBya5Dkceyl0FU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9D2JKdOTFPPD0dHruXomgeVRu1AXOsDKFPfoAjZ99cE2EY0ZA0EIOiNKya7MRvbVdOFE949JhrCvgLgqwr7Umzo2hASU/+EnipCvr2G3z0YPspbS952tRri+eIbeEGK9bxWw6L1+/vgxsNgmaFbQjoRP66vmNjSC0DSvNVVwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hq6wihak; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=UEeCL38PHXnSztjS/6CD3ugZQl17GiH4O46J5Qeh2ow=;
	b=Hq6wihakIVrABfWAspSMpgZ4h9RCajB1RhhaOQz1G3Q5Y8BIelyUs5lyjJVI0I
	e3mn1lUeLX8Upyxm34xbvI+k9u0bMI/YMmRkOT+Z6SlHGp2pI3GMYe24vVe+I3+v
	iuyxHpCUjZITpMncf4HZGaioIKXMbsIYXfCgqKW8uzhHo=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3v0evoBVqYN9KDg--.14290S6;
	Tue, 26 May 2026 21:31:43 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	louis.chauvet@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+fcede535e7eb57cf5b43@syzkaller.appspotmail.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2 6.18.y 4/5] drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks()
Date: Tue, 26 May 2026 21:31:22 +0800
Message-Id: <20260526133123.691465-5-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526133123.691465-1-w15303746062@163.com>
References: <20260526133123.691465-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v0evoBVqYN9KDg--.14290S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW8Cw4kKrykXF13ZrWUArb_yoW8CFW3pF
	srKFyUtrsYqF1Dt34DAa1xZa4Y9ay7XFyIg3srtw1ruw4qyF9IyF1SvrW3GFyUZrsrur4a
	vas7Jr13Cr15CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFGQDUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAB83G2oVoL-2sQAA3U
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-254357-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,fcede535e7eb57cf5b43];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,intel.com:email,suse.de:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 169805D6AFC
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
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
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


