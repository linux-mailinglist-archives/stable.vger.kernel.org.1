Return-Path: <stable+bounces-182345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F1BAD7CA
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3319B163DCA
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363DD27C872;
	Tue, 30 Sep 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NmeMI1gI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D01F152D;
	Tue, 30 Sep 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244640; cv=none; b=mMnj6XY8J46suRbje+iJdj4aU6IceZGSw14Xm4oRV4u64tMwQUsPjMOQZRHnTBcoFQRHIQgpZoALcVZ8bWWmBEfkCseOrgkh7R/cpXn2eB6/bnQ1/AxJWibrRxy0OZGH6oqnoAMrGs4kFyJHPES5Q3BTN8BydAxq0XUke1L5Dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244640; c=relaxed/simple;
	bh=2oKvDNMp35RW1ZuMx1p8ZQZBpkYuABr/wWUdJTiTwU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtaGaCh8XgIJrqwH+27Ss89gj1s3IklbhmA+jBTVGG0/7LxNAyCHX87DlAGmtCNeJekBTund3q0fGjHaOCxrN3LpZ6UYqNbjrJGBDdfv2pdrEG5iWd6etLa2jWTFKu4KQ0h1ReUUvt6378+O1CViMcWEF23HjDSrLsFckuxpMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NmeMI1gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4A2C4CEF0;
	Tue, 30 Sep 2025 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244639;
	bh=2oKvDNMp35RW1ZuMx1p8ZQZBpkYuABr/wWUdJTiTwU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmeMI1gInqDEfYJWIXgX19ZMgYFCU8Rf41MtxsZ/Yf0nDeAAOuYxRUBRcg0CsWdhO
	 xvH5vLfkgyI8/NtQQHsbmuZMQXPCqW7Padl4/kntDEddHabxvIRRqXfMxPw9rhZpvj
	 A4MWLA/YXg3B4oirhCO0Tj5Siin3NhjdtHRxtnsA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Junvyyang, Tencent Zhuque Lab" <zhuque@tencent.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 070/143] Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
Date: Tue, 30 Sep 2025 16:46:34 +0200
Message-ID: <20250930143834.027454270@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 9e622804d57e2d08f0271200606bd1270f75126f ]

This fixes the following UFA in hci_acl_create_conn_sync where a
connection still pending is command submission (conn->state == BT_OPEN)
maybe freed, also since this also can happen with the likes of
hci_le_create_conn_sync fix it as well:

BUG: KASAN: slab-use-after-free in hci_acl_create_conn_sync+0x5ef/0x790 net/bluetooth/hci_sync.c:6861
Write of size 2 at addr ffff88805ffcc038 by task kworker/u11:2/9541

CPU: 1 UID: 0 PID: 9541 Comm: kworker/u11:2 Not tainted 6.16.0-rc7 #3 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Workqueue: hci3 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 hci_acl_create_conn_sync+0x5ef/0x790 net/bluetooth/hci_sync.c:6861
 hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16-rc7/arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 123736:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __hci_conn_add+0x233/0x1b30 net/bluetooth/hci_conn.c:939
 hci_conn_add_unset net/bluetooth/hci_conn.c:1051 [inline]
 hci_connect_acl+0x16c/0x4e0 net/bluetooth/hci_conn.c:1634
 pair_device+0x418/0xa70 net/bluetooth/mgmt.c:3556
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 sock_write_iter+0x258/0x330 net/socket.c:1131
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x54b/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 103680:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 device_release+0x9c/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 hci_conn_cleanup net/bluetooth/hci_conn.c:175 [inline]
 hci_conn_del+0x8ff/0xcb0 net/bluetooth/hci_conn.c:1173
 hci_conn_complete_evt+0x3c7/0x1040 net/bluetooth/hci_event.c:3199
 hci_event_func net/bluetooth/hci_event.c:7477 [inline]
 hci_event_packet+0x7e0/0x1200 net/bluetooth/hci_event.c:7531
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4070
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16-rc7/arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2183
 __queue_work+0xbd9/0xfe0 kernel/workqueue.c:2345
 queue_delayed_work_on+0x18b/0x280 kernel/workqueue.c:2561
 pairing_complete+0x1e7/0x2b0 net/bluetooth/mgmt.c:3451
 pairing_complete_cb+0x1ac/0x230 net/bluetooth/mgmt.c:3487
 hci_connect_cfm include/net/bluetooth/hci_core.h:2064 [inline]
 hci_conn_failed+0x24d/0x310 net/bluetooth/hci_conn.c:1275
 hci_conn_complete_evt+0x3c7/0x1040 net/bluetooth/hci_event.c:3199
 hci_event_func net/bluetooth/hci_event.c:7477 [inline]
 hci_event_packet+0x7e0/0x1200 net/bluetooth/hci_event.c:7531
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4070
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16-rc7/arch/x86/entry/entry_64.S:245

Fixes: aef2aa4fa98e ("Bluetooth: hci_event: Fix creating hci_conn object on error status")
Reported-by: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h | 21 +++++++++++++++++++++
 net/bluetooth/hci_event.c        | 26 +++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 439bc124ce709..1347ae13dd0a1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1245,6 +1245,27 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_role(struct hci_dev *hdev,
+							 __u8 type, __u8 role,
+							 bdaddr_t *ba)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && c->role == role && !bacmp(&c->dst, ba)) {
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
 static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 						       bdaddr_t *ba,
 						       __u8 ba_type)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d3d9c3cbd9293..2ef5b3004197b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3087,8 +3087,18 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then it must be receiver/slave role.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-	if (!conn) {
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
@@ -5638,8 +5648,18 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
-	if (!conn) {
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then use the role to create a new object.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
+	conn = hci_conn_hash_lookup_role(hdev, LE_LINK, role, bdaddr);
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
-- 
2.51.0




