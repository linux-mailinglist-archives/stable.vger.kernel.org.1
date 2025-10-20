Return-Path: <stable+bounces-188191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2BFBF2617
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4619218A6DCE
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF026B764;
	Mon, 20 Oct 2025 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSog/Wxo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554541D6187
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977361; cv=none; b=PYq/leilKAbLRPwwz3gduMnlyHgUChbBjVqEgpYm5qstYXSXAxxQCR/xJ0zJI0zytX6scS1q90K10Pj4BgqDCZpSemP2d6gwAGsMVHI9IkFkrSiyMEgdRIlzlrXTVoplsa5skAn7BFeRj/chvtvMhaElfw7CuxT4QLE3ICeVhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977361; c=relaxed/simple;
	bh=5NzIpN6QjzKHl3e/Vkw2yyZV6gkDrslTLHb0Cgx7vKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8BGEY6ohkMN5AOtKgBot0OnxIsxq+vBuakmzzVmecLWE8Mn9hEatzWFSbuoxhzUZSsrgyZUwDWMGdcubwvNoEZiYyX2Pq7DEQ+mBlhYxZW7C0DKaKwX1DEYsXW26kQnFoDNE8e9CuPzvCyvUGDV9ou3J9Qq9HO547KK0W8cAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSog/Wxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89DEC4CEF9;
	Mon, 20 Oct 2025 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977360;
	bh=5NzIpN6QjzKHl3e/Vkw2yyZV6gkDrslTLHb0Cgx7vKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSog/Wxox+cufK1JOtXQ3H5lrmP7d3ySG7XMt2rAfHtYwj3ghBvP+J/Bjx0vbWyb9
	 +wyV5c+3zsZ7//8IE+mwWXqoJ1r/CJ+31A2/P3uwJllL3/r38A+5mBTKlpt5YqU8Tg
	 14akcOUEwle1yhw99iezQw8QLeHdLyDTl7/kCvoYBSSQ4RxJn47CUcOu/n0t9lobjc
	 OOJqL4Cly43UVkJqXBXmkfUWnxpkh54CI6Ud3LvrIXgWImE41GsqPxgU2XPJ5+nM4n
	 KNQmotkEM3TFjcydNTQu/lqea6KLm7A6oUJM96NCTRnRwi2c//RkYNUJz7Py/EY7Hk
	 kIuNHXcZRSWOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] PCI: tegra194: Handle errors in BPMP response
Date: Mon, 20 Oct 2025 12:22:37 -0400
Message-ID: <20251020162237.1837094-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101628-deflected-bruising-7def@gregkh>
References: <2025101628-deflected-bruising-7def@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vidya Sagar <vidyas@nvidia.com>

[ Upstream commit f8c9ad46b00453a8c075453f3745f8d263f44834 ]

The return value from tegra_bpmp_transfer() indicates the success or
failure of the IPC transaction with BPMP. If the transaction succeeded, we
also need to check the actual command's result code.

If we don't have error handling for tegra_bpmp_transfer(), we will set the
pcie->ep_state to EP_STATE_ENABLED even when the tegra_bpmp_transfer()
command fails. Thus, the pcie->ep_state will get out of sync with reality,
and any further PERST# assert + deassert will be a no-op and will not
trigger the hardware initialization sequence.

This is because pex_ep_event_pex_rst_deassert() checks the current
pcie->ep_state, and does nothing if the current state is already
EP_STATE_ENABLED.

Thus, it is important to have error handling for tegra_bpmp_transfer(),
such that the pcie->ep_state can not get out of sync with reality, so that
we will try to initialize the hardware not only during the first PERST#
assert + deassert, but also during any succeeding PERST# assert + deassert.

One example where this fix is needed is when using a rock5b as host.
During the initial PERST# assert + deassert (triggered by the bootloader on
the rock5b) pex_ep_event_pex_rst_deassert() will get called, but for some
unknown reason, the tegra_bpmp_transfer() call to initialize the PHY fails.
Once Linux has been loaded on the rock5b, the PCIe driver will once again
assert + deassert PERST#. However, without tegra_bpmp_transfer() error
handling, this second PERST# assert + deassert will not trigger the
hardware initialization sequence.

With tegra_bpmp_transfer() error handling, the second PERST# assert +
deassert will once again trigger the hardware to be initialized and this
time the tegra_bpmp_transfer() succeeds.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
[cassel: improve commit log]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250922140822.519796-8-cassel@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 80c2015b49d8f..b230f2d5eb4d9 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1160,6 +1160,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	/* Controller-5 doesn't need to have its state set by BPMP-FW */
 	if (pcie->cid == 5)
@@ -1179,7 +1180,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
@@ -1188,6 +1195,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1207,7 +1215,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
-- 
2.51.0


