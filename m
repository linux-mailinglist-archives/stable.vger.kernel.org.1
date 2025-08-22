Return-Path: <stable+bounces-172503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE50B322A4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBA1B207A2
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C52C17A8;
	Fri, 22 Aug 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV6BlWK6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81372C159D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889836; cv=none; b=cHKa+r97BLhuySb59Bx9eKe2j59jFpOGPblYIaK51NeGz8cHnZ1z8T5oZc4aNuVN7tCGlSVqno8wrIyQ5ibrAqzLAn0H1PFfdspKdY9M1c4R5jcNkoRV0ZY2hKVsMcXk0bHIBP4pIzG6UwzL7Kw9YTyOOamOfEn5RcCCQR7NMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889836; c=relaxed/simple;
	bh=JDy2eBROVGKtzmm/49JYFcrhhH+AvzZktn5zGi20X+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/7TkOwuLOasCui29HI6dfOJweozK6hM2RiNBeq5emA7bwqeN+fIJYcPNZ1nHY4hoxlGPXFkjkoSrGqzo8u3i1MLWHGMpUsqOQ130PUd/nztOlm0ywx5jG+R7AxkzhL+Tjuv7vNPUpKRTkED/V4mccyx505RpJziLL0WEHWECrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV6BlWK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF2EC113CF;
	Fri, 22 Aug 2025 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755889835;
	bh=JDy2eBROVGKtzmm/49JYFcrhhH+AvzZktn5zGi20X+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AV6BlWK6WojcSO5UkYxHN6ij4PzO+K46IUxD3NXiPVkaPi3yw2smZzyN9J0T6ru0B
	 0v1ridaghRb+zszLs9nKDQC69BymEdDAyeqyWX5WCXU7p2HMqMZK2hOSgUNLFQp/E4
	 ngXBHqUAiOwOgSJLioMZ893/MflNc37/jSl/hPJED4sHqJARuRtxAtQYMiWmWSJ069
	 QlJ2TyT1F3RHR2S7vdIrP//vYKAZ0ljwiYbWUCRm8ky49iJajv8cvQRxd/Ec1XDdIx
	 JwdIa5ckIIse76FmtKLsCpVyCtMrl8I2xsqvCPkp2ORrnIflhAgKnwdHMMmNozeMvo
	 t1EBz83eF3HwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] PCI: rockchip: Set Target Link Speed to 5.0 GT/s before retraining
Date: Fri, 22 Aug 2025 15:10:31 -0400
Message-ID: <20250822191032.1432952-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822191032.1432952-1-sashal@kernel.org>
References: <2025082125-deputy-provoke-92e7@gregkh>
 <20250822191032.1432952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geraldo Nascimento <geraldogabriel@gmail.com>

[ Upstream commit 114b06ee108cabc82b995fbac6672230a9776936 ]

Rockchip controllers can support up to 5.0 GT/s link speed. But the driver
doesn't set the Target Link Speed currently. This may cause failure in
retraining the link to 5.0 GT/s if supported by the endpoint. So set the
Target Link Speed to 5.0 GT/s in the Link Control and Status Register 2.

Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
[mani: fixed whitespace warning, commit message rewording, added fixes tag]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/0afa6bc47b7f50e2e81b0b47d51c66feb0fb565f.1751322015.git.geraldogabriel@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 357a4509ea51..77f065284fa3 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -342,6 +342,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status &= ~PCI_EXP_LNKCTL2_TLS;
+		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-- 
2.50.1


