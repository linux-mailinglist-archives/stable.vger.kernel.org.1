Return-Path: <stable+bounces-226869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O5nKImWuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:59:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E622B0774
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D05831C34D2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C33246F8;
	Tue, 17 Mar 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f8QFAt9C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E115E5BB;
	Tue, 17 Mar 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768542; cv=none; b=MaX6CSlWBgtwwWBbUfw+Ge5EiAXWbpnW7IUc9BH9aC1PsBvli4nzxda87pnl2fSP02nxdjVTeaeq0Are0V9Tgtut5GnkuA6oM6EvR36lnd0DT90bIXChyG+sV6gu9RwCxdafSPRUpV2xoRwKWqg24GThnHZfOHvtefa3CNVRlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768542; c=relaxed/simple;
	bh=w/iDeFhTc5spp1eqOYsy2mM03aGC7GJuu15+pRpTvuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZHEtTD7sS61C5b6QtyRGkXLSAgL/dMvWUbFZMrYps5RkMNjQ/IJEiYZo/qcgbp0dV9GSOaCmcpF3VXHj8W5XerEdUs9yb0Hp7gYE6dZBI5+7xXNam5fCh0pXtnyibbJVw2ClvVyy9z6aeLqVS8WFgsGv8qIL7PCru859F5At2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f8QFAt9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D9DC4CEF7;
	Tue, 17 Mar 2026 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768542;
	bh=w/iDeFhTc5spp1eqOYsy2mM03aGC7GJuu15+pRpTvuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8QFAt9CxY1N7RvBJ70JKHkzck4peYL53dDqDzkwZVOvr1jRjwX+vVmwh0zHTXqse
	 1WDPFkgQ6Nm7l7MMjAqE4CWzRQa1wvzqzmBsGcbKH035gTN58RwRdb6j9WZf1txrOp
	 q9WWclbsL2o3URraRsapAnhHccBn+51nHVnpOLPo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ruben Wauters <rubenru09@aol.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 317/333] drm/gud: rearrange gud_probe() to prepare for function splitting
Date: Tue, 17 Mar 2026 17:35:46 +0100
Message-ID: <20260317163011.139033171@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226869-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,aol.com,suse.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,suse.de:email]
X-Rspamd-Queue-Id: 16E622B0774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/gud/gud_drv.c |   45 ++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -249,7 +249,7 @@ int gud_usb_set_u8(struct gud_device *gd
 	return gud_usb_set(gdrm, request, 0, &val, sizeof(val));
 }
 
-static int gud_get_properties(struct gud_device *gdrm)
+static int gud_plane_add_properties(struct gud_device *gdrm)
 {
 	struct gud_property_req *properties;
 	unsigned int i, num_properties;
@@ -463,10 +463,6 @@ static int gud_probe(struct usb_interfac
 		return PTR_ERR(gdrm);
 
 	drm = &gdrm->drm;
-	drm->mode_config.funcs = &gud_mode_config_funcs;
-	ret = drmm_mode_config_init(drm);
-	if (ret)
-		return ret;
 
 	gdrm->flags = le32_to_cpu(desc.flags);
 	gdrm->compression = desc.compression & GUD_COMPRESSION_LZ4;
@@ -483,11 +479,28 @@ static int gud_probe(struct usb_interfac
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
@@ -587,6 +600,7 @@ static int gud_probe(struct usb_interfac
 			return -ENOMEM;
 	}
 
+	/* Pipeline init */
 	ret = drm_universal_plane_init(drm, &gdrm->plane, 0,
 				       &gud_plane_funcs,
 				       formats, num_formats,
@@ -598,12 +612,9 @@ static int gud_probe(struct usb_interfac
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
 
@@ -621,16 +632,7 @@ static int gud_probe(struct usb_interfac
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
 
@@ -638,7 +640,8 @@ static int gud_probe(struct usb_interfac
 	if (ret)
 		return ret;
 
-	drm_kms_helper_poll_init(drm);
+	devm_kfree(dev, formats);
+	devm_kfree(dev, formats_dev);
 
 	drm_client_setup(drm, NULL);
 



