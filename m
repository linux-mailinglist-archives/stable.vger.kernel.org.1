Return-Path: <stable+bounces-131384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4AA809E2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C364E61F1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0488D26FA57;
	Tue,  8 Apr 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ELqalhSp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6112265630;
	Tue,  8 Apr 2025 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116251; cv=none; b=J6Lvc0RVhos5jAftz7++I68YrsdKAnxkfPgeWu03G4TqotfRCfW9ApGN00V3/XbFuTCrH9RL3RGBmeZBBh8dgaOrrqQ5Cu+ay2CwhVT5iYTx1ZtYYj9cqrsCv0PVEooNCFiXfSaxrTzB7d1PBIBHvVRHMiTCY4WJVtRsenUsmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116251; c=relaxed/simple;
	bh=ok2dsSmslfALs5R5nKRXZu8Ay0NvAKhRDfoI5itWbzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is0rg13Nf4xaG8TN4pKVg8ZR1JTGEyM+X76fzL/G+af2QX2LfjtSIyxDYENxwvgzdT8wrFclbbszCZ7/pUi7cfdtYR/qJRxhsKtzzu0kYhWkm2NtHEN+At18thaELPpjQRaQuON+UiP9iGF7k36VueugRAb7ffeRDoQubpoUolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ELqalhSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3886AC4CEE5;
	Tue,  8 Apr 2025 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116251;
	bh=ok2dsSmslfALs5R5nKRXZu8Ay0NvAKhRDfoI5itWbzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELqalhSp1oV4Rpe9cnzqFYPnqswsDfj8+zqUkrg+qEo1swWNiL8SNhnRMDRq6LGME
	 BHbsBquNHEQPtxQ8y8RhjvmxAY7mxGEjRbBLfTszsBEqLKImLmyyy1n1Jbdz3I+1T/
	 H9xgusz2QQbCGeE0GvEt+n0uhr2QaPYnWMSVZx6s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Zhang <18255117159@163.com>,
	Hans Zhang <hans.zhang@cixtech.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 071/423] PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload
Date: Tue,  8 Apr 2025 12:46:37 +0200
Message-ID: <20250408104847.401910125@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Zhang <18255117159@163.com>

[ Upstream commit 3ac47fbf4f6e8c3a7c3855fac68cc3246f90f850 ]

Per the Cadence's "PCIe Controller IP for AX14" user guide, Version
1.04, Section 9.1.7.1, "AXI Subordinate to PCIe Address Translation
Registers", Table 9.4, the bit 16 of the AXI Subordinate Address
(axi_s_awaddr) when set corresponds to MSG with data, and when not set,
to MSG without data.

However, the driver is currently doing the opposite and due to this,
the INTx is never received on the host.

So, fix the driver to reflect the documentation and also make INTx work.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20250214165724.184599-1-18255117159@163.com
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
 drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde7..0bf4cde34f517 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 	spin_unlock_irqrestore(&ep->lock, flags);
 
 	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
-		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
-		 CDNS_PCIE_MSG_NO_DATA;
+		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
 	writel(0, ep->irq_cpu_addr + offset);
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec19..39ee9945c903e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
 #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
 	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
-#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
+#define CDNS_PCIE_MSG_DATA			BIT(16)
 
 struct cdns_pcie;
 
-- 
2.39.5




