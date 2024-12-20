Return-Path: <stable+bounces-105487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2119F9822
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56580163F9E
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB571233D8C;
	Fri, 20 Dec 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKltxeHV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060E21C9EB;
	Fri, 20 Dec 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714824; cv=none; b=srDqni0e8WJae5/YpVL0WB2X9FGliocxgn7YUOw8OmVAwACPAYt1qgqUo/VQHmwsOD+hy7sVgx/3vv7Bv4dU2Ykfj89Mdr/jQGvujum8MtUhP5iu5E7VZhI4xaqOgT3uZtWa1v9vuOo3R4qJ1KjWZgMCXVXSe4fYpG6VJPcdY1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714824; c=relaxed/simple;
	bh=yeY6xWuN5eYa0cBr7mJJU8BQgL9+Q0l4o3HTT2tq70I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7CSyf9jmHXmTjyMXmVBN5wIzDiJworwrJYwux6b89mR9IfCBC+siiflt/9NunE0Q10zGPCRuq0OxolsjB+c85bwfQwbgUXooYZOL08m6WN1eW/3lcQ0ENeNm2cPnez3D/GifF+nZVuHB1Xt8kGNohMwM0zC87LQAN5eY9OoLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKltxeHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A960CC4CECD;
	Fri, 20 Dec 2024 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714824;
	bh=yeY6xWuN5eYa0cBr7mJJU8BQgL9+Q0l4o3HTT2tq70I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKltxeHV2Mpdd5tYi3/1umQfsI2Qc6WBjcFce923217cvgjClRuo9VEv503OiaTrG
	 K0YDF9PYj7wcCq4Ta/DXlURVkqaYC73E6aVPOq1bRZ7lbfFIbE4XVEFXou+pPW3NB5
	 nsQyq/dhGCE8ms1+Kq5XzsTQAte39GeHRKZoOQQdOoUGJLCx7FtIRyVmIHbXnaOs58
	 rLxU6FuU7cNrWyFal8NlN6OGunizXXNCsFYEKIlo4df1u4estdFGkv2aipXvSkRe2p
	 jgbIw78wm1VBubp0FBjHw7wxVZJJfCHD8q2E155LleVKoTXjvoq2qNaJuycUqzdEM4
	 nELyfDG6Gdajg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	20373622@buaa.edu.cn,
	viro@zeniv.linux.org.uk,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/12] Bluetooth: hci_core: Fix sleeping function called from invalid context
Date: Fri, 20 Dec 2024 12:13:15 -0500
Message-Id: <20241220171317.512120-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171317.512120-1-sashal@kernel.org>
References: <20241220171317.512120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.121
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 4d94f05558271654670d18c26c912da0c1c15549 ]

This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bugs
like the bellow:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5070, name: kworker/u9:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
4 locks held by kworker/u9:2/5070:
 #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffff8880665d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_le_create_big_complete_evt+0xcf/0xae0 net/bluetooth/hci_event.c:6914
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hci_le_create_big_complete_evt+0xdb/0xae0 net/bluetooth/hci_event.c:6915
CPU: 0 PID: 5070 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __might_resched+0x5d4/0x780 kernel/sched/core.c:10187
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
 hci_connect_cfm include/net/bluetooth/hci_core.h:2004 [inline]
 hci_le_create_big_complete_evt+0x3d9/0xae0 net/bluetooth/hci_event.c:6939
 hci_event_func net/bluetooth/hci_event.c:7514 [inline]
 hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Tested-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h | 108 ++++++++++++++++++++-----------
 net/bluetooth/hci_core.c         |  10 +--
 net/bluetooth/iso.c              |   6 ++
 net/bluetooth/l2cap_core.c       |  12 ++--
 net/bluetooth/rfcomm/core.c      |   6 ++
 net/bluetooth/sco.c              |  12 ++--
 6 files changed, 97 insertions(+), 57 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d26b57e87f7f..b37e95554271 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -815,7 +815,6 @@ struct hci_conn_params {
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
-extern struct mutex hci_cb_list_lock;
 
 #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev_flags)
 #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->dev_flags)
@@ -1769,24 +1768,47 @@ struct hci_cb {
 
 	char *name;
 
+	bool (*match)		(struct hci_conn *conn);
 	void (*connect_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*disconn_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
-								__u8 encrypt);
+				 __u8 encrypt);
 	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
 };
 
+static inline void hci_cb_lookup(struct hci_conn *conn, struct list_head *list)
+{
+	struct hci_cb *cb, *cpy;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
+		if (cb->match && cb->match(conn)) {
+			cpy = kmalloc(sizeof(*cpy), GFP_ATOMIC);
+			if (!cpy)
+				break;
+
+			*cpy = *cb;
+			INIT_LIST_HEAD(&cpy->list);
+			list_add_rcu(&cpy->list, list);
+		}
+	}
+	rcu_read_unlock();
+}
+
 static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct hci_cb *cb;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
+
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->connect_cfm)
 			cb->connect_cfm(conn, status);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->connect_cfm_cb)
 		conn->connect_cfm_cb(conn, status);
@@ -1794,43 +1816,55 @@ static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 
 static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
 {
-	struct hci_cb *cb;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
+
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->disconn_cfm)
 			cb->disconn_cfm(conn, reason);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->disconn_cfm_cb)
 		conn->disconn_cfm_cb(conn, reason);
 }
 
-static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
+static inline void hci_security_cfm(struct hci_conn *conn, __u8 status,
+				    __u8 encrypt)
 {
-	struct hci_cb *cb;
-	__u8 encrypt;
-
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
-		return;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
 
-	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->security_cfm)
 			cb->security_cfm(conn, status, encrypt);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->security_cfm_cb)
 		conn->security_cfm_cb(conn, status);
 }
 
+static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
+{
+	__u8 encrypt;
+
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
+		return;
+
+	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
+
+	hci_security_cfm(conn, status, encrypt);
+}
+
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct hci_cb *cb;
 	__u8 encrypt;
 
 	if (conn->state == BT_CONFIG) {
@@ -1857,40 +1891,38 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 			conn->sec_level = conn->pending_sec_level;
 	}
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->security_cfm)
-			cb->security_cfm(conn, status, encrypt);
-	}
-	mutex_unlock(&hci_cb_list_lock);
-
-	if (conn->security_cfm_cb)
-		conn->security_cfm_cb(conn, status);
+	hci_security_cfm(conn, status, encrypt);
 }
 
 static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct hci_cb *cb;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
+
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->key_change_cfm)
 			cb->key_change_cfm(conn, status);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 }
 
 static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 								__u8 role)
 {
-	struct hci_cb *cb;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
+
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->role_switch_cfm)
 			cb->role_switch_cfm(conn, status, role);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 }
 
 static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3cd7c212375f..496dac042b9c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -58,7 +58,6 @@ DEFINE_RWLOCK(hci_dev_list_lock);
 
 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
-DEFINE_MUTEX(hci_cb_list_lock);
 
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
@@ -2978,9 +2977,7 @@ int hci_register_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_add_tail(&cb->list, &hci_cb_list);
-	mutex_unlock(&hci_cb_list_lock);
+	list_add_tail_rcu(&cb->list, &hci_cb_list);
 
 	return 0;
 }
@@ -2990,9 +2987,8 @@ int hci_unregister_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_del(&cb->list);
-	mutex_unlock(&hci_cb_list_lock);
+	list_del_rcu(&cb->list);
+	synchronize_rcu();
 
 	return 0;
 }
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index ff15d5192768..45dc39aa7618 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1575,6 +1575,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return lm;
 }
 
+static bool iso_match(struct hci_conn *hcon)
+{
+	return hcon->type == ISO_LINK || hcon->type == LE_LINK;
+}
+
 static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
 	if (hcon->type != ISO_LINK) {
@@ -1744,6 +1749,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 static struct hci_cb iso_cb = {
 	.name		= "ISO",
+	.match		= iso_match,
 	.connect_cfm	= iso_connect_cfm,
 	.disconn_cfm	= iso_disconn_cfm,
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 187c91843876..2a8051fae08c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8273,6 +8273,11 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 	return NULL;
 }
 
+static bool l2cap_match(struct hci_conn *hcon)
+{
+	return hcon->type == ACL_LINK || hcon->type == LE_LINK;
+}
+
 static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct hci_dev *hdev = hcon->hdev;
@@ -8280,9 +8285,6 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	struct l2cap_chan *pchan;
 	u8 dst_type;
 
-	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
-		return;
-
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
 	if (status) {
@@ -8347,9 +8349,6 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
 
 static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
-	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
-		return;
-
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	l2cap_conn_del(hcon, bt_to_errno(reason));
@@ -8637,6 +8636,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 static struct hci_cb l2cap_cb = {
 	.name		= "L2CAP",
+	.match		= l2cap_match,
 	.connect_cfm	= l2cap_connect_cfm,
 	.disconn_cfm	= l2cap_disconn_cfm,
 	.security_cfm	= l2cap_security_cfm,
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4f54c7df3a94..1686fa60e278 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2130,6 +2130,11 @@ static int rfcomm_run(void *unused)
 	return 0;
 }
 
+static bool rfcomm_match(struct hci_conn *hcon)
+{
+	return hcon->type == ACL_LINK;
+}
+
 static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 {
 	struct rfcomm_session *s;
@@ -2176,6 +2181,7 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 
 static struct hci_cb rfcomm_cb = {
 	.name		= "RFCOMM",
+	.match		= rfcomm_match,
 	.security_cfm	= rfcomm_security_cfm
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ad5afde17213..d62019e575a7 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1366,11 +1366,13 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return lm;
 }
 
-static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
+static bool sco_match(struct hci_conn *hcon)
 {
-	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
-		return;
+	return hcon->type == SCO_LINK || hcon->type == ESCO_LINK;
+}
 
+static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
+{
 	BT_DBG("hcon %p bdaddr %pMR status %u", hcon, &hcon->dst, status);
 
 	if (!status) {
@@ -1385,9 +1387,6 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 {
-	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
-		return;
-
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	sco_conn_del(hcon, bt_to_errno(reason));
@@ -1413,6 +1412,7 @@ void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 
 static struct hci_cb sco_cb = {
 	.name		= "SCO",
+	.match		= sco_match,
 	.connect_cfm	= sco_connect_cfm,
 	.disconn_cfm	= sco_disconn_cfm,
 };
-- 
2.39.5


