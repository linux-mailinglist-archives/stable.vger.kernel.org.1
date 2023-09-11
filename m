Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9209679B1FB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355427AbjIKV6M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbjIKOi6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:38:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F7FE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:38:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14623C433CB;
        Mon, 11 Sep 2023 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443133;
        bh=Vdd70sNchvJZnufT94Md0AsJmXgYHpv2+ddAJ5YWG/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRtRwhzETbPMz1xhStZq0o2JXH2rY/DzQnRKQz6LYEQP5ibIbu1lqwX49S1efIROR
         WEXH5qPJe7LcD/jKFdokGD4X7nfVAWOU1WlzbpdUsaH5wwoiDes0CPSDl7n8XUcTX+
         zVJieh3guZY1UNBH4xj7GxvS+g67OQk/sGsdfSzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 242/737] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
Date:   Mon, 11 Sep 2023 15:41:41 +0200
Message-ID: <20230911134657.365749656@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 5af1f84ed13a416297ab9ced7537f4d5ae7f329a ]

Connections may be cleanup while waiting for the commands to complete so
this attempts to check if the connection handle remains valid in case of
errors that would lead to call hci_conn_failed:

BUG: KASAN: slab-use-after-free in hci_conn_failed+0x1f/0x160
Read of size 8 at addr ffff888001376958 by task kworker/u3:0/52

CPU: 0 PID: 52 Comm: kworker/u3:0 Not tainted
6.5.0-rc1-00527-g2dfe76d58d3a #5615
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x1d/0x70
 print_report+0xce/0x620
 ? __virt_addr_valid+0xd4/0x150
 ? hci_conn_failed+0x1f/0x160
 kasan_report+0xd1/0x100
 ? hci_conn_failed+0x1f/0x160
 hci_conn_failed+0x1f/0x160
 hci_abort_conn_sync+0x237/0x360

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 45 ++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ae5d5193d9ba7..60e213982635c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5337,27 +5337,20 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
-	int err;
+	int err = 0;
+	u16 handle = conn->handle;
 
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		return hci_disconnect_sync(hdev, conn, reason);
+		err = hci_disconnect_sync(hdev, conn, reason);
+		break;
 	case BT_CONNECT:
 		err = hci_connect_cancel_sync(hdev, conn, reason);
-		/* Cleanup hci_conn object if it cannot be cancelled as it
-		 * likelly means the controller and host stack are out of sync
-		 * or in case of LE it was still scanning so it can be cleanup
-		 * safely.
-		 */
-		if (err) {
-			hci_dev_lock(hdev);
-			hci_conn_failed(conn, err);
-			hci_dev_unlock(hdev);
-		}
-		return err;
+		break;
 	case BT_CONNECT2:
-		return hci_reject_conn_sync(hdev, conn, reason);
+		err = hci_reject_conn_sync(hdev, conn, reason);
+		break;
 	case BT_OPEN:
 		/* Cleanup bises that failed to be established */
 		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags)) {
@@ -5368,10 +5361,30 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		break;
 	default:
 		conn->state = BT_CLOSED;
-		break;
+		return 0;
 	}
 
-	return 0;
+	/* Cleanup hci_conn object if it cannot be cancelled as it
+	 * likelly means the controller and host stack are out of sync
+	 * or in case of LE it was still scanning so it can be cleanup
+	 * safely.
+	 */
+	if (err) {
+		struct hci_conn *c;
+
+		/* Check if the connection hasn't been cleanup while waiting
+		 * commands to complete.
+		 */
+		c = hci_conn_hash_lookup_handle(hdev, handle);
+		if (!c || c != conn)
+			return 0;
+
+		hci_dev_lock(hdev);
+		hci_conn_failed(conn, err);
+		hci_dev_unlock(hdev);
+	}
+
+	return err;
 }
 
 static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
-- 
2.40.1



