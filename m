Return-Path: <stable+bounces-180370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8109BB7F2E0
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4600E720297
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B222F33C76C;
	Wed, 17 Sep 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTdpogGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6933C765
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115091; cv=none; b=FLe0BEulfxeYK4QS6iEMik9bdLrfUfpiCTAdnWlvT/31SVV12G4frzXqrp8FTF1No+DvHNm2KzU9ylJQr0O6jRuCTobUCrClkd5ciYY5hWuCTv04WyXdi2IUNrn+VAST6KZxpiT6+T4eXcAsf/ow5mMnQvJnzAp85Oq7CDm2Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115091; c=relaxed/simple;
	bh=vHjh39rKns+2xFSG2qgLSw5hzV4LRHEoZA8acU1Xv8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtEN/d1wnuqIkso1Ri4uCnW0m0Lz5h/8IYTQ/x4TU2EUNx29I/IRZVm3fX47HL7mrLxt9h2n13IXbn8oGANI9LUTHaXUpXumJp14tB1jsiv7FuHOgHnn8dRUbIbFiRolTSD4GGEEu8iR7boHK/DOLGGXr+4shz9yqWcEvumvh2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTdpogGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C478C4CEFA;
	Wed, 17 Sep 2025 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115091;
	bh=vHjh39rKns+2xFSG2qgLSw5hzV4LRHEoZA8acU1Xv8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTdpogGX6huM4KHKZs/0Ddehmjm8fvgAnuBF1sCGyDOLfoo8BxTEj2jZVX5X0WLo9
	 ene5tgaESrnBahGCOhazxo5ESkKU7bBRmhelK3PoDi9kSS+/Uewp/e5BhqVZvOxHqv
	 JKgPu9cacZHqsQiij34JypizYxmsRsHAwZoEl62A8du5nSFMtFCd3YltMZ9xjS0wRf
	 /wucfNNt5i7JwiPqY0+RflOzxviaLOn3QeTrXqn9BKRmOREplLOe4Glm4dAKyPxumF
	 5d3I0emKsZUljIYBuWPe80GEBqMpRSoa8xO0iD72a7inG/E2g2EiBTXrp7cfUPVGqg
	 g1w4WSDi4O8Qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] phy: ti: omap-usb2: fix device leak at unbind
Date: Wed, 17 Sep 2025 09:18:07 -0400
Message-ID: <20250917131807.543316-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917131807.543316-1-sashal@kernel.org>
References: <2025091751-almanac-unused-2e7b@gregkh>
 <20250917131807.543316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 64961557efa1b98f375c0579779e7eeda1a02c42 ]

Make sure to drop the reference to the control device taken by
of_find_device_by_node() during probe when the driver is unbound.

Fixes: 478b6c7436c2 ("usb: phy: omap-usb2: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724131206.2211-3-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-omap-usb2.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 78e19b128962a..0fea766a98d75 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -363,6 +363,13 @@ static void omap_usb2_init_errata(struct omap_usb *phy)
 		phy->flags |= OMAP_USB2_DISABLE_CHRG_DET;
 }
 
+static void omap_usb2_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int omap_usb2_probe(struct platform_device *pdev)
 {
 	struct omap_usb	*phy;
@@ -373,6 +380,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
 	const struct usb_phy_data *phy_data;
+	int ret;
 
 	phy_data = device_get_match_data(&pdev->dev);
 	if (!phy_data)
@@ -423,6 +431,11 @@ static int omap_usb2_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 		phy->control_dev = &control_pdev->dev;
+
+		ret = devm_add_action_or_reset(&pdev->dev, omap_usb2_put_device,
+					       phy->control_dev);
+		if (ret)
+			return ret;
 	} else {
 		if (of_property_read_u32_index(node,
 					       "syscon-phy-power", 1,
-- 
2.51.0


