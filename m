Return-Path: <stable+bounces-83549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223C899B3D4
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BBDB23AD6
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3451C9EBF;
	Sat, 12 Oct 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv7GplDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182A161310;
	Sat, 12 Oct 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732481; cv=none; b=Hwd7ChECQ7ILWIghi4/ueBYXlnUeZyOJCygscUAVG7eUhiQIed4zmmNhdWtXg4NbtXQ2jacPhBTKY2JE1INeocAI9Eg/uZk9KzxrneAKkVIbPjho3axUjVbv8XVfKWyu52p3A7/8EP2w3ERAORHt76O6xRuw3Ysx6cNBzf2g3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732481; c=relaxed/simple;
	bh=puTmv4xsqmpJFI+PMGcQwnS9bPy4XtIzMU074nWDteA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA+4UDgWogXtWIeNeAPbOivprBiWE79NMaQC1VMN7c7t8Gt8A+GrdzLnsPQf02ahh2NY7eCLTTS8dbwU+x2Tp+lYSJMMAny90vifF6ELu21SnhClGimiRVQaR6l5irfLv5jYw/WPAVx+NkOsdH2hE9+gMF24IO9z14tpmGZRASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv7GplDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3025FC4CEC7;
	Sat, 12 Oct 2024 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732481;
	bh=puTmv4xsqmpJFI+PMGcQwnS9bPy4XtIzMU074nWDteA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zv7GplDewklujL8JgOan25g0blEshr2AiM+AARcdBxksJJ5wY/O5a+w1v4rhpK8Ip
	 nb0094khM8Sr380fK2fz3Fgp1TLwjsv3HM5dcN+JGEaTqCoi2QDjz7OoBYgCSHDrEG
	 O7YdJ0yAU464nAvOQMNrLC7hKYyY8apSH3kwnm7E0r8eVBZm+6pwz2UsfhJArDJKXN
	 9osX+wfAS47iRRY5EHlCQFg10tXqjWr/DhhiC0Gf+lVXU0SfuZv778eGg0Obet4vou
	 z2xPV3Oa1x2DFKRVxI3JIfNy7wzeWMETgw974as+hpoDr6ETenkl1byZEgT70aKSad
	 V9dECtBJodSkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peiyang Wang <wangpeiyang1@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	yisen.zhuang@huawei.com,
	salil.mehta@huawei.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	liuyonglong@huawei.com,
	lanhao@huawei.com,
	shenjian15@huawei.com,
	chenhao418@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/20] net: hns3: use correct release function during uninitialization
Date: Sat, 12 Oct 2024 07:26:51 -0400
Message-ID: <20241012112715.1763241-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112715.1763241-1-sashal@kernel.org>
References: <20241012112715.1763241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Peiyang Wang <wangpeiyang1@huawei.com>

[ Upstream commit 7660833d217528c8f2385528951ab820a031e4e3 ]

pci_request_regions is called to apply for PCI I/O and memory resources
when the driver is initialized, Therefore, when the driver is uninstalled,
pci_release_regions should be used to release PCI I/O and memory resources
instead of pci_release_mem_regions is used to release memory reasouces
only.

Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c8059d96f64be..3b01447478159 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11358,7 +11358,7 @@ static void hclge_pci_uninit(struct hclge_dev *hdev)
 
 	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 	pci_free_irq_vectors(pdev);
-	pci_release_mem_regions(pdev);
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.43.0


