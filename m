Return-Path: <stable+bounces-186903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC76BE9C0D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28FB0348089
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B933290A;
	Fri, 17 Oct 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hQ13YOmE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C509732E15D;
	Fri, 17 Oct 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714556; cv=none; b=Zrc2WV7hKu+axCEFbghSOnK6sy9EYdbCWhPjApp9Xgnr3+ZEOgH04KAlKws1aXRI0ENlitrmMUA6lXKAQfM9f28tbGuH6oFyuJp3MI/p+03LVCj2vgn685fyYu7CjuKbkGGqwEfxissvQUjdG+ga4PEGgclwg2CjadDyOk00MLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714556; c=relaxed/simple;
	bh=kRz3ExObRv+Ju5YxzuWDAbeLijkszsOC5P4Oc6qS58M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uP3G3Tv3pdBRxHbYLFWEq65emfXSHhkzwv0egzWIaIqd9j8r5ErwAZuvHyVREeWcOZmYIDgak4NocRZcOPGsB8pb/YJ1iEXl6XS9FfiE7uf3voF3V25nxo+UVYS7ElVtyb4QrTjtv9kjDXnoIzpoXj9OmrIuqCTFHFh9KeYWD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hQ13YOmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48475C4CEE7;
	Fri, 17 Oct 2025 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714556;
	bh=kRz3ExObRv+Ju5YxzuWDAbeLijkszsOC5P4Oc6qS58M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQ13YOmEFTzWYVEL+j9sIY/bgD2OHjZnn73IKDKJ0a3MsgEc4SCNZZM8ZgnnhMJ0i
	 +9qGwW5RIT2mT694BoZPPL+8kkeB3TCKHEIBxjoLMq+HbnbYQ9iQ327W9TyRpQTDWJ
	 f152JpzVzVIoUf/RX3+zzY+Wk1FBRVtDSQhTz2mE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 6.12 187/277] PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()
Date: Fri, 17 Oct 2025 16:53:14 +0200
Message-ID: <20251017145153.951545252@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

commit b640d42a6ac9ba01abe65ec34f7c73aaf6758ab8 upstream.

The pci_epc_raise_irq() supplies a MSI or MSI-X interrupt number in range
(1-N), as per the pci_epc_raise_irq() kdoc, where N is 32 for MSI.

But tegra_pcie_ep_raise_msi_irq() incorrectly uses the interrupt number as
the MSI vector. This causes wrong MSI vector to be triggered, leading to
the failure of PCI endpoint Kselftest MSI_TEST test case.

To fix this issue, convert the interrupt number to MSI vector.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250922140822.519796-6-cassel@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1954,10 +1954,10 @@ static int tegra_pcie_ep_raise_intx_irq(
 
 static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
-	if (unlikely(irq > 31))
+	if (unlikely(irq > 32))
 		return -EINVAL;
 
-	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
+	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
 
 	return 0;
 }



