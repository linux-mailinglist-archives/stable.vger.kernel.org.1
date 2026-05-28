Return-Path: <stable+bounces-254980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLm9JkNBGGrIhwgAu9opvQ
	(envelope-from <stable+bounces-254980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:21:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5595F2A32
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4DAA3053C8B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C93F39FC;
	Thu, 28 May 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B2YKoIo+"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B303F39D3;
	Thu, 28 May 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974372; cv=none; b=d1ZqWqAsr76kztzlp5g56u/eeFdGlwSkrxHtCU027cuWSqZjkZ6CbnJSVHKAx2PhkLlQc0fnWiN3MaVKuYhZ9HuVCsz7b7basGhj0zI1PrHODNAQI2rrl8Ictf/ZC3FeDmfyfiZasIlc/WCH0OCeVun4ilObe+8jlksGkZhNrb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974372; c=relaxed/simple;
	bh=N4rIG6n/PqilyxtxEPYBrE4PIrFlZtS30+eRLKAQxEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrYZngy19Xv8Qr9nj0Mf9OwdHvUsijZRme4kUQiXWVQRsQSFe2Sf0BP7r9h9aYaNKYW+sRPUZhMzaW//ivRYRn/sW8U0aO+jJRFKf79xh54RzbsahfllnfP97JovvspNVG0F9dFh6IlNDL88VeFH3XOU3m4YMLwnv3iaOHGyH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B2YKoIo+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ye
	z8QRDeKKQnQ8dYgCq8BDZ1EGknlWfbs50O87oXkfg=; b=B2YKoIo+j/oDDrhoaV
	2iEIh2A5FODVsPudvAmbbPl5leYZmV53/H6P/n8s3E6P7qDRysDsYK9zUO5RjiGT
	0/jCw0aVhSwIVmz7jL6Etrwr2s55EQBmpRxAEmlidtdAZ0bmJhkS1hJLIHEPEmzz
	6WX1EIkBBEOoSGiHickeDzhtc=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD373KaQBhq1y1jAA--.16331S2;
	Thu, 28 May 2026 21:18:22 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y 1/2] drm/fbdev-helper: Set and clear VGA switcheroo client from fb_info
Date: Thu, 28 May 2026 21:18:16 +0800
Message-ID: <20260528131817.59900-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD373KaQBhq1y1jAA--.16331S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFy8Ar1xKFy7KFyUJr45trb_yoW5ur4DpF
	W3GFW5Kr4ktF4UWwnru3Wjva43AwsxCFy8urs7Gw4avw1jyryS9Fn8Ary09FW5Gr1xJr1j
	yw1YyF18uF1kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE7PEsUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxB-XoGoYQJ85swAA3L
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254980-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,redhat.com,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: AF5595F2A32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 02257549daf7ff839e2be6d4f3cac975e522fd7a ]

Call vga_switcheroo_client_fb_set() with the PCI device from the
instance of struct fb_info. All fbdev clients now run these calls.
For non-PCI devices or drivers without vga-switcheroo, this does
nothing. For i915 and radeon, it allows these drivers to use a
common fbdev client.

The device is the same as the one stored in struct drm_client and
struct drm_fb_helper, so there is no difference in behavior. Some
NULL-pointer checks are being removed, where those pointers cannot
be NULL.

v4:
- clarify call semantics for drm_fb_helper_unregister_info() (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.98201-3-tzimmermann@suse.de
[ The variable 'dev' in the function drm_fb_helper_single_fb_probe() is
unused; remove it in v6.6. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index b507c1c008a3..eee7b56d441f 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -567,7 +567,7 @@ EXPORT_SYMBOL(drm_fb_helper_release_info);
 
 /**
  * drm_fb_helper_unregister_info - unregister fb_info framebuffer device
- * @fb_helper: driver-allocated fbdev helper, can be NULL
+ * @fb_helper: driver-allocated fbdev helper, must not be NULL
  *
  * A wrapper around unregister_framebuffer, to release the fb_info
  * framebuffer device. This must be called before releasing all resources for
@@ -575,8 +575,12 @@ EXPORT_SYMBOL(drm_fb_helper_release_info);
  */
 void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
 {
-	if (fb_helper && fb_helper->info)
-		unregister_framebuffer(fb_helper->info);
+	struct fb_info *info = fb_helper->info;
+	struct device *dev = info->device;
+
+	if (dev_is_pci(dev))
+		vga_switcheroo_client_fb_set(to_pci_dev(dev), NULL);
+	unregister_framebuffer(fb_helper->info);
 }
 EXPORT_SYMBOL(drm_fb_helper_unregister_info);
 
@@ -1668,8 +1672,8 @@ static int drm_fb_helper_find_sizes(struct drm_fb_helper *fb_helper,
 static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 {
 	struct drm_client_dev *client = &fb_helper->client;
-	struct drm_device *dev = fb_helper->dev;
 	struct drm_fb_helper_surface_size sizes;
+	struct fb_info *info;
 	int ret;
 
 	ret = drm_fb_helper_find_sizes(fb_helper, &sizes);
@@ -1687,9 +1691,11 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 
 	strcpy(fb_helper->fb->comm, "[fbcon]");
 
+	info = fb_helper->info;
+
 	/* Set the fb info for vgaswitcheroo clients. Does nothing otherwise. */
-	if (dev_is_pci(dev->dev))
-		vga_switcheroo_client_fb_set(to_pci_dev(dev->dev), fb_helper->info);
+	if (dev_is_pci(info->device))
+		vga_switcheroo_client_fb_set(to_pci_dev(info->device), info);
 
 	return 0;
 }
-- 
2.43.0


