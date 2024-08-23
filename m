Return-Path: <stable+bounces-69989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC0F95CEDE
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1809B28059
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CC5193400;
	Fri, 23 Aug 2024 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1JV7pJi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14F188A2A;
	Fri, 23 Aug 2024 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421750; cv=none; b=prKuqEXXsz/QSG3z/F2bXN7s2E4wnXB/2m/hWvWQY4sZEw2d0ul8KRJlHxp3NdrKLxy4JRPuPuwCdCOLFvlh8BmUSZj2EYOzVGGoOGgkzTOOW4S1T3oyS3tK/n8LhYDz91C8IFGlOqUyh6kDTurwWqyxAobHlUoj8dj0BvwkgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421750; c=relaxed/simple;
	bh=b87XEznGZLDr2Ndb4DCyuuM6UJX5obcZJ8MITwWeEX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgg/4wWlCw4eKfkv/VPne81oIUH0IWRmjzcj8LV+qYjuAK/csJGjUUujKMsOsYh7VogBsxLh3ljOL5eVU1KKx/FOwcAECYEhZgjgs2BZXCku2OYoHDKuq/1o/pEzTBoQhvkHP2mgKxBUxgw/dgZLjQCQNpxNZkbdl/PAVlPZyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1JV7pJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F3EC4AF09;
	Fri, 23 Aug 2024 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421750;
	bh=b87XEznGZLDr2Ndb4DCyuuM6UJX5obcZJ8MITwWeEX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1JV7pJiRT/LfcKDax7VX2+z0/VY3Grv6WduDYsIV5ukuyobOoNBDsZyxGwEUPFyR
	 vUCfhazJXIg1Rc/ILvo1BqlIH8O/M0qbT8zCBpUTw/7tUltGGgECWqHG3CjeTvxx08
	 Kx3/bd7nHPkwywyHdNIhG/AV8ny+KeEjS8IYw1uWc5NK31s8rSJNygmFci0la3oBy4
	 bd8FEv/WQqqtuUZMWZxnAbzYoato0TErajVYBntkQqDyBBeCrAtT8Mq3b3yTnJt4Bg
	 KAC+LLXbWHeh+GYvWUheJ0E2aCQQDoGyo6353ld4rpAC43UxgNU6KDtec/ADsHpwNE
	 lt5ymTmVImEGg==
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
Subject: [PATCH AUTOSEL 6.10 22/24] net: hns3: use correct release function during uninitialization
Date: Fri, 23 Aug 2024 10:00:44 -0400
Message-ID: <20240823140121.1974012-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
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
index 82574ce0194fb..66af928c03d4a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11444,7 +11444,7 @@ static void hclge_pci_uninit(struct hclge_dev *hdev)
 
 	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 	pci_free_irq_vectors(pdev);
-	pci_release_mem_regions(pdev);
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.43.0


