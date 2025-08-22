Return-Path: <stable+bounces-172521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A870B323D2
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 22:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6562B05C27
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282462FDC40;
	Fri, 22 Aug 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZAowf9+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB642ED14B
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896148; cv=none; b=BYbzbqp8PJ6nkoF2mAGt7dHs4tuLiu5gLByTZwQfnIqJ/1b4ZfRbPZL5nyKDzQwqxtzxoEJdEZO8+Qm17sFGh2iT/z/I4qdAuviMhd5bb3dGK7tHus2BvYAAz3foao5OH2DL6pFM9Z387HQLCfuoT2A+mCrQnE2ByuaEiwt8WfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896148; c=relaxed/simple;
	bh=kPvcmSA4cPBJ7eJn8tDpdsYyuqDCA+ZiIMX8ImWGeaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMJ3MqvLLZBRxIn4P4uLra2hj1dgsue3HP/lpCLvtmf/2TOxPsMPc4jhT+aff41P1MGWc/TEEOh1QzIrI1wy7KBqEZwf7LCjFAmYdnU9GVJK74Po38TogTDCfICNXRfjHT+P/aThmud4KfSZGgqB6RJUst/im6/M9JNt4yF345A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZAowf9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43FEC113CF;
	Fri, 22 Aug 2025 20:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755896148;
	bh=kPvcmSA4cPBJ7eJn8tDpdsYyuqDCA+ZiIMX8ImWGeaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZAowf9+Jp4bo/0jUbvXE2rlI06NShCQ71xkwIsTfWMzuF+XZMKy7O3xrmjknl+pZ
	 21t4MP/+I51WQOqFSrVY9Q3arDDgBqRi2MUGi1IHo2zug24sxKWrcRi6G1wA/XL4mD
	 3rhCaCCoTfJ1/bGHYhmz6ubYCxkKR44rXNzcmRl2lZyQ02fjrtZIMhFjTHMiFq6gYH
	 6JIb1G9Lt6dYEWBzemcJdmUGSAwtiAe6I52Hpuu+jBcXxzarHzknk9+TnBJmlyAgZZ
	 yuBcGF/0t97Rj8abBHsMQNKEn6PiV3Zgf6sF1uaCi/0ABIeb59mvYTwZeVP/enXRNY
	 o3rusoiKBWNxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] PCI: rockchip: Set Target Link Speed to 5.0 GT/s before retraining
Date: Fri, 22 Aug 2025 16:55:44 -0400
Message-ID: <20250822205544.1528134-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822205544.1528134-1-sashal@kernel.org>
References: <2025082127-dreamy-chase-b12a@gregkh>
 <20250822205544.1528134-1-sashal@kernel.org>
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
index f10023fb59ee..32b82e916b57 100644
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


