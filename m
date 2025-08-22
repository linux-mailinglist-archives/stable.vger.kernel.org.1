Return-Path: <stable+bounces-172515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77DB3239A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 22:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EBB3AB3C5
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352902BDC03;
	Fri, 22 Aug 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/I7+WY8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C52D77F7
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894606; cv=none; b=XIbUgzfr4NMA5cicjYIHT+yyRJb309XU8se4OL+HrXvgkJHIPqFHFcN5jaokEQbNaJmlK/xU5xqt40M+/SM7MTApoGnRYD2GDGsi4VhO0T8PzVzsRjRyF4AZqTqjSTqcIK+/4+AmkTGlxsiORQD38a4KsoOc5UYhMj/0b36IuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894606; c=relaxed/simple;
	bh=GbSxnfcW4q81gw/DtOt1VrFthsaEuoWMBiL7QAmlpPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUUSsh9fuZvTwTgNonY6e01w+FERuXNQUWYdbfp8asoTlLt6QVUP0UsjiTrMMF98rRL+HwcI+9PyuqoaxTEZiN6oaFGvUYdiqGWjOCqhPRFf+pebgNmO/JI6VPkuK144qIcj7MHF3g49YtaXymlvQTVtrNyaTV1KKMdjZzVYlrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/I7+WY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9F6C116B1;
	Fri, 22 Aug 2025 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755894604;
	bh=GbSxnfcW4q81gw/DtOt1VrFthsaEuoWMBiL7QAmlpPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/I7+WY85L98stLrAQLwkfRud4bIwL6J5o9BfzkvtBVd2TfzH+7DfHgR0JilD/9U4
	 t5lp/F6EoOmbb6J4HCTevHWtQ4WjeA44eaw9nQVygEaGcLehdVwDExlFgJ4dgC73yo
	 s7srLgbV0UCxcyodatZ6hix86bEA5zJE3cWy0+B8ulruOuFEVtCfjAAhUuXT6+9W2S
	 upacGm3p/iQCMygvzVCOmCF63NH9ic//3b3WgCUYyT2zfXzp1jwip94uP660l1QXB5
	 sawGN7HMVOcTkc5qILCGn2nWvc+DAtdnxAnyh1qS72d7w1xJ5DaAuVLwJp8YCvWhu8
	 +NOp4G8uKJNJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] PCI: rockchip: Set Target Link Speed to 5.0 GT/s before retraining
Date: Fri, 22 Aug 2025 16:29:59 -0400
Message-ID: <20250822202959.1484986-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822202959.1484986-1-sashal@kernel.org>
References: <2025082126-geometric-stark-b2bc@gregkh>
 <20250822202959.1484986-1-sashal@kernel.org>
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
index 54d195a8d55b..ea1df03edc2e 100644
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


