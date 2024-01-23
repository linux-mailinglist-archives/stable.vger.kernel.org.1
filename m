Return-Path: <stable+bounces-13626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEED837D29
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FED31C286F1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD75D736;
	Tue, 23 Jan 2024 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hn61a1Ox"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB65C603;
	Tue, 23 Jan 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969818; cv=none; b=ejVpuK7+tOvqVyFWBZJb29dWvSujhG023fjGuonQkKT36YpVB2e4P4Pz0MLwhhx0OGhFPOpq01BFEZV/6BR3yrW051svypoIpjS6QEYrxB9beZ0C4f8HoVzWzOmEluOPsVeKIRCgYgrzMMFmD1NRklzjvIo4/GtbAWvDqxRKiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969818; c=relaxed/simple;
	bh=uzZqnJ3vGqupiapXo6qaxcx5BmAK8/EFJL0AzGrT6TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A68K3jLw23rvqRA6XwIIlOs54cT7OIVMGjAq9eSe1C2GCEvTZ3XX2XUAtQfDf8QoYLotkWMakxHjsolBuoNxeL9dkN1JEbadas48DUoOkkr9b4hTkVc9pxwlnXECxTRNn0DH7a03iFojkH+hehdB9vgCY6TQPlvlFyR8roVB7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hn61a1Ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EB1C433C7;
	Tue, 23 Jan 2024 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969818;
	bh=uzZqnJ3vGqupiapXo6qaxcx5BmAK8/EFJL0AzGrT6TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hn61a1OxQqyAhimVdONmgvv/tskTmNOvtL//umdKwYC78d7l4s2zgOIV5loE9kaXs
	 dbBBSzAS74gydevsU6cyc4Bqn/p9qvNKd4AZMCrV+uj7vMqzpq3UeJcvaGrws7VXmQ
	 nDWmLzG7Y+vcOIZZyxlsJSGNL6rQ2XR86rjz6c5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <niklas.cassel@wdc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [PATCH 6.7 468/641] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support
Date: Mon, 22 Jan 2024 15:56:12 -0800
Message-ID: <20240122235832.684822707@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@wdc.com>

commit 2217fffcd63f86776c985d42e76daa43a56abdf1 upstream.

Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
support iATUs which require a specific alignment.

However, this support cannot have been properly tested.

The whole point is for the iATU to map an address that is aligned,
using dw_pcie_ep_map_addr(), and then let the writel() write to
ep->msi_mem + aligned_offset.

Thus, modify the address that is mapped such that it is aligned.
With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
dw_pcie_ep_raise_msi_irq().

Link: https://lore.kernel.org/linux-pci/20231128132231.2221614-1-nks@flawful.org
Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org # 5.7
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
+	msg_addr &= ~aligned_offset;
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)



