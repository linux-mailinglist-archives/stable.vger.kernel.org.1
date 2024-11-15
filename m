Return-Path: <stable+bounces-93365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE59CD8D9
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FD91F2344F
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125571885AA;
	Fri, 15 Nov 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9UwswSp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4973185949;
	Fri, 15 Nov 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653678; cv=none; b=XsV75pWmqeMiRLFGn9ceKeuOY9Jl22iKpmjrhC9WH9L4GSN/DsgcZLglmyIxEKQjWpk90s+YWYteIJtVbOX7bgqL0k7kO8OBWcRzaVD0A2S1kW0zxUHugctB/ZqzlX+9gAiUIqAIDYLWq1vAWY7sGv/vyLMjTPsAPeUxy1EqXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653678; c=relaxed/simple;
	bh=9g5Hs3P/rNgbdqOTGaWlfwjS6MPgesxnbX7ynAhy55M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqUu+XCahbFsZxedMZb//ghMM7C/D+C83gen8tT/IuS+T6gw5W3HY8rRL7poCVb7y2iWMCBinSQM593MN7vy9xUws6c2qFCeC50Thb+iUxKVafR97uVzZxFb+9dapQ6haASIXcF0Q49Xof93LiS0YxQf6U58+PzX/K2QEtmdDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9UwswSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6738C4CECF;
	Fri, 15 Nov 2024 06:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653678;
	bh=9g5Hs3P/rNgbdqOTGaWlfwjS6MPgesxnbX7ynAhy55M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9UwswSpabks4Mxlz1XBGGP1maZKjRxSyc3GYyQNwPANUmh0ampK+zy9pPRUBGztA
	 mv5V1F6VBxcWQDMrqBFfLbhQajyPH3KzIQulgllYBpPFaAzUrTw+TglMO8ELmd39QF
	 EUTNTt60EYj+5fmGCZZH5hpP5OXKWXZyY2EJXf9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Xiangyu Chen <xiangyu.chen@windriver.com>
Subject: [PATCH 6.1 35/39] Bluetooth: L2CAP: Fix uaf in l2cap_connect
Date: Fri, 15 Nov 2024 07:38:45 +0100
Message-ID: <20241115063723.874443364@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
References: <20241115063722.599985562@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 333b4fd11e89b29c84c269123f871883a30be586 upstream.

[Syzbot reported]
BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
Read of size 8 at addr ffff8880241e9800 by task kworker/u9:0/54

CPU: 0 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-00268-g788220eee30d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
 l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
...

Freed by task 5245:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 l2cap_conn_free net/bluetooth/l2cap_core.c:1810 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1822 [inline]
 l2cap_conn_del+0x59d/0x730 net/bluetooth/l2cap_core.c:1802
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
Fixes: 7b064edae38d ("Bluetooth: Fix authentication if acl data comes before remote feature evt")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: Modified to bp this commit to fix CVE-2024-49950]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_core.c   |    2 ++
 net/bluetooth/hci_event.c  |    2 +-
 net/bluetooth/l2cap_core.c |    9 ---------
 3 files changed, 3 insertions(+), 10 deletions(-)

--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3846,6 +3846,8 @@ static void hci_acldata_packet(struct hc
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_device_connected(hdev, conn, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3789,7 +3789,7 @@ static void hci_remote_features_evt(stru
 		goto unlock;
 	}
 
-	if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+	if (!ev->status) {
 		struct hci_cp_remote_name_req cp;
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, &conn->dst);
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4300,18 +4300,9 @@ sendresp:
 static int l2cap_connect_req(struct l2cap_conn *conn,
 			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-	struct hci_conn *hcon = conn->hcon;
-
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	hci_dev_lock(hdev);
-	if (hci_dev_test_flag(hdev, HCI_MGMT) &&
-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
-		mgmt_device_connected(hdev, hcon, NULL, 0);
-	hci_dev_unlock(hdev);
-
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
 	return 0;
 }



