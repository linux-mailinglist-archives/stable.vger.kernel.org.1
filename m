Return-Path: <stable+bounces-83804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFFB99C9DA
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73C2B21AED
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C61A00CB;
	Mon, 14 Oct 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHhZ7x8h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBD158A19
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908090; cv=none; b=sK5lXv4UBpZ3YLJLN4Tod5eghG79OP5NDOIbtL7hsLZz1y++r3FCHgT3Tg6hT0nWDpJwxsvPfsGNyME/1U5c0rRFS6RJcZ2EH93CVd6/kSKBIeadwAkFbEixBDjoQphU2oalFxeIvoe0sSSWwMGlSrT1D8jislyogerXzpjwzyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908090; c=relaxed/simple;
	bh=/GTZ9p8qfbSCPlkSw2CIDHZk5Q8NdTCpoZmn3skPumA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OxN7KKf/gWspEJJyfKmM0aa22d6PZlib1V++dNjtWeykAwykSpY2U85G1cTxe0XtL/TYKzLkOZCTpmxTamEJCGZEFZ8GzzZFTDRRecnT5sid5piHDMXf8LoUhxs/nKdrxqCaYJoIl996Waq+Ah7lG4jcTL9N90JLtEyL3TMreWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHhZ7x8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB61DC4CEC6;
	Mon, 14 Oct 2024 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728908090;
	bh=/GTZ9p8qfbSCPlkSw2CIDHZk5Q8NdTCpoZmn3skPumA=;
	h=Subject:To:Cc:From:Date:From;
	b=KHhZ7x8hp8/B2YovIu6WvjU71eJ410WPP+lCx45S7TrkQgwrliK7vUJl3aocPBzLA
	 ubbPy1qRjUbyC8gSZ+yAQVxkNRD3qU4HIaAd3IuI90D/UjZPKtwVhgxrE9H8vy5L2v
	 LWJZxzrI/eMDDqil63Vd2NMbP/2JzcT4ftzBOnqw=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync" failed to apply to 6.1-stable tree
To: luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 14:14:47 +0200
Message-ID: <2024101446-approve-rants-581d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 18fd04ad856df07733f5bb07e7f7168e7443d393
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101446-approve-rants-581d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

18fd04ad856d ("Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18fd04ad856df07733f5bb07e7f7168e7443d393 Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Wed, 2 Oct 2024 11:17:26 -0400
Subject: [PATCH] Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync

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

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d083117ee36c..c4c74b82ed21 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -289,6 +289,9 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 
 	kfree(conn_handle);
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	configure_datapath_sync(hdev, &conn->codec);


