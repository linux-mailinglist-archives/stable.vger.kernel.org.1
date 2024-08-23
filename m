Return-Path: <stable+bounces-70010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7795CF28
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEEA1C20B75
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358519AD5C;
	Fri, 23 Aug 2024 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRAPjnsr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568A18BBA1;
	Fri, 23 Aug 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421840; cv=none; b=ED/wb1WEluSTZ2FyxTb2WFMGDxy157qk/nmomsW0g57IWVMrHFXhQSBEoPZ0XysTp3jJxX4xvhJe4O1aFgJYcU0l6hruR+wlMaSTm6yf2hi1z/a6F9lURJX0QEK5bMjMvT7PWrKcUbmTk3U9yEB8FyfWFw2lkz6a6QCFlNUDUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421840; c=relaxed/simple;
	bh=puTmv4xsqmpJFI+PMGcQwnS9bPy4XtIzMU074nWDteA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXVf/BbxVAUaegKZERAdf56bKVQcwSVOARlztCwcdTQdJKulihGxv2DWQPagrMeYHiHDY+gZpv9pc2cPNtoQ/F6gjCTYnOsmEUDE/D46DL0F/H9J27u0fhtHwn8ENpCVXqsqHLmRtOjlF22dlCi+7dSjgSBP1nMlEoO9s9KgtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRAPjnsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C54BC32786;
	Fri, 23 Aug 2024 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421840;
	bh=puTmv4xsqmpJFI+PMGcQwnS9bPy4XtIzMU074nWDteA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRAPjnsrSTFvecKaV3ofBEL46BU65EFtD+eV+ApK2alL14gJrGuxTVKMNScZeIbA0
	 gI7L+l2VGEivDkT5sOb0l6FXcy451Iou/EdGDMMSBizEFvTgROxFgPF10f73/u7KS9
	 JfI1f+u13taoUC3OyznlycRYg4XMuYZiMstkXsj6SBrZYBn9l/pXmQBExrJ11VkYmZ
	 9VrgDaMYYQzYi4Pd1aIZaVVDcuCXGBKy2Vc6vexVN+yi0JBNIhNtaRvqlcY/S278SV
	 F0r4d8BfVHVgqRvIM08kxtR44rjOWbTGBRuK36IpZYU1S0Gj1Msyjpx20fs/Ea2LCJ
	 7Wp49G7yC7+TA==
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
	wangjie125@huawei.com,
	liuyonglong@huawei.com,
	lanhao@huawei.com,
	chenhao418@huawei.com,
	shenjian15@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/20] net: hns3: use correct release function during uninitialization
Date: Fri, 23 Aug 2024 10:02:33 -0400
Message-ID: <20240823140309.1974696-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
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


