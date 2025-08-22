Return-Path: <stable+bounces-172513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97333B32393
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 22:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF71A3B4537
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158572C21DD;
	Fri, 22 Aug 2025 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0ysnZAf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1F1DED5B
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894435; cv=none; b=LluWrcvhMLr26rqr7BACZfyqfdVQ534qTgHYAZBzr5meqyp9ADUzLM6jG/Jr7DJRD4NbJIye8cXUWziUhu5pWLq1Ep2QklD3HWARBLvHo8Xe2NjNT+RlMee3yf0J2DUcj5mEa58U2lpjx5TksMDe6NVVVE/MgvU5l2JkDUNVC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894435; c=relaxed/simple;
	bh=uOjSm2WwMSCQP1ZlNZHzz1WxZQaTs5qKBcHkwJqMqIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFKI2B5mj7jW6KIyOX0tkoD73ZpbTngcL+N95CWjD4n0Dt3JfB+fbJq4HI70QcgrwoljKAA/+2KRXTx/4vV7l6ZqntB4l0SuGTj1QVmB7LO4wbg18aOrDe37mmcqR4MyCdxOHT8flL0f8ownIuzfts1KXst6/i2vhthfXNv9ge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0ysnZAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B192FC4CEED;
	Fri, 22 Aug 2025 20:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755894435;
	bh=uOjSm2WwMSCQP1ZlNZHzz1WxZQaTs5qKBcHkwJqMqIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0ysnZAfCa1dKU0NvJ1gdUjdePXIk3eaL3CZJKv3u9IDNXXTGObZSz7hnsZrC6TEf
	 7m4k7B9bkr2mqkGDU1i5/T9NezuHh2ee+9Mc+jN1uCHtg7GIT0qh9J1HX3TD/AN2Bp
	 oPlELFmk1xCR7eovT2yp5yXrHS84nGe1gaqO/a3AmYmx1zDuC4cCWcssZ5v++L6wNQ
	 cTMjOYUcUmzRfpE85b6EY69M9VNjZOyo4IP0sPhaLWL7pi0myiBX3l12TC8ZEIASte
	 SvQnkn9l6y1pOFH623pwzY0QvFRh0xMtWZGYcpk6JLFqDE4SEmAGAadszvhmsOjBXf
	 cXZvHxdnrJySQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI: imx6: Add IMX8MM_EP and IMX8MP_EP fixed 256-byte BAR 4 in epc_features
Date: Fri, 22 Aug 2025 16:27:13 -0400
Message-ID: <20250822202713.1483619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082152-acetone-swept-9f05@gregkh>
References: <2025082152-acetone-swept-9f05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit 399444a87acdea5d21c218bc8e9b621fea1cd218 ]

For IMX8MM_EP and IMX8MP_EP, add fixed 256-byte BAR 4 and reserved BAR 5
in imx8m_pcie_epc_features.

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[bhelgaas: add details in subject]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250708091003.2582846-3-hongxing.zhu@nxp.com
[ Adapted BAR configuration to use reserved_bar bitmap and bar_fixed_size ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index cedfbd425863..bddec814b826 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1043,7 +1043,10 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
-	.reserved_bar = 1 << BAR_1 | 1 << BAR_3,
+	.reserved_bar = 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
+	.bar_fixed_size = {
+		[BAR_4] = SZ_256,
+	},
 	.align = SZ_64K,
 };
 
-- 
2.50.1


