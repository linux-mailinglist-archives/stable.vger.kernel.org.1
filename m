Return-Path: <stable+bounces-157198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC6AE52DD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E8E1B660CC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5463FD4;
	Mon, 23 Jun 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mR6qa4Ei"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A242056;
	Mon, 23 Jun 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715279; cv=none; b=FisSDTJueLik6k7Lwt4EfLfoWjthI0fHof4OjI9VU74ni1A/ICPiYxn2/+Vm6lD4YEWyv6zEB2R+KJfG2RG4pk/J9w82FwOhPqG1/2xEpaUhgNLHIJncrTId3/uzVjFpANPGSg4vFT/XltXSghtePL1ZoTcteKpf+PFFgN5QLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715279; c=relaxed/simple;
	bh=/YLc2R0FFRV5dXEO9Ewn+HdH+wp5K7+7laO3JzWb6sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1SFqGTL0Elj4+5ucTe7rMBrIWoa8suDBA5Lu7WC06rXqBN/oxFQDOAroZ1HooNXWK1NWNuSBGbSHAeQI4r21uJbzHjDT/HsfOkxqoqR9YwOR8R31cKREI2vYDsA2tMC+CkkmSOqLmCdsrDQZaiLr0duBCz9nBvctRtYdWV/zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mR6qa4Ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D21AC4CEED;
	Mon, 23 Jun 2025 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715279;
	bh=/YLc2R0FFRV5dXEO9Ewn+HdH+wp5K7+7laO3JzWb6sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mR6qa4Ei9W86Ek4mOJdzlNCZTZX9lvZ7Ai+kRC+64g8jBc7C9bfpvtjR6bdP1VESh
	 T1rC1UHdYGmd66h9TxM9joMjBvMZyPkkHFE+NEMyg6AjmXMtVL7/a3d6yfCs7bQfCl
	 SF8WYxa/Fa0PUP9pwZJOHq/vGW0pw8Dol5Nbwlyw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 225/508] Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
Date: Mon, 23 Jun 2025 15:04:30 +0200
Message-ID: <20250623130650.798554613@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit e6ed54e86aae9e4f7286ce8d5c73780f91b48d1c ]

This reworks MGMT_OP_REMOVE_ADV_MONITOR to not use mgmt_pending_add to
avoid crashes like bellow:

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5406
Read of size 8 at addr ffff88801c53f318 by task kworker/u5:5/5341

CPU: 0 UID: 0 PID: 5341 Comm: kworker/u5:5 Not tainted 6.15.0-syzkaller-10402-g4cb6c8af8591 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5406
 hci_cmd_sync_work+0x261/0x3a0 net/bluetooth/hci_sync.c:334
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5987:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4358
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 mgmt_pending_new+0x65/0x240 net/bluetooth/mgmt_util.c:252
 mgmt_pending_add+0x34/0x120 net/bluetooth/mgmt_util.c:279
 remove_adv_monitor+0x103/0x1b0 net/bluetooth/mgmt.c:5454
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 sock_write_iter+0x258/0x330 net/socket.c:1131
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5989:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kfree+0x18e/0x440 mm/slub.c:4841
 mgmt_pending_foreach+0xc9/0x120 net/bluetooth/mgmt_util.c:242
 mgmt_index_removed+0x10d/0x2f0 net/bluetooth/mgmt.c:9366
 hci_sock_bind+0xbe9/0x1000 net/bluetooth/hci_sock.c:1314
 __sys_bind_socket net/socket.c:1810 [inline]
 __sys_bind+0x2c3/0x3e0 net/socket.c:1841
 __do_sys_bind net/socket.c:1846 [inline]
 __se_sys_bind net/socket.c:1844 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1844
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 66bd095ab5d4 ("Bluetooth: advmon offload MSFT remove monitor")
Closes: https://syzkaller.appspot.com/bug?extid=feb0dc579bbe30a13190
Reported-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
Tested-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         |  4 +---
 net/bluetooth/mgmt.c             | 37 ++++++++++----------------------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d26b57e87f7f4..97cde23f56ecd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2125,7 +2125,6 @@ void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
 void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 			      u8 instance);
-void mgmt_adv_monitor_removed(struct hci_dev *hdev, u16 handle);
 int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
 void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 				  bdaddr_t *bdaddr, u8 addr_type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dc53e3078ba79..a26323400bf53 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1873,10 +1873,8 @@ void hci_free_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 	if (monitor->handle)
 		idr_remove(&hdev->adv_monitors_idr, monitor->handle);
 
-	if (monitor->state != ADV_MONITOR_STATE_NOT_REGISTERED) {
+	if (monitor->state != ADV_MONITOR_STATE_NOT_REGISTERED)
 		hdev->adv_monitors_cnt--;
-		mgmt_adv_monitor_removed(hdev, monitor->handle);
-	}
 
 	kfree(monitor);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 27bd8c8ddeb02..123cf62e3c000 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5236,24 +5236,14 @@ static void mgmt_adv_monitor_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADV_MONITOR_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
-void mgmt_adv_monitor_removed(struct hci_dev *hdev, u16 handle)
+static void mgmt_adv_monitor_removed(struct sock *sk, struct hci_dev *hdev,
+				     u16 handle)
 {
 	struct mgmt_ev_adv_monitor_removed ev;
-	struct mgmt_pending_cmd *cmd;
-	struct sock *sk_skip = NULL;
-	struct mgmt_cp_remove_adv_monitor *cp;
-
-	cmd = pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev);
-	if (cmd) {
-		cp = cmd->param;
-
-		if (cp->monitor_handle)
-			sk_skip = cmd->sk;
-	}
 
 	ev.monitor_handle = cpu_to_le16(handle);
 
-	mgmt_event(MGMT_EV_ADV_MONITOR_REMOVED, hdev, &ev, sizeof(ev), sk_skip);
+	mgmt_event(MGMT_EV_ADV_MONITOR_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
 static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
@@ -5355,8 +5345,7 @@ static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 
 	if (pending_find(MGMT_OP_SET_LE, hdev) ||
 	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR, hdev) ||
-	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev) ||
-	    pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev)) {
+	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev)) {
 		status = MGMT_STATUS_BUSY;
 		goto unlock;
 	}
@@ -5526,8 +5515,7 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_remove_adv_monitor *cp;
 
-	if (status == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+	if (status == -ECANCELED)
 		return;
 
 	hci_dev_lock(hdev);
@@ -5536,12 +5524,14 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 
 	rp.monitor_handle = cp->monitor_handle;
 
-	if (!status)
+	if (!status) {
+		mgmt_adv_monitor_removed(cmd->sk, hdev, cp->monitor_handle);
 		hci_update_passive_scan(hdev);
+	}
 
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
 			  mgmt_status(status), &rp, sizeof(rp));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 	bt_dev_dbg(hdev, "remove monitor %d complete, status %d",
@@ -5551,10 +5541,6 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-
-	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
-		return -ECANCELED;
-
 	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
 	u16 handle = __le16_to_cpu(cp->monitor_handle);
 
@@ -5573,14 +5559,13 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (pending_find(MGMT_OP_SET_LE, hdev) ||
-	    pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev) ||
 	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR, hdev) ||
 	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev)) {
 		status = MGMT_STATUS_BUSY;
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_ADV_MONITOR, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_REMOVE_ADV_MONITOR, hdev, data, len);
 	if (!cmd) {
 		status = MGMT_STATUS_NO_RESOURCES;
 		goto unlock;
@@ -5590,7 +5575,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 				  mgmt_remove_adv_monitor_complete);
 
 	if (err) {
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 
 		if (err == -ENOMEM)
 			status = MGMT_STATUS_NO_RESOURCES;
-- 
2.39.5




