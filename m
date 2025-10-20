Return-Path: <stable+bounces-188177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03058BF2571
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B943B834B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7731285CA9;
	Mon, 20 Oct 2025 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHGj7kvG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A6285CA4
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976854; cv=none; b=itIHoY5rBWJ9A1ghLocdzHolK0qynoBL0yMsscPDfFkAnxj4Yycfxni4VwbaJ4M/oEOM/Ad3jTA2tHzvuufDRH9SpmFUtMEkjKuHc+XE6S3oLbxIJ85fL6Ph7PNgdglc9fqG53cfbZXqhZ3fiCmCD/oUghX14DkW0an62TVpink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976854; c=relaxed/simple;
	bh=C7hFGltUVA5n+r3glvbIgauWGhpDMcIPtXmBj65JX10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clxF9A09mTzuxClDxaiWnnEGomEb0dp76DgqCFR51gsdic4IMJ67utLY1dL97IzN6vBK8PK7J2mBOLCU95ESI0QZScVg5QFIDHX/0+Dta58YphFg+me7shzys9f5jcBQoP+3JLYWB6IpbC+YQMkVNj+ByNfiSZVy1ArOy7+/a3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHGj7kvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B827EC113D0;
	Mon, 20 Oct 2025 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976854;
	bh=C7hFGltUVA5n+r3glvbIgauWGhpDMcIPtXmBj65JX10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHGj7kvGUdGFX8h2MWC2QRNIJDYXkiTwnvgf/4mVkCu+Be4rd1StuTq9ZrlhdIQ7w
	 gkBPtFLw1A+XxRyePWf4dtXYO9JiJ6kO48LK6NQNuvIkn5KqdA92mYmVqNqAXd9N8p
	 10qZtp82MzubPS82P+sOr3ykZ+zWTb8teCV3ar78d4eELHDcbAhz22g/SeaJwcluGu
	 xZ0Lm2/M+98BjQj4XNGhIGCEm7adbKzGsMV8MjhK/6GSB7ThcyzdY1t2gMDpFTPWKn
	 X2tAoAlSLkGhVPCoZ3xZS7kU+EmRFycG/hF1Vlq56ZQ958IG8DBdh5ZoTBcGez9iDN
	 Gwz+H5E/xui4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] PCI: j721e: Fix programming sequence of "strap" settings
Date: Mon, 20 Oct 2025 12:14:08 -0400
Message-ID: <20251020161408.1833901-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020161408.1833901-1-sashal@kernel.org>
References: <2025101616-unopposed-carat-7cf4@gregkh>
 <20251020161408.1833901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siddharth Vadapalli <s-vadapalli@ti.com>

[ Upstream commit f842d3313ba179d4005096357289c7ad09cec575 ]

The Cadence PCIe Controller integrated in the TI K3 SoCs supports both
Root-Complex and Endpoint modes of operation. The Glue Layer allows
"strapping" the Mode of operation of the Controller, the Link Speed
and the Link Width. This is enabled by programming the "PCIEn_CTRL"
register (n corresponds to the PCIe instance) within the CTRL_MMR
memory-mapped register space. The "reset-values" of the registers are
also different depending on the mode of operation.

Since the PCIe Controller latches onto the "reset-values" immediately
after being powered on, if the Glue Layer configuration is not done while
the PCIe Controller is off, it will result in the PCIe Controller latching
onto the wrong "reset-values". In practice, this will show up as a wrong
representation of the PCIe Controller's capability structures in the PCIe
Configuration Space. Some such capabilities which are supported by the PCIe
Controller in the Root-Complex mode but are incorrectly latched onto as
being unsupported are:
- Link Bandwidth Notification
- Alternate Routing ID (ARI) Forwarding Support
- Next capability offset within Advanced Error Reporting (AER) capability

Fix this by powering off the PCIe Controller before programming the "strap"
settings and powering it on after that. The runtime PM APIs namely
pm_runtime_put_sync() and pm_runtime_get_sync() will decrement and
increment the usage counter respectively, causing GENPD to power off and
power on the PCIe Controller.

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250908120828.1471776-1-s-vadapalli@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pci-j721e.c | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index b692dc5e3b99e..0aad6668a81cd 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -270,6 +270,25 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	if (!ret)
 		offset = args.args[0];
 
+	/*
+	 * The PCIe Controller's registers have different "reset-values"
+	 * depending on the "strap" settings programmed into the PCIEn_CTRL
+	 * register within the CTRL_MMR memory-mapped register space.
+	 * The registers latch onto a "reset-value" based on the "strap"
+	 * settings sampled after the PCIe Controller is powered on.
+	 * To ensure that the "reset-values" are sampled accurately, power
+	 * off the PCIe Controller before programming the "strap" settings
+	 * and power it on after that. The runtime PM APIs namely
+	 * pm_runtime_put_sync() and pm_runtime_get_sync() will decrement and
+	 * increment the usage counter respectively, causing GENPD to power off
+	 * and power on the PCIe Controller.
+	 */
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power off PCIe Controller\n");
+		return ret;
+	}
+
 	ret = j721e_pcie_set_mode(pcie, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set pci mode\n");
@@ -288,6 +307,12 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power on PCIe Controller\n");
+		return ret;
+	}
+
 	/* Enable ACSPCIE refclk output if the optional property exists */
 	syscon = syscon_regmap_lookup_by_phandle_optional(node,
 						"ti,syscon-acspcie-proxy-ctrl");
-- 
2.51.0


