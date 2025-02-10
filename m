Return-Path: <stable+bounces-114583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1CA2EEF4
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750131885250
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238AD23099E;
	Mon, 10 Feb 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GLUkYtg7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEE2309A3
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195737; cv=none; b=i8LZdLnK4h4+GPMqgg6NwBdEKwFlUr++nlx5Ict94uSE4vAwNkUmPyw967o87UE+RksrYwCopB8pIa49tdt1v+onwCdo4hvpOgIcN7mRkn0gCBvBzg4Ac63Ez/huBSG3UKwEA/qyAkowbGf9mql9mSp/d2xmNxQJkwgKLSksPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195737; c=relaxed/simple;
	bh=ypR+akZ0LR4G44fB6fQ7npP3uLF/mygvsoej9p2gH9M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=shqk7U7hyFjObadpwezBZ3mW2uHvR/uC6WbZ415e1Rw4IhEl6jUoE+YleU998knXS6YsYC7ZYMlm7URrxUPcGhy68kGki4L6CTKkKQDr9k/ymwt7PecU06p61Fe8Bi6Muj3LGfygLzfA88gen0TfLv3Ydm6DymxH0BCIyR4kfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GLUkYtg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0004C4CED1;
	Mon, 10 Feb 2025 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195737;
	bh=ypR+akZ0LR4G44fB6fQ7npP3uLF/mygvsoej9p2gH9M=;
	h=Subject:To:Cc:From:Date:From;
	b=GLUkYtg74jmKqVVqYw6qDajZDToGGJUZslRGSMIb4bsIQIu5eXSgK02bobdJybnOk
	 XOIsrjRVWnA99mwr8Y3mWAYP0cLjmn96ufiyY01s0EijVzj2vypDks1xy/RsQGIT17
	 nsSM7yEV212SRbR/Jt5nmkleo5F9796fjZ0yA6L8=
Subject: FAILED: patch "[PATCH] PCI: dwc: ep: Write BAR_MASK before iATU registers in" failed to apply to 6.6-stable tree
To: cassel@kernel.org,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:55:34 +0100
Message-ID: <2025021034-upheaval-hydration-0e42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 33a6938e0c3373f2d11f92d098f337668cd64fdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021034-upheaval-hydration-0e42@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


