Return-Path: <stable+bounces-149795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E2ACB4D8
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769494050C1
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC37224AED;
	Mon,  2 Jun 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xfPFX9tJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5020E026;
	Mon,  2 Jun 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875063; cv=none; b=OMBaICvBCF+hS3Bi19X6zRawJXuD3CtFSb/uesKWlQtXrMvrSp98ZAaOVgbPmZfrkMaUEJOTnJLBZXKEUiETlSG1ODap0yyLCVDZ8ZLXp6OaSA6S9IIkNNqzsMkQrS/nsN3hUjaKQ4f2qZIR3sAFMUv4P6PV3cFdLZRPOrKmUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875063; c=relaxed/simple;
	bh=5oE/fC574sOunMf5vyj4z7nATJjzjKCYaCuGnV2canc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGPhhDD/g5wIOx42Fn+aPEynGiYVrU//+ENFKXdPfwi27Ue3zVqZ22KtCbJEFKLUbOFpdu726W9sxvmw9kcmFQQn9In7l5jfHvonpLXJolb10yApaBVJruE8yPaC3zVAMIR71+AycIHXM+F7PNw2mdQa4KgVuPsew7zG6YQkU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xfPFX9tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285BBC4CEEB;
	Mon,  2 Jun 2025 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875063;
	bh=5oE/fC574sOunMf5vyj4z7nATJjzjKCYaCuGnV2canc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xfPFX9tJ9SYtMc5h6vItYIA+QEXZQ63Qu5YOfbRLkw5USVCTPtKfQSqFYcDSD61/H
	 Sreyd9GqZtnMSxMEDjjMQbf2wIIp2OfhDIr2kujfhmMDtxMN6e+TM+PMiOCEjaCk6E
	 /xrqRhF5pbk03HNzKo5IEg4+VZ4mOQrxrvK3IxYc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenpeng Liang <liangwenpeng@huawei.com>,
	Weihang Li <liweihang@huawei.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 017/270] net/mlx5: Remove return statement exist at the end of void function
Date: Mon,  2 Jun 2025 15:45:02 +0200
Message-ID: <20250602134307.897214924@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenpeng Liang <liangwenpeng@huawei.com>

[ Upstream commit 9dee115bc1478b6a51f664defbc5b091985a3fd3 ]

void function return statements are not generally useful.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: 90538d23278a ("net/mlx5: E-switch, Fix error handling for enabling roce")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 6fd9749203944..2f886bd776640 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -88,7 +88,6 @@ static void irq_set_name(char *name, int vecidx)
 
 	snprintf(name, MLX5_MAX_IRQ_NAME, "mlx5_comp%d",
 		 vecidx - MLX5_IRQ_VEC_COMP_BASE);
-	return;
 }
 
 static int request_irqs(struct mlx5_core_dev *dev, int nvec)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
index 945d90844f0cb..ab5afa6c5e0fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
@@ -183,5 +183,4 @@ void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
 	mlx5_rdma_del_roce_addr(dev);
 disable_roce:
 	mlx5_nic_vport_disable_roce(dev);
-	return;
 }
-- 
2.39.5




