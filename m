Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1047ECBBB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjKOTYJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjKOTYH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:24:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7F19D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:24:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F860C433C9;
        Wed, 15 Nov 2023 19:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076241;
        bh=xgaQmLBjWgJa6J153vpyKNhMkVvwWGkqcmAZEDtpv4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiPEaIRqIAL8yzpQAbtb32kbKX4HYzHaCACFRLtjwRf1I2ZaoHbmZyCKeCtDf1IOo
         d1+1hDHAvrI74vKWscv/SCxdfRXeYsny0SL2G3XcQJ/URyjKd1KQ8z0LX48gmUUKiP
         0Fz6VQx8Q+hyn2eDgxVhB/tEicQOC/SO+twV7UVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 140/550] Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
Date:   Wed, 15 Nov 2023 14:12:04 -0500
Message-ID: <20231115191610.385522500@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Iulia Tanasescu <iulia.tanasescu@nxp.com>

[ Upstream commit fbdc4bc47268953c80853489f696e02d61f9a2c6 ]

This commit implements defer setup support for the Broadcast Sink
scenario: By setting defer setup on a broadcast socket before calling
listen, the user is able to trigger the PA sync and BIG sync procedures
separately.

This is useful if the user first wants to synchronize to the periodic
advertising transmitted by a Broadcast Source, and trigger the BIG sync
procedure later on.

If defer setup is set, once a PA sync established event arrives, a new
hcon is created and notified to the ISO layer. A child socket associated
with the PA sync connection will be added to the accept queue of the
listening socket.

Once the accept call returns the fd for the PA sync child socket, the
user should call read on that fd. This will trigger the BIG create sync
procedure, and the PA sync socket will become a listening socket itself.

When the BIG sync established event is notified to the ISO layer, the
bis connections will be added to the accept queue of the PA sync parent.
The user should call accept on the PA sync socket to get the final bis
connections.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  30 +++++-
 net/bluetooth/hci_conn.c         |  13 ++-
 net/bluetooth/hci_event.c        |  41 +++++++-
 net/bluetooth/hci_sync.c         |  15 +++
 net/bluetooth/iso.c              | 160 ++++++++++++++++++++++++-------
 5 files changed, 218 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index abb7cb5db9457..032c05998345d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -978,6 +978,8 @@ enum {
 	HCI_CONN_CREATE_CIS,
 	HCI_CONN_BIG_SYNC,
 	HCI_CONN_BIG_SYNC_FAILED,
+	HCI_CONN_PA_SYNC,
+	HCI_CONN_PA_SYNC_FAILED,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1301,7 +1303,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct hci_dev *
 		if (c->type != ISO_LINK)
 			continue;
 
-		if (handle == c->iso_qos.bcast.big) {
+		if (handle != BT_ISO_QOS_BIG_UNSET && handle == c->iso_qos.bcast.big) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1312,6 +1314,29 @@ static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct hci_dev *
 	return NULL;
 }
 
+static inline struct hci_conn *
+hci_conn_hash_lookup_pa_sync(struct hci_dev *hdev, __u8 big)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != ISO_LINK ||
+			!test_bit(HCI_CONN_PA_SYNC, &c->flags))
+			continue;
+
+		if (c->iso_qos.bcast.big == big) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 							__u8 type, __u16 state)
 {
@@ -1415,7 +1440,8 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 data_len, __u8 *data);
 int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 		       __u8 sid, struct bt_iso_qos *qos);
-int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
+int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6d6192f514d0f..c3da326615931 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -734,6 +734,7 @@ struct iso_list_data {
 	};
 	int count;
 	bool big_term;
+	bool pa_sync_term;
 	bool big_sync_term;
 };
 
@@ -807,7 +808,10 @@ static int big_terminate_sync(struct hci_dev *hdev, void *data)
 	if (d->big_sync_term)
 		hci_le_big_terminate_sync(hdev, d->big);
 
-	return hci_le_pa_terminate_sync(hdev, d->sync_handle);
+	if (d->pa_sync_term)
+		return hci_le_pa_terminate_sync(hdev, d->sync_handle);
+
+	return 0;
 }
 
 static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *conn)
@@ -823,6 +827,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 
 	d->big = big;
 	d->sync_handle = conn->sync_handle;
+	d->pa_sync_term = test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags);
 	d->big_sync_term = test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn->flags);
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
@@ -2127,7 +2132,8 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 	return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
 }
 
-int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
+int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
 {
 	struct _packed {
@@ -2143,6 +2149,9 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
 	if (err)
 		return err;
 
+	if (hcon)
+		hcon->iso_qos.bcast.big = qos->bcast.big;
+
 	memset(&pdu, 0, sizeof(pdu));
 	pdu.cp.handle = qos->bcast.big;
 	pdu.cp.sync_handle = cpu_to_le16(sync_handle);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dd70fd5313840..97d589178eb78 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6578,20 +6578,39 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	struct hci_ev_le_pa_sync_established *ev = data;
 	int mask = hdev->link_mode;
 	__u8 flags = 0;
+	struct hci_conn *bis;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	if (ev->status)
-		return;
-
 	hci_dev_lock(hdev);
 
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ISO_LINK, &flags);
-	if (!(mask & HCI_LM_ACCEPT))
+	if (!(mask & HCI_LM_ACCEPT)) {
 		hci_le_pa_term_sync(hdev, ev->handle);
+		goto unlock;
+	}
+
+	if (!(flags & HCI_PROTO_DEFER))
+		goto unlock;
+
+	/* Add connection to indicate the PA sync event */
+	bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
+			   HCI_ROLE_SLAVE);
 
+	if (!bis)
+		goto unlock;
+
+	if (ev->status)
+		set_bit(HCI_CONN_PA_SYNC_FAILED, &bis->flags);
+	else
+		set_bit(HCI_CONN_PA_SYNC, &bis->flags);
+
+	/* Notify connection to iso layer */
+	hci_connect_cfm(bis, ev->status);
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -7051,6 +7070,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
 	struct hci_conn *bis;
+	struct hci_conn *pa_sync;
 	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
@@ -7061,6 +7081,15 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	if (!ev->status) {
+		pa_sync = hci_conn_hash_lookup_pa_sync(hdev, ev->handle);
+		if (pa_sync)
+			/* Also mark the BIG sync established event on the
+			 * associated PA sync hcon
+			 */
+			set_bit(HCI_CONN_BIG_SYNC, &pa_sync->flags);
+	}
+
 	for (i = 0; i < ev->num_bis; i++) {
 		u16 handle = le16_to_cpu(ev->bis[i]);
 		__le32 interval;
@@ -7074,6 +7103,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			bis->handle = handle;
 		}
 
+		if (ev->status != 0x42)
+			/* Mark PA sync as established */
+			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
+
 		bis->iso_qos.bcast.big = ev->handle;
 		memset(&interval, 0, sizeof(interval));
 		memcpy(&interval, ev->latency, sizeof(ev->latency));
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 360813ab0c4db..92a6921a161f2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5389,6 +5389,21 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		err = hci_reject_conn_sync(hdev, conn, reason);
 		break;
 	case BT_OPEN:
+		hci_dev_lock(hdev);
+
+		/* Cleanup bis or pa sync connections */
+		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags) ||
+		    test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags)) {
+			hci_conn_failed(conn, reason);
+		} else if (test_bit(HCI_CONN_PA_SYNC, &conn->flags) ||
+			   test_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
+			conn->state = BT_CLOSED;
+			hci_disconn_cfm(conn, reason);
+			hci_conn_del(conn);
+		}
+
+		hci_dev_unlock(hdev);
+		return 0;
 	case BT_BOUND:
 		break;
 	default:
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index c8460eb7f5c0b..4689f94e4da81 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -51,6 +51,7 @@ static void iso_sock_kill(struct sock *sk);
 /* iso_pinfo flags values */
 enum {
 	BT_SK_BIG_SYNC,
+	BT_SK_PA_SYNC,
 };
 
 struct iso_pinfo {
@@ -75,6 +76,8 @@ static struct bt_iso_qos default_qos;
 
 static bool check_ucast_qos(struct bt_iso_qos *qos);
 static bool check_bcast_qos(struct bt_iso_qos *qos);
+static bool iso_match_sid(struct sock *sk, void *data);
+static void iso_sock_disconn(struct sock *sk);
 
 /* ---- ISO timers ---- */
 #define ISO_CONN_TIMEOUT	(HZ * 40)
@@ -601,6 +604,15 @@ static void iso_sock_cleanup_listen(struct sock *parent)
 		iso_sock_kill(sk);
 	}
 
+	/* If listening socket stands for a PA sync connection,
+	 * properly disconnect the hcon and socket.
+	 */
+	if (iso_pi(parent)->conn && iso_pi(parent)->conn->hcon &&
+	    test_bit(HCI_CONN_PA_SYNC, &iso_pi(parent)->conn->hcon->flags)) {
+		iso_sock_disconn(parent);
+		return;
+	}
+
 	parent->sk_state  = BT_CLOSED;
 	sock_set_flag(parent, SOCK_ZAPPED);
 }
@@ -622,6 +634,16 @@ static void iso_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
+static void iso_sock_disconn(struct sock *sk)
+{
+	sk->sk_state = BT_DISCONN;
+	iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
+	iso_conn_lock(iso_pi(sk)->conn);
+	hci_conn_drop(iso_pi(sk)->conn->hcon);
+	iso_pi(sk)->conn->hcon = NULL;
+	iso_conn_unlock(iso_pi(sk)->conn);
+}
+
 static void __iso_sock_close(struct sock *sk)
 {
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
@@ -633,20 +655,19 @@ static void __iso_sock_close(struct sock *sk)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (iso_pi(sk)->conn->hcon) {
-			sk->sk_state = BT_DISCONN;
-			iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
-			iso_conn_lock(iso_pi(sk)->conn);
-			hci_conn_drop(iso_pi(sk)->conn->hcon);
-			iso_pi(sk)->conn->hcon = NULL;
-			iso_conn_unlock(iso_pi(sk)->conn);
-		} else {
+		if (iso_pi(sk)->conn->hcon)
+			iso_sock_disconn(sk);
+		else
 			iso_chan_del(sk, ECONNRESET);
-		}
 		break;
 
 	case BT_CONNECT2:
-		iso_chan_del(sk, ECONNRESET);
+		if (iso_pi(sk)->conn->hcon &&
+		    (test_bit(HCI_CONN_PA_SYNC, &iso_pi(sk)->conn->hcon->flags) ||
+		    test_bit(HCI_CONN_PA_SYNC_FAILED, &iso_pi(sk)->conn->hcon->flags)))
+			iso_sock_disconn(sk);
+		else
+			iso_chan_del(sk, ECONNRESET);
 		break;
 	case BT_CONNECT:
 		/* In case of DEFER_SETUP the hcon would be bound to CIG which
@@ -1162,6 +1183,29 @@ static void iso_conn_defer_accept(struct hci_conn *conn)
 	hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
 }
 
+static void iso_conn_big_sync(struct sock *sk)
+{
+	int err;
+	struct hci_dev *hdev;
+
+	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
+			     iso_pi(sk)->src_type);
+
+	if (!hdev)
+		return;
+
+	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
+		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
+					     &iso_pi(sk)->qos,
+					     iso_pi(sk)->sync_handle,
+					     iso_pi(sk)->bc_num_bis,
+					     iso_pi(sk)->bc_bis);
+		if (err)
+			bt_dev_err(hdev, "hci_le_big_create_sync: %d",
+				   err);
+	}
+}
+
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags)
 {
@@ -1174,8 +1218,15 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		lock_sock(sk);
 		switch (sk->sk_state) {
 		case BT_CONNECT2:
-			iso_conn_defer_accept(pi->conn->hcon);
-			sk->sk_state = BT_CONFIG;
+			if (pi->conn->hcon &&
+			    test_bit(HCI_CONN_PA_SYNC, &pi->conn->hcon->flags)) {
+				iso_conn_big_sync(sk);
+				sk->sk_state = BT_LISTEN;
+				set_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
+			} else {
+				iso_conn_defer_accept(pi->conn->hcon);
+				sk->sk_state = BT_CONFIG;
+			}
 			release_sock(sk);
 			return 0;
 		case BT_CONNECT:
@@ -1518,11 +1569,17 @@ static bool iso_match_big(struct sock *sk, void *data)
 	return ev->handle == iso_pi(sk)->qos.bcast.big;
 }
 
+static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
+{
+	return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
+}
+
 static void iso_conn_ready(struct iso_conn *conn)
 {
-	struct sock *parent;
+	struct sock *parent = NULL;
 	struct sock *sk = conn->sk;
-	struct hci_ev_le_big_sync_estabilished *ev;
+	struct hci_ev_le_big_sync_estabilished *ev = NULL;
+	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_conn *hcon;
 
 	BT_DBG("conn %p", conn);
@@ -1534,15 +1591,32 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (!hcon)
 			return;
 
-		ev = hci_recv_event_data(hcon->hdev,
-					 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
-		if (ev)
+		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags) ||
+		    test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
+			ev = hci_recv_event_data(hcon->hdev,
+						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
+
+			/* Get reference to PA sync parent socket, if it exists */
 			parent = iso_get_sock_listen(&hcon->src,
 						     &hcon->dst,
-						     iso_match_big, ev);
-		else
+						     iso_match_pa_sync_flag, NULL);
+			if (!parent && ev)
+				parent = iso_get_sock_listen(&hcon->src,
+							     &hcon->dst,
+							     iso_match_big, ev);
+		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags) ||
+				test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
+			ev2 = hci_recv_event_data(hcon->hdev,
+						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
+			if (ev2)
+				parent = iso_get_sock_listen(&hcon->src,
+							     &hcon->dst,
+							     iso_match_sid, ev2);
+		}
+
+		if (!parent)
 			parent = iso_get_sock_listen(&hcon->src,
-						     BDADDR_ANY, NULL, NULL);
+							BDADDR_ANY, NULL, NULL);
 
 		if (!parent)
 			return;
@@ -1559,11 +1633,17 @@ static void iso_conn_ready(struct iso_conn *conn)
 		iso_sock_init(sk, parent);
 
 		bacpy(&iso_pi(sk)->src, &hcon->src);
-		iso_pi(sk)->src_type = hcon->src_type;
+
+		/* Convert from HCI to three-value type */
+		if (hcon->src_type == ADDR_LE_DEV_PUBLIC)
+			iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
+		else
+			iso_pi(sk)->src_type = BDADDR_LE_RANDOM;
 
 		/* If hcon has no destination address (BDADDR_ANY) it means it
-		 * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED so we need to
-		 * initialize using the parent socket destination address.
+		 * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED or
+		 * HCI_EV_LE_PA_SYNC_ESTABLISHED so we need to initialize using
+		 * the parent socket destination address.
 		 */
 		if (!bacmp(&hcon->dst, BDADDR_ANY)) {
 			bacpy(&hcon->dst, &iso_pi(parent)->dst);
@@ -1571,13 +1651,21 @@ static void iso_conn_ready(struct iso_conn *conn)
 			hcon->sync_handle = iso_pi(parent)->sync_handle;
 		}
 
+		if (ev2 && !ev2->status) {
+			iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
+			iso_pi(sk)->qos = iso_pi(parent)->qos;
+			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
+			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
+		}
+
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
 		iso_pi(sk)->dst_type = hcon->dst_type;
 
 		hci_conn_hold(hcon);
 		iso_chan_add(conn, sk, parent);
 
-		if (ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) {
+		if ((ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) ||
+		    (ev2 && ev2->status)) {
 			/* Trigger error signal on child socket */
 			sk->sk_err = ECONNREFUSED;
 			sk->sk_error_report(sk);
@@ -1635,7 +1723,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	if (ev1) {
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
 					 ev1);
-		if (sk)
+		if (sk && !ev1->status)
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
 
 		goto done;
@@ -1643,16 +1731,21 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
+		/* Try to get PA sync listening socket, if it exists */
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
-					 iso_match_sync_handle, ev2);
+						iso_match_pa_sync_flag, NULL);
+		if (!sk)
+			sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
+						 iso_match_sync_handle, ev2);
 		if (sk) {
 			int err;
 
 			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
-			if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-				err = hci_le_big_create_sync(hdev,
+			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
+			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
+				err = hci_le_big_create_sync(hdev, NULL,
 							     &iso_pi(sk)->qos,
 							     iso_pi(sk)->sync_handle,
 							     iso_pi(sk)->bc_num_bis,
@@ -1704,12 +1797,13 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
-	/* Similar to the success case, if HCI_CONN_BIG_SYNC_FAILED is set,
-	 * queue the failed bis connection into the accept queue of the
-	 * listening socket and wake up userspace, to inform the user about
-	 * the BIG sync failed event.
+	/* Similar to the success case, if HCI_CONN_BIG_SYNC_FAILED or
+	 * HCI_CONN_PA_SYNC_FAILED is set, queue the failed connection
+	 * into the accept queue of the listening socket and wake up
+	 * userspace, to inform the user about the event.
 	 */
-	if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
+	if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags) ||
+	    test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
 		struct iso_conn *conn;
 
 		conn = iso_conn_add(hcon);
-- 
2.42.0



