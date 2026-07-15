Return-Path: <stable+bounces-274913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sKljMH5yV2rJOAEAu9opvQ
	(envelope-from <stable+bounces-274913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:43:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B52475DA9D
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:43:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lq4Vz6ro;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274913-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274913-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D00F30FDF93
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE353CAA52;
	Wed, 15 Jul 2026 11:40:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD6432E86
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:40:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115632; cv=none; b=lB6NLzAA7nLCgqugXubvpc5PiaRbXDCT8mhkix04EgCStdHHnDtEcYRep4gpVav6XUqz61isi5G1CGFxlr+Ba6QHWw2oJBWSX5macUPA6TnmQTRCqQGA0RX5KJQ62KOUrqwTO8tYu9PPSoGO2bA+EJykwYPNQgMGH9hVW0g91qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115632; c=relaxed/simple;
	bh=ZEwZKYyldvKNhynBUvHSb+mLKSNFKo6h3cwHK3VO3Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WveNs1gSxiZd/JCnRn9qrm8ZeAGbY15LteElu2Eaxi2cfJ88aOvj+5gwYPxn+9p/L/yrdQzcJbbh9UnSOPBUGr5zRzU/p2mNODe+7NszWnoEFMIhgt7MyWVKFJ6+oU8BDs20QJMHcnpQ9924LNIz2Y1EbsSrCZ/+sDE99P5sCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq4Vz6ro; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F801F000E9;
	Wed, 15 Jul 2026 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115630;
	bh=h9kmBKQsdrzlK+TilHJHfTNXmk6LpqKY5X3mNianDF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lq4Vz6roZ7U0Fgc/ZpmZ8NKvAMzTiPyc38+4fk7E7J8E+FvAtO5szu99It6+vfeul
	 u5fRNJosWDNL3apeM90P3QCOQ3FPRtR+JbicejeMQDuVikC7TGdrujVYLdy6qZazau
	 DkwUgkQA8ClfsQLXY4eL2JFlDEsS9Tk5rvk0Cx0Tq9JRB1Jd57O4zZrA5VLPdnevqW
	 W851N/ob0G8/Gg50ljtBYB5tcB5rTgN6t2vRPiOL+45TjOW+sipAylD2eiToboKRax
	 XT4T+WJzpNI/krfcvsBSIfWpKFez9IpAlsZFKsSphFNTsXdvQfj1c5PEWMfqAnIIgh
	 0qmOExY1e3GbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] media: nxp: imx8-isi: use devm_pm_runtime_enable() to simplify code
Date: Wed, 15 Jul 2026 07:40:27 -0400
Message-ID: <20260715114028.727360-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071341-throttle-refurbish-8c48@gregkh>
References: <2026071341-throttle-refurbish-8c48@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274913-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:Frank.Li@nxp.com,m:laurent.pinchart@ideasonboard.com,m:hverkuil+cisco@kernel.org,m:sashal@kernel.org,m:hverkuil@kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B52475DA9D

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 078161dd44d6f848a62a473206d69025607736ec ]

Use devm_pm_runtime_enable() to simplify code. Change to use
dev_err_probe() because previous goto change to return.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20260116-cam_cleanup-v4-2-29ce01640443@nxp.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: b670bf89824e ("media: nxp: imx8-isi: Fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/nxp/imx8-isi/imx8-isi-core.c  | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index adc8d9960bf0df..da73a8cee0540a 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -488,13 +488,14 @@ static int mxc_isi_probe(struct platform_device *pdev)
 	dma_size = isi->pdata->has_36bit_dma ? 36 : 32;
 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_size));
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	ret = mxc_isi_crossbar_init(isi);
-	if (ret) {
-		dev_err(dev, "Failed to initialize crossbar: %d\n", ret);
-		goto err_pm;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize crossbar\n");
 
 	for (i = 0; i < isi->pdata->num_channels; ++i) {
 		ret = mxc_isi_pipe_init(isi, i);
@@ -517,8 +518,7 @@ static int mxc_isi_probe(struct platform_device *pdev)
 
 err_xbar:
 	mxc_isi_crossbar_cleanup(&isi->crossbar);
-err_pm:
-	pm_runtime_disable(isi->dev);
+
 	return ret;
 }
 
@@ -537,8 +537,6 @@ static void mxc_isi_remove(struct platform_device *pdev)
 
 	mxc_isi_crossbar_cleanup(&isi->crossbar);
 	mxc_isi_v4l2_cleanup(isi);
-
-	pm_runtime_disable(isi->dev);
 }
 
 static const struct of_device_id mxc_isi_of_match[] = {
-- 
2.53.0


