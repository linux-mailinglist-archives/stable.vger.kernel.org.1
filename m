Return-Path: <stable+bounces-179866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D45B7DF17
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F813189BCDA
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A021DFE22;
	Wed, 17 Sep 2025 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JZxpLXaT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF913B7A3;
	Wed, 17 Sep 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112653; cv=none; b=Lk/OBEFdxoB8cXcoS1h9LcdFGUvwEfSpRk74JJA1YAmItR8Vvlp7uDl3JI+G49nm9XZO3nNBf7FTwBqCZzLxD+WYytkX4gMCsts+JU2pVBljjh+KYbeYtPpjXPxFiDewss9cxlxU8k7np6FagnLrx85RX11Ix/inf9QLB3Ao0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112653; c=relaxed/simple;
	bh=sGEmzgJczDaR67qQMux5k/lydLxr43oPCIHn/j2PF/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JR1Nh2deQ5dsMxbJ4WbPMEMRuDy+ZHURYQo6IBmlmUHeJ723/qXVDi7fIye5r2bJ94EwvbYjQ1BcXiqVgGcZODPnzivyPwR1yJZvgXh5gLhJWAc1Wd1oNWsz/o5XaSgy7obDrWyNmgFzh4Pjle3xftD8TXeg+ErteBnfAXy826E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JZxpLXaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D13BC4CEF0;
	Wed, 17 Sep 2025 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112651;
	bh=sGEmzgJczDaR67qQMux5k/lydLxr43oPCIHn/j2PF/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZxpLXaTvCfyCo7ZhJnPkJmypdZ4a019oV5u/SQyc6Vx6SpTqZQsK8pKbByJ/p4sW
	 VIc/cVeKwK9hfX3/5rRV3YEmVu0JcYCC1urVzwlhxos8TS9QI437h1pVVVpnN3uumT
	 n4AICGcdsUevocH2DcsvlI8YtuCxDbAlVvQQAu1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com,
	Pu Lehui <pulehui@huawei.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 035/189] tracing: Silence warning when chunk allocation fails in trace_pid_write
Date: Wed, 17 Sep 2025 14:32:25 +0200
Message-ID: <20250917123352.715532974@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pu Lehui <pulehui@huawei.com>

[ Upstream commit cd4453c5e983cf1fd5757e9acb915adb1e4602b6 ]

Syzkaller trigger a fault injection warning:

WARNING: CPU: 1 PID: 12326 at tracepoint_add_func+0xbfc/0xeb0
Modules linked in:
CPU: 1 UID: 0 PID: 12326 Comm: syz.6.10325 Tainted: G U 6.14.0-rc5-syzkaller #0
Tainted: [U]=USER
Hardware name: Google Compute Engine/Google Compute Engine
RIP: 0010:tracepoint_add_func+0xbfc/0xeb0 kernel/tracepoint.c:294
Code: 09 fe ff 90 0f 0b 90 0f b6 74 24 43 31 ff 41 bc ea ff ff ff
RSP: 0018:ffffc9000414fb48 EFLAGS: 00010283
RAX: 00000000000012a1 RBX: ffffffff8e240ae0 RCX: ffffc90014b78000
RDX: 0000000000080000 RSI: ffffffff81bbd78b RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffffffffef
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff81c264f0
FS:  00007f27217f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e80dff8 CR3: 00000000268f8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tracepoint_probe_register_prio+0xc0/0x110 kernel/tracepoint.c:464
 register_trace_prio_sched_switch include/trace/events/sched.h:222 [inline]
 register_pid_events kernel/trace/trace_events.c:2354 [inline]
 event_pid_write.isra.0+0x439/0x7a0 kernel/trace/trace_events.c:2425
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

We can reproduce the warning by following the steps below:
1. echo 8 >> set_event_notrace_pid. Let tr->filtered_pids owns one pid
   and register sched_switch tracepoint.
2. echo ' ' >> set_event_pid, and perform fault injection during chunk
   allocation of trace_pid_list_alloc. Let pid_list with no pid and
assign to tr->filtered_pids.
3. echo ' ' >> set_event_pid. Let pid_list is NULL and assign to
   tr->filtered_pids.
4. echo 9 >> set_event_pid, will trigger the double register
   sched_switch tracepoint warning.

The reason is that syzkaller injects a fault into the chunk allocation
in trace_pid_list_alloc, causing a failure in trace_pid_list_set, which
may trigger double register of the same tracepoint. This only occurs
when the system is about to crash, but to suppress this warning, let's
add failure handling logic to trace_pid_list_set.

Link: https://lore.kernel.org/20250908024658.2390398-1-pulehui@huaweicloud.com
Fixes: 8d6e90983ade ("tracing: Create a sparse bitmask for pid filtering")
Reported-by: syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67cb890e.050a0220.d8275.022e.GAE@google.com
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9329ac1667551..56f6cebdb2299 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -846,7 +846,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		/* copy the current bits to the new max */
 		ret = trace_pid_list_first(filtered_pids, &pid);
 		while (!ret) {
-			trace_pid_list_set(pid_list, pid);
+			ret = trace_pid_list_set(pid_list, pid);
+			if (ret < 0)
+				goto out;
+
 			ret = trace_pid_list_next(filtered_pids, pid + 1, &pid);
 			nr_pids++;
 		}
@@ -883,6 +886,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		trace_parser_clear(&parser);
 		ret = 0;
 	}
+ out:
 	trace_parser_put(&parser);
 
 	if (ret < 0) {
-- 
2.51.0




