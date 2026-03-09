Return-Path: <stable+bounces-223512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOYcLv+HrmnKFgIAu9opvQ
	(envelope-from <stable+bounces-223512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 09:42:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A92359AB
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 09:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C11633006B54
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 08:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120353016F7;
	Mon,  9 Mar 2026 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="v/E3VhYV"
X-Original-To: stable@vger.kernel.org
Received: from out30-86.freemail.mail.aliyun.com (out30-86.freemail.mail.aliyun.com [115.124.30.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCC2BE02A;
	Mon,  9 Mar 2026 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045756; cv=none; b=gmeCVKyRgbnKlysT73EIZn3hmnsVEUC6VE6ZWUU4epSHgUlaidsa/yXTxrepwtzvWYYuvRXmUgbZ5jecB8gyTDILdvYYlwvFpPYS2BltyAo0ey5ezhYnCiWX2duIEUGruXjhLVCxGiXuw6bpVuNYt2PNTFik8Y/8wUAoM33cUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045756; c=relaxed/simple;
	bh=6qZm8FDoi8Ka9/n34PbtUoB0Wu9RtC4JHjJH7u4pRLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mdvakt5NbrIs8cwYQzWlH6KCvH4H5Rt4Bpc7YvhDByYHQG4NKelcqWxVRouvfNvvYjcW7ZXqUmRvERPKNSMbuVWm9e1sQpg+6nUrRdKBYmTH46Vpgsk/014PKW4GQKhGRH1wYaddLdQBH1oV0cwOM7wzVRth1SB2tZKaXs5e6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=v/E3VhYV; arc=none smtp.client-ip=115.124.30.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1773045750; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LVHx/hRP3JNPfNbpVACuLXX0P3JD1/lPT/FW39DBLzI=;
	b=v/E3VhYVgG/uqQlMqMoH09ZWEi0i3vozBwy6nzV4KDiui1/D9uyIgp/RYR8rnyYpdVNBn6GkfhCW5qnkNYp6Q8GvIv0eGGPl74ReaT6PViQmZG4GRCTxf8Wgf8VpMZanmaZXtwvfmdUFv9sFRTP1b7TzVhuQYeDa5bAh5XfU+Z0=
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X-W7qA4_1773045712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Mar 2026 16:42:29 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.1.y] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
Date: Mon,  9 Mar 2026 16:41:14 +0800
Message-Id: <20260309084114.3722155-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 584A92359AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,syzkaller.appspotmail.com,molgen.mpg.de,intel.com,aliyun.com];
	TAGGED_FROM(0.00)[bounces-223512-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[aliyun.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aliyun.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable,2faa4825e556199361f9];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,syzkaller.appspot.com:url,intel.com:email,aliyun.com:dkim,aliyun.com:email,aliyun.com:mid]
X-Rspamd-Action: no action

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 1d6123102e9fbedc8d25bf4731da6d513173e49e ]

syzbot reported use-after-free in vhci_flush() without repro. [0]

From the splat, a thread close()d a vhci file descriptor while
its device was being used by iotcl() on another thread.

Once the last fd refcnt is released, vhci_release() calls
hci_unregister_dev(), hci_free_dev(), and kfree() for struct
vhci_data, which is set to hci_dev->dev->driver_data.

The problem is that there is no synchronisation after unlinking
hdev from hci_dev_list in hci_unregister_dev().  There might be
another thread still accessing the hdev which was fetched before
the unlink operation.

We can use SRCU for such synchronisation.

Let's run hci_dev_reset() under SRCU and wait for its completion
in hci_unregister_dev().

Another option would be to restore hci_dev->destruct(), which was
removed in commit 587ae086f6e4 ("Bluetooth: Remove unused
hci-destruct cb").  However, this would not be a good solution, as
we should not run hci_unregister_dev() while there are in-flight
ioctl() requests, which could lead to another data-race KCSAN splat.

Note that other drivers seem to have the same problem, for exmaple,
virtbt_remove().

[0]:
BUG: KASAN: slab-use-after-free in skb_queue_empty_lockless include/linux/skbuff.h:1891 [inline]
BUG: KASAN: slab-use-after-free in skb_queue_purge_reason+0x99/0x360 net/core/skbuff.c:3937
Read of size 8 at addr ffff88807cb8d858 by task syz.1.219/6718

CPU: 1 UID: 0 PID: 6718 Comm: syz.1.219 Not tainted 6.16.0-rc1-syzkaller-00196-g08207f42d3ff #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 skb_queue_empty_lockless include/linux/skbuff.h:1891 [inline]
 skb_queue_purge_reason+0x99/0x360 net/core/skbuff.c:3937
 skb_queue_purge include/linux/skbuff.h:3368 [inline]
 vhci_flush+0x44/0x50 drivers/bluetooth/hci_vhci.c:69
 hci_dev_do_reset net/bluetooth/hci_core.c:552 [inline]
 hci_dev_reset+0x420/0x5c0 net/bluetooth/hci_core.c:592
 sock_do_ioctl+0xd9/0x300 net/socket.c:1190
 sock_ioctl+0x576/0x790 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf5b98e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf5c7b9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcf5bbb6160 RCX: 00007fcf5b98e929
RDX: 0000000000000000 RSI: 00000000400448cb RDI: 0000000000000009
RBP: 00007fcf5ba10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcf5bbb6160 R15: 00007ffd6353d528
 </TASK>

Allocated by task 6535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 vhci_open+0x57/0x360 drivers/bluetooth/hci_vhci.c:635
 misc_open+0x2bc/0x330 drivers/char/misc.c:161
 chrdev_open+0x4c9/0x5e0 fs/char_dev.c:414
 do_dentry_open+0xdf0/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 vhci_release+0xbc/0xd0 drivers/bluetooth/hci_vhci.c:671
 __fput+0x44c/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6ad/0x22e0 kernel/exit.c:955
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1104
 __do_sys_exit_group kernel/exit.c:1115 [inline]
 __se_sys_exit_group kernel/exit.c:1113 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1113
 x64_sys_call+0x21ba/0x21c0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807cb8d800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 88 bytes inside of
 freed 1024-byte region [ffff88807cb8d800, ffff88807cb8dc00)

Fixes: bf18c7118cf8 ("Bluetooth: vhci: Free driver_data on file release")
Reported-by: syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f62d64848fc4c7c30cd6
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Minor context conflict resolved. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 34 ++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b0a7ceb99eec..2775752a4e4f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,8 @@
 #include <linux/leds.h>
 #include <linux/rculist.h>
 #include <linux/spinlock.h>
+#include <linux/srcu.h>
+
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_sync.h>
 #include <net/bluetooth/hci_sock.h>
@@ -347,6 +349,7 @@ struct amp_assoc {
 
 struct hci_dev {
 	struct list_head list;
+	struct srcu_struct srcu;
 	struct mutex	lock;
 
 	const char	*name;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a26323400bf5..c6dec3c82f76 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -65,7 +65,7 @@ static DEFINE_IDA(hci_index_ida);
 
 /* Get HCI device by index.
  * Device is held on return. */
-struct hci_dev *hci_dev_get(int index)
+static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
 {
 	struct hci_dev *hdev = NULL, *d;
 
@@ -78,6 +78,8 @@ struct hci_dev *hci_dev_get(int index)
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (d->id == index) {
 			hdev = hci_dev_hold(d);
+			if (srcu_index)
+				*srcu_index = srcu_read_lock(&d->srcu);
 			break;
 		}
 	}
@@ -85,6 +87,22 @@ struct hci_dev *hci_dev_get(int index)
 	return hdev;
 }
 
+struct hci_dev *hci_dev_get(int index)
+{
+	return __hci_dev_get(index, NULL);
+}
+
+static struct hci_dev *hci_dev_get_srcu(int index, int *srcu_index)
+{
+	return __hci_dev_get(index, srcu_index);
+}
+
+static void hci_dev_put_srcu(struct hci_dev *hdev, int srcu_index)
+{
+	srcu_read_unlock(&hdev->srcu, srcu_index);
+	hci_dev_put(hdev);
+}
+
 /* ---- Inquiry support ---- */
 
 bool hci_discovery_active(struct hci_dev *hdev)
@@ -595,9 +613,9 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 int hci_dev_reset(__u16 dev)
 {
 	struct hci_dev *hdev;
-	int err;
+	int err, srcu_index;
 
-	hdev = hci_dev_get(dev);
+	hdev = hci_dev_get_srcu(dev, &srcu_index);
 	if (!hdev)
 		return -ENODEV;
 
@@ -619,7 +637,7 @@ int hci_dev_reset(__u16 dev)
 	err = hci_dev_do_reset(hdev);
 
 done:
-	hci_dev_put(hdev);
+	hci_dev_put_srcu(hdev, srcu_index);
 	return err;
 }
 
@@ -2435,6 +2453,11 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	if (!hdev)
 		return NULL;
 
+	if (init_srcu_struct(&hdev->srcu)) {
+		kfree(hdev);
+		return NULL;
+	}
+
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
@@ -2692,6 +2715,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	synchronize_srcu(&hdev->srcu);
+	cleanup_srcu_struct(&hdev->srcu);
+
 	cancel_work_sync(&hdev->rx_work);
 	cancel_work_sync(&hdev->cmd_work);
 	cancel_work_sync(&hdev->tx_work);
-- 
2.43.0


