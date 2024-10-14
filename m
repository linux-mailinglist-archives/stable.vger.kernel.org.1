Return-Path: <stable+bounces-83991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED099CD92
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B81B221E6
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7051ABEA5;
	Mon, 14 Oct 2024 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4MqpsLC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B914A614;
	Mon, 14 Oct 2024 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916431; cv=none; b=Vc0n3Tb2m2EccUu2nD5gVOoq59RbOOBMDg5zS7hikFY8Vr79AFHOqkdeQlYB3t3MSK2Dwpo36bETYaq2S2fY5z4orTkNue9aOOMdDC+19oT2aBpO6ndJOVRcA3hxzOxTiRz1k8vIA05Pj18RUgzpV7FlJNeAcwXeM+9egJDXv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916431; c=relaxed/simple;
	bh=qc25ACoiQQcTSnHjBWCqOG8Y0Xjpmqx8D4gFF7bwICw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbZQjgbANvMBWogrXEDTxiTtWtJuqt1cvIZH3rP+4exBhYS25ZvxENRIskdO6L90uE470wjr2mr0VLe4/0tF+VNbO3gHpJOQ5Ip8PRvdh9yd7L6Tc3E1re6APPT3fJNwHucn+yxQiJqZeFs9eDJRyoYiQre1lmZ4SJNQNmRGUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4MqpsLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BC6C4CEC3;
	Mon, 14 Oct 2024 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916431;
	bh=qc25ACoiQQcTSnHjBWCqOG8Y0Xjpmqx8D4gFF7bwICw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4MqpsLCEjb+sMwrNMi1t/KOVd4biey0fK9CodKWEBQZQg5Pp+hvVmen04Z1UsE/V
	 2NxM0CUE1MPuzGHBeW5JK7JvSTW+kIaOufgQlMjNtV6eYTqfUIyrjeE0MZD/PguTle
	 aYOiY1pGZ446YE9vpyD84M/KmsTIFwMp7X6hEggA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.11 181/214] Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync
Date: Mon, 14 Oct 2024 16:20:44 +0200
Message-ID: <20241014141052.045236167@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_conn.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -289,6 +289,9 @@ static int hci_enhanced_setup_sync(struc
 
 	kfree(conn_handle);
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	configure_datapath_sync(hdev, &conn->codec);



