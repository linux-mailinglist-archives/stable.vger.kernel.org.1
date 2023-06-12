Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0772C24F
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbjFLLEK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjFLLDl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A97961AF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1741C624E0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C9BC433D2;
        Mon, 12 Jun 2023 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567111;
        bh=n8g4x5x1JW79tx7FDJthEf9V8G2k5eel8/WpIiLlfdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlCvvdxWsWTRRdOiLyDWJn9i42TZ6TLx8qe8sYF+vUzYEZnONGHb0cXQAGEcJ6wLM
         mgHEVXFQEdMMkPLl2hDNusjCXseqKgh29MRujXxuBPg9Rfv3VoLa0tWgXy2Jg1I3H+
         oiU2V0YDUiAlnlgE9Gnv/+Fi7unPrDCuDz1+IkjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.3 155/160] Bluetooth: Fix UAF in hci_conn_hash_flush again
Date:   Mon, 12 Jun 2023 12:28:07 +0200
Message-ID: <20230612101722.162675544@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ruihan Li <lrh2000@pku.edu.cn>

commit a2ac591cb4d83e1f2d4b4adb3c14b2c79764650a upstream.

Commit 06149746e720 ("Bluetooth: hci_conn: Add support for linking
multiple hcon") reintroduced a previously fixed bug [1] ("KASAN:
slab-use-after-free Read in hci_conn_hash_flush"). This bug was
originally fixed by commit 5dc7d23e167e ("Bluetooth: hci_conn: Fix
possible UAF").

The hci_conn_unlink function was added to avoid invalidating the link
traversal caused by successive hci_conn_del operations releasing extra
connections. However, currently hci_conn_unlink itself also releases
extra connections, resulted in the reintroduced bug.

This patch follows a more robust solution for cleaning up all
connections, by repeatedly removing the first connection until there are
none left. This approach does not rely on the inner workings of
hci_conn_del and ensures proper cleanup of all connections.

Meanwhile, we need to make sure that hci_conn_del never fails. Indeed it
doesn't, as it now always returns zero. To make this a bit clearer, this
patch also changes its return type to void.

Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |   33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1324,7 +1324,7 @@ int hci_le_create_cis(struct hci_conn *c
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role);
-int hci_conn_del(struct hci_conn *conn);
+void hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1093,6 +1093,14 @@ static void hci_conn_unlink(struct hci_c
 
 			hci_conn_unlink(child);
 
+			/* If hdev is down it means
+			 * hci_dev_close_sync/hci_conn_hash_flush is in progress
+			 * and links don't need to be cleanup as all connections
+			 * would be cleanup.
+			 */
+			if (!test_bit(HCI_UP, &hdev->flags))
+				continue;
+
 			/* Due to race, SCO connection might be not established
 			 * yet at this point. Delete it now, otherwise it is
 			 * possible for it to be stuck and can't be deleted.
@@ -1117,7 +1125,7 @@ static void hci_conn_unlink(struct hci_c
 	conn->link = NULL;
 }
 
-int hci_conn_del(struct hci_conn *conn)
+void hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -1168,8 +1176,6 @@ int hci_conn_del(struct hci_conn *conn)
 	 * rest of hci_conn_del.
 	 */
 	hci_conn_cleanup(conn);
-
-	return 0;
 }
 
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
@@ -2526,22 +2532,27 @@ timer:
 /* Drop all connection on the device */
 void hci_conn_hash_flush(struct hci_dev *hdev)
 {
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn *c, *n;
+	struct list_head *head = &hdev->conn_hash.list;
+	struct hci_conn *conn;
 
 	BT_DBG("hdev %s", hdev->name);
 
-	list_for_each_entry_safe(c, n, &h->list, list) {
-		c->state = BT_CLOSED;
-
-		hci_disconn_cfm(c, HCI_ERROR_LOCAL_HOST_TERM);
+	/* We should not traverse the list here, because hci_conn_del
+	 * can remove extra links, which may cause the list traversal
+	 * to hit items that have already been released.
+	 */
+	while ((conn = list_first_entry_or_null(head,
+						struct hci_conn,
+						list)) != NULL) {
+		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, HCI_ERROR_LOCAL_HOST_TERM);
 
 		/* Unlink before deleting otherwise it is possible that
 		 * hci_conn_del removes the link which may cause the list to
 		 * contain items already freed.
 		 */
-		hci_conn_unlink(c);
-		hci_conn_del(c);
+		hci_conn_unlink(conn);
+		hci_conn_del(conn);
 	}
 }
 


