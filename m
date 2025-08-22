Return-Path: <stable+bounces-172519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37791B323B6
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 22:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AB95665CA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A02D781F;
	Fri, 22 Aug 2025 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeZ0x3qz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD6528150F
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895264; cv=none; b=dk2kdvFCQNse+xay1C1lf8nWVqTcpphJqUGXgZbF0RO0vWqZ8hHK5IWuZcjVet6schUZqIheStmXokDtasyHD3uFzf1AbQm5EcBF5Iimn2/LrL2Lyqa4JzYRZzGyv7B3vsmaOsKuBn+sBT4Ev7e00W+E/h0nOQ45+7e46hUIsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895264; c=relaxed/simple;
	bh=5THeiSUH+GwZEmfRIY5L9vVeXPDVf1+CCufDQSawFD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMZyDwl7rfVyg9YSOQtm1wBOrC4A2znPlprufFTl5dZC7ihyZ638JjD1Pbq4J+zacu190LSRa3LaBWnbnCHRxtWO4LMh5vlZbcPzf//ATm6B76tzWX2lXJhxBFZyWK1N9wgww51RZfQ6Ibt52jjd4g26c2lDxe0senpfHeN9csE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeZ0x3qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0A5C4CEF1;
	Fri, 22 Aug 2025 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755895264;
	bh=5THeiSUH+GwZEmfRIY5L9vVeXPDVf1+CCufDQSawFD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeZ0x3qzNI2ykOcgfPAD8fea78hiSCRDz3+sA/QCrTBeTbJAk4Vb1WweVaTs8cxLt
	 reFAVYCQzxasowJVavxIog6zLKLdvgJveDJhdTPb8bE0UVrt092W3vU11IXvnRSjcp
	 wCEtc3zJg/pzvfHSDZ5AN3SNMJN9A3f8jkGh0O+TdupEbhCvfkPVxe8itFQJRTivM+
	 a5YsrAFkGuj8b9HMFmTDaLIOmQpUq4XouZ6EDcZKizrMZzVS3T4VK666cRTucahs4F
	 rhXphjDQ1ZHBqyGjhOC5X+62VLl+fgXk6XM2jvK/lLs33gnGjkxBKkEOAua7rmaax7
	 3CQvjh4gdgKmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] PCI: rockchip: Set Target Link Speed to 5.0 GT/s before retraining
Date: Fri, 22 Aug 2025 16:40:59 -0400
Message-ID: <20250822204059.1520239-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822204059.1520239-1-sashal@kernel.org>
References: <2025082126-primp-scoff-af34@gregkh>
 <20250822204059.1520239-1-sashal@kernel.org>
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
index b262480a12b0..c25f32abbdf6 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -339,6 +339,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
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


