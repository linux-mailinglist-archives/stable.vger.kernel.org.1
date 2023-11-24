Return-Path: <stable+bounces-2176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1357F8318
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097D728702B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2942C35EE6;
	Fri, 24 Nov 2023 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ghJ/KbXn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD75D2E64F;
	Fri, 24 Nov 2023 19:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1DCC433C7;
	Fri, 24 Nov 2023 19:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853236;
	bh=KwZImb9QevDGmMVbpW61X/8N/0G6YHLzXD3jh3EA35s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghJ/KbXnzK/nUJk0+QO8kU2nt7z8CjQK15dMBGT3H+oBeCN8Ic79ZsmE+nkW0SSQT
	 Er7nvcuAPahrKUDuKsAbryGNm/KIXIfyzqBi85THlCAVKE3H81OCiFIwlXFNLHBXh0
	 UrrZeWnCN6jqKCtuQCZoqpc5w9fWWSH0vKoCZgRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yonglong Liu <liuyonglong@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 109/297] net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()
Date: Fri, 24 Nov 2023 17:52:31 +0000
Message-ID: <20231124172004.093304883@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit dbd2f3b20c6ae425665b6975d766e3653d453e73 ]

When a VF is calling hns3_init_mac_addr(), get_mac_addr() may
return fail, then the value of mac_addr_temp is not initialized.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index fde1ff3580458..60e610ab976d4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4915,7 +4915,7 @@ static int hns3_init_mac_addr(struct net_device *netdev)
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	char format_mac_addr[HNAE3_FORMAT_MAC_ADDR_LEN];
 	struct hnae3_handle *h = priv->ae_handle;
-	u8 mac_addr_temp[ETH_ALEN];
+	u8 mac_addr_temp[ETH_ALEN] = {0};
 	int ret = 0;
 
 	if (h->ae_algo->ops->get_mac_addr)
-- 
2.42.0




