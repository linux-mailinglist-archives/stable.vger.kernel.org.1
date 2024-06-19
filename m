Return-Path: <stable+bounces-54301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D300490ED8F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819132816D3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE28145334;
	Wed, 19 Jun 2024 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ct+i3BvW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18882495;
	Wed, 19 Jun 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803175; cv=none; b=aJLN9MJBDyskRu9Lm9UJmykOzdpINQ0JrcMR2Mz1uKqsXu8vttdIKYz+owOA/HqvZXRCGgTYbQqNVbx0yYLlO+N1tjJ8hieAnrFpujRDJvqv9nx6hfaNfJfDh7pvhPhDDVnkAD1hQGjI6GVxjl8+3hjRIMch1zCR+sKwYYsv0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803175; c=relaxed/simple;
	bh=ynLAq1kCu99krt1mdqzLT78Annta5RJKIxKLfX2+02w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oc6REej9Pfn6FpQVg0D+Z6lanL8NI3VRAyOmGrRivVVC35jpecVEXUFXwwgTG7+6HqKJ+xQm2cOPePxcFp4+9KQNjzpUl1p62jgT1bNgb9MnBy0wxo9D9KkjPSF8gRJFgXdcN/5YLR/C7Ny4zNTiXH5vKS3d4MpSPA10fME59Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ct+i3BvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BC2C2BBFC;
	Wed, 19 Jun 2024 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803175;
	bh=ynLAq1kCu99krt1mdqzLT78Annta5RJKIxKLfX2+02w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ct+i3BvW+KfAgwc97JouldRPfRwEhVQTi6tfccLRgeKvwV6amG1pAfCJHYxdTTNt/
	 3Nk2sa9Gx9ZHwuyYDcv4GZGHQPs+QiLeITcGZaykeFgPL5uP4hQd365j33PoNKW9lT
	 WzglEBL/HlGYqSm28EiQ3pcm6SpLygGSa0azRzeE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yonglong Liu <liuyonglong@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 147/281] net: hns3: fix kernel crash problem in concurrent scenario
Date: Wed, 19 Jun 2024 14:55:06 +0200
Message-ID: <20240619125615.498527058@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

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
index ce60332d83c39..990d7bd397aa8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3042,9 +3042,7 @@ static void hclge_push_link_status(struct hclge_dev *hdev)
 
 static void hclge_update_link_status(struct hclge_dev *hdev)
 {
-	struct hnae3_handle *rhandle = &hdev->vport[0].roce;
 	struct hnae3_handle *handle = &hdev->vport[0].nic;
-	struct hnae3_client *rclient = hdev->roce_client;
 	struct hnae3_client *client = hdev->nic_client;
 	int state;
 	int ret;
@@ -3068,8 +3066,15 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 
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
@@ -11245,6 +11250,12 @@ static int hclge_init_client_instance(struct hnae3_client *client,
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
@@ -11253,7 +11264,7 @@ static void hclge_uninit_client_instance(struct hnae3_client *client,
 
 	if (hdev->roce_client) {
 		clear_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state);
-		while (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		while (hclge_uninit_need_wait(hdev))
 			msleep(HCLGE_WAIT_RESET_DONE);
 
 		hdev->roce_client->ops->uninit_instance(&vport->roce, 0);
-- 
2.43.0




