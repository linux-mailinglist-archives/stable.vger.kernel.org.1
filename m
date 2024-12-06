Return-Path: <stable+bounces-99051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC54A9E6E6E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237DC1887970
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8E200103;
	Fri,  6 Dec 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m89+mAVO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984C1FCF40
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488405; cv=none; b=bq7IIgAsuBr3gGF0CZeVEyD4r9trqQstvKKlVWMSyCpWgK9ULmeVrFd/+fm130stused7rByQo54kEUe7Vp3eOeJvuM+kIF/q7GuPf4AtWwd7Wq8EZgCW9NbQt/fAW/yJxIqsspS0DsgmWdI2szZJlb2dq+EzeX1kg2Eyc/9yiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488405; c=relaxed/simple;
	bh=lL1Y4rWk59EZfJpEtz0SSSGmiRIX7oxZx4lJHOHftxc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mIpFNj7zr7kCo5EX/4+PWDlwSyokgowxtwcXC1dUtAwvXub/lVFQrgXcpRrn5PLLoOY2p0eY4TCoeRjY5jg5eJiiWKOfYRzPhzhuSNN6BKGh/Nvj/Ygirh986A4n+t+xSPNho0fyEiOuJ5pVCoyTyelttj0mFUYo9Lw6XL3iQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m89+mAVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB7EC4CEDE;
	Fri,  6 Dec 2024 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733488405;
	bh=lL1Y4rWk59EZfJpEtz0SSSGmiRIX7oxZx4lJHOHftxc=;
	h=Subject:To:Cc:From:Date:From;
	b=m89+mAVOhYBV6urhVwT4MSLfza4GTUdQgbZBdySY2f61OXsZwNL8jgJgpkvfJCnKX
	 s2YRIYMqCxLNNyOD0HONvMmJIWPWeluDtlcoyXIuA3BJ5QZH6oZm+jrgxU3bIGGkdx
	 u7FJDyv7u2uIDDFarSFrIs5LNMY87fSIYT3qcMQU=
Subject: FAILED: patch "[PATCH] PCI: rockchip-ep: Fix address translation unit programming" failed to apply to 5.10-stable tree
To: dlemoal@kernel.org,bhelgaas@google.com,kwilczynski@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:33:21 +0100
Message-ID: <2024120621-scoreless-reword-f512@gregkh>
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
git cherry-pick -x 64f093c4d99d797b68b407a9d8767aadc3e3ea7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120621-scoreless-reword-f512@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 64f093c4d99d797b68b407a9d8767aadc3e3ea7a Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Thu, 17 Oct 2024 10:58:36 +0900
Subject: [PATCH] PCI: rockchip-ep: Fix address translation unit programming
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Rockchip PCIe endpoint controller handles PCIe transfers addresses
by masking the lower bits of the programmed PCI address and using the
same number of lower bits masked from the CPU address space used for the
mapping. For a PCI mapping of <size> bytes starting from <pci_addr>,
the number of bits masked is the number of address bits changing in the
address range [pci_addr..pci_addr + size - 1].

However, rockchip_pcie_prog_ep_ob_atu() calculates num_pass_bits only
using the size of the mapping, resulting in an incorrect number of mask
bits depending on the value of the PCI address to map.

Fix this by introducing the helper function
rockchip_pcie_ep_ob_atu_num_bits() to correctly calculate the number of
mask bits to use to program the address translation unit. The number of
mask bits is calculated depending on both the PCI address and size of
the mapping, and clamped between 8 and 20 using the macros
ROCKCHIP_PCIE_AT_MIN_NUM_BITS and ROCKCHIP_PCIE_AT_MAX_NUM_BITS. As
defined in the Rockchip RK3399 TRM V1.3 Part2, Sections 17.5.5.1.1 and
17.6.8.2.1, this clamping is necessary because:

  1) The lower 8 bits of the PCI address to be mapped by the outbound
     region are ignored. So a minimum of 8 address bits are needed and
     imply that the PCI address must be aligned to 256.

  2) The outbound memory regions are 1MB in size. So while we can specify
     up to 63-bits for the PCI address (num_bits filed uses bits 0 to 5 of
     the outbound address region 0 register), we must limit the number of
     valid address bits to 20 to match the memory window maximum size (1
     << 20 = 1MB).

Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Link: https://lore.kernel.org/r/20241017015849.190271-2-dlemoal@kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 136274533656..a6805b005798 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -63,15 +63,25 @@ static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
 			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
 }
 
+static int rockchip_pcie_ep_ob_atu_num_bits(struct rockchip_pcie *rockchip,
+					    u64 pci_addr, size_t size)
+{
+	int num_pass_bits = fls64(pci_addr ^ (pci_addr + size - 1));
+
+	return clamp(num_pass_bits,
+		     ROCKCHIP_PCIE_AT_MIN_NUM_BITS,
+		     ROCKCHIP_PCIE_AT_MAX_NUM_BITS);
+}
+
 static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 					 u32 r, u64 cpu_addr, u64 pci_addr,
 					 size_t size)
 {
-	int num_pass_bits = fls64(size - 1);
+	int num_pass_bits;
 	u32 addr0, addr1, desc0;
 
-	if (num_pass_bits < 8)
-		num_pass_bits = 8;
+	num_pass_bits = rockchip_pcie_ep_ob_atu_num_bits(rockchip,
+							 pci_addr, size);
 
 	addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
 		(lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 6111de35f84c..15ee949f2485 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -245,6 +245,10 @@
 	(PCIE_EP_PF_CONFIG_REGS_BASE + (((fn) << 12) & GENMASK(19, 12)))
 #define ROCKCHIP_PCIE_EP_VIRT_FUNC_BASE(fn) \
 	(PCIE_EP_PF_CONFIG_REGS_BASE + 0x10000 + (((fn) << 12) & GENMASK(19, 12)))
+
+#define ROCKCHIP_PCIE_AT_MIN_NUM_BITS  8
+#define ROCKCHIP_PCIE_AT_MAX_NUM_BITS  20
+
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(PCIE_CORE_AXI_CONF_BASE + 0x0828 + (fn) * 0x0040 + (bar) * 0x0008)
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \


