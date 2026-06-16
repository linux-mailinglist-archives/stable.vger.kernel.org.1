Return-Path: <stable+bounces-264862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UEZeMrt+MWpbkwUAu9opvQ
	(envelope-from <stable+bounces-264862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:50:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E946927ED
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:50:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=roLGj11D;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264862-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264862-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC9C5300DF6B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA2A32ED55;
	Tue, 16 Jun 2026 16:44:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52436493F;
	Tue, 16 Jun 2026 16:44:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628281; cv=none; b=ffpvHywStofFi0mm11xE42aayTO2W0MmNnHrSrT5pu40ILoBrZ3IxnOxomqe527Yx79XptTkEboB5Nvm8M+1xeH1776oyhFejVy+o6QWlWW98g2nULHCczqIVfIDwxc4En4zDyQM0hwMOtLHWux8viPjqwlIWDgd37GQIZkkQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628281; c=relaxed/simple;
	bh=0Wn+fwuRruur8S45AlFeIFv2gDQmKt8BFI5wM+LzDO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWIVcI54BOoQag3LkWunUHjSZY0MD75kn18BZt8LH02zJcY32DdRCSozlsvMdTOpzeyF1CjAvzIJ0dJoPkKR9AmkO9Ln/CEiwluSzrC6n5kwMwYujSyskN5k2DxfcNVO7zvYET/VjNYhg87qXtS3VBmXHn/xzvdCikEL2tWo/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=roLGj11D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FFF1F000E9;
	Tue, 16 Jun 2026 16:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628280;
	bh=6+SskHldMZWryoZDFsGE3Kj64T5MfhL6AFdQRrR5pnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=roLGj11DJKntYqAKlj3LUiJQAGy/QHmogtDTmndkOttO5ufFmVBGOjkIPQodvEAC6
	 OD22Ez/IxNNK7bC2Xj/jhVukz8W5ttkaGkl+WOgZRLb5bwnwwig2INGR6oqUC3EHoM
	 RrYH1cK/aVhZ/jk4Vb2EaelkpYL3qu7X57wpxlbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Wenshan Lan <jetlan9@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 065/452] drm/fbdev-helper: Set and clear VGA switcheroo client from fb_info
Date: Tue, 16 Jun 2026 20:24:52 +0530
Message-ID: <20260616145121.356199655@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.de,redhat.com,163.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264862-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:tzimmermann@suse.de,m:javierm@redhat.com,m:jetlan9@163.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,patchwork.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21E946927ED

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index b507c1c008a3e9..eee7b56d441f71 100644
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
2.53.0




