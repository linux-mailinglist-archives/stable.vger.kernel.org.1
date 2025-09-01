Return-Path: <stable+bounces-176916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D9B3F152
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 01:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E991A83E79
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66E4287249;
	Mon,  1 Sep 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SDhmWVtY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wP+D39Q8"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62B2853E2
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756768888; cv=none; b=YrUjP+QbCdDhoFWb1mnyXgAGOGBVrz6ItUpSoihy6m/jNtMhYDhxWkVDlVzZesw+0IWkOGFKPkdgfUsborU7uPcY+uFKwPwluwg6qFr89Dto3WFpuQnUbZOU02h8E9ceM5Zz9wyRB5Tt2FFoYg6CYPHTmCdr1eS51gdF0nTBSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756768888; c=relaxed/simple;
	bh=O72R77SRWosP1S8lN/BmObGzANH8tn4FhOhcUhfP9qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9em89xBUMVkcyHgDOZiOlHyfJbVGzM3AiMxI/YZzZVpPVBjMaBuyhJCXM2eD2TINlIsDzY1WtuQm1pFVHJmuE/74UTALGDt3j2k5MVjt4Yy7Hq6pg41E/gWVq7gQWNz5quY8s//L0hl99fmTXgUzfrPo11ASbvd5APJvR06av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SDhmWVtY; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wP+D39Q8; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cG4d06Lb6z9tcR;
	Tue,  2 Sep 2025 01:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756768884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A0TS/MuuBOb4e1g5oyiDVjipXCw+4/CDYUrn74Rpm1U=;
	b=SDhmWVtYtGZcwkeEr9ZE8iy5CB9pOPvm2PyayPHaO9dWWxdLcRsjEQI/a4AzKdhQ4ddm9G
	g659O4pjcGaDsz24sooldW4qq0LZ2AjqOoA1Vp9l9e7EE9nRaEflZlj3XrT++4t1+np1Ko
	+jZECEtoGj0xJEUgjEelusxIa05StwV/rH+LiqET7W0eXjr3jCGyYvr8JE7LPJovIs6dbZ
	KrrllADrxeutnTI6IdjRAqc4YIvZwQ6TLATmEK+p+u4CORH21F3gRHwLjBY1yw8ZUvICdF
	YWpDTMg6jw8kcRxHdKA+KiOQ1y5+B3113gs3/ZueY3ld3l1pP59xurtAuNnAZw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wP+D39Q8;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756768883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A0TS/MuuBOb4e1g5oyiDVjipXCw+4/CDYUrn74Rpm1U=;
	b=wP+D39Q8DhfOMD2ZpvwrHgYhYp9kxvWR6LT9522wxjP/okaAwZarUcOjBYy0JSC80mqph4
	xe+2H5qE/D2K0MqZhE5an1A7hmd4n959JYE4jGNUYPdNaz5ZE4WVc6gW+J7o23eNjSx39y
	cUVG0RREjQ3lflRGgjlMsPFPwn9ENjo8p0rPG+6MTpryfiCSH6hcaGUu40MylV2Zac7tVb
	3BCG6d29MZAZ7JXspWD35d9pr+htCBYC4m/IyR+wsc57ejsqyzoW+5Klj4YUv3Q8hsYhZW
	Zu+JUcemET1MPMwFXHHKHGcIVqB/Ol7xAWY6BPOR46o5E6ruNYXtMURQl6n9CA==
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v2 2/2] PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link up
Date: Tue,  2 Sep 2025 01:20:10 +0200
Message-ID: <20250901232051.232813-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250901232051.232813-1-marek.vasut+renesas@mailbox.org>
References: <20250901232051.232813-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d783cd1962064fca2fc
X-MBO-RS-META: mf14ktgxijca8ixqhff3ixmgm37oe7xe
X-Rspamd-Queue-Id: 4cG4d06Lb6z9tcR

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
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: <stable@vger.kernel.org> # 6.12.x
---
V2: Add own SoB line
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


