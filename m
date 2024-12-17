Return-Path: <stable+bounces-104814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5619F533A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EE718914AD
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35CA1F757B;
	Tue, 17 Dec 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M31yxnk9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE114A4E7;
	Tue, 17 Dec 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456184; cv=none; b=HYkZoIGd9LFDJx64hV6EkPTyTIq3m/OvMRSJC42N7CWMMPtD3xsaStJ1YfcVGm0c/kV5pTrZjMJRZqu7DNlUuUrd/JUrt6yTH2zD4fvvpQ3HFav/5O4oNBi9Xi/Ysf91u0g3QEUnzmIgwFurUTkX8ax6mZPyF44+s/HOI2sZ+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456184; c=relaxed/simple;
	bh=icOZ+Q60l2XvZWg8CWtBIr2Rsx8XSaj+166q+k9fumw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlbvNRQHNXUtZ3KSVXRQ3LJtmeLBw5X0FcVO1ObcQEoXqWLC1f4AZatqnnnHZoJ3FIkyk/4xSu4r9CXcz34EEAnghVwne/BDJwxSMxx3pE6Ye1x/dNMVbB70oGONnTHxg8t6ILeZ5G3RferHw9XUwlgZM9m4N3CDyOuFtxqqEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M31yxnk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A193C4CED7;
	Tue, 17 Dec 2024 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456184;
	bh=icOZ+Q60l2XvZWg8CWtBIr2Rsx8XSaj+166q+k9fumw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M31yxnk9UAoAg0URjZmqQwuqlzyqKR6F7uoQdNqn6LMmfXIGZ6iUApTHjz+X2urrr
	 zFTodKh8QySdlTPl1/LqNLGNF311H5u3rNgb6ez6AGIDuwRqjXsumKFeXRWgUXIxLY
	 6iJXcWQQCzwpNb0Y3XoJbEofO/sh/E4cVltg9+fs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 086/109] Bluetooth: ISO: Reassociate a socket with an active BIS
Date: Tue, 17 Dec 2024 18:08:10 +0100
Message-ID: <20241217170536.978355896@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
References: <20241217170533.329523616@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Iulia Tanasescu <iulia.tanasescu@nxp.com>

[ Upstream commit fa224d0c094a458e9ebf5ea9b1c696136b7af427 ]

For ISO Broadcast, all BISes from a BIG have the same lifespan - they
cannot be created or terminated independently from each other.

This links together all BIS hcons that are part of the same BIG, so all
hcons are kept alive as long as the BIG is active.

If multiple BIS sockets are opened for a BIG handle, and only part of
them are closed at some point, the associated hcons will be marked as
open. If new sockets will later be opened for the same BIG, they will
be reassociated with the open BIS hcons.

All BIS hcons will be cleaned up and the BIG will be terminated when
the last BIS socket is closed from userspace.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 581dd2dc168f ("Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h | 24 ++++++++++
 net/bluetooth/hci_conn.c         | 32 ++++++++++++-
 net/bluetooth/iso.c              | 79 +++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4185eb679180..e9214ccfde2d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1294,6 +1294,30 @@ static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct hci_dev *
 	return NULL;
 }
 
+static inline struct hci_conn *
+hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (bacmp(&c->dst, BDADDR_ANY) || c->type != ISO_LINK ||
+			c->state != state)
+			continue;
+
+		if (handle == c->iso_qos.bcast.big) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *
 hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8 big)
 {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 35d739988ce3..6178ae8feafc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1054,8 +1054,9 @@ static void hci_conn_cleanup_child(struct hci_conn *conn, u8 reason)
 			hci_conn_failed(conn, reason);
 		break;
 	case ISO_LINK:
-		if (conn->state != BT_CONNECTED &&
-		    !test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
+		if ((conn->state != BT_CONNECTED &&
+		    !test_bit(HCI_CONN_CREATE_CIS, &conn->flags)) ||
+		    test_bit(HCI_CONN_BIG_CREATED, &conn->flags))
 			hci_conn_failed(conn, reason);
 		break;
 	}
@@ -2134,7 +2135,17 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
 			      __u8 base_len, __u8 *base)
 {
 	struct hci_conn *conn;
+	struct hci_conn *parent;
 	__u8 eir[HCI_MAX_PER_AD_LENGTH];
+	struct hci_link *link;
+
+	/* Look for any BIS that is open for rebinding */
+	conn = hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, BT_OPEN);
+	if (conn) {
+		memcpy(qos, &conn->iso_qos, sizeof(*qos));
+		conn->state = BT_CONNECTED;
+		return conn;
+	}
 
 	if (base_len && base)
 		base_len = eir_append_service_data(eir, 0,  0x1851,
@@ -2162,6 +2173,20 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->iso_qos = *qos;
 	conn->state = BT_BOUND;
 
+	/* Link BISes together */
+	parent = hci_conn_hash_lookup_big(hdev,
+					  conn->iso_qos.bcast.big);
+	if (parent && parent != conn) {
+		link = hci_conn_link(parent, conn);
+		if (!link) {
+			hci_conn_drop(conn);
+			return ERR_PTR(-ENOLINK);
+		}
+
+		/* Link takes the refcount */
+		hci_conn_drop(conn);
+	}
+
 	return conn;
 }
 
@@ -2193,6 +2218,9 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	if (IS_ERR(conn))
 		return conn;
 
+	if (conn->state == BT_CONNECTED)
+		return conn;
+
 	data.big = qos->bcast.big;
 	data.bis = qos->bcast.bis;
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index c2c80d600083..83597b3c0a8d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -612,19 +612,68 @@ static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
 			continue;
 
 		/* Exact match. */
-		if (!bacmp(&iso_pi(sk)->src, src))
+		if (!bacmp(&iso_pi(sk)->src, src)) {
+			sock_hold(sk);
 			break;
+		}
 
 		/* Closest match */
-		if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY))
+		if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY)) {
+			if (sk1)
+				sock_put(sk1);
+
 			sk1 = sk;
+			sock_hold(sk1);
+		}
 	}
 
+	if (sk && sk1)
+		sock_put(sk1);
+
 	read_unlock(&iso_sk_list.lock);
 
 	return sk ? sk : sk1;
 }
 
+static struct sock *iso_get_sock_big(struct sock *match_sk, bdaddr_t *src,
+				     bdaddr_t *dst, uint8_t big)
+{
+	struct sock *sk = NULL;
+
+	read_lock(&iso_sk_list.lock);
+
+	sk_for_each(sk, &iso_sk_list.head) {
+		if (match_sk == sk)
+			continue;
+
+		/* Look for sockets that have already been
+		 * connected to the BIG
+		 */
+		if (sk->sk_state != BT_CONNECTED &&
+		    sk->sk_state != BT_CONNECT)
+			continue;
+
+		/* Match Broadcast destination */
+		if (bacmp(&iso_pi(sk)->dst, dst))
+			continue;
+
+		/* Match BIG handle */
+		if (iso_pi(sk)->qos.bcast.big != big)
+			continue;
+
+		/* Match source address */
+		if (bacmp(&iso_pi(sk)->src, src))
+			continue;
+
+		sock_hold(sk);
+		break;
+	}
+
+	read_unlock(&iso_sk_list.lock);
+
+	return sk;
+}
+
 static void iso_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
@@ -677,6 +726,28 @@ static void iso_sock_kill(struct sock *sk)
 
 static void iso_sock_disconn(struct sock *sk)
 {
+	struct sock *bis_sk;
+	struct hci_conn *hcon = iso_pi(sk)->conn->hcon;
+
+	if (test_bit(HCI_CONN_BIG_CREATED, &hcon->flags)) {
+		bis_sk = iso_get_sock_big(sk, &iso_pi(sk)->src,
+					  &iso_pi(sk)->dst,
+					  iso_pi(sk)->qos.bcast.big);
+
+		/* If there are any other connected sockets for the
+		 * same BIG, just delete the sk and leave the bis
+		 * hcon active, in case later rebinding is needed.
+		 */
+		if (bis_sk) {
+			hcon->state = BT_OPEN;
+			iso_pi(sk)->conn->hcon = NULL;
+			iso_sock_clear_timer(sk);
+			iso_chan_del(sk, bt_to_errno(hcon->abort_reason));
+			sock_put(bis_sk);
+			return;
+		}
+	}
+
 	sk->sk_state = BT_DISCONN;
 	iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
 	iso_conn_lock(iso_pi(sk)->conn);
@@ -1724,6 +1795,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		parent->sk_data_ready(parent);
 
 		release_sock(parent);
+		sock_put(parent);
 	}
 }
 
@@ -1819,6 +1891,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 				if (err) {
 					bt_dev_err(hdev, "hci_le_big_create_sync: %d",
 						   err);
+					sock_put(sk);
 					sk = NULL;
 				}
 			}
@@ -1847,6 +1920,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
 		*flags |= HCI_PROTO_DEFER;
 
+	sock_put(sk);
+
 	return lm;
 }
 
-- 
2.39.5




