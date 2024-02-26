Return-Path: <stable+bounces-23702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F786768E
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 14:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DFC1F2AC8D
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0782128821;
	Mon, 26 Feb 2024 13:29:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77DB604BF
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954144; cv=none; b=PemWsFh8mM7E5b0VOz/MGqucR3w7oVPh/Yj+DnvZ1dO7aYFfJxuYdmq5DQgHXEus00qEQUMGbxumjU0xGRXwKF6o7xJbf5UncahT9oEcnFfnVPsWTMMpAUouPIkPS+LMAy5gNP3x7u/2MdMO1U9CZXbF7+i6knN2PUfYz5NzHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954144; c=relaxed/simple;
	bh=N2EHNcB28HYVDa5g/JL2u96wV92DdKDK/0bdHpYJ2tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JLTYJovxamk/LE/e4bARWMKe3eI/JL6Ms6j8EFa7DY0f19+YpRzxOvOAnYcknNaPh2RdTeavWTwtrbvR3Q1EqB5O9bhe7+Fyq+ESJizF/237uRg4FdB3kpS6MIvQWNYspKRVkqcsAH8tuZgw6Wet7ZxmArYGRcT32pV2bnV+TXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 0E3512F20255; Mon, 26 Feb 2024 13:29:01 +0000 (UTC)
X-Spam-Level: 
Received: from taut9powder.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id DC0DA2F2024B;
	Mon, 26 Feb 2024 13:28:54 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm
Date: Mon, 26 Feb 2024 16:28:36 +0300
Message-Id: <20240226132837.8404-2-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240226132837.8404-1-oficerovas@altlinux.org>
References: <20240226132837.8404-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")

This attempts to fix the following trace:

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc2-g0b93eeba4454 #4703 Not tainted
------------------------------------------------------
kworker/u3:0/46 is trying to acquire lock:
ffff888001fd9130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at:
sco_connect_cfm+0x118/0x4a0

but task is already holding lock:
ffffffff831e3340 (hci_cb_list_lock){+.+.}-{3:3}, at:
hci_sync_conn_complete_evt+0x1ad/0x3d0

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (hci_cb_list_lock){+.+.}-{3:3}:
       __mutex_lock+0x13b/0xcc0
       hci_sync_conn_complete_evt+0x1ad/0x3d0
       hci_event_packet+0x55c/0x7c0
       hci_rx_work+0x34c/0xa00
       process_one_work+0x575/0x910
       worker_thread+0x89/0x6f0
       kthread+0x14e/0x180
       ret_from_fork+0x2b/0x50

-> #1 (&hdev->lock){+.+.}-{3:3}:
       __mutex_lock+0x13b/0xcc0
       sco_sock_connect+0xfc/0x630
       __sys_connect+0x197/0x1b0
       __x64_sys_connect+0x37/0x50
       do_syscall_64+0x42/0x90
       entry_SYSCALL_64_after_hwframe+0x70/0xda

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
       __lock_acquire+0x18cc/0x3740
       lock_acquire+0x151/0x3a0
       lock_sock_nested+0x32/0x80
       sco_connect_cfm+0x118/0x4a0
       hci_sync_conn_complete_evt+0x1e6/0x3d0
       hci_event_packet+0x55c/0x7c0
       hci_rx_work+0x34c/0xa00
       process_one_work+0x575/0x910
       worker_thread+0x89/0x6f0
       kthread+0x14e/0x180
       ret_from_fork+0x2b/0x50

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_BLUETOOTH-BTPROTO_SCO --> &hdev->lock --> hci_cb_list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hci_cb_list_lock);
                               lock(&hdev->lock);
                               lock(hci_cb_list_lock);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_SCO);

 *** DEADLOCK ***

4 locks held by kworker/u3:0/46:
 #0: ffff8880028d1130 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
 process_one_work+0x4c0/0x910
 #1: ffff8880013dfde0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
 at: process_one_work+0x4c0/0x910
 #2: ffff8880025d8070 (&hdev->lock){+.+.}-{3:3}, at:
 hci_sync_conn_complete_evt+0xa6/0x3d0
 #3: ffffffffb79e3340 (hci_cb_list_lock){+.+.}-{3:3}, at:
 hci_sync_conn_complete_evt+0x1ad/0x3d0

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 net/bluetooth/sco.c | 69 ++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 6d4168cfeb563..0e1f5dde7bfec 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -235,27 +235,41 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	return err;
 }
 
-static int sco_connect(struct hci_dev *hdev, struct sock *sk)
+static int sco_connect(struct sock *sk)
 {
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
+	struct hci_dev  *hdev;
 	int err, type;
 
 	BT_DBG("%pMR -> %pMR", &sco_pi(sk)->src, &sco_pi(sk)->dst);
 
+	hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+	if (!hdev)
+		return -EHOSTUNREACH;
+
+	hci_dev_lock(hdev);
+
 	if (lmp_esco_capable(hdev) && !disable_esco)
 		type = ESCO_LINK;
 	else
 		type = SCO_LINK;
 
 	if (sco_pi(sk)->setting == BT_VOICE_TRANSPARENT &&
-	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev)))
-		return -EOPNOTSUPP;
+	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
 			       sco_pi(sk)->setting, &sco_pi(sk)->codec);
-	if (IS_ERR(hcon))
-		return PTR_ERR(hcon);
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
+		goto unlock;
+	}
+
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 
 	conn = sco_conn_add(hcon);
 	if (!conn) {
@@ -263,13 +277,15 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 		return -ENOMEM;
 	}
 
-	/* Update source addr of the socket */
-	bacpy(&sco_pi(sk)->src, &hcon->src);
-
 	err = sco_chan_add(conn, sk, NULL);
 	if (err)
 		return err;
 
+	lock_sock(sk);
+
+	/* Update source addr of the socket */
+	bacpy(&sco_pi(sk)->src, &hcon->src);
+
 	if (hcon->state == BT_CONNECTED) {
 		sco_sock_clear_timer(sk);
 		sk->sk_state = BT_CONNECTED;
@@ -278,6 +294,13 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 		sco_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
+	release_sock(sk);
+
+	return err;
+
+unlock:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 	return err;
 }
 
@@ -565,7 +588,6 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
-	struct hci_dev  *hdev;
 	int err;
 
 	BT_DBG("sk %p", sk);
@@ -574,37 +596,26 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	lock_sock(sk);
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
-		err = -EBADFD;
-		goto done;
-	}
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
+		return -EBADFD;
 
-	if (sk->sk_type != SOCK_SEQPACKET) {
+	if (sk->sk_type != SOCK_SEQPACKET)
 		err = -EINVAL;
-		goto done;
-	}
-
-	hdev = hci_get_route(&sa->sco_bdaddr, &sco_pi(sk)->src, BDADDR_BREDR);
-	if (!hdev) {
-		err = -EHOSTUNREACH;
-		goto done;
-	}
-	hci_dev_lock(hdev);
 
+	lock_sock(sk);
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
+	release_sock(sk);
 
-	err = sco_connect(hdev, sk);
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	err = sco_connect(sk);
 	if (err)
-		goto done;
+		return err;
+
+	lock_sock(sk);
 
 	err = bt_sock_wait_state(sk, BT_CONNECTED,
 				 sock_sndtimeo(sk, flags & O_NONBLOCK));
 
-done:
 	release_sock(sk);
 	return err;
 }
-- 
2.42.1


