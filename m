Return-Path: <stable+bounces-3107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C881F7FCB79
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 01:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8272C28326F
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 00:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C926627;
	Wed, 29 Nov 2023 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0vX5mPQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A971867;
	Wed, 29 Nov 2023 00:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F100C433C9;
	Wed, 29 Nov 2023 00:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701218222;
	bh=4QzmELDeyNIPo50f4wQdlM5oa5HP9wUnEBo9dfh91cI=;
	h=From:Date:Subject:To:Cc:From;
	b=J0vX5mPQdyMCcxFjfCEt2YBQwhaw7LxtF10YxzxI6yBpIqAipLNSw8NEZxkA4y7yH
	 uKM+2Zk3WIu5YxWREz/iNaAMnBm6qTl05spv0i3rubV16GJrkDZlKwevPKTGS3zr8Z
	 +7cUJ5nQTrWbiAALrEFFaLP8G1oLGxqpmxIHhXuDwU10ks7ehLEKK0PLbNwcytFf4p
	 EThNTJy9JlOX9KfVo9F5gDIQQ2WYwpAZRmUaSSo2EW3B8Y+WhJ1t+ipsnnxguXiIiV
	 hf3nTsATMeOFmbBxicaOvlJRQpfGTiVIJ8tEdVNq3GXElpg04Bmg0tAeTI/sDhmVnI
	 i9yGMJoRiZx+A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 28 Nov 2023 17:37:00 -0700
Subject: [PATCH 5.10] PCI: keystone: Drop __init from
 ks_pcie_add_pcie_{ep,port}()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-5-10-fix-pci-keystone-modpost-warning-v1-1-43240045c516@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKuHZmUC/x2NywrCMBAAf6Xs2ZVspBr8FfEQk21dxE3IFh+U/
 rvB4xxmZgXjJmxwHlZo/BKToh1oN0C6R50ZJXcG7/yByAcckRxO8sGaBB/8taUo47PkWmzBd2w
 qOmMMHMLxlpObTtBbtXF3/p8LjHtycN22HwA7Hb19AAAA
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: u.kleine-koenig@pengutronix.de, bhelgaas@google.com, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3259; i=nathan@kernel.org;
 h=from:subject:message-id; bh=4QzmELDeyNIPo50f4wQdlM5oa5HP9wUnEBo9dfh91cI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlp7Ws3+ExXMjv4/YVl49af+4X8W6bx/Zz9y0aRP1rbN
 aBffUVuRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZgIRzLDf0/H2xc2vpqdLJsx
 yamWn/3fT8vHdW1r3Z1mvS8+Y8MZKsrwV95XOOGlgoF59tQF6/zvGFtxmK2TNYzzb+P9+Nyr6f4
 VPgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

This commit has no upstream equivalent.

After commit db5ebaeb8fda ("PCI: keystone: Don't discard .probe()
callback") in 5.10, there are two modpost warnings when building with
clang:

  WARNING: modpost: vmlinux.o(.text+0x5aa6dc): Section mismatch in reference from the function ks_pcie_probe() to the function .init.text:ks_pcie_add_pcie_port()
  The function ks_pcie_probe() references
  the function __init ks_pcie_add_pcie_port().
  This is often because ks_pcie_probe lacks a __init
  annotation or the annotation of ks_pcie_add_pcie_port is wrong.

  WARNING: modpost: vmlinux.o(.text+0x5aa6f4): Section mismatch in reference from the function ks_pcie_probe() to the function .init.text:ks_pcie_add_pcie_ep()
  The function ks_pcie_probe() references
  the function __init ks_pcie_add_pcie_ep().
  This is often because ks_pcie_probe lacks a __init
  annotation or the annotation of ks_pcie_add_pcie_ep is wrong.

ks_pcie_add_pcie_ep() was removed in upstream commit a0fd361db8e5 ("PCI:
dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common
code") and ks_pcie_add_pcie_port() was removed in upstream
commit 60f5b73fa0f2 ("PCI: dwc: Remove unnecessary wrappers around
dw_pcie_host_init()"), both of which happened before upstream
commit 7994db905c0f ("PCI: keystone: Don't discard .probe() callback").

As neither of these removal changes are really suitable for stable, just
remove __init from these functions in stable, as it is no longer a
correct annotation after dropping __init from ks_pcie_probe().

Fixes: db5ebaeb8fda ("PCI: keystone: Don't discard .probe() callback")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This is not an issue in mainline but I still cc'd the author and
committer of 7994db905c0f in case they would like to check my analysis.
---
 drivers/pci/controller/dwc/pci-keystone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5b722287aac9..afaea201a5af 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -865,8 +865,8 @@ static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
 	return ks_pcie_handle_error_irq(ks_pcie);
 }
 
-static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
-					struct platform_device *pdev)
+static int ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
+				 struct platform_device *pdev)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
@@ -978,8 +978,8 @@ static const struct dw_pcie_ep_ops ks_pcie_am654_ep_ops = {
 	.get_features = &ks_pcie_am654_get_features,
 };
 
-static int __init ks_pcie_add_pcie_ep(struct keystone_pcie *ks_pcie,
-				      struct platform_device *pdev)
+static int ks_pcie_add_pcie_ep(struct keystone_pcie *ks_pcie,
+			       struct platform_device *pdev)
 {
 	int ret;
 	struct dw_pcie_ep *ep;

---
base-commit: 479e8b8925415420b31e2aa65f9b0db3dea2adf4
change-id: 20231128-5-10-fix-pci-keystone-modpost-warning-a8e886bdc0f7

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


