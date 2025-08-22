Return-Path: <stable+bounces-172517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BEDB323B4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 22:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6F662561D
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C612D7804;
	Fri, 22 Aug 2025 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO3o0XGW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194872D6E47
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895257; cv=none; b=TbWkQfl8MDuUiypt6uDGdOPHSZ8CB7/Fbj3/6j3g89bR+TR2uYvLOwD1pe3IV/1QFSqYJW5/WqHcCe2gi0ofb0rMje1y5WWwv3uqSHft+L0gk2EEyxN2erm1r1PXjlaNT6K5XU3Jvqp5y9EqZ8SvLxX33LhutUJVMg5o26aJi2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895257; c=relaxed/simple;
	bh=0gR0mBs1b7pcCKymQXl5qZP1xyjsSyulA5POocTn6iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjSf9jbmkivaqJ6l5DiXjLKjcz0sBP8mIsW9aqUze2yF0I+liKoKBv5X0xXm7AEJYhApviJXnyMeOiuGG9lly2wAKhzcUueHVgk88QZIrL4bEITQClN5SX+UMf9Vr3fHMUVrDGUgqMUrcYy1Jl27oAKQmkm8qvkXWRib2WQ+y3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO3o0XGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85AFC4CEF1;
	Fri, 22 Aug 2025 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755895255;
	bh=0gR0mBs1b7pcCKymQXl5qZP1xyjsSyulA5POocTn6iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CO3o0XGWOmMG8MficV+A4YUruXUmJV8LLCNWcFgud8pq0rEhn9mT7NheG20kUvz3H
	 NE9lotwp9LCxR0EOEIFmjgF/J5Zh55jdofCIf0ArVIGeewMY9VpY81h4E2XfnZ1C+B
	 ZcwAriHF8MsXYsubjQyBNyuKm2A4j9UgjOa3LYJlBvZx87RVMbCEQOOJ+cViiepkDe
	 /KDrsrSHgt9zk6XZt9hPd5zIr+mDPk7ahmcQFkwqkGNeKmVGpJK1RsgfPPTaABOO9G
	 EH3Xkvf1eJ3XRVZgGBt2u51nulVDA9KFfjN7R1TdKTIwIs+pxhVLTFrVmkj+g/LKNC
	 19sZ5DXnEZI6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI: imx6: Delay link start until configfs 'start' written
Date: Fri, 22 Aug 2025 16:40:52 -0400
Message-ID: <20250822204052.1519937-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082111-relock-troubling-f45c@gregkh>
References: <2025082111-relock-troubling-f45c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit 2e6ea70690ddd1ffa422423fd0d4523e4dfe4b62 ]

According to Documentation/PCI/endpoint/pci-endpoint-cfs.rst, the Endpoint
controller (EPC) should only start the link when userspace writes '1' to
the '/sys/kernel/config/pci_ep/controllers/<EPC>/start' attribute, which
ultimately results in calling imx_pcie_start_link() via
pci_epc_start_store().

To align with the documented behavior, do not start the link automatically
when adding the EP controller.

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[mani: reworded commit subject and description]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250709033722.2924372-3-hongxing.zhu@nxp.com
[ imx_pcie_ltssm_enable() => imx6_pcie_ltssm_enable() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index cedfbd425863..2bcc86ee14f4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1098,8 +1098,6 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 		dev_err(dev, "failed to initialize endpoint\n");
 		return ret;
 	}
-	/* Start LTSSM. */
-	imx6_pcie_ltssm_enable(dev);
 
 	return 0;
 }
-- 
2.50.1


