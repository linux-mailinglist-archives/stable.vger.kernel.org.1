Return-Path: <stable+bounces-155605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D6AE42D6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FD71888C7E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7C2517AF;
	Mon, 23 Jun 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jHnCx/c+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03845242D90;
	Mon, 23 Jun 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684862; cv=none; b=sqIaF7jg+TWFKCmcc/s/2HC+cVUzPesxiURozI0Vm+uA2S0INyLkgXQwKjDXACF9k7Gxkz1GUtcM4KptlWTaB3CGcsF9+EOKbbJhPDVfCOlaEiLQcfaDcdyxJlU0kevPZkMc4OHK3i2bGdD7WjTgJdNuuyG87jrxe414Hz/ucJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684862; c=relaxed/simple;
	bh=8MhrdeEa8kXjyOHOovfZE0kqXudXsloUCcSbzEpd0Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1RvCnyHTt9v64eLQw+evWXp7e9qZe7ZHl5F3DWY6ZfT24PLitZPEpLY0z+cWVjnayghfXOb/KY5sorNF3jI/b68sJDr+Z+I1fBUUetgA434DdboHN0/SMEzNOssf2pt2Q3YxF9SZqeha9xnVjnTKtnuC/cFHWSqVGe/LaSaO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jHnCx/c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A115C4CEEA;
	Mon, 23 Jun 2025 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684861;
	bh=8MhrdeEa8kXjyOHOovfZE0kqXudXsloUCcSbzEpd0Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHnCx/c+7j7i7A20tkix4LFz3nwNMkLXhF2D3SXT3WjBTWxzaSqqV1cSRzSPJC6O5
	 cFDiIAKq2iB7QETs6xxYnztGXBQ62uBTRXMUfAoIuTddm2BweQaZVPR7Q9LatmlbHr
	 vSFXfh4DX7MiSym1f8YYBnshFsVn5FowgSn4w6TM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6.15 184/592] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from rockchip_pcie_link_up()
Date: Mon, 23 Jun 2025 15:02:22 +0200
Message-ID: <20250623130704.660102244@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

commit 7d9b5d6115532cf90a789ed6afd3f4c70ebbd827 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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
@@ -177,8 +176,7 @@ static int rockchip_pcie_link_up(struct
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	u32 val = rockchip_pcie_get_ltssm(rockchip);
 
-	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
-	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
+	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
 		return 1;
 
 	return 0;



