Return-Path: <stable+bounces-226031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G/gOaxouWmZDwIAu9opvQ
	(envelope-from <stable+bounces-226031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:43:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 723BA2AC33A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A0C31EC8FC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490823E5596;
	Tue, 17 Mar 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDY3/HHK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76F3E556F
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757730; cv=none; b=XrmxUEh7/4eACeU/m+VkpUkr+ZTk9736AYgWE7mL1nMakJuXEAWSfxSoTuOkp0CMM2CNHAGWwqVKzeoVrWD1Mn1PCqOAfSn+em8361PUPnXmU80ay+5ZgosSlNptW5q/EasvnmOv6yYapLnPdeyYSuLNClR/7phF8pG7yOiIg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757730; c=relaxed/simple;
	bh=RiePVk6YY1FNsBRidGimMkD5mhQJ+CtHoXTyTa6fcJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUCzkSbMhoCP7b7AoIUSVkcVdeXO8jjkzysjqnXiCt9vkEMb7yRnjQAn6apj+ow/pa+mYs8zpBb8d9UDYPXrGDCHBEaEFeQ9e+U2kx2dpT0kYcgpSwxcN+s+W71egsi2v+kbup0QddOaZT5TUwPhCyBRwOTci1NIui/Peq/PQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDY3/HHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84F5C4CEF7;
	Tue, 17 Mar 2026 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773757730;
	bh=RiePVk6YY1FNsBRidGimMkD5mhQJ+CtHoXTyTa6fcJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDY3/HHKmJcsoZDfWJbwrcTa3xhegJcDNjVoe8+BR0lEvgCrohOHDisajuJGXN3Zm
	 jiqLzASKr0YcnnnueycttpugsfIYdR067KDybYMfvafVaXf1XQ6w7mha7+L9rGeUfM
	 WYWm7vnbK/spCN6rtwb2rlVGkZzM6Fe1DGNra+6e0dRnxIkfedUHm1b4smUMYhoV/C
	 6dnU99QVQJijltXGfgWjviKNQdUdiFWQfrdAeCcyq0D1+exUHYIVo/Tfn31dD534tS
	 kfBLRnwUlijYNV432znum0l1r37Y5Hme+iE256poIg+rOf29yeNItwkgYf2wLm2ovf
	 KywPDLl0TMa2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruben Wauters <rubenru09@aol.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] drm/gud: rearrange gud_probe() to prepare for function splitting
Date: Tue, 17 Mar 2026 10:28:46 -0400
Message-ID: <20260317142847.165695-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031703-footpad-unpaved-0a7a@gregkh>
References: <2026031703-footpad-unpaved-0a7a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[aol.com,suse.de,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226031-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 723BA2AC33A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ruben Wauters <rubenru09@aol.com>

[ Upstream commit b9e5e9d2c187b849e050d59823e8c834f78475ab ]

gud_probe() is currently very large and does many things, including
pipeline setup and feature detection, as well as having USB functions.

This patch re-orders the code in gud_probe() to make it more organised
and easier to split apart in the future.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20251020140147.5017-1-rubenru09@aol.com/
Stable-dep-of: 7149be786da0 ("drm/gud: fix NULL crtc dereference on display disable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gud/gud_drv.c | 45 +++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index b7345c8d823de..42135a48d92ef 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -249,7 +249,7 @@ int gud_usb_set_u8(struct gud_device *gdrm, u8 request, u8 val)
 	return gud_usb_set(gdrm, request, 0, &val, sizeof(val));
 }
 
-static int gud_get_properties(struct gud_device *gdrm)
+static int gud_plane_add_properties(struct gud_device *gdrm)
 {
 	struct gud_property_req *properties;
 	unsigned int i, num_properties;
@@ -463,10 +463,6 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		return PTR_ERR(gdrm);
 
 	drm = &gdrm->drm;
-	drm->mode_config.funcs = &gud_mode_config_funcs;
-	ret = drmm_mode_config_init(drm);
-	if (ret)
-		return ret;
 
 	gdrm->flags = le32_to_cpu(desc.flags);
 	gdrm->compression = desc.compression & GUD_COMPRESSION_LZ4;
@@ -483,11 +479,28 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (ret)
 		return ret;
 
+	usb_set_intfdata(intf, gdrm);
+
+	dma_dev = usb_intf_get_dma_device(intf);
+	if (dma_dev) {
+		drm_dev_set_dma_dev(drm, dma_dev);
+		put_device(dma_dev);
+	} else {
+		dev_warn(dev, "buffer sharing not supported"); /* not an error */
+	}
+
+	/* Mode config init */
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
 	drm->mode_config.min_width = le32_to_cpu(desc.min_width);
 	drm->mode_config.max_width = le32_to_cpu(desc.max_width);
 	drm->mode_config.min_height = le32_to_cpu(desc.min_height);
 	drm->mode_config.max_height = le32_to_cpu(desc.max_height);
+	drm->mode_config.funcs = &gud_mode_config_funcs;
 
+	/* Format init */
 	formats_dev = devm_kmalloc(dev, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
 	/* Add room for emulated XRGB8888 */
 	formats = devm_kmalloc_array(dev, GUD_FORMATS_MAX_NUM + 1, sizeof(*formats), GFP_KERNEL);
@@ -587,6 +600,7 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 			return -ENOMEM;
 	}
 
+	/* Pipeline init */
 	ret = drm_universal_plane_init(drm, &gdrm->plane, 0,
 				       &gud_plane_funcs,
 				       formats, num_formats,
@@ -598,12 +612,9 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	drm_plane_helper_add(&gdrm->plane, &gud_plane_helper_funcs);
 	drm_plane_enable_fb_damage_clips(&gdrm->plane);
 
-	devm_kfree(dev, formats);
-	devm_kfree(dev, formats_dev);
-
-	ret = gud_get_properties(gdrm);
+	ret = gud_plane_add_properties(gdrm);
 	if (ret) {
-		dev_err(dev, "Failed to get properties (error=%d)\n", ret);
+		dev_err(dev, "Failed to add properties (error=%d)\n", ret);
 		return ret;
 	}
 
@@ -621,16 +632,7 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	}
 
 	drm_mode_config_reset(drm);
-
-	usb_set_intfdata(intf, gdrm);
-
-	dma_dev = usb_intf_get_dma_device(intf);
-	if (dma_dev) {
-		drm_dev_set_dma_dev(drm, dma_dev);
-		put_device(dma_dev);
-	} else {
-		dev_warn(dev, "buffer sharing not supported"); /* not an error */
-	}
+	drm_kms_helper_poll_init(drm);
 
 	drm_debugfs_add_file(drm, "stats", gud_stats_debugfs, NULL);
 
@@ -638,7 +640,8 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (ret)
 		return ret;
 
-	drm_kms_helper_poll_init(drm);
+	devm_kfree(dev, formats);
+	devm_kfree(dev, formats_dev);
 
 	drm_client_setup(drm, NULL);
 
-- 
2.51.0


