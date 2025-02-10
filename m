Return-Path: <stable+bounces-114584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC139A2EEF6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D941164643
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7104723099E;
	Mon, 10 Feb 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u4yYDm51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085222E406
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195747; cv=none; b=u3CHK3nCXVzcSUcE47fI8/tEJWSllvTnYZjvK5hPuYe3F86P2A3Te2Z2BeJHXikKdy6bMzuc7li0JpRuwLd2iy5s4T06lNqjtmF+oakwfQboUVEaZa++/d+fpVTyzjj0Lo0WIRgU4d3j9OB/a88lZA//dpeIN0oDguet5UaYEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195747; c=relaxed/simple;
	bh=MImmFPhAtVIa53+yn1rZ2goz/8t+mwB5PNseWvFzU4E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=riIIa16S0vQe8kCmMsuxHZ6NqUia8cpmbvcRGSVxbWYfmgzcQDIhrqjR/b5GNFf/HZpRSAAh2HIBRHHJKBApA1LmHMsD4pBmRMYNr9bzKDPJlD5VC4xL7FC/jDcL279nSUbu4KCc9zaOcetQ0Y8w0cRRcxNCFOpGaau0VyBGIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u4yYDm51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7745C4CED1;
	Mon, 10 Feb 2025 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195746;
	bh=MImmFPhAtVIa53+yn1rZ2goz/8t+mwB5PNseWvFzU4E=;
	h=Subject:To:Cc:From:Date:From;
	b=u4yYDm51z5H7gjq5+Xncllgs3gYyWmjK+/B4wSXxBhH1W9Dnus9xp8aU4Xf+rChUm
	 nLU8ATOQSRo9B+funeEvv/0g2T/Fp+JWCtvG13l8wzayv4lmCP+xKVtEt5Taqdkn20
	 Zq16hYZE3p6+x0lBKCSWJn9KHkZ+rAzKZaEIj1aE=
Subject: FAILED: patch "[PATCH] PCI: dwc: ep: Write BAR_MASK before iATU registers in" failed to apply to 5.15-stable tree
To: cassel@kernel.org,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:55:35 +0100
Message-ID: <2025021035-theme-scarcity-f244@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 33a6938e0c3373f2d11f92d098f337668cd64fdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021035-theme-scarcity-f244@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33a6938e0c3373f2d11f92d098f337668cd64fdd Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 13 Dec 2024 15:33:02 +0100
Subject: [PATCH] PCI: dwc: ep: Write BAR_MASK before iATU registers in
 pci_epc_set_bar()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "DesignWare Cores PCI Express Controller Register Descriptions,
Version 4.60a", section "1.21.70 IATU_LWR_TARGET_ADDR_OFF_INBOUND_i",
fields LWR_TARGET_RW and LWR_TARGET_HW both state that:
"Field size depends on log2(BAR_MASK+1) in BAR match mode."

I.e. only the upper bits are writable, and the number of writable bits is
dependent on the configured BAR_MASK.

If we do not write the BAR_MASK before writing the iATU registers, we are
relying the reset value of the BAR_MASK being larger than the requested
BAR size (which is supplied in the struct pci_epf_bar which is passed to
pci_epc_set_bar()). The reset value of the BAR_MASK is SoC dependent.

Thus, if the struct pci_epf_bar requests a BAR size that is larger than the
reset value of the BAR_MASK, the iATU will try to write to read-only bits,
which will cause the iATU to end up redirecting to a physical address that
is different from the address that was intended.

Thus, we should always write the iATU registers after writing the BAR_MASK.

Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
Link: https://lore.kernel.org/r/20241213143301.4158431-9-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f3ac7d46a855..bad588ef69a4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -222,19 +222,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
 		return -EINVAL;
 
-	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
-
-	if (!(flags & PCI_BASE_ADDRESS_SPACE))
-		type = PCIE_ATU_TYPE_MEM;
-	else
-		type = PCIE_ATU_TYPE_IO;
-
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
-	if (ret)
-		return ret;
-
 	if (ep->epf_bar[bar])
-		return 0;
+		goto config_atu;
+
+	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -246,9 +237,20 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
 	}
 
-	ep->epf_bar[bar] = epf_bar;
 	dw_pcie_dbi_ro_wr_dis(pci);
 
+config_atu:
+	if (!(flags & PCI_BASE_ADDRESS_SPACE))
+		type = PCIE_ATU_TYPE_MEM;
+	else
+		type = PCIE_ATU_TYPE_IO;
+
+	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
+	if (ret)
+		return ret;
+
+	ep->epf_bar[bar] = epf_bar;
+
 	return 0;
 }
 


