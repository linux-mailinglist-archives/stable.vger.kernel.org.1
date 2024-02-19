Return-Path: <stable+bounces-20685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D485AB40
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850481C22179
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7214C605;
	Mon, 19 Feb 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLKzETj1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD0487AB
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368072; cv=none; b=JTyhbpyrJ50aiyO0K2Jyw833AqjZADBgnBkHF8ENsogeaIzVZB8GKHdZqqpCtpjNH2849sv1TERlvlZkhGki97RIMSK8K33lp7ryoVuR/Nkg7YOQ8YsVbTGa9v1Nfz3M89xccJnqHNAzfrNLuklGg381x7prHD9KJKy4wby38ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368072; c=relaxed/simple;
	bh=BxiNs6MeCrzgT8QQ1OOw3M97kpXLcTiz5t14ogFvYvE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NxX9qyhFIRzm90PJCgwd2WdVIc6at+6U7T/+fvRGkH8Alf+E2RvSnygShoKt3BsbjLpWGXXVdRVY/NDVbzjPGM4P5wraLrJpBcZ5nrqzb7C3oCc94srZCcWOiIK48VCnp+nC3oDxEBBLLarWnp9oIlBUKgaHh7VbufQjWnuS5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLKzETj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6320EC433C7;
	Mon, 19 Feb 2024 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368072;
	bh=BxiNs6MeCrzgT8QQ1OOw3M97kpXLcTiz5t14ogFvYvE=;
	h=Subject:To:Cc:From:Date:From;
	b=bLKzETj1gbpxOECQLhz+3bpGzmlCJNy0Rew9mbgpSOfcdN+OPswIj41ZcKE64tWYP
	 dIHEwyRg8akAa2MZlz4CjwX8CTUz+/RK89z/b8Ai9dGWzq1AG8oov9FLzGCGH/uVQ3
	 Q2vPPo2X+7D0+uJJekhIuRhyF5Ms68zabDe3F9IM=
Subject: FAILED: patch "[PATCH] PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()" failed to apply to 6.1-stable tree
To: dan.carpenter@linaro.org,bhelgaas@google.com,cassel@kernel.org,ilpo.jarvinen@linux.intel.com,manivannan.sadhasivam@linaro.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:40:46 +0100
Message-ID: <2024021946-sprain-turmoil-2ff2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b5d1b4b46f856da1473c7ba9a5cdfcb55c9b2478
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021946-sprain-turmoil-2ff2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


