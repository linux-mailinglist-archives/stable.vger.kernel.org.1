Return-Path: <stable+bounces-176776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F324B3D526
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 22:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 440F77AADE8
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824C622CBC6;
	Sun, 31 Aug 2025 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VOm8/WjT"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE042153ED
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756671714; cv=none; b=SrvFSN0xMJZkeguZeTptYF8vUIAWJZbF0TfU9H185Uh0tUZ4dD89HR3SS+0AjvisI7M6BkOqg7kOOG+3KLinhQW8Q8NkmO7R0Yt52fsG6XO1sv7uB7+RvzMZCWCSwdNFZ6Xab8mZaVmnW7VSjGKSTSMvHfbR5ggycQ+oovdc0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756671714; c=relaxed/simple;
	bh=Xj9LDGcB5k64hfy81C5HDGNBcky1uAyosY5h3N5gj3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxuTndQ4MqtQFqUloF0wJwOMO2Azdn37L+JRmEewqRsdPC+6uLmNBL27SstSDG32mepud6jwRpZy/0GOhss1ez+KnpQYyXvO+s5A53jGiw4PcxIo2erH9XdmkQ0EuLN0iDTmjrvT/TtK17YaubSK/8qHtMkykQecbssgiRUvqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VOm8/WjT; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cFNhD50F9z9stc;
	Sun, 31 Aug 2025 22:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756671708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFDTznUcpqCdl2K+bs5gzSYmb6hQgkvBiWsN+65QQJo=;
	b=VOm8/WjT/q1Fwx3ATjmgZp3eJJpwlLh3d7MatQU8CYOSs4J4/I0g3HxkfYFGIn4Hl31SAH
	+j9U4GcF80f3UWOzwuYpwv7YeIr2DOLKf1F144faB884LB52w8L2qpt9PtUgCg5ixozMLP
	iZthPuIX0wbSrAiqGyFaWtf1+Zcxele+s0oe+lUunvKr+C3l14aShHGKogIN6GB3rAVtiO
	pTt6VANqwlbvete3dLF1ZETDSGTg4ZLymrqWCMX1YEKrieVlUhy7IxHDKTsaVOQo91cPdY
	UuGn/QGH+zTJ8j0Fo9qPabf30t7ck8QaQ0sJ14pGoaSW8JYD9hsJlz4oPQxrxA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 2/2] PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link up
Date: Sun, 31 Aug 2025 22:20:49 +0200
Message-ID: <20250831202100.443607-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250831202100.443607-1-marek.vasut+renesas@mailbox.org>
References: <20250831202100.443607-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9m3jo9nf4zjq8rhscfkmaidiw3gu3eqt
X-MBO-RS-ID: 10cd81abf1993f469e4

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 80dc18a0cba8dea42614f021b20a04354b213d86 ]

As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
training completes before sending a Configuration Request.

Add this delay in dw_pcie_wait_for_link(), after the link is reported as
up. The delay will only be performed in the success case where the link
came up.

DWC glue drivers that have a link up IRQ (drivers that set
use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
perform this delay in their threaded link up IRQ handler.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: <stable@vger.kernel.org> # 6.12.x
---
 drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d40afe74ddd1a..f9473b8160778 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -655,6 +655,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
+	/*
+	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
+	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
+	 * after Link training completes before sending a Configuration Request.
+	 */
+	if (pci->max_link_speed > 2)
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
-- 
2.50.1


