Return-Path: <stable+bounces-1650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452787F80B6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768351C215CD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1A8364A0;
	Fri, 24 Nov 2023 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0H2ZRKd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5328DBB;
	Fri, 24 Nov 2023 18:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EF8C433C7;
	Fri, 24 Nov 2023 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851931;
	bh=738ZT1MZI0PdIFhgEfCO5iGF3CkF0QOPgtPRQVl6lqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0H2ZRKddWDu8jL+h53MFn0QHrEzWEG8Rlghv1rKonAmKV5B8tp4aSx7J+rqukNvs
	 hUu2/jl4kGQMkh6ShbPjx3BgtwRumZx9ubPzjPsSu0NPleBuVNyrrI8qRS7OYO1Z36
	 t+Au572RY37ypx2f2QdTp52u1+QEKsvyjUnMT5is=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 135/372] net: hns3: fix VF wrong speed and duplex issue
Date: Fri, 24 Nov 2023 17:48:42 +0000
Message-ID: <20231124172014.987174298@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit dff655e82faffc287d4a72a59f66fa120bf904e4 ]

If PF is down, firmware will returns 10 Mbit/s rate and half-duplex mode
when PF queries the port information from firmware.

After imp reset command is executed, PF status changes to down,
and PF will query link status and updates port information
from firmware in a periodic scheduled task.

However, there is a low probability that port information is updated
when PF is down, and then PF link status changes to up.
In this case, PF synchronizes incorrect rate and duplex mode to VF.

This patch fixes it by updating port information before
PF synchronizes the rate and duplex to the VF
when PF changes to up.

Fixes: 18b6e31f8bf4 ("net: hns3: PF add support for pushing link status to VFs")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index da5fbe627fa0b..48b0cb5ec5d29 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -74,6 +74,7 @@ static void hclge_sync_fd_table(struct hclge_dev *hdev);
 static void hclge_update_fec_stats(struct hclge_dev *hdev);
 static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret,
 				      int wait_cnt);
+static int hclge_update_port_info(struct hclge_dev *hdev);
 
 static struct hnae3_ae_algo ae_algo;
 
@@ -3141,6 +3142,9 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 
 	if (state != hdev->hw.mac.link) {
 		hdev->hw.mac.link = state;
+		if (state == HCLGE_LINK_STATUS_UP)
+			hclge_update_port_info(hdev);
+
 		client->ops->link_status_change(handle, state);
 		hclge_config_mac_tnl_int(hdev, state);
 		if (rclient && rclient->ops->link_status_change)
-- 
2.42.0




