Return-Path: <stable+bounces-169819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C93CB286DA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796251CC26D8
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3512561C9;
	Fri, 15 Aug 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQQi9cWu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6031770C
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288223; cv=none; b=nOt0323kTeNXkBY17Q1N8BdohQdJc6DcuDdsRphPXq8DedEajD8p+241gGpGCTOMcMR5t2ENZn4owGcobcmm81YmBGzi7qqpFibFShqn1a/nM4cdl+ETx78uRlgVf3R2LQSGsBsJbqCEP73NHSD/PtPA14WbTm08Sy5dYnsI7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288223; c=relaxed/simple;
	bh=9meDaXk9yCeVuJjchKnr52PfhWBqvXUDonXqDQeaJoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuITiFohBeLWl+3qnaahnJRsGc60i6EPHgB7mQNizbSk45HPZA3KnNkEaA2klylcZ+Jvzxg9Q7RsheqT28NEQ630KkPV8FRlyy1ZCrw5SdYo/X9YjyzSXi2TsTBnBPFqasnrthisQ5J0/Cir/1M9xUCRYU4stBIkoMDEXQ2lx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQQi9cWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097E8C4CEEB;
	Fri, 15 Aug 2025 20:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755288221;
	bh=9meDaXk9yCeVuJjchKnr52PfhWBqvXUDonXqDQeaJoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQQi9cWuwGwg8tdn+s9hfDxusOSfwQJ015WaqvG9snw/JJFWuU94QnIhJRZ+ldmlU
	 m6bEFOwDtVL6C9gwKh185SXs6Rd+57bPUR0S/W9iFtWI7lxL1d/bhvCqpTeVt/U9TS
	 Dk/VqC3SHxuYmvl+U6BYy5THbhK5vPiIqFp/AfgGEE+ah2TsNBnPBD24KznI+Q81cp
	 DCIJ8Mdkqu0m9d7aXbhrfrrMukIOL+4NpAOYJMdxM4Wq5EPuSDex63ZpcDX8N2YsN/
	 ex/MnpxZO4Uuz8lc8gD52r/CAChOO7ETUDu2eXwqAdkhUahd9C1Dm7ZENDjEBF8eUI
	 hfu0WLKZtd+zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: enetc: fix device and OF node leak at probe
Date: Fri, 15 Aug 2025 16:03:37 -0400
Message-ID: <20250815200337.201844-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081557-glimmer-distill-dc47@gregkh>
References: <2025081557-glimmer-distill-dc47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 70458f8a6b44daf3ad39f0d9b6d1097c8a7780ed ]

Make sure to drop the references to the IERB OF node and platform device
taken by of_parse_phandle() and of_find_device_by_node() during probe.

Fixes: e7d48e5fbf30 ("net: enetc: add a mini driver for the Integrated Endpoint Register Block")
Cc: stable@vger.kernel.org	# 5.13
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250725171213.880-3-johan@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 5efb079ef25f..c2fdf8405243 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1206,6 +1206,7 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct platform_device *ierb_pdev;
 	struct device_node *ierb_node;
+	int ret;
 
 	/* Don't register with the IERB if the PF itself is disabled */
 	if (!node || !of_device_is_available(node))
@@ -1213,16 +1214,25 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 
 	ierb_node = of_find_compatible_node(NULL, NULL,
 					    "fsl,ls1028a-enetc-ierb");
-	if (!ierb_node || !of_device_is_available(ierb_node))
+	if (!ierb_node)
 		return -ENODEV;
 
+	if (!of_device_is_available(ierb_node)) {
+		of_node_put(ierb_node);
+		return -ENODEV;
+	}
+
 	ierb_pdev = of_find_device_by_node(ierb_node);
 	of_node_put(ierb_node);
 
 	if (!ierb_pdev)
 		return -EPROBE_DEFER;
 
-	return enetc_ierb_register_pf(ierb_pdev, pdev);
+	ret = enetc_ierb_register_pf(ierb_pdev, pdev);
+
+	put_device(&ierb_pdev->dev);
+
+	return ret;
 }
 
 static int enetc_pf_probe(struct pci_dev *pdev,
-- 
2.50.1


