Return-Path: <stable+bounces-96817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FA9E2181
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA461285D0D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA51F8905;
	Tue,  3 Dec 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uCzYf7YM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37931FAC54;
	Tue,  3 Dec 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238680; cv=none; b=euCvjQPg9W7A9gpYQouhQWt9rNPg04cgaKWUQVjnh2tGh57iAStvIVvhFV6VawV9iXpkf3AAB2M61/pW+yux21on1xJS0ZM/dW/JJLEwAoYOIe57xNAT2CukHus6VtUjvf3QIhmehxCLlLP81Kbm5C092OV0BVUXhWxZ0FIhyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238680; c=relaxed/simple;
	bh=fugOaCetRIG6nuT/42tZQUGRQsx8P4TGcDf8VTL7dZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahF+Q5KTdRTPxuAI/SQn+mKpYUcuxMeE+V/5044Vr1qMWroRXWVzRHMprPPtpbPc5ubvoLxMlOvpnd7jMBoClMvRbWkpbayvWMZSmV6ipH8ByXXVWXspOMU8EhxapFk7eFWdoryXqG1MAQwBXFqOeOWOhT4N/nYk++12OWbZh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uCzYf7YM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2383EC4CECF;
	Tue,  3 Dec 2024 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238678;
	bh=fugOaCetRIG6nuT/42tZQUGRQsx8P4TGcDf8VTL7dZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCzYf7YMwe56UZdN6jV6o3GVhS1DHKBLiPjoHeOYzWcg7VvgVTas1RXsjNG+XrR6k
	 j2VZWwQJyN07E4QCsIrBqF1VArBm3XESP75LbGPlnQTECvgK+EYQK0sypeupK6+AWo
	 bMZbriqq1y+ofImsTZIsnl3twdKaf5iPQZgbib4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 360/817] Bluetooth: ISO: Use kref to track lifetime of iso_conn
Date: Tue,  3 Dec 2024 15:38:52 +0100
Message-ID: <20241203144009.885756309@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit dc26097bdb864a0d5955b9a25e43376ffc1af99b ]

This make use of kref to keep track of reference of iso_conn which
allows better tracking of its lifetime with usage of things like
kref_get_unless_zero in a similar way as used in l2cap_chan.

In addition to it remove call to iso_sock_set_timer on iso_sock_disconn
since at that point it is useless to set a timer as the sk will be freed
there is nothing to be done in iso_sock_timeout.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 88 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7a83e400ac77a..109bf58c982ae 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -35,6 +35,7 @@ struct iso_conn {
 	struct sk_buff	*rx_skb;
 	__u32		rx_len;
 	__u16		tx_sn;
+	struct kref	ref;
 };
 
 #define iso_conn_lock(c)	spin_lock(&(c)->lock)
@@ -93,6 +94,49 @@ static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
 #define ISO_CONN_TIMEOUT	(HZ * 40)
 #define ISO_DISCONN_TIMEOUT	(HZ * 2)
 
+static void iso_conn_free(struct kref *ref)
+{
+	struct iso_conn *conn = container_of(ref, struct iso_conn, ref);
+
+	BT_DBG("conn %p", conn);
+
+	if (conn->sk)
+		iso_pi(conn->sk)->conn = NULL;
+
+	if (conn->hcon) {
+		conn->hcon->iso_data = NULL;
+		hci_conn_drop(conn->hcon);
+	}
+
+	/* Ensure no more work items will run since hci_conn has been dropped */
+	disable_delayed_work_sync(&conn->timeout_work);
+
+	kfree(conn);
+}
+
+static void iso_conn_put(struct iso_conn *conn)
+{
+	if (!conn)
+		return;
+
+	BT_DBG("conn %p refcnt %d", conn, kref_read(&conn->ref));
+
+	kref_put(&conn->ref, iso_conn_free);
+}
+
+static struct iso_conn *iso_conn_hold_unless_zero(struct iso_conn *conn)
+{
+	if (!conn)
+		return NULL;
+
+	BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
+
+	if (!kref_get_unless_zero(&conn->ref))
+		return NULL;
+
+	return conn;
+}
+
 static struct sock *iso_sock_hold(struct iso_conn *conn)
 {
 	if (!conn || !bt_sock_linked(&iso_sk_list, conn->sk))
@@ -109,9 +153,14 @@ static void iso_sock_timeout(struct work_struct *work)
 					     timeout_work.work);
 	struct sock *sk;
 
+	conn = iso_conn_hold_unless_zero(conn);
+	if (!conn)
+		return;
+
 	iso_conn_lock(conn);
 	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
+	iso_conn_put(conn);
 
 	if (!sk)
 		return;
@@ -149,9 +198,14 @@ static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
 {
 	struct iso_conn *conn = hcon->iso_data;
 
+	conn = iso_conn_hold_unless_zero(conn);
 	if (conn) {
-		if (!conn->hcon)
+		if (!conn->hcon) {
+			iso_conn_lock(conn);
 			conn->hcon = hcon;
+			iso_conn_unlock(conn);
+		}
+		iso_conn_put(conn);
 		return conn;
 	}
 
@@ -159,6 +213,7 @@ static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
 	if (!conn)
 		return NULL;
 
+	kref_init(&conn->ref);
 	spin_lock_init(&conn->lock);
 	INIT_DELAYED_WORK(&conn->timeout_work, iso_sock_timeout);
 
@@ -178,17 +233,15 @@ static void iso_chan_del(struct sock *sk, int err)
 	struct sock *parent;
 
 	conn = iso_pi(sk)->conn;
+	iso_pi(sk)->conn = NULL;
 
 	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
 
 	if (conn) {
 		iso_conn_lock(conn);
 		conn->sk = NULL;
-		iso_pi(sk)->conn = NULL;
 		iso_conn_unlock(conn);
-
-		if (conn->hcon)
-			hci_conn_drop(conn->hcon);
+		iso_conn_put(conn);
 	}
 
 	sk->sk_state = BT_CLOSED;
@@ -210,6 +263,7 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	struct iso_conn *conn = hcon->iso_data;
 	struct sock *sk;
 
+	conn = iso_conn_hold_unless_zero(conn);
 	if (!conn)
 		return;
 
@@ -219,20 +273,18 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	iso_conn_lock(conn);
 	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
+	iso_conn_put(conn);
 
-	if (sk) {
-		lock_sock(sk);
-		iso_sock_clear_timer(sk);
-		iso_chan_del(sk, err);
-		release_sock(sk);
-		sock_put(sk);
+	if (!sk) {
+		iso_conn_put(conn);
+		return;
 	}
 
-	/* Ensure no more work items will run before freeing conn. */
-	cancel_delayed_work_sync(&conn->timeout_work);
-
-	hcon->iso_data = NULL;
-	kfree(conn);
+	lock_sock(sk);
+	iso_sock_clear_timer(sk);
+	iso_chan_del(sk, err);
+	release_sock(sk);
+	sock_put(sk);
 }
 
 static int __iso_chan_add(struct iso_conn *conn, struct sock *sk,
@@ -652,6 +704,8 @@ static void iso_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
+	iso_conn_put(iso_pi(sk)->conn);
+
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 }
@@ -711,6 +765,7 @@ static void iso_sock_disconn(struct sock *sk)
 		 */
 		if (bis_sk) {
 			hcon->state = BT_OPEN;
+			hcon->iso_data = NULL;
 			iso_pi(sk)->conn->hcon = NULL;
 			iso_sock_clear_timer(sk);
 			iso_chan_del(sk, bt_to_errno(hcon->abort_reason));
@@ -720,7 +775,6 @@ static void iso_sock_disconn(struct sock *sk)
 	}
 
 	sk->sk_state = BT_DISCONN;
-	iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
 	iso_conn_lock(iso_pi(sk)->conn);
 	hci_conn_drop(iso_pi(sk)->conn->hcon);
 	iso_pi(sk)->conn->hcon = NULL;
-- 
2.43.0




