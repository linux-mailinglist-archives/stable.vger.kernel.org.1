Return-Path: <stable+bounces-2175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07907F8317
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADA3286F96
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E88B381CE;
	Fri, 24 Nov 2023 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cogcSdgz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF935EE6;
	Fri, 24 Nov 2023 19:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E5EC433C9;
	Fri, 24 Nov 2023 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853234;
	bh=Vxippnb5O3TkTPi12qOI/TnJG2Co/7z986bBhQLebBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cogcSdgzyga80gZd5rIkhyULmV+q1Gq+RQ21C3VH3nYkej+6kFZgFFHDbL+rVLYQC
	 HtC8F+UGLG6k941PkyhqxFyxWvDihFhTtwTvqgSFBXzVjAg06T8aqH6ENAqVMEbT+Y
	 Hbvpp72T/4HfXthoGczW2VhPab0b9SlV2KiFh5hY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 108/297] net: hns3: fix incorrect capability bit display for copper port
Date: Fri, 24 Nov 2023 17:52:30 +0000
Message-ID: <20231124172004.059916513@linuxfoundation.org>
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

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 75b247b57d8b71bcb679e4cb37d0db104848806c ]

Currently, the FEC capability bit is default set for device version V2.
It's incorrect for the copper port. Eventhough it doesn't make the nic
work abnormal, but the capability information display in debugfs may
confuse user. So clear it when driver get the port type inforamtion.

Fixes: 433ccce83504 ("net: hns3: use FEC capability queried from firmware")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index dba3cf15b48e1..7c28c74c1de92 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11713,6 +11713,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		goto err_msi_irq_uninit;
 
 	if (hdev->hw.mac.media_type == HNAE3_MEDIA_TYPE_COPPER) {
+		clear_bit(HNAE3_DEV_SUPPORT_FEC_B, ae_dev->caps);
 		if (hnae3_dev_phy_imp_supported(hdev))
 			ret = hclge_update_tp_port_info(hdev);
 		else
-- 
2.42.0




