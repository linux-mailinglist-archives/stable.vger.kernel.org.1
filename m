Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489087D1460
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJTQuZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 12:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJTQuY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 12:50:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08837CA
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 09:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6D6C433C8;
        Fri, 20 Oct 2023 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697820622;
        bh=6x6FQPIdbaXyYJ2JL2VZA9pWT3xc62kZBDXuGznW1Qs=;
        h=Subject:To:Cc:From:Date:From;
        b=Ff8e+YuG/1o43R1rR+GV0J9lJAHwtBFXWIAA8qX2EbL4sLno8iCr1SU562zxh6GSQ
         QfjnDqClhcu90MQgBjKuoboC2JgzGoZBF1rs5Re22G+nGvJAiw3pcoG1dOCSr0+j27
         Y+tv7ksTcgoYHt844l8xC5fTRynSoFMlzjE4klG0=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_sync: always check if connection is alive" failed to apply to 6.5-stable tree
To:     pav@iki.fi, luiz.von.dentz@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 18:50:19 +0200
Message-ID: <2023102019-shove-stagnant-982e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x a239110ee8e0b0aafa265f0d54f7a16744855e70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102019-shove-stagnant-982e@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a239110ee8e0b0aafa265f0d54f7a16744855e70 Mon Sep 17 00:00:00 2001
From: Pauli Virtanen <pav@iki.fi>
Date: Sat, 30 Sep 2023 15:53:32 +0300
Subject: [PATCH] Bluetooth: hci_sync: always check if connection is alive
 before deleting

In hci_abort_conn_sync it is possible that conn is deleted concurrently
by something else, also e.g. when waiting for hdev->lock.  This causes
double deletion of the conn, so UAF or conn_hash.list corruption.

Fix by having all code paths check that the connection is still in
conn_hash before deleting it, while holding hdev->lock which prevents
any races.

Log (when powering off while BAP streaming, occurs rarely):
=======================================================================
kernel BUG at lib/list_debug.c:56!
...
 ? __list_del_entry_valid (lib/list_debug.c:56)
 hci_conn_del (net/bluetooth/hci_conn.c:154) bluetooth
 hci_abort_conn_sync (net/bluetooth/hci_sync.c:5415) bluetooth
 ? __pfx_hci_abort_conn_sync+0x10/0x10 [bluetooth]
 ? lock_release+0x1d5/0x3c0
 ? hci_disconnect_all_sync.constprop.0+0xb2/0x230 [bluetooth]
 ? __pfx_lock_release+0x10/0x10
 ? __kmem_cache_free+0x14d/0x2e0
 hci_disconnect_all_sync.constprop.0+0xda/0x230 [bluetooth]
 ? __pfx_hci_disconnect_all_sync.constprop.0+0x10/0x10 [bluetooth]
 ? hci_clear_adv_sync+0x14f/0x170 [bluetooth]
 ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
 hci_set_powered_sync+0x293/0x450 [bluetooth]
=======================================================================

Fixes: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d06e07a0ea5a..a15ab0b874a9 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5369,6 +5369,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
 	int err = 0;
 	u16 handle = conn->handle;
+	bool disconnect = false;
 	struct hci_conn *c;
 
 	switch (conn->state) {
@@ -5399,24 +5400,15 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		hci_dev_unlock(hdev);
 		return 0;
 	case BT_BOUND:
-		hci_dev_lock(hdev);
-		hci_conn_failed(conn, reason);
-		hci_dev_unlock(hdev);
-		return 0;
+		break;
 	default:
-		hci_dev_lock(hdev);
-		conn->state = BT_CLOSED;
-		hci_disconn_cfm(conn, reason);
-		hci_conn_del(conn);
-		hci_dev_unlock(hdev);
-		return 0;
+		disconnect = true;
+		break;
 	}
 
 	hci_dev_lock(hdev);
 
-	/* Check if the connection hasn't been cleanup while waiting
-	 * commands to complete.
-	 */
+	/* Check if the connection has been cleaned up concurrently */
 	c = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!c || c != conn) {
 		err = 0;
@@ -5428,7 +5420,13 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	 * or in case of LE it was still scanning so it can be cleanup
 	 * safely.
 	 */
-	hci_conn_failed(conn, reason);
+	if (disconnect) {
+		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, reason);
+		hci_conn_del(conn);
+	} else {
+		hci_conn_failed(conn, reason);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);

