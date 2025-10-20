Return-Path: <stable+bounces-188189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE8BF25F0
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D77F4E8C65
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9208B285CA4;
	Mon, 20 Oct 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="advwkzTT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA632853F3
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977292; cv=none; b=rF1zKMdfOneA0m3ngagHGLhr/JXBVnjZGFhHKstnFuqLcVGhRn0LibCuUQg3S44qaU6LUIJWBq2jlHjhRy908HKtmpAL22xlDbAEDQEFYJEB9LaKYAXgHfuJlrEZKBZeKkoRXOg4askKOqWWhe3rmKscAOHVNySEblcCbXV0ORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977292; c=relaxed/simple;
	bh=4al4JDvCgPGBjUH0B7Pvy4NrC6c6I0iT+CQRrXKahdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAwITHTJiMTDYtnVtZ5yP/+Klpp52MV5wln9gKOPJSRPTQVy8ktKHS5sRdh/YbSXYd8YRqAv5LzeAZvK5k+osvDc9fIwFzE4AxZNviGkhbbo/+sWp72QN5kh/e9LL3UyrgfkRe8sF+gNj3ctx4U6BPcP/vQ8RY72RPILGbVB3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=advwkzTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA68DC113D0;
	Mon, 20 Oct 2025 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977291;
	bh=4al4JDvCgPGBjUH0B7Pvy4NrC6c6I0iT+CQRrXKahdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=advwkzTT5oqcXvY3qjmpPi0bZTqEbMwse79v1+Dz+uaD00xtxOkc0HczaZ98FF0BL
	 wxwHCf0ylDW3y/WRZXijpQx8+NpxKG6LOETADcs4XIVAQIk8H1ghbO4ab4N0We8ryc
	 f9grUtstYumvxh/Wr8rWnPQuXn/OYC+uiGI+6QVl/49eILjqa7nfd7LecGPXz5UzPL
	 EGUnNm6LoAYw6DYnrOpFYIUhdQpCcoJMzS+ixsAaLkAFua/cil7HwMgbKh3LzNuXdG
	 IBQ663MIxMeKmiMdHoCcUIkPohKWf4GYPLpSkMxP5oNmHLO2bknmUrsx8Tf2vyne4q
	 z9NbYliJIcLBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] PCI: tegra194: Handle errors in BPMP response
Date: Mon, 20 Oct 2025 12:21:28 -0400
Message-ID: <20251020162128.1836626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101627-backwash-capably-abbe@gregkh>
References: <2025101627-backwash-capably-abbe@gregkh>
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
index 0046983e5ab89..570b224a56be8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1168,6 +1168,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	/* Controller-5 doesn't need to have its state set by BPMP-FW */
 	if (pcie->cid == 5)
@@ -1187,7 +1188,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
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
@@ -1196,6 +1203,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1215,7 +1223,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
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


