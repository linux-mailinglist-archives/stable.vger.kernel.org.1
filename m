Return-Path: <stable+bounces-172506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D2B322B4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FA36270FC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F42D0C94;
	Fri, 22 Aug 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReOxIhQq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51135253B4C
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890274; cv=none; b=rH7hiKToh4/jKUpiK31NftFhUDLx5TXfs61Etva5Ous2Tc/uF4pwFe5Uha/jp6sYeFJTF3yIuLNcQtqqd8EAolAP6NsGBpjI5e6E1PJLWNDKj4aW4Vibl5cPP/ZOo2hxMWn6mQEaQ+PdXK9dsvwW2ozaLdi9iPU2gVwyE+LBrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890274; c=relaxed/simple;
	bh=l2G5Uq1Nyd2VWE/fQbpU7Be9UY5kzrYLsd77Zw2gXmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1aivzank5YwAnkcQQkslfylp+0uNWHlCKdLzxEEasicvwIWlUPH3ZyyZYtNiclUE4kHn1yI1mQJOo6mVBwaO5y6JX6hAVE4AMVtp67ouXZpTZpS9rqrS3NmuhLITwpAcP0cfHtlB6qv3YT8m+mip9urlE7IFgSldo20AWHxQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReOxIhQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777C5C113CF;
	Fri, 22 Aug 2025 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755890274;
	bh=l2G5Uq1Nyd2VWE/fQbpU7Be9UY5kzrYLsd77Zw2gXmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReOxIhQqDGNShD+U4/6caw8pGgbQf1ZkaxfyQCkVPELQl8xahy1dccBnWJ0s97zxv
	 C4/dZAtl2gPa+a1Xh71jXlILSnmi+HOQsutd3vzNi1PvEgwPDBPWbFIQbZS3Db0VBw
	 Fu6tRngpO3glLJj4r9rZJ2Jwb6q2PhoTWJZyesf2Zfl+x4QdA0LsAH6Tc81mmZXOEJ
	 QSHWAdHYLC18zUIK2h0HbH/RW21JCJTr8P5eQfkqamtuafv35f64KmQ2HYqq1Neeli
	 5DiCBqE74pO5VLeW4cRleO1VSKQXn3GB6SE3GeqUPzJPh2ZSk4fD5K4cPX0GFFvEVm
	 tLwYAFN4h2vGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] PCI: imx6: Add IMX8MQ_EP third 64-bit BAR in epc_features
Date: Fri, 22 Aug 2025 15:17:50 -0400
Message-ID: <20250822191750.1437890-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822191750.1437890-1-sashal@kernel.org>
References: <2025082145-scrap-ride-31b5@gregkh>
 <20250822191750.1437890-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit c523fa63ac1d452abeeb4e699560ec3365037f32 ]

IMX8MQ_EP has three 64-bit BAR0/2/4 capable and programmable BARs. For
IMX8MQ_EP, use imx8q_pcie_epc_features (64-bit BARs 0, 2, 4) instead
of imx8m_pcie_epc_features (64-bit BARs 0, 2).

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[bhelgaas: add details in subject]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250708091003.2582846-2-hongxing.zhu@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 70f281abb607..7b05eb8f95d0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1676,7 +1676,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-		.epc_features = &imx8m_pcie_epc_features,
+		.epc_features = &imx8q_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
-- 
2.50.1


