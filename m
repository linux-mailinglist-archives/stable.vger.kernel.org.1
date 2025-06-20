Return-Path: <stable+bounces-155045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9ACAE173D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BB91892B3D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A1227FB14;
	Fri, 20 Jun 2025 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iFgk9mTJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208223312D
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410726; cv=none; b=B1akiSKxSgKq2KVNWMqEvV9QXmD+5EYO9w/5CjwVdh7NRQ6VjQTyd3hHE3gryPlluCzqOTxVA6OailHGhorNJ3cGd1VTFsYx2nVaOIrQvFmgB3RdkEH2i00ICIqUXYNV4TUIMCNoTuqt8/tl31+TtvbmBkoRaGOBjYdVkbFIAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410726; c=relaxed/simple;
	bh=FKxrl5Z/TLCfZ5dgxGalqIJpopSgF/g1SG16XhmWJwg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LFH7bMqvgk2FMNbYYi4saT+KsvTxLzzwHM6Yyr2C4FfaUudvFa7UNNR3BF0MIqxEDiZWsgEJt3dIszM450oXa9fmFeaxOiFdL0/YSEQxo9p/SCE1mYtnxPspACkTZ9QYKywAD6y/B57cblFOlPeCdKap3DefDSgX+DzftbPVOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iFgk9mTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0810FC4CEE3;
	Fri, 20 Jun 2025 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410726;
	bh=FKxrl5Z/TLCfZ5dgxGalqIJpopSgF/g1SG16XhmWJwg=;
	h=Subject:To:Cc:From:Date:From;
	b=iFgk9mTJGPakIRiRC+/Ngc/qI9kBTmYZfyZzqRQBI+n+gfviesCNTq0xmrNAVLUpq
	 OljWrIISPXfuVSeQ2EIRHEexiN7OHMwE2weaXaYnydtEZc0QIve/zczs6q9nutaobp
	 2eDqP36xerICkVbmThDo/KGVUuER/WMoNTvS0ID8=
Subject: FAILED: patch "[PATCH] PCI: cadence-ep: Correct PBA offset in .set_msix() callback" failed to apply to 5.10-stable tree
To: cassel@kernel.org,bhelgaas@google.com,dlemoal@kernel.org,manivannan.sadhasivam@linaro.org,wilfred.mallawa@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:12:03 +0200
Message-ID: <2025062003-congenial-pamphlet-9cd6@gregkh>
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
git cherry-pick -x c8bcb01352a86bc5592403904109c22b66bd916e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062003-congenial-pamphlet-9cd6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c8bcb01352a86bc5592403904109c22b66bd916e Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 14 May 2025 09:43:15 +0200
Subject: [PATCH] PCI: cadence-ep: Correct PBA offset in .set_msix() callback

While cdns_pcie_ep_set_msix() writes the Table Size field correctly (N-1),
the calculation of the PBA offset is wrong because it calculates space for
(N-1) entries instead of N.

This results in the following QEMU error when using PCI passthrough on a
device which relies on the PCI endpoint subsystem:

  failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align

Fix the calculation of PBA offset in the MSI-X capability.

[bhelgaas: more specific subject and commit log]

Fixes: 3ef5d16f50f8 ("PCI: cadence: Add MSI-X support to Endpoint driver")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250514074313.283156-10-cassel@kernel.org

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 599ec4b1223e..112ae200b393 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -292,13 +292,14 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 val, reg;
+	u16 actual_interrupts = interrupts + 1;
 
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	reg = cap + PCI_MSIX_FLAGS;
 	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
-	val |= interrupts;
+	val |= interrupts; /* 0's based value */
 	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
 
 	/* Set MSI-X BAR and offset */
@@ -308,7 +309,7 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;


