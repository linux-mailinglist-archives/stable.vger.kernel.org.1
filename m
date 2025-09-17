Return-Path: <stable+bounces-180394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D90B7FA42
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0FF52470D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A41C6FFA;
	Wed, 17 Sep 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqYs64C5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225CA31618F
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117311; cv=none; b=OX0oByp0K/3WlRYyeZZfPmtKoSDhOOoi67qYJBIjSQ2NVDyPoVISq+BHbFfhxCytUiHUGIBKLCBYuJfBhnbPYrGHXCzmGsKbX0Fx20A3/UvhB76enk4ZU22LMGnJO4O9CVrrgYJmkymMMlfyTqx5Y7KR+FPitqeG9hsNW+bkkfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117311; c=relaxed/simple;
	bh=8leQjEPLXkRxssTfI+mFFCIn7AiHJsZSfyqddCF6/XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuV+LRXVk7MUOqiyhs7yjAadCe+sRyBevVc0NhAGeQPsf5EDuBpT7YCzrRDVS0wFkiZNK0+csTdzfH68/KC14/LUKFYN6H9ge4US2vwEanC4lugU3CAoUpH+H1IUOFThggBWJy3cXRlLCR/mva7KGm4INC/r2ItprILFMcsv3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqYs64C5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177E0C4CEF7;
	Wed, 17 Sep 2025 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758117310;
	bh=8leQjEPLXkRxssTfI+mFFCIn7AiHJsZSfyqddCF6/XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqYs64C5+9prM4EhZxVfbD77pMJwF8h2kSzZlo+75dFwvV1b7CzS2byCOLRRGDxy9
	 EJAiyjKq/ogp4dO5nWiLVWgmM79UFfzHOLyRQrBoZGltxjTHZIFoPD2+3NphhrcISM
	 AVejFbQvw14eKjx23PBwRgkiJev6OwZYlwPB6EPO7I135S5WQS+xS2ugBFJh2G40fD
	 XD8Ri2/urzcO0WF/dlg7VLFz6qX/lxZZjYsnE42BAFij7KAh6SfjguVYG4AsR+hskn
	 VhwEfpayuDZjN+ztid1H2iA/xeCmZ3G1O7XiG+w129I7hIuk9NLLcUIbDNeuXMZYV5
	 UCnWmWcn1VkYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/6] phy: ti: omap-usb2: fix device leak at unbind
Date: Wed, 17 Sep 2025 09:55:02 -0400
Message-ID: <20250917135502.565547-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917135502.565547-1-sashal@kernel.org>
References: <2025091752-daycare-art-9e78@gregkh>
 <20250917135502.565547-1-sashal@kernel.org>
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
index dd55f4db72707..5a80d77c72b9d 100644
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


