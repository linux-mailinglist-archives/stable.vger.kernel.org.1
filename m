Return-Path: <stable+bounces-20686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C929A85AB41
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822DF283A43
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C14CB4C;
	Mon, 19 Feb 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OlN3XJ7H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B837487AB
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368076; cv=none; b=nZnvg8L3JWGmo3fCQ4JPOlB1MGR2CizgSA/SUI1BaTY58FGSzDd66k7lhKB8PiZtG/Om40WlCRMZzpEjapIW4mjQDwrDjxETB9YmHsiMTWrDqNZqoIMxejTaGVIVNNM9AwTyAzCECH6gRx1AlcnE9glqgQJ1ryFuf+OI37Ttt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368076; c=relaxed/simple;
	bh=uzMfN229gRZSoBnESBk23Bopb7IlV/BhEJNSulqjUXQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kgGhb2sFpSco41N4wv3FjM5GUgvLSnZXSpewylVk7o0t4IGHoAO4nETkZ21Np0LS/4NyL08xiVH8mrnCdwdMKpOrSG4Te14Bu+WYmDJQZd5IDqDXj0BtdT5BpJ0jEx3kPC7mMC6zQ4zIftB1qs/JxziYJ2uvsMFDZu1kZTDNoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OlN3XJ7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD79C433F1;
	Mon, 19 Feb 2024 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368076;
	bh=uzMfN229gRZSoBnESBk23Bopb7IlV/BhEJNSulqjUXQ=;
	h=Subject:To:Cc:From:Date:From;
	b=OlN3XJ7HWFX7G1ESmHI4m+9jESd/wiO5VOEXodt79OR0h62b3aZBJ4rActYzUaWOQ
	 Ea8J0tV6SM7v/V6k2N1+QioO5iMsqGGSQZ75OzkIPh0ZYk/4TB78PoXk9O2ttfm7Rl
	 gk9gIW/sBlh0/LtebxE28OtMkbeDUfYgigC8TZ1o=
Subject: FAILED: patch "[PATCH] PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()" failed to apply to 5.15-stable tree
To: dan.carpenter@linaro.org,bhelgaas@google.com,cassel@kernel.org,ilpo.jarvinen@linux.intel.com,manivannan.sadhasivam@linaro.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:40:47 +0100
Message-ID: <2024021947-penholder-identify-b98c@gregkh>
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
git cherry-pick -x b5d1b4b46f856da1473c7ba9a5cdfcb55c9b2478
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021947-penholder-identify-b98c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b5d1b4b46f85 ("PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()")
2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
92af77ca26f7 ("PCI: dwc: Use FIELD_GET/PREP()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b5d1b4b46f856da1473c7ba9a5cdfcb55c9b2478 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Fri, 26 Jan 2024 11:40:37 +0300
Subject: [PATCH] PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "msg_addr" variable is u64.  However, the "aligned_offset" is an
unsigned int.  This means that when the code does:

  msg_addr &= ~aligned_offset;

it will unintentionally zero out the high 32 bits.  Use ALIGN_DOWN() to do
the alignment instead.

Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
Link: https://lore.kernel.org/r/af59c7ad-ab93-40f7-ad4a-7ac0b14d37f5@moroto.mountain
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: <stable@vger.kernel.org>

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b..d6b66597101e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -551,7 +552,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
-	msg_addr &= ~aligned_offset;
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)


