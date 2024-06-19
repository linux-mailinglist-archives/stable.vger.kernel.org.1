Return-Path: <stable+bounces-54575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E8990EEE3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539941F21E67
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99914A0A0;
	Wed, 19 Jun 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iULNqD/d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED261147C89;
	Wed, 19 Jun 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803986; cv=none; b=cZuLJwFZPghbmuz4cR4MpeN5sKnWhlYWXwLXIKEhrrozkhnJn47X4M1ryix7He1JSINVnaG4hM5v6eLhWUoHdrXPq84M1+gG4Tki10ExukEILcNd3Z3selw64tOCXEQ9bFI90dbW9OOSkn3/5waVvz7ABQUsSwIRpfilGynsbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803986; c=relaxed/simple;
	bh=6BiFSeOeHHUzVM+t84VDDkY1248+4X3chZTX8njYZgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSw7/pQc9ghE6ActFjKtPkhNk5ID8oPmrtph8CJaToi8eJwjFID3O3psLg6HLhlh9T/5lbBvMtXVrQmF4zEBmQSnUTjv5qLh4PZMKi97vwDJInTVe1DQN9Bghnf9ZCUgN+4Mtrf5i/U4OZpzVsvbPPqHw9zk6YyrCxqQyrPjLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iULNqD/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E31C4AF4D;
	Wed, 19 Jun 2024 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803985;
	bh=6BiFSeOeHHUzVM+t84VDDkY1248+4X3chZTX8njYZgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iULNqD/d/HBTvWpvm1aS/wZlAddR/8fNICVXLeaDfDAx9iZFSkDIn3FInx3Lj8T9i
	 5m8Gme/0/FWB7ifaeGftivqsxz3ZkPcjuCtvuj4g5I/UwdmkvMThB3UPyDJ/f52vZX
	 28wQby+QNwzrvZYZsGds67eC7UrImVH6EqQfSvWk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yonglong Liu <liuyonglong@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 139/217] net: hns3: fix kernel crash problem in concurrent scenario
Date: Wed, 19 Jun 2024 14:56:22 +0200
Message-ID: <20240619125602.055394310@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
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

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 12cda920212a49fa22d9e8b9492ac4ea013310a4 ]

When link status change, the nic driver need to notify the roce
driver to handle this event, but at this time, the roce driver
may uninit, then cause kernel crash.

To fix the problem, when link status change, need to check
whether the roce registered, and when uninit, need to wait link
update finish.

Fixes: 45e92b7e4e27 ("net: hns3: add calling roce callback function when link status change")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a2655adc764cd..01e24b69e9203 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3129,9 +3129,7 @@ static void hclge_push_link_status(struct hclge_dev *hdev)
 
 static void hclge_update_link_status(struct hclge_dev *hdev)
 {
-	struct hnae3_handle *rhandle = &hdev->vport[0].roce;
 	struct hnae3_handle *handle = &hdev->vport[0].nic;
-	struct hnae3_client *rclient = hdev->roce_client;
 	struct hnae3_client *client = hdev->nic_client;
 	int state;
 	int ret;
@@ -3155,8 +3153,15 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 
 		client->ops->link_status_change(handle, state);
 		hclge_config_mac_tnl_int(hdev, state);
-		if (rclient && rclient->ops->link_status_change)
-			rclient->ops->link_status_change(rhandle, state);
+
+		if (test_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state)) {
+			struct hnae3_handle *rhandle = &hdev->vport[0].roce;
+			struct hnae3_client *rclient = hdev->roce_client;
+
+			if (rclient && rclient->ops->link_status_change)
+				rclient->ops->link_status_change(rhandle,
+								 state);
+		}
 
 		hclge_push_link_status(hdev);
 	}
@@ -11339,6 +11344,12 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 	return ret;
 }
 
+static bool hclge_uninit_need_wait(struct hclge_dev *hdev)
+{
+	return test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
+	       test_bit(HCLGE_STATE_LINK_UPDATING, &hdev->state);
+}
+
 static void hclge_uninit_client_instance(struct hnae3_client *client,
 					 struct hnae3_ae_dev *ae_dev)
 {
@@ -11347,7 +11358,7 @@ static void hclge_uninit_client_instance(struct hnae3_client *client,
 
 	if (hdev->roce_client) {
 		clear_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state);
-		while (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		while (hclge_uninit_need_wait(hdev))
 			msleep(HCLGE_WAIT_RESET_DONE);
 
 		hdev->roce_client->ops->uninit_instance(&vport->roce, 0);
-- 
2.43.0




