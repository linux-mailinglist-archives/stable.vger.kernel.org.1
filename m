Return-Path: <stable+bounces-102737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B600A9EF55E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7ADC178860
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B7226171;
	Thu, 12 Dec 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QhHfvO0E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA8226165;
	Thu, 12 Dec 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022310; cv=none; b=m0Nrdr3T+8nhlMZYLyN3egNlJkm7qHApp4pBZzHCClWc5acYU3eJa27jzHASJlX+nb5wOkz6iq3k6CWK8esMv6m68q3EITjIll05wP5XOVFf2ZCu/kd83f4o5L55GPS2guv3xh8AhJL2Xr/F8wSMXBNxDe0drcYKrFLg3IwY0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022310; c=relaxed/simple;
	bh=XZE0Rrpo6TNx1KigY0Cy6qW/+VaZmiYYqWvrdmuGRfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePaaxtMc2CFGPKouUhiEaAn/iDBWl1t4ZmhbOkGNIRy9cZRpkbuHynlUR8QoZJ0ajGpjsPndXGqYPw5T8ECe/eqWGDbnWOq2pa7zrCrUznXL93zYOvJyYjKw+lbVWt1ceLHO3fnLgD6TNL9ubCiTNkhsQXImkGcgqwnKNUzO+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QhHfvO0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83860C4CECE;
	Thu, 12 Dec 2024 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022309;
	bh=XZE0Rrpo6TNx1KigY0Cy6qW/+VaZmiYYqWvrdmuGRfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhHfvO0EifIcXKSp58frG0Ta1pQYi7y012g1TE0Jb1tjFXWAMqFxoAiaolGIE1cL2
	 7F8KXG/VOKXDfEmheO8v5hQtEeHX1ZwNVRFgQyexKlz3h/qk9RS0lEERLq21uE95JO
	 7V/0SArxBgsxTyu7YMAeiYKWLIBZ8TSq+k6uMm8A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 205/565] Bluetooth: fix use-after-free in device_for_each_child()
Date: Thu, 12 Dec 2024 15:56:40 +0100
Message-ID: <20241212144319.593827544@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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

Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Tested-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
Fixes: a85fb91e3d72 ("Bluetooth: Fix double free in hci_conn_cleanup")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sysfs.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 633b82d542728..cc7d4a8ed8ce2 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -19,16 +19,6 @@ static const struct device_type bt_link = {
 	.release = bt_link_release,
 };
 
-/*
- * The rfcomm tty device will possibly retain even when conn
- * is down, and sysfs doesn't support move zombie device,
- * so we should move the device before conn device is destroyed.
- */
-static int __match_tty(struct device *dev, void *data)
-{
-	return !strncmp(dev_name(dev), "rfcomm", 6);
-}
-
 void hci_conn_init_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -71,10 +61,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		return;
 	}
 
+	/* If there are devices using the connection as parent reset it to NULL
+	 * before unregistering the device.
+	 */
 	while (1) {
 		struct device *dev;
 
-		dev = device_find_child(&conn->dev, NULL, __match_tty);
+		dev = device_find_any_child(&conn->dev);
 		if (!dev)
 			break;
 		device_move(dev, NULL, DPM_ORDER_DEV_LAST);
-- 
2.43.0




