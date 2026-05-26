Return-Path: <stable+bounces-254358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOumCPeiFWprWwcAu9opvQ
	(envelope-from <stable+bounces-254358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:41:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0F05D6B0A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C4973081428
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781C3FB072;
	Tue, 26 May 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G3HNf0FM"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF53FA5EC;
	Tue, 26 May 2026 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802393; cv=none; b=jYI3B6O7ABDxzaQ8jTDaeZkK2VeDIoJA+87zgHcuYN70LtYaVNuJSRnwgZH4xMbbxN5mkkfC3dBTFPpXn7uLTFM7ZNA1c43LKIXAQchYPJijneGt7qKVMxodp8K/P5o+pAiHah/Wqr35kHOV1vlcFjtsmGql1LCaVEE3QbilZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802393; c=relaxed/simple;
	bh=8c455aXFF7HLlHYcNMeNADliusp09afhq5rjFXml4XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G9BNA0gikUrqsluLedvoScYhOp5YmE/EZjbl4bthpzS3ednaqkNAjtTPbNEVaq/MML0fp8loZzRerFG0hivUQZo8DYG5cNFU2kodqys9NRCGFJJwiZpyvKWMn4a5+2Z8Hr4moWafS6eI281egyL7KxqIRNtDxPG6VSS8N4oyyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G3HNf0FM; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1N
	4mxlQmcxLBqdU9q8trXnA6PzPq3w4ggMHk2XEFBAc=; b=G3HNf0FMpBpjlMusbE
	L2dD3uUhcARQYiHVYysLKrYXcjPGeYn5hx9AM5TgIifYYyrHzSq3MwRml3HUvLWq
	dYB8n9WS3hMQvbwWOH65NoAHwKYHqs/Suudj5vTMG5C3Jo5UtUxx1xdYT9qKWak9
	z5m5z9jEbdsJUIKi1mdZYsv/4=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3v0evoBVqYN9KDg--.14290S7;
	Tue, 26 May 2026 21:31:45 +0800 (CST)
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
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Javier Martinez Canillas <javierm@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2 6.18.y 5/5] drm/vblank: Fix kernel docs for vblank timer
Date: Tue, 26 May 2026 21:31:23 +0800
Message-Id: <20260526133123.691465-6-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526133123.691465-1-w15303746062@163.com>
References: <20260526133123.691465-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v0evoBVqYN9KDg--.14290S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWUKryfuw4rWFykZw17Awb_yoW8Aw48pr
	srGry3trs5tF90g3WDC3Z7CFyY9a45JFyxuF9rt3y5Zwnayr1ayF1Fyr43uFyUXrnxCa1a
	qr9xXr13AF1rCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFXdbUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wE4HGoVoMF7xwAA3k
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254358-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[suse.de,linux.intel.com,kernel.org,bootlin.com,lists.freedesktop.org,vger.kernel.org,canb.auug.org.au,redhat.com,gmail.com,ffwll.ch,stu.xidian.edu.cn];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,auug.org.au:email,intel.com:email,suse.de:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9D0F05D6B0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Zimmermann <tzimmermann@suse.de>

Fix documentation for drm_crtc_vblank_start_timer(), which referred
to drm_crtc_vblank_cancel_timer().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/dri-devel/20251106152201.6f248c09@canb.auug.org.au/
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://patch.msgid.link/20251106073207.11192-1-tzimmermann@suse.de
(cherry picked from commit 3946d3ba99342f3b9996e621f05e7003d4308171)
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 61e211fd3c9c..451ec9620226 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2258,7 +2258,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 EXPORT_SYMBOL(drm_crtc_vblank_start_timer);
 
 /**
- * drm_crtc_vblank_start_timer - Cancels the given CRTC's vblank timer
+ * drm_crtc_vblank_cancel_timer - Cancels the given CRTC's vblank timer
  * @crtc: the CRTC
  *
  * Drivers should call this function from their CRTC's disable_vblank
-- 
2.34.1


