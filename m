Return-Path: <stable+bounces-109457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56F4A15E8D
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B9B1886962
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630A61D517B;
	Sat, 18 Jan 2025 19:12:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EC1B0410;
	Sat, 18 Jan 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737227552; cv=none; b=d9LPOXIcW4k/lIgUWJi05I74VEbh5MiHQ43wTqELIh4lLqf2GOVTBxeh0oYT/Ys0lIaqNJksG8hVt1Bsm+9fYfgvfsLzGwVQRKkRA2mG2NyY07yULoUYzZ8UO0cQJHAewHdlrA1UiTsa+FE3MNDgJ2pcrw2ADVCG+aszlmVAv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737227552; c=relaxed/simple;
	bh=g1W0w1urS1qKulYmjYsh3uatYycfOaMB93IrBjtIgHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i8pTzaLL+anmsXaQ6BK2ly8bur32x/vmj4aAJYIjiulQ+6jjNF+dKQje7Axeig4jWYm2v2G4EcadHUfKI7M7/21xYyQvZXNQZc6m+PDaroe42fTgCvM8bo4eiG+8HbvFn9mR7aqAcSte4/rt2pjAU+Lr+oVFjixPg6i2Ax+xqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 2C7B820002;
	Sat, 18 Jan 2025 22:12:23 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1] Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync
Date: Sat, 18 Jan 2025 22:12:05 +0300
Message-Id: <20250118191205.7175-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 18fd04ad856df07733f5bb07e7f7168e7443d393 upstream.

This checks if the ACL connection remains valid as it could be destroyed
while hci_enhanced_setup_sync is pending on cmd_sync leading to the
following trace:

BUG: KASAN: slab-use-after-free in hci_enhanced_setup_sync+0x91b/0xa60
Read of size 1 at addr ffff888002328ffd by task kworker/u5:2/37

CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 6.11.0-rc6-01300-g810be445d8d6 #7099
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 ? hci_enhanced_setup_sync+0x91b/0xa60
 print_report+0x152/0x4c0
 ? hci_enhanced_setup_sync+0x91b/0xa60
 ? __virt_addr_valid+0x1fa/0x420
 ? hci_enhanced_setup_sync+0x91b/0xa60
 kasan_report+0xda/0x1b0
 ? hci_enhanced_setup_sync+0x91b/0xa60
 hci_enhanced_setup_sync+0x91b/0xa60
 ? __pfx_hci_enhanced_setup_sync+0x10/0x10
 ? __pfx___mutex_lock+0x10/0x10
 hci_cmd_sync_work+0x1c2/0x330
 process_one_work+0x7d9/0x1360
 ? __pfx_lock_acquire+0x10/0x10
 ? __pfx_process_one_work+0x10/0x10
 ? assign_work+0x167/0x240
 worker_thread+0x5b7/0xf60
 ? __kthread_parkme+0xac/0x1c0
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x293/0x360
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2f/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 34:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 __hci_conn_add+0x187/0x17d0
 hci_connect_sco+0x2e1/0xb90
 sco_sock_connect+0x2a2/0xb80
 __sys_connect+0x227/0x2a0
 __x64_sys_connect+0x6d/0xb0
 do_syscall_64+0x71/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 37:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x101/0x160
 kfree+0xd0/0x250
 device_release+0x9a/0x210
 kobject_put+0x151/0x280
 hci_conn_del+0x448/0xbf0
 hci_abort_conn_sync+0x46f/0x980
 hci_cmd_sync_work+0x1c2/0x330
 process_one_work+0x7d9/0x1360
 worker_thread+0x5b7/0xf60
 kthread+0x293/0x360
 ret_from_fork+0x2f/0x70
 ret_from_fork_asm+0x1a/0x30

Cc: stable@vger.kernel.org
Fixes: e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to hci_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[kovalev: inline `hci_conn_valid()` functionality directly into
`hci_enhanced_setup_sync()` to avoid dependencies during backporting.]
Link: https://lore.kernel.org/all/2024101446-approve-rants-581d@gregkh/
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
Backport to fix CVE-2024-50029
Link: https://www.cve.org/CVERecord/?id=CVE-2024-50029
---
 net/bluetooth/hci_conn.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 49b9dd21b73ea6..3906324b99d41a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -390,9 +390,22 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	__u16 handle = conn_handle->handle;
 	struct hci_cp_enhanced_setup_sync_conn cp;
 	const struct sco_param *param;
+	struct hci_conn_hash *hdev_conn_hash = &hdev->conn_hash;
+	struct hci_conn  *hdev_conn;
 
 	kfree(conn_handle);
 
+	rcu_read_lock();
+	list_for_each_entry_rcu(hdev_conn, &hdev_conn_hash->list, list) {
+		if (hdev_conn == conn) {
+			rcu_read_unlock();
+			goto conn_valid;
+		}
+	}
+	rcu_read_unlock();
+	return -ECANCELED;
+
+conn_valid:
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	configure_datapath_sync(hdev, &conn->codec);
-- 
2.33.8


