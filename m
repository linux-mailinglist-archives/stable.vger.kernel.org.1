Return-Path: <stable+bounces-169495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72BEB25A8D
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 06:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04157A7327
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 04:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC9B20C494;
	Thu, 14 Aug 2025 04:39:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4D72612
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755146356; cv=none; b=sWGfV9o/DXftz+7fPIUGGtDBmWEtI4JC0z6PuXefVh2lL39dIgCAnem2ZAimCk7bOX8wnXO6hLYhQWGABc1fKywHxL03hPF32LzgrsfNwjinKR/35IZMf6RgKETBzGuU5qO9moMsyYYEg6zgDchjSIj0s/+15NDHgDNBegb1DFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755146356; c=relaxed/simple;
	bh=t1hh/Jw0YAv0hUSy9t/Xv7c8RObia1W8amBTjd34shY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BMWNNODqRn8QzTaRvIk8m61+Br3FPLFVzQ/sEaROLnhLeAN1jNmDSVwId9+RqRKyx25qpk9JNVUSbVFQCRWTeh4h6yJr2E3YXeRcjB0f0c7rrPszYNWRdPgL3p+uzn5+Aue+lHRSh08ixu4UphxBjb6MqoqLQACkb0i7I1yPMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
	by 156.147.23.52 with ESMTP; 14 Aug 2025 13:39:04 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.151 with ESMTP; 14 Aug 2025 13:39:04 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Chanho Min <chanho.min@lge.com>
Subject: [PATCH] Bluetooth: fix use-after-free in device_for_each_child()
Date: Thu, 14 Aug 2025 13:38:32 +0900
Message-Id: <20250814043832.8767-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 27aabf27fd014ae037cc179c61b0bee7cff55b3d ]

Syzbot has reported the following KASAN splat:

BUG: KASAN: slab-use-after-free in device_for_each_child+0x18f/0x1a0
Read of size 8 at addr ffff88801f605308 by task kbnepd bnep0/4980

CPU: 0 UID: 0 PID: 4980 Comm: kbnepd bnep0 Not tainted 6.12.0-rc4-00161-gae90f6a6170d #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x100/0x190
 ? device_for_each_child+0x18f/0x1a0
 print_report+0x13a/0x4cb
 ? __virt_addr_valid+0x5e/0x590
 ? __phys_addr+0xc6/0x150
 ? device_for_each_child+0x18f/0x1a0
 kasan_report+0xda/0x110
 ? device_for_each_child+0x18f/0x1a0
 ? __pfx_dev_memalloc_noio+0x10/0x10
 device_for_each_child+0x18f/0x1a0
 ? __pfx_device_for_each_child+0x10/0x10
 pm_runtime_set_memalloc_noio+0xf2/0x180
 netdev_unregister_kobject+0x1ed/0x270
 unregister_netdevice_many_notify+0x123c/0x1d80
 ? __mutex_trylock_common+0xde/0x250
 ? __pfx_unregister_netdevice_many_notify+0x10/0x10
 ? trace_contention_end+0xe6/0x140
 ? __mutex_lock+0x4e7/0x8f0
 ? __pfx_lock_acquire.part.0+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 ? unregister_netdev+0x12/0x30
 unregister_netdevice_queue+0x30d/0x3f0
 ? __pfx_unregister_netdevice_queue+0x10/0x10
 ? __pfx_down_write+0x10/0x10
 unregister_netdev+0x1c/0x30
 bnep_session+0x1fb3/0x2ab0
 ? __pfx_bnep_session+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_woken_wake_function+0x10/0x10
 ? __kthread_parkme+0x132/0x200
 ? __pfx_bnep_session+0x10/0x10
 ? kthread+0x13a/0x370
 ? __pfx_bnep_session+0x10/0x10
 kthread+0x2b7/0x370
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x48/0x80
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 4974:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 __kmalloc_noprof+0x1d1/0x440
 hci_alloc_dev_priv+0x1d/0x2820
 __vhci_create_device+0xef/0x7d0
 vhci_write+0x2c7/0x480
 vfs_write+0x6a0/0xfc0
 ksys_write+0x12f/0x260
 do_syscall_64+0xc7/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 4979:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x4f/0x70
 kfree+0x141/0x490
 hci_release_dev+0x4d9/0x600
 bt_host_release+0x6a/0xb0
 device_release+0xa4/0x240
 kobject_put+0x1ec/0x5a0
 put_device+0x1f/0x30
 vhci_release+0x81/0xf0
 __fput+0x3f6/0xb30
 task_work_run+0x151/0x250
 do_exit+0xa79/0x2c30
 do_group_exit+0xd5/0x2a0
 get_signal+0x1fcd/0x2210
 arch_do_signal_or_restart+0x93/0x780
 syscall_exit_to_user_mode+0x140/0x290
 do_syscall_64+0xd4/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

In 'hci_conn_del_sysfs()', 'device_unregister()' may be called when
an underlying (kobject) reference counter is greater than 1. This
means that reparenting (happened when the device is actually freed)
is delayed and, during that delay, parent controller device (hciX)
may be deleted. Since the latter may create a dangling pointer to
freed parent, avoid that scenario by reparenting to NULL explicitly.

Cc: stable@vger.kernel.org # 5.4
Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Tested-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
Fixes: a85fb91e3d72 ("Bluetooth: Fix double free in hci_conn_cleanup")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ chanho: Backported from v5.10.y to v5.4.y. device_find_any_child() is not
supported in v5.4.y, so changed to use device_find_child() with __match_any ]
Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sysfs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 266112c960ee8..f8e7b0ba2d273 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -19,14 +19,9 @@ static const struct device_type bt_link = {
 	.release = bt_link_release,
 };
 
-/*
- * The rfcomm tty device will possibly retain even when conn
- * is down, and sysfs doesn't support move zombie device,
- * so we should move the device before conn device is destroyed.
- */
-static int __match_tty(struct device *dev, void *data)
+static int __match_any(struct device *dev, void *unused)
 {
-	return !strncmp(dev_name(dev), "rfcomm", 6);
+	return 1;
 }
 
 void hci_conn_init_sysfs(struct hci_conn *conn)
@@ -71,10 +66,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		return;
 	}
 
+	/* If there are devices using the connection as parent reset it to NULL
+	 * before unregistering the device.
+	 */
 	while (1) {
 		struct device *dev;
-
-		dev = device_find_child(&conn->dev, NULL, __match_tty);
+		dev = device_find_child(&conn->dev, NULL, __match_any);
 		if (!dev)
 			break;
 		device_move(dev, NULL, DPM_ORDER_DEV_LAST);

