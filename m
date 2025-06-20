Return-Path: <stable+bounces-155055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE04AE1749
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89543BC0DD
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4279227FB30;
	Fri, 20 Jun 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D6+eBKLF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268C8632B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410823; cv=none; b=ACIr4udG5Ty8Hl+9hMbbQ4iaQBJM/AA3+zAOJ8pf7S5abJ8rDyZVxYnTDGQdR24WuDwipYD9pv/yuODNNLx3dle7dMIiFiya10pZyC32dA2TQKz4xkpxvfGEpzYQj6Jfjyl1hia3yl4Gqt+pqj8dMbH6yHzBM7OB/THsJLoK0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410823; c=relaxed/simple;
	bh=rnR/SD699eCnBr9jo6rkMoxV4uC+lGMI5TpdTKzP4B0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LEoCi9dmLmsghI5HsipxfGy9c1SNjELS9tvyLF5H4aMnlcMmCnUFI2R0Ck8fSxsplrEPY4S1yxGP7Bl5B+GcKgujtpyF3jrrsbaKv1uH8EcL5+AK9NUkX6uy/E2A70q/3a4X4/8J0veW+bLofVmcyznYqh+Gk0RGwb/I9wOl3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D6+eBKLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E23C4CEE3;
	Fri, 20 Jun 2025 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410822;
	bh=rnR/SD699eCnBr9jo6rkMoxV4uC+lGMI5TpdTKzP4B0=;
	h=Subject:To:Cc:From:Date:From;
	b=D6+eBKLFgDI6ewHzsPjKnk5KtqoFnI/At/ZxHyV5KTlFzjFpI12/ce0hdnSF46HJa
	 YnydCUk/rUf25NFvrVAdvokY6JDxouRZGKETuaHg3CzfWFhAzzUgMU2Gr5VCeGPvhW
	 /G9ULnns54B66bFh8EbTvvvqatMn2PomOUmU5exE=
Subject: FAILED: patch "[PATCH] PCI: apple: Set only available ports up" failed to apply to 6.1-stable tree
To: j@jannau.net,alyssa@rosenzweig.io,manivannan.sadhasivam@linaro.org,maz@kernel.org,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:13:29 +0200
Message-ID: <2025062029-moody-stinking-a43c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 751bec089c4eed486578994abd2c5395f08d0302
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062029-moody-stinking-a43c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 751bec089c4eed486578994abd2c5395f08d0302 Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Tue, 1 Apr 2025 10:17:01 +0100
Subject: [PATCH] PCI: apple: Set only available ports up

Iterating over disabled ports results in of_irq_parse_raw() parsing
the wrong "interrupt-map" entries, as it takes the status of the node
into account.

This became apparent after disabling unused PCIe ports in the Apple
Silicon device trees instead of deleting them.

Switching from for_each_child_of_node_scoped() to
for_each_available_child_of_node_scoped() solves this issue.

Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Fixes: a0189fdfb73d ("arm64: dts: apple: t8103: Disable unused PCIe ports")
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
Link: https://patch.msgid.link/20250401091713.2765724-2-maz@kernel.org

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 18e11b9a7f46..996cef8a2e17 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -754,7 +754,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
-	for_each_child_of_node_scoped(dev->of_node, of_port) {
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
 			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);


