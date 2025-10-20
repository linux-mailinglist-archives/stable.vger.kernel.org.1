Return-Path: <stable+bounces-188178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7CBF2574
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72A7734DE22
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2328504F;
	Mon, 20 Oct 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq1zoJSX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F5283FDD
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976905; cv=none; b=KXivN4MIzf3IOQISNwDpRyS5SLNIvH31vKxai+ncyGCbOsK1NQaSk6+jrc4amuSBdl6s3oQplinFXVVsjqU5kknXc06jq3NuIKYO490VfwVs6VQ3u3KpN8XJegmu1C6AsA7J/ETcOeAxmgvY+h47FB+TABFQOlafU3kbfmDMJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976905; c=relaxed/simple;
	bh=dit4mJklZmEBHhQl2dNKL5YwAA+rctDjpVtaGsAverc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhSclpMXQIs+GGiYlrnfLJrIm+j5JsAMyLDTTTQPRFFJupBM4X2Scnh3j+N8tfoUIwUQ9BfrgtBalN+VH2pdXJsX4CVzvpijr+2jYdeaiLZvB9xYFbMtK7S0N65TV7zP3b3NlkisvqCj3Q+oynGOpuKezNciEXNU22Jb5rPrmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq1zoJSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6688DC4CEF9;
	Mon, 20 Oct 2025 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976904;
	bh=dit4mJklZmEBHhQl2dNKL5YwAA+rctDjpVtaGsAverc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rq1zoJSXFqLjg7tbm1CNJgwv8eEiym0vgt86RsL+eWBWbi3bVwpOitYa9lLYkWl8s
	 cxAGZPjPfAEhYcZUFrUR1c9pEXz7+qj6hlNq2UyFgBEi5nB0txcp3It7J7aYT0o8WN
	 mFU535Qo1gHE/9UCBQAfCTtvoHgKrVeCYxP8LC6dxcBfaW+SNppIkcg8e2GfchV21D
	 +2pyRW/Xw+rrlTm+/EhLRg6B1Zvnz1Gsk6LJwvisvyBI6Q4MYmsl4BphUdrMHMgusL
	 14clOQ/Jw/0H0FVYO79uTg4Iv+Wblpcl0dTe7UxCOpC6Ndr61v+fUPQYj7iSaIMlju
	 tfdsgOTWtNacQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] PCI: j721e: Fix programming sequence of "strap" settings
Date: Mon, 20 Oct 2025 12:15:01 -0400
Message-ID: <20251020161501.1834257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101617-matching-native-d141@gregkh>
References: <2025101617-matching-native-d141@gregkh>
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
[ removed offset parameter from j721e_pcie_set_mode() and ACSPCIE refclk handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pci-j721e.c | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 8a6d68e13f301..4332c8572b201 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -227,6 +227,25 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return PTR_ERR(syscon);
 	}
 
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
 	ret = j721e_pcie_set_mode(pcie, syscon);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set pci mode\n");
@@ -245,6 +264,12 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power on PCIe Controller\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.51.0


