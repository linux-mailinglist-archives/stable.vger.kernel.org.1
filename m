Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5AA72C1B0
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbjFLK7o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbjFLK7C (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9B7287
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:46:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6C9F6244C
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0585CC433EF;
        Mon, 12 Jun 2023 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566777;
        bh=5F3pARx27/Kclj+fMsdAUFMTm7s1UnijKAOg3RduDFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQfGaOmHxZftjqRpUV1tCyNBKzNnQP5ZZ1Y1H5AmTTTk2p7djogtbZRv/WgTLhvIF
         VkvAQXEhTGEj1Aajh01YyFpylTU47/6H3FDHSvGICU/d+5rau6HWhdp28p5vZnFbjk
         v19k/OwKRRhXMFB7tKjUQYftnmkGxKmkMfG8A1L0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 028/160] Bluetooth: ISO: use correct CIS order in Set CIG Parameters event
Date:   Mon, 12 Jun 2023 12:26:00 +0200
Message-ID: <20230612101716.329008574@linuxfoundation.org>
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

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 71e9588435c38112d6a8686d3d8e7cc1de8fe22c ]

The order of CIS handle array in Set CIG Parameters response shall match
the order of the CIS_ID array in the command (Core v5.3 Vol 4 Part E Sec
7.8.97).  We send CIS_IDs mainly in the order of increasing CIS_ID (but
with "last" CIS first if it has fixed CIG_ID).  In handling of the
reply, we currently assume this is also the same as the order of
hci_conn in hdev->conn_hash, but that is not true.

Match the correct hci_conn to the correct handle by matching them based
on the CIG+CIS combination.  The CIG+CIS combination shall be unique for
ISO_LINK hci_conn at state >= BT_BOUND, which we maintain in
hci_le_set_cig_params.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_event.c        | 44 +++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a08e8dc772e54..341592d427520 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1197,7 +1197,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 		if (id != BT_ISO_QOS_CIS_UNSET && id != c->iso_qos.ucast.cis)
 			continue;
 
-		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
+		/* Match destination address if set */
+		if (!ba || (ba_type == c->dst_type && !bacmp(&c->dst, ba))) {
 			rcu_read_unlock();
 			return c;
 		}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d00ef6e3fc451..09ba6d8987ee1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3804,48 +3804,56 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
 	struct hci_rp_le_set_cig_params *rp = data;
+	struct hci_cp_le_set_cig_params *cp;
 	struct hci_conn *conn;
-	int i = 0;
+	u8 status = rp->status;
+	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
+	if (!cp || rp->num_handles != cp->num_cis || rp->cig_id != cp->cig_id) {
+		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
+		status = HCI_ERROR_UNSPECIFIED;
+	}
+
 	hci_dev_lock(hdev);
 
-	if (rp->status) {
+	if (status) {
 		while ((conn = hci_conn_hash_lookup_cig(hdev, rp->cig_id))) {
 			conn->state = BT_CLOSED;
-			hci_connect_cfm(conn, rp->status);
+			hci_connect_cfm(conn, status);
 			hci_conn_del(conn);
 		}
 		goto unlock;
 	}
 
-	rcu_read_lock();
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2553
+	 *
+	 * If the Status return parameter is zero, then the Controller shall
+	 * set the Connection_Handle arrayed return parameter to the connection
+	 * handle(s) corresponding to the CIS configurations specified in
+	 * the CIS_IDs command parameter, in the same order.
+	 */
+	for (i = 0; i < rp->num_handles; ++i) {
+		conn = hci_conn_hash_lookup_cis(hdev, NULL, 0, rp->cig_id,
+						cp->cis[i].cis_id);
+		if (!conn || !bacmp(&conn->dst, BDADDR_ANY))
+			continue;
 
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (conn->type != ISO_LINK ||
-		    conn->iso_qos.ucast.cig != rp->cig_id ||
-		    conn->state == BT_CONNECTED)
+		if (conn->state != BT_BOUND && conn->state != BT_CONNECT)
 			continue;
 
-		conn->handle = __le16_to_cpu(rp->handle[i++]);
+		conn->handle = __le16_to_cpu(rp->handle[i]);
 
 		bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p", conn,
 			   conn->handle, conn->parent);
 
 		/* Create CIS if LE is already connected */
-		if (conn->parent && conn->parent->state == BT_CONNECTED) {
-			rcu_read_unlock();
+		if (conn->parent && conn->parent->state == BT_CONNECTED)
 			hci_le_create_cis(conn);
-			rcu_read_lock();
-		}
-
-		if (i == rp->num_handles)
-			break;
 	}
 
-	rcu_read_unlock();
-
 unlock:
 	hci_dev_unlock(hdev);
 
-- 
2.39.2



