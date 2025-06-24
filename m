Return-Path: <stable+bounces-157947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6032AE5652
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E77F170EC4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECAD2192EC;
	Mon, 23 Jun 2025 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wFt0JFnL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE516D9BF;
	Mon, 23 Jun 2025 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717109; cv=none; b=qJu5+5JUBrItXO2CcZA0QCfG+im/+uEu5Z7F+dEsxJYjh5WFvIWNinCrJBFnbNTPxxTUW2rx5pXJquX3oos5f0C9DQVYJoe+VnaDMxzS50JNNwV91GNxwCrdzFbB7mY6i5aZtEG0zJISTLsq6Xusbfu6Zk70gSS6rEIZEqqZyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717109; c=relaxed/simple;
	bh=U8FplPlMzD6l61erJluzmBnZV88GlH41D4EqABhfSGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZL59wx2dCbwRISfLw/XyAOTABhorbdbKoTbTfs6R1VSmwL6fIjYLe4shLJocL71a5YBS1buoZwTViCvA9TOGcbfNZH50YEh09ps/+6zQnM98gO/kT65cV3qaC6WkFA1QnEvgXSyxGAWZYioq8soiyKcq+1zssKmOnUL7DtQ/sns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wFt0JFnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2C3C4CEEA;
	Mon, 23 Jun 2025 22:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717109;
	bh=U8FplPlMzD6l61erJluzmBnZV88GlH41D4EqABhfSGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wFt0JFnL2Sq0s15z8WEclOaN0ESW2QaD5tQoj92urIdDKR4YiE11TaXWNVSXI8Gdk
	 HmZtPHQ+hA21+O4+TzxyiaWPSUDQft5klHu7Ub3xuomPxE38uAN/8eA0ltDYlU2yfm
	 x+eSLuAWlceNFeHXcl1df0tCwZXtNBf7+jn4tamU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.1 367/508] PCI: cadence-ep: Correct PBA offset in .set_msix() callback
Date: Mon, 23 Jun 2025 15:06:52 +0200
Message-ID: <20250623130654.383703385@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

commit c8bcb01352a86bc5592403904109c22b66bd916e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -294,13 +294,14 @@ static int cdns_pcie_ep_set_msix(struct
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
 
 	/* Set MSIX BAR and offset */
@@ -310,7 +311,7 @@ static int cdns_pcie_ep_set_msix(struct
 
 	/* Set PBA BAR and offset.  BAR must match MSIX BAR */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;



