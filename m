Return-Path: <stable+bounces-137257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73984AA1261
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6B416C0F3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48590215060;
	Tue, 29 Apr 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rMGbM2ML"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535224113C;
	Tue, 29 Apr 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945529; cv=none; b=ktJnCCWh9hiSDVFBm00QcD0OtUgo/cgyb7nxcStmedHfPCpmeBDWbiiET4UvibIzZu7fWcbNQhtD/9cMjL4O0+E7QXxzK3xIOYgwhTmVR9hK/RUzwSnz/FI5Hbt8L5zQoAwpMy/jlvmWlBoCqui1W8hMUARfuWitDCvHVpr3FYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945529; c=relaxed/simple;
	bh=eG5nbBndONWtHhGyluz0aOQHWEc/wpZo7J8TePD8qG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBlffSXnNJP9nP2qK2vCSI6P+sZU+mensi1LAQS8Qh/bs/i2OD/Vscas87O/IvTscVgGcS6WdshyUg7WY1Vx46eo3rwxC5ptPTYQTuZGRvnwNjJhFjVc63M3IW9QtfQTmnrY6l1rTPIdC7aajEkApRiiupw4IOB7+OLt2Q6/QMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rMGbM2ML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F369C4CEE3;
	Tue, 29 Apr 2025 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945528;
	bh=eG5nbBndONWtHhGyluz0aOQHWEc/wpZo7J8TePD8qG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMGbM2ML3I6p7DeA8xYifSVpBosj8MVX/ZqD4EwCkkyIq8Pj1I0OMlMILsgbnk9xN
	 2rGf0+aJw54n6aApsdb1RtiK8m61/ZTd+gfOlwdb10X8lBdclrIv+kB8/ir5GsP+RQ
	 CoG3hNJcVg8mtILZ2ZA0UhxMVBs2RI17cH6X6aUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+ed60da8d686dc709164c@syzkaller.appspotmail.com,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 143/179] tipc: fix NULL pointer dereference in tipc_mon_reinit_self()
Date: Tue, 29 Apr 2025 18:41:24 +0200
Message-ID: <20250429161055.179067375@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tung Nguyen <tung.quang.nguyen@est.tech>

[ Upstream commit d63527e109e811ef11abb1c2985048fdb528b4cb ]

syzbot reported:

tipc: Node number set to 1055423674
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 UID: 0 PID: 6017 Comm: kworker/3:5 Not tainted 6.15.0-rc1-syzkaller-00246-g900241a5cc15 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events tipc_net_finalize_work
RIP: 0010:tipc_mon_reinit_self+0x11c/0x210 net/tipc/monitor.c:719
...
RSP: 0018:ffffc9000356fb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003ee87cba
RDX: 0000000000000000 RSI: ffffffff8dbc56a7 RDI: ffff88804c2cc010
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
R13: fffffbfff2111097 R14: ffff88804ead8000 R15: ffff88804ead9010
FS:  0000000000000000(0000) GS:ffff888097ab9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f720eb00 CR3: 000000000e182000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tipc_net_finalize+0x10b/0x180 net/tipc/net.c:140
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
...
RIP: 0010:tipc_mon_reinit_self+0x11c/0x210 net/tipc/monitor.c:719
...
RSP: 0018:ffffc9000356fb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003ee87cba
RDX: 0000000000000000 RSI: ffffffff8dbc56a7 RDI: ffff88804c2cc010
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
R13: fffffbfff2111097 R14: ffff88804ead8000 R15: ffff88804ead9010
FS:  0000000000000000(0000) GS:ffff888097ab9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f720eb00 CR3: 000000000e182000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

There is a racing condition between workqueue created when enabling
bearer and another thread created when disabling bearer right after
that as follow:

enabling_bearer                          | disabling_bearer
---------------                          | ----------------
tipc_disc_timeout()                      |
{                                        | bearer_disable()
 ...                                     | {
 schedule_work(&tn->work);               |  tipc_mon_delete()
 ...                                     |  {
}                                        |   ...
                                         |   write_lock_bh(&mon->lock);
                                         |   mon->self = NULL;
                                         |   write_unlock_bh(&mon->lock);
                                         |   ...
                                         |  }
tipc_net_finalize_work()                 | }
{                                        |
 ...                                     |
 tipc_net_finalize()                     |
 {                                       |
  ...                                    |
  tipc_mon_reinit_self()                 |
  {                                      |
   ...                                   |
   write_lock_bh(&mon->lock);            |
   mon->self->addr = tipc_own_addr(net); |
   write_unlock_bh(&mon->lock);          |
   ...                                   |
  }                                      |
  ...                                    |
 }                                       |
 ...                                     |
}                                        |

'mon->self' is set to NULL in disabling_bearer thread and dereferenced
later in enabling_bearer thread.

This commit fixes this issue by validating 'mon->self' before assigning
node address to it.

Reported-by: syzbot+ed60da8d686dc709164c@syzkaller.appspotmail.com
Fixes: 46cb01eeeb86 ("tipc: update mon's self addr when node addr generated")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250417074826.578115-1-tung.quang.nguyen@est.tech
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 0b9ad3b5ff18a..2e63d5f82b784 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -677,7 +677,8 @@ void tipc_mon_reinit_self(struct net *net)
 		if (!mon)
 			continue;
 		write_lock_bh(&mon->lock);
-		mon->self->addr = tipc_own_addr(net);
+		if (mon->self)
+			mon->self->addr = tipc_own_addr(net);
 		write_unlock_bh(&mon->lock);
 	}
 }
-- 
2.39.5




