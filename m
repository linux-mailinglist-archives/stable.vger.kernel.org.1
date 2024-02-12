Return-Path: <stable+bounces-19468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3B8851426
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 14:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DEBB21DBC
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B23A1BC;
	Mon, 12 Feb 2024 13:10:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF23A28B;
	Mon, 12 Feb 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743418; cv=none; b=hNtPAjFgcFeURr9G/VCro9OZKv5NOXB3BpH0tcwc5pvcPTBg7u0xJDIMCpQuPea9MuT5Kj1qis3BdPmvTptQTNiLbtCXkoeSm/rMsvuIkWZ5dooT9AG8tul0epLiCNS0vv06j2aVEjnszS1bhZPf/Xtgr3QxmqaRJLVM1uvsc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743418; c=relaxed/simple;
	bh=grTu+GWxdnfxSaMkYRxM8JuDC8n6g2nj3OXPhlDOaXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUyiHlPKVReb/R11e8wszVitiwKReTB8ru10DUyAdFqHqaFIBU1S31owHXUrbERi2EEmtHM/RVYGpVYWJaBKKPTpkFPmulBgkbD0voeU+QN87N0mwPmrQK3K42j4X340L0JayQp+prkjNZGJQjwxLEjR4A7bNjhPsIFnC45WhZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id A19D42F20243; Mon, 12 Feb 2024 13:10:05 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 2AD332F2023F;
	Mon, 12 Feb 2024 13:10:03 +0000 (UTC)
From: oficerovas@altlinux.org
To: oficerovas@altlinux.org,
	stable@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org
Subject: [PATCH 1/2] Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm
Date: Mon, 12 Feb 2024 16:09:32 +0300
Message-ID: <20240212130933.3856081-2-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240212130933.3856081-1-oficerovas@altlinux.org>
References: <20240212130933.3856081-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Ofitserov <oficerovas@altlinux.org>

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


