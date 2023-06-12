Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFD172C24D
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbjFLLEI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbjFLLDi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E07EFF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F5862544
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72A3C4339B;
        Mon, 12 Jun 2023 10:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567106;
        bh=HE7QFaWORdYoc1/quui3z8A7eoIjjg4kGhVF8MzgB3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3whmZL/cLNp1qqldYqsqX6GrSyA1fm5/U4kuLiQzILhereWem9TaE87AhODPes9f
         hWTz2cJS5LjBY0wEu/ayOmEqOfuPrxbA6VQQHXww+Ah1PqI0/182MnWsPDLa3CMWiq
         PMs58kaTR30oGK//1S2jrNFbnwr+OhCfdWHh4EvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Subject: [PATCH 6.3 153/160] Bluetooth: Fix potential double free caused by hci_conn_unlink
Date:   Mon, 12 Jun 2023 12:28:05 +0200
Message-ID: <20230612101722.073285238@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Ruihan Li <lrh2000@pku.edu.cn>

commit ca1fd42e7dbfcb34890ffbf1f2f4b356776dab6f upstream.

The hci_conn_unlink function is being called by hci_conn_del, which
means it should not call hci_conn_del with the input parameter conn
again. If it does, conn may have already been released when
hci_conn_unlink returns, leading to potential UAF and double-free
issues.

This patch resolves the problem by modifying hci_conn_unlink to release
only conn's child links when necessary, but never release conn itself.

Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_conn.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1088,8 +1088,18 @@ static void hci_conn_unlink(struct hci_c
 	if (!conn->parent) {
 		struct hci_link *link, *t;
 
-		list_for_each_entry_safe(link, t, &conn->link_list, list)
-			hci_conn_unlink(link->conn);
+		list_for_each_entry_safe(link, t, &conn->link_list, list) {
+			struct hci_conn *child = link->conn;
+
+			hci_conn_unlink(child);
+
+			/* Due to race, SCO connection might be not established
+			 * yet at this point. Delete it now, otherwise it is
+			 * possible for it to be stuck and can't be deleted.
+			 */
+			if (child->handle == HCI_CONN_HANDLE_UNSET)
+				hci_conn_del(child);
+		}
 
 		return;
 	}
@@ -1105,13 +1115,6 @@ static void hci_conn_unlink(struct hci_c
 
 	kfree(conn->link);
 	conn->link = NULL;
-
-	/* Due to race, SCO connection might be not established
-	 * yet at this point. Delete it now, otherwise it is
-	 * possible for it to be stuck and can't be deleted.
-	 */
-	if (conn->handle == HCI_CONN_HANDLE_UNSET)
-		hci_conn_del(conn);
 }
 
 int hci_conn_del(struct hci_conn *conn)


