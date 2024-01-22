Return-Path: <stable+bounces-12786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7411837393
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713741F2C971
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39618405F7;
	Mon, 22 Jan 2024 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h02WhPY5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2F3DB86
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954512; cv=none; b=Cp/x/moIWpY4Zb/VqeFMWQ5lDGlgzJ0BZHCuM4TqgE+iBxugRYw/ezhvOL4qV/R0pkK1l3Zd58AVrvLCLwzCf3eFjf1omdND43YgsxQvOveCr1jOIUTOW6zZwQxAJ0ifnUC6BFg74Vs+9JW8mxQhVoBk/RRP1wuOkxYSE3b5/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954512; c=relaxed/simple;
	bh=SYel9SN/Pqqs9HXA2OgqLNmJSRulkzpTD37cc1rcT7Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CniPIgnfVx50d576CPK/YM1HPewJas4n28I2JDwqzOWU56QfzORUoq4f/yhdEkX2NM0jISIhB/vocCKjedk8kWwkewbu9s7P7rRdZinzOFHQeIorvpP95onECdjy/PRR/4Ne0f94m6+1j/lLPw2C5vc4bbkrTIyGH9kdtl9S59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h02WhPY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B47CC433C7;
	Mon, 22 Jan 2024 20:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705954511;
	bh=SYel9SN/Pqqs9HXA2OgqLNmJSRulkzpTD37cc1rcT7Y=;
	h=Subject:To:Cc:From:Date:From;
	b=h02WhPY5mFhMN+db/aF5iB6OAZTnZDeo4dgJNT1Jcw6Zw/uSUUZXk8lQzzMIDD744
	 HoWZS3cvBmii2R3WfPZSY/ejKB7m4DeGfI4Xajd3/Sdz/CBjH1/cmkgmW56AYytvEv
	 QMhocoqi1tBGhiKHyzztuFKncnsKK9CnKHrtBoF0=
Subject: FAILED: patch "[PATCH] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment" failed to apply to 5.10-stable tree
To: niklas.cassel@wdc.com,kishon@kernel.org,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:15:09 -0800
Message-ID: <2024012208-vest-commence-5d45@gregkh>
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
git cherry-pick -x 2217fffcd63f86776c985d42e76daa43a56abdf1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012208-vest-commence-5d45@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
53fd3cbe5e9d ("PCI: endpoint: Add virtual function number in pci_epc ops")
1cf362e907f3 ("PCI: endpoint: Add support to add virtual function in endpoint core")
347269c113f1 ("PCI: Fix kernel-doc formatting")
6613bc2301ba ("PCI: endpoint: Fix NULL pointer dereference for ->get_features()")
8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
dbcc542f3608 ("PCI: cadence: Implement ->msi_map_irq() ops")
38ad827e3bc0 ("PCI: endpoint: Allow user to create sub-directory of 'EPF Device' directory")
256ae475201b ("PCI: endpoint: Add pci_epf_ops to expose function-specific attrs")
87d5972e476f ("PCI: endpoint: Add pci_epc_ops to map MSI IRQ")
63840ff53223 ("PCI: endpoint: Add support to associate secondary EPC with EPF")
0e27aeccfa3d ("PCI: endpoint: Make *_free_bar() to return error codes on failure")
fa8fef0e104a ("PCI: endpoint: Add helper API to get the 'next' unreserved BAR")
959a48d0eac0 ("PCI: endpoint: Make *_get_first_free_bar() take into account 64 bit BAR")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2217fffcd63f86776c985d42e76daa43a56abdf1 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <niklas.cassel@wdc.com>
Date: Tue, 28 Nov 2023 14:22:30 +0100
Subject: [PATCH] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment
 support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
support iATUs which require a specific alignment.

However, this support cannot have been properly tested.

The whole point is for the iATU to map an address that is aligned,
using dw_pcie_ep_map_addr(), and then let the writel() write to
ep->msi_mem + aligned_offset.

Thus, modify the address that is mapped such that it is aligned.
With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
dw_pcie_ep_raise_msi_irq().

Link: https://lore.kernel.org/linux-pci/20231128132231.2221614-1-nks@flawful.org
Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org # 5.7
Cc: Kishon Vijay Abraham I <kishon@kernel.org>

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f6207989fc6a..bc94d7f39535 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
+	msg_addr &= ~aligned_offset;
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)


