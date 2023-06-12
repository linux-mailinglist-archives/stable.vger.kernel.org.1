Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9479572C0D2
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbjFLKyr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjFLKyV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4662D7E
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3635612A1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91374C433EF;
        Mon, 12 Jun 2023 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566414;
        bh=C/z0oKGd8LLWwPGcj3ovzvRbzgW/Ra3919UCaKcy0QY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XSZdj32G2gRWkEHTKsrllZNXDnRW6Zk735BKA7cGmCnkBgvBpMGn3KZmQZ8gYpl31
         r+3XkUhIe879bXtpXPcLu5FosxRKJ1+7gXNv822zWcZbHST330t6549HBHuYVGOIJz
         O4OyoVMRVzG6KGsxikY5bJdV0kM22T7ySLgk4pVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengping Jiang <jiangzp@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 022/132] Bluetooth: hci_sync: add lock to protect HCI_UNREGISTER
Date:   Mon, 12 Jun 2023 12:25:56 +0200
Message-ID: <20230612101711.251216733@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhengping Jiang <jiangzp@google.com>

[ Upstream commit 1857c19941c87eb36ad47f22a406be5dfe5eff9f ]

When the HCI_UNREGISTER flag is set, no jobs should be scheduled. Fix
potential race when HCI_UNREGISTER is set after the flag is tested in
hci_cmd_sync_queue.

Fixes: 0b94f2651f56 ("Bluetooth: hci_sync: Fix queuing commands when HCI_UNREGISTER is set")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  2 ++
 net/bluetooth/hci_sync.c         | 20 ++++++++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 061fec6fd0152..84c5ce57eab69 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -513,6 +513,7 @@ struct hci_dev {
 	struct work_struct	cmd_sync_work;
 	struct list_head	cmd_sync_work_list;
 	struct mutex		cmd_sync_work_lock;
+	struct mutex		unregister_lock;
 	struct work_struct	cmd_sync_cancel_work;
 	struct work_struct	reenable_adv_work;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 334e308451f53..ac36e7ae70b21 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2685,7 +2685,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 {
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
+	mutex_lock(&hdev->unregister_lock);
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
+	mutex_unlock(&hdev->unregister_lock);
 
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e8b78104a4071..40a6cfa2f9a07 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -629,6 +629,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
 	INIT_LIST_HEAD(&hdev->cmd_sync_work_list);
 	mutex_init(&hdev->cmd_sync_work_lock);
+	mutex_init(&hdev->unregister_lock);
 
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 	INIT_WORK(&hdev->reenable_adv_work, reenable_adv);
@@ -688,14 +689,19 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	struct hci_cmd_sync_work_entry *entry;
+	int err = 0;
 
-	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		return -ENODEV;
+	mutex_lock(&hdev->unregister_lock);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		err = -ENODEV;
+		goto unlock;
+	}
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
+	if (!entry) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 	entry->func = func;
 	entry->data = data;
 	entry->destroy = destroy;
@@ -706,7 +712,9 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 
 	queue_work(hdev->req_workqueue, &hdev->cmd_sync_work);
 
-	return 0;
+unlock:
+	mutex_unlock(&hdev->unregister_lock);
+	return err;
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue);
 
-- 
2.39.2



