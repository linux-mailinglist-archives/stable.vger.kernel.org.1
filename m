Return-Path: <stable+bounces-162901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827A9B06017
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51E73B2753
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65682E3B02;
	Tue, 15 Jul 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B/+hYKfX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2126D4F2;
	Tue, 15 Jul 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587772; cv=none; b=L0hhig9GrLlttgXB3EUESueYdpJ5KvJoD8DXGH6JyXvDISJIhKwdmeff65fAKlxrS1fJR2OwwhvaW7hihbH+G3m+4sP0akFoBzffBJmQs1vIM+pjxr3XIj7wwBR2+4Q8FBRIiA1mWpTiD/C/Q3C2JwOkXMnPc4HfcykbFFP8e7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587772; c=relaxed/simple;
	bh=WDqMVnM9EVJXgvwMYIDDqrvrl0PB7mKxkkxynGaQ+6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQy9qnvPmxzBU005leJMjOKueooyvzC0wQxPwxBTS9Fcx+3e7UcUAA+nW/QbNMMw91XNTJWx9iuF+cmiN7/1LA9HjBn9EacyfXZOJsEgUsATjQVzNz3XRUGWoiiREKvhucCnjFlaJq2R0OM/bzK+OObrDSQP17PC939GSpY3ugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B/+hYKfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB253C4CEF1;
	Tue, 15 Jul 2025 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587772;
	bh=WDqMVnM9EVJXgvwMYIDDqrvrl0PB7mKxkkxynGaQ+6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/+hYKfXO7eKmRIUCT+O6ZbP73vZafgG+CWzGbwMXXtffqVU2aEpEJ8I4hoaw6iHP
	 V1J9tiU5vzM/yYmRNV9Cb8Yh+fHB7x3zzK9oOHu+7+uD/aDlxLxV314u+2pURBbILH
	 qAITqLsl18keJTcYhBxAL0zBrsBBm20dKFNavoGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d333febcf8f4bc5f6110@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 138/208] tipc: Fix use-after-free in tipc_conn_close().
Date: Tue, 15 Jul 2025 15:14:07 +0200
Message-ID: <20250715130816.458803791@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 667eeab4999e981c96b447a4df5f20bdf5c26f13 ]

syzbot reported a null-ptr-deref in tipc_conn_close() during netns
dismantle. [0]

tipc_topsrv_stop() iterates tipc_net(net)->topsrv->conn_idr and calls
tipc_conn_close() for each tipc_conn.

The problem is that tipc_conn_close() is called after releasing the
IDR lock.

At the same time, there might be tipc_conn_recv_work() running and it
could call tipc_conn_close() for the same tipc_conn and release its
last ->kref.

Once we release the IDR lock in tipc_topsrv_stop(), there is no
guarantee that the tipc_conn is alive.

Let's hold the ref before releasing the lock and put the ref after
tipc_conn_close() in tipc_topsrv_stop().

[0]:
BUG: KASAN: use-after-free in tipc_conn_close+0x122/0x140 net/tipc/topsrv.c:165
Read of size 8 at addr ffff888099305a08 by task kworker/u4:3/435

CPU: 0 PID: 435 Comm: kworker/u4:3 Not tainted 4.19.204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fc/0x2ef lib/dump_stack.c:118
 print_address_description.cold+0x54/0x219 mm/kasan/report.c:256
 kasan_report_error.cold+0x8a/0x1b9 mm/kasan/report.c:354
 kasan_report mm/kasan/report.c:412 [inline]
 __asan_report_load8_noabort+0x88/0x90 mm/kasan/report.c:433
 tipc_conn_close+0x122/0x140 net/tipc/topsrv.c:165
 tipc_topsrv_stop net/tipc/topsrv.c:701 [inline]
 tipc_topsrv_exit_net+0x27b/0x5c0 net/tipc/topsrv.c:722
 ops_exit_list+0xa5/0x150 net/core/net_namespace.c:153
 cleanup_net+0x3b4/0x8b0 net/core/net_namespace.c:553
 process_one_work+0x864/0x1570 kernel/workqueue.c:2153
 worker_thread+0x64c/0x1130 kernel/workqueue.c:2296
 kthread+0x33f/0x460 kernel/kthread.c:259
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:415

Allocated by task 23:
 kmem_cache_alloc_trace+0x12f/0x380 mm/slab.c:3625
 kmalloc include/linux/slab.h:515 [inline]
 kzalloc include/linux/slab.h:709 [inline]
 tipc_conn_alloc+0x43/0x4f0 net/tipc/topsrv.c:192
 tipc_topsrv_accept+0x1b5/0x280 net/tipc/topsrv.c:470
 process_one_work+0x864/0x1570 kernel/workqueue.c:2153
 worker_thread+0x64c/0x1130 kernel/workqueue.c:2296
 kthread+0x33f/0x460 kernel/kthread.c:259
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:415

Freed by task 23:
 __cache_free mm/slab.c:3503 [inline]
 kfree+0xcc/0x210 mm/slab.c:3822
 tipc_conn_kref_release net/tipc/topsrv.c:150 [inline]
 kref_put include/linux/kref.h:70 [inline]
 conn_put+0x2cd/0x3a0 net/tipc/topsrv.c:155
 process_one_work+0x864/0x1570 kernel/workqueue.c:2153
 worker_thread+0x64c/0x1130 kernel/workqueue.c:2296
 kthread+0x33f/0x460 kernel/kthread.c:259
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:415

The buggy address belongs to the object at ffff888099305a00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 512-byte region [ffff888099305a00, ffff888099305c00)
The buggy address belongs to the page:
page:ffffea000264c140 count:1 mapcount:0 mapping:ffff88813bff0940 index:0x0
flags: 0xfff00000000100(slab)
raw: 00fff00000000100 ffffea00028b6b88 ffffea0002cd2b08 ffff88813bff0940
raw: 0000000000000000 ffff888099305000 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888099305900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888099305980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888099305a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888099305a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888099305b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: c5fa7b3cf3cb ("tipc: introduce new TIPC server infrastructure")
Reported-by: syzbot+d333febcf8f4bc5f6110@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=27169a847a70550d17be
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Link: https://patch.msgid.link/20250702014350.692213-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/topsrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 89d8a2bd30cd0..d914c5eb25178 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -699,8 +699,10 @@ static void tipc_topsrv_stop(struct net *net)
 	for (id = 0; srv->idr_in_use; id++) {
 		con = idr_find(&srv->conn_idr, id);
 		if (con) {
+			conn_get(con);
 			spin_unlock_bh(&srv->idr_lock);
 			tipc_conn_close(con);
+			conn_put(con);
 			spin_lock_bh(&srv->idr_lock);
 		}
 	}
-- 
2.39.5




