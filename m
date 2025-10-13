Return-Path: <stable+bounces-184227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59220BD2D7C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04CC934B2F9
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879221E5B95;
	Mon, 13 Oct 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+8OKn5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630B19CCFC
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356080; cv=none; b=UXjQdsmqVA2t1zlAIt+L8V8JiPEPLhPZadYb8c01zKJuW3iKvwGFibd5OYY0U+KpBa4yET3bImpFvq/pAHrm2VHNjBzP5+fmuNjBm8tEHejVnuwwgEcBfWHUHLPimQrUeaGTncXpnSCtAh33f7N2BbXXKcApx0udVFxZACq0fYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356080; c=relaxed/simple;
	bh=Uh0BHUQYlZkuMXGLh6hCcKuumiY52S+MBjuYGGIttl8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=syHt0y2dPon+PHMicRQzTzgvtyzB8IcoRli88z1YyNIvuhYjMvF1/p1Dg+I9yCEH0ITEEaP8Ayvr9fR5TDAMkmhdGBa+LLlEP9X2sdQA/n9jyfNK6YOj9eTYgYY904vc6IjVqzNOLS47X0Dm6FEMN0xYHrupJxd05bAHoAylpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+8OKn5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4F5C4CEE7;
	Mon, 13 Oct 2025 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760356080;
	bh=Uh0BHUQYlZkuMXGLh6hCcKuumiY52S+MBjuYGGIttl8=;
	h=Subject:To:Cc:From:Date:From;
	b=N+8OKn5ugqgRjkLQ5AhEk/LkxNts8tRCMDAmEYa1aZZ2XyfiTY+W4rmqln3S7bZVm
	 MgFpW4FW9l1kzGW0zH3iDGDDD4o6GjZSSMHiFWnzj8le2x10k5uHjqknvwucT5B0jK
	 BYTkimyF3ebJuVvnU6Zi2lFyfEtFLW6geRsx/Fbk=
Subject: FAILED: patch "[PATCH] PCI: endpoint: pci-epf-test: Add NULL check for DMA channels" failed to apply to 5.10-stable tree
To: shinichiro.kawasaki@wdc.com,dlemoal@kernel.org,kwilczynski@kernel.org,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 13:47:42 +0200
Message-ID: <2025101342-copartner-greedless-b2d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 85afa9ea122dd9d4a2ead104a951d318975dcd25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101342-copartner-greedless-b2d8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85afa9ea122dd9d4a2ead104a951d318975dcd25 Mon Sep 17 00:00:00 2001
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Date: Tue, 16 Sep 2025 11:57:56 +0900
Subject: [PATCH] PCI: endpoint: pci-epf-test: Add NULL check for DMA channels
 before release
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fields dma_chan_tx and dma_chan_rx of the struct pci_epf_test can be
NULL even after EPF initialization. Then it is prudent to check that
they have non-NULL values before releasing the channels. Add the checks
in pci_epf_test_clean_dma_chan().

Without the checks, NULL pointer dereferences happen and they can lead
to a kernel panic in some cases:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
  Call trace:
   dma_release_channel+0x2c/0x120 (P)
   pci_epf_test_epc_deinit+0x94/0xc0 [pci_epf_test]
   pci_epc_deinit_notify+0x74/0xc0
   tegra_pcie_ep_pex_rst_irq+0x250/0x5d8
   irq_thread_fn+0x34/0xb8
   irq_thread+0x18c/0x2e8
   kthread+0x14c/0x210
   ret_from_fork+0x10/0x20

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Fixes: 5ebf3fc59bd2 ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
[mani: trimmed the stack trace]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250916025756.34807-1-shinichiro.kawasaki@wdc.com

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 09e1b8b46b55..31617772ad51 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -301,15 +301,20 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	if (!epf_test->dma_supported)
 		return;
 
-	dma_release_channel(epf_test->dma_chan_tx);
-	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+	if (epf_test->dma_chan_tx) {
+		dma_release_channel(epf_test->dma_chan_tx);
+		if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+			epf_test->dma_chan_tx = NULL;
+			epf_test->dma_chan_rx = NULL;
+			return;
+		}
 		epf_test->dma_chan_tx = NULL;
-		epf_test->dma_chan_rx = NULL;
-		return;
 	}
 
-	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_rx = NULL;
+	if (epf_test->dma_chan_rx) {
+		dma_release_channel(epf_test->dma_chan_rx);
+		epf_test->dma_chan_rx = NULL;
+	}
 }
 
 static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,


