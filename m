Return-Path: <stable+bounces-186096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611DBBE395E
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03E540536C
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493CD32D7F6;
	Thu, 16 Oct 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oThCuM+q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5C32D440
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619644; cv=none; b=afPblaqLHOUhhPE4e7lcuOVPcRhyT19PVBfjjnxQxqy2h/YrP+F9nx7BViENLNpOe8KJS9PnTOrTrgIRR+6/MJW3Ko2ePV8YmhyTSXg7Q+69KInBjKmdZMCQ8pQsc1boz2UHr9VmEg1axcVeotdVG/5LNwj+XcVsAHAiVGoRG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619644; c=relaxed/simple;
	bh=DkPXngH2nlzY7qol4iO7S6BxmOJpx1L1u7BfLhqd4Nw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hnfLWvACL/Z3J6P55F7e4JDpyITzYebbcTk3ZcUBiQa/iqsvq8hWhki/Dj51hAlqC+SPWKmxd1ZaNooK7GNr1BcEIb7rKzh+jOWhH03UefGe6iebuq3nP7PxCHixGzd/iZ3At7rQyse87B+ym+/7C5Q8UoyafNymHPvSYXjW4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oThCuM+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71108C4CEF1;
	Thu, 16 Oct 2025 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619643;
	bh=DkPXngH2nlzY7qol4iO7S6BxmOJpx1L1u7BfLhqd4Nw=;
	h=Subject:To:Cc:From:Date:From;
	b=oThCuM+qYfZy4daLID7KCKdQ1ZT4VMoyLeQ/MaXXWpnVVRrDWuTAwH9MplCymoS4/
	 Lds2wP0wPRtv1jrOgIE+F689vPgSbYb2A80KgkPqFpayMlu3KTmP/hMkG3l36cm1Pb
	 Bgzf87Zw8UC0s+t8eO3fkC1D1GPTOqegu8ZFCaGU=
Subject: FAILED: patch "[PATCH] PCI: tegra194: Handle errors in BPMP response" failed to apply to 5.10-stable tree
To: vidyas@nvidia.com,bhelgaas@google.com,cassel@kernel.org,jonathanh@nvidia.com,mani@kernel.org,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:00:28 +0200
Message-ID: <2025101628-deflected-bruising-7def@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f8c9ad46b00453a8c075453f3745f8d263f44834
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101628-deflected-bruising-7def@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8c9ad46b00453a8c075453f3745f8d263f44834 Mon Sep 17 00:00:00 2001
From: Vidya Sagar <vidyas@nvidia.com>
Date: Mon, 22 Sep 2025 16:08:26 +0200
Subject: [PATCH] PCI: tegra194: Handle errors in BPMP response

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

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 359d92dca86a..d71053fa4365 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1214,6 +1214,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	/*
 	 * Controller-5 doesn't need to have its state set by BPMP-FW in
@@ -1236,7 +1237,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
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
@@ -1245,6 +1252,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1264,7 +1272,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
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


