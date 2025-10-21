Return-Path: <stable+bounces-188406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1A6BF81AE
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D217219C06C8
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5C34D923;
	Tue, 21 Oct 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahz4lxFK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24434D900
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071845; cv=none; b=KclijtBKyHSXpzn/gDCetooGBJ/kl/+XGYE0JyFLLQ3OXDWuejiAYVMsX3AKrqpHwb7V3P/QPI21YqMF5dWH4RjrO2oFS7mg4kZ4QvzLBXdfARZgBV4oyvfADPlSVmDatXeF6AKKtlpa2EZfK8oOZk2rYgtbjURrLYCfFuNA9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071845; c=relaxed/simple;
	bh=Qizt93syst2CSE8ZIrmjxg6cpVXn0pQWjtejEUz7K6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJJxRnfm3N3cD2qoQoGkJgrKQtzkD6J7yFsBWmh2FZJsL0Z1rGEqt3vaeUYrHUrsoSTX0FK2MU1Ahjp6tI8TNwki2hF10y7Wk+2xooULw2e9MucvrqUTjd9lPbjC17sBOE6Rt0iODEs7ZgGVYpKwNP3Qw0MLy9D7FwV+yYG6UUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahz4lxFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1FBC4CEF1;
	Tue, 21 Oct 2025 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761071844;
	bh=Qizt93syst2CSE8ZIrmjxg6cpVXn0pQWjtejEUz7K6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahz4lxFKQrZ70emN14FTcm84j2Qa+lO346g3JxYg7yNTGC6WMLT/PKU9HHvMwPCVg
	 dTNbzWA1D6jr1vr+ajbjxYFd0Zv+4MCC/2Anpc/wzDCDLlH2mAVYIdUyqQyHmGKtJ0
	 nUGoL6piSEDg9t9VeAt2KFisgv6O7+6n31+1gEfU72OaHt06+/0/uCis4MezVwJD/S
	 9y0BZh3Vk8BnnUD4b3XjcMRunt4tzckmrHelcp65U7Szq8xMW1zZqUmCkS0Pi8swVM
	 fd2xYmM7jU95WP62pN/8+BbBapqNrkvyMTKzFiGEyuOJHWCgey5d91HjCPGABQhU0R
	 2q7/0+WRxarkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists
Date: Tue, 21 Oct 2025 14:37:21 -0400
Message-ID: <20251021183722.2520843-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101614-regulator-gumball-c7c6@gregkh>
References: <2025101614-regulator-gumball-c7c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Siddharth Vadapalli <s-vadapalli@ti.com>

[ Upstream commit 82c4be4168e26a5593aaa1002b5678128a638824 ]

The ACSPCIE module is capable of driving the reference clock required by
the PCIe Endpoint device. It is an alternative to on-board and external
reference clock generators. Enabling the output from the ACSPCIE module's
PAD IO Buffers requires clearing the "PAD IO disable" bits of the
ACSPCIE_PROXY_CTRL register in the CTRL_MMR register space.

Add support to enable the ACSPCIE reference clock output using the optional
device-tree property "ti,syscon-acspcie-proxy-ctrl".

Link: https://lore.kernel.org/linux-pci/20240829105316.1483684-3-s-vadapalli@ti.com
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Stable-dep-of: f842d3313ba1 ("PCI: j721e: Fix programming sequence of "strap" settings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pci-j721e.c | 39 +++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index f76a358e2b5b6..28da514bfa128 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -48,6 +48,7 @@ enum link_status {
 #define J721E_MODE_RC			BIT(7)
 #define LANE_COUNT(n)			((n) << 8)
 
+#define ACSPCIE_PAD_DISABLE_MASK	GENMASK(1, 0)
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
 struct j721e_pcie {
@@ -225,6 +226,36 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 	return ret;
 }
 
+static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
+				       struct regmap *syscon)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct device_node *node = dev->of_node;
+	u32 mask = ACSPCIE_PAD_DISABLE_MASK;
+	struct of_phandle_args args;
+	u32 val;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(node,
+					       "ti,syscon-acspcie-proxy-ctrl",
+					       1, 0, &args);
+	if (ret) {
+		dev_err(dev,
+			"ti,syscon-acspcie-proxy-ctrl has invalid arguments\n");
+		return ret;
+	}
+
+	/* Clear PAD IO disable bits to enable refclk output */
+	val = ~(args.args[0]);
+	ret = regmap_update_bits(syscon, 0, mask, val);
+	if (ret) {
+		dev_err(dev, "failed to enable ACSPCIE refclk: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
@@ -264,7 +295,13 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
-	return 0;
+	/* Enable ACSPCIE refclk output if the optional property exists */
+	syscon = syscon_regmap_lookup_by_phandle_optional(node,
+						"ti,syscon-acspcie-proxy-ctrl");
+	if (!syscon)
+		return 0;
+
+	return j721e_enable_acspcie_refclk(pcie, syscon);
 }
 
 static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
-- 
2.51.0


