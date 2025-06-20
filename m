Return-Path: <stable+bounces-155051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D2BAE1745
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB551894B82
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C427FB1E;
	Fri, 20 Jun 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugtHh5VB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66B8632B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410795; cv=none; b=nQWMBuCDjhwzR42K+swehIN3fdvBDcBYA+8zAvgDnXnRP7Qt4gzXlw7CA4+777pJxJ9DxTP5mKedpSXAKUTUTrFAwPvM+TfvTb7VqMlKj53HnvxuL2Eg9Oty27VWTGfgh4gOiYdJv2fBsUhuI10TWpG++LQXupsWPgoTQ8Z5npE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410795; c=relaxed/simple;
	bh=pySKL1+34Ufdb4EXmx7rdLTWpWH4yT+m5H+92ApuoJ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Oeoo8HHPBEgcMhtt0pIJWveo+C7VtYrJOo+GD5BQRjDqU+OI7LXnEBw0jTo6DOJw0DjBMHpDiqrCCS8WFM1na0u6ErRpVPV3+D2lpzdBbRgqerF5dU7rZn1WmOSiDppcLCPS0B5phOgyh55B7GyouDUA0r3dEGmeTlnl3/Ticws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugtHh5VB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBF1C4CEE3;
	Fri, 20 Jun 2025 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410795;
	bh=pySKL1+34Ufdb4EXmx7rdLTWpWH4yT+m5H+92ApuoJ4=;
	h=Subject:To:Cc:From:Date:From;
	b=ugtHh5VBq/8+vuqnZ2sTVi7eOFkXUHQKXKe5eCfIbnx5uJi4qBEljQyIBC/9r3jWy
	 XdOTPgfCm7bNdaL7FeNvalPokA6+StAm+WzsYUbl/JS4fBxhLZuuU1LMX5QVGTgE3P
	 DZ6rNyhf3gR6kVakvwtNzntFx7dkM6q+ie86QNAE=
Subject: FAILED: patch "[PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from" failed to apply to 5.15-stable tree
To: shawn.lin@rock-chips.com,cassel@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:13:04 +0200
Message-ID: <2025062004-mystified-skimmed-94c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7d9b5d6115532cf90a789ed6afd3f4c70ebbd827
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062004-mystified-skimmed-94c0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


