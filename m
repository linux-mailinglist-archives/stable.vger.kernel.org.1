Return-Path: <stable+bounces-155050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AC8AE1744
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D544A54C2
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CAC27FB35;
	Fri, 20 Jun 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0NdA6Lz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E8207A08
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410787; cv=none; b=elV5esOobnkn2BwW5ar2oc0AU2qevp0BlNE8BCU6rDAbPIgd0LxuZv1fConl0QVkmyqndAbBgbaOddEAdzh21mrAO7DSkDRb8Cz/P/nIaU0lF2Pze/hXTqmizxZXIK3FpUd6cw2mVu3wqseioABQNtzGylXFjdsN8C6vWqkOQ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410787; c=relaxed/simple;
	bh=0cT8MZquSRExq/JwAGG98RLT9oTbcISgj4UNBUUQmVI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E1RRDTB9jtoo1CDLjW72B3v7lAguu5aznCwTno4O6obrNCNNFZWCP6kgPOI6zzO+Qluj2Oir4XlXqfYOuJEgYWQry6y0gY7AZG6FZ/hf0jX0BFsMZFv+l7t9pmNb0xF5tgsRnH2C2j84LLF2ABwnslAc4izF1Y4Hznx7mWwrhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0NdA6Lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E5CC4CEE3;
	Fri, 20 Jun 2025 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410786;
	bh=0cT8MZquSRExq/JwAGG98RLT9oTbcISgj4UNBUUQmVI=;
	h=Subject:To:Cc:From:Date:From;
	b=G0NdA6Lzkkf/kHGr99o9wboVTmvZaMjb75AY9E8PY5cqTAWtCf7tI8nTE+gy7AKbA
	 +HwCBsCt/r6bjV4zFDmkPMLAkQb+12sUavHkSNTWucLoG1QTOCIk83mLck1+awY/wj
	 rYk/w8wx5dtWWB7tIsUEN7MB/7jhbdyNaW/C0Cmk=
Subject: FAILED: patch "[PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from" failed to apply to 6.6-stable tree
To: shawn.lin@rock-chips.com,cassel@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:13:03 +0200
Message-ID: <2025062003-garland-playful-e84e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7d9b5d6115532cf90a789ed6afd3f4c70ebbd827
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062003-garland-playful-e84e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d9b5d6115532cf90a789ed6afd3f4c70ebbd827 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Thu, 17 Apr 2025 08:35:09 +0800
Subject: [PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from
 rockchip_pcie_link_up()

rockchip_pcie_link_up() currently has two issues:
1. Value 0x11 of PCIE_L0S_ENTRY corresponds to L0 state, not L0S. So the
naming is wrong from the very beginning.
2. Checking for value 0x11 treats other states like L0S and L1 as link
down, which is wrong.

Hence, remove the PCIE_L0S_ENTRY check and also its definition. This allows
adding ASPM support in the successive commits.

Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
[mani: commit message rewording]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c624b7ebd118..21dc99c9d95c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -44,7 +44,6 @@
 #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
 #define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
 #define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
-#define PCIE_L0S_ENTRY			0x11
 #define PCIE_CLIENT_GENERAL_CONTROL	0x0
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
 #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
@@ -177,8 +176,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	u32 val = rockchip_pcie_get_ltssm(rockchip);
 
-	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
-	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
+	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
 		return 1;
 
 	return 0;


