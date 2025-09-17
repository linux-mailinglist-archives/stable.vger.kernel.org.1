Return-Path: <stable+bounces-180377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165CB7F535
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64733B846A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73C2EB853;
	Wed, 17 Sep 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHKD9/r7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB98302CDC
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115794; cv=none; b=ZStyELGiBdX41OPE9yUAnrL23F4drkbIfxR1YO8QeR6+dm/k+XWw+I7K+Q9r/IfTexwcXZdnuZJGGKNm8VUh29o/oWor40p4ESBDeFWjCvhQC5w9em3iEFfrfuFrVWiMq5hMQRIYT/Z9R59G4ZhksnKyFKISqIyH64ni6frHEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115794; c=relaxed/simple;
	bh=MnafXCa2n/Nc6VzlL27pSeM+4ajM1enasNx+seZ8uGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR4EUFewLXgu2DjA6veBBYH0ra9AKzuLXhPYLa6AOGaSGQ6XyItoSCVZiB3v5jcDjf0zrXvRP9839uMcD1SfDYVOpntZVLk4z8Ld8ZafO99jPzSW4TdSMjEmV+4KhxYeqiFmseyY4sbBTXcuJXZYGfyOh+cVPl6bRqJJ1p8oaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHKD9/r7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A794C4CEFC;
	Wed, 17 Sep 2025 13:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115794;
	bh=MnafXCa2n/Nc6VzlL27pSeM+4ajM1enasNx+seZ8uGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHKD9/r76jV+qxgu16L5LIvTyP+f2AEn+i/+vx8Vr5rKmYQIA63MB3yEwKGhSnqxZ
	 I1tWRSMQidpJUNi2RQQVfS2wIurEzbIFtgw6PS/klOZFZ6ZueVbF72kGPKU2g5LTpw
	 K6fqW523gbw53aQIzPDS1ztRujj8KMEcoqv1SLm0V18shbnqTaygSChXFaMihLmqc4
	 jLvrQL/umWDL1Kr7Pq4nlTh78eyTkMLWhOdk4I4pzsw+h+XfwqOFLImAGOjtWmND5H
	 t76ZrL6h+6wgFsq2VCMDlxnnNicyIwKFGRAKRr1slCNe1cDyAv2Xp2vmWZtopx6a4U
	 /twVFYYoeLw4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] phy: ti: omap-usb2: fix device leak at unbind
Date: Wed, 17 Sep 2025 09:29:51 -0400
Message-ID: <20250917132951.550844-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917132951.550844-1-sashal@kernel.org>
References: <2025091751-geometry-screen-8bd7@gregkh>
 <20250917132951.550844-1-sashal@kernel.org>
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
index ec4a54d4f0d7a..913a6673f459f 100644
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


