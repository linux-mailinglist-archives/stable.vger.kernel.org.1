Return-Path: <stable+bounces-150733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62EDACCBC2
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD906168717
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504901DB13A;
	Tue,  3 Jun 2025 17:11:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E31D7E54;
	Tue,  3 Jun 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970674; cv=none; b=ZcBEk8g08upxkPhvSOpOtTvgmf6eaJT9oAIPzziBns6kdylKCWiGJ0lTYIJ0mbF9Od8Jd1ZpS0urE0OnEmdYy2hvMw4WBdeBVs4jUF1FUJdS5gb92zaTj38UnlSwnlj6P3jypMUVxdneYC0FzsYumjIZ1G6DyAHB2iqFSIabUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970674; c=relaxed/simple;
	bh=fiZC9m2o/8iWsIotLzKkDj8RsLh9fnr3AXBC611yQRQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Vw9g5N8iO+MnOchWAOCdt5tKX3JFbCP4ai9Us35Y4vti8tR+VLJ+pWfKy8vCQ5qi6omuhWfW3WlQJdl1Q2V6Og5adhRoVs9+Jl3AlYnc+HsrNRPyh+HnA5JsfESJvl9k8mnQkfzuGuoRhE8mKuH2pxAc+jmU3bgLg8g8UTduoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8AAC4CEF1;
	Tue,  3 Jun 2025 17:11:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uMVBc-0000000E3zZ-2PqM;
	Tue, 03 Jun 2025 13:12:28 -0400
Message-ID: <20250603171228.423180093@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 03 Jun 2025 13:11:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Ye Bin <yebin10@huawei.com>
Subject: [for-linus][PATCH 1/5] ftrace: Fix UAF when lookup kallsym after ftrace disabled
References: <20250603171149.582996770@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ye Bin <yebin10@huawei.com>

The following issue happens with a buggy module:

BUG: unable to handle page fault for address: ffffffffc05d0218
PGD 1bd66f067 P4D 1bd66f067 PUD 1bd671067 PMD 101808067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN PTI
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
RIP: 0010:sized_strscpy+0x81/0x2f0
RSP: 0018:ffff88812d76fa08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffc0601010 RCX: dffffc0000000000
RDX: 0000000000000038 RSI: dffffc0000000000 RDI: ffff88812608da2d
RBP: 8080808080808080 R08: ffff88812608da2d R09: ffff88812608da68
R10: ffff88812608d82d R11: ffff88812608d810 R12: 0000000000000038
R13: ffff88812608da2d R14: ffffffffc05d0218 R15: fefefefefefefeff
FS:  00007fef552de740(0000) GS:ffff8884251c7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc05d0218 CR3: 00000001146f0000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ftrace_mod_get_kallsym+0x1ac/0x590
 update_iter_mod+0x239/0x5b0
 s_next+0x5b/0xa0
 seq_read_iter+0x8c9/0x1070
 seq_read+0x249/0x3b0
 proc_reg_read+0x1b0/0x280
 vfs_read+0x17f/0x920
 ksys_read+0xf3/0x1c0
 do_syscall_64+0x5f/0x2e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The above issue may happen as follows:
(1) Add kprobe tracepoint;
(2) insmod test.ko;
(3)  Module triggers ftrace disabled;
(4) rmmod test.ko;
(5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
ftrace_mod_get_kallsym()
...
strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
...

The problem is when a module triggers an issue with ftrace and
sets ftrace_disable. The ftrace_disable is set when an anomaly is
discovered and to prevent any more damage, ftrace stops all text
modification. The issue that happened was that the ftrace_disable stops
more than just the text modification.

When a module is loaded, its init functions can also be traced. Because
kallsyms deletes the init functions after a module has loaded, ftrace
saves them when the module is loaded and function tracing is enabled. This
allows the output of the function trace to show the init function names
instead of just their raw memory addresses.

When a module is removed, ftrace_release_mod() is called, and if
ftrace_disable is set, it just returns without doing anything more. The
problem here is that it leaves the mod_list still around and if kallsyms
is called, it will call into this code and access the module memory that
has already been freed as it will return:

  strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);

Where the "mod" no longer exists and triggers a UAF bug.

Link: https://lore.kernel.org/all/20250523135452.626d8dcd@gandalf.local.home/

Cc: stable@vger.kernel.org
Fixes: aba4b5c22cba ("ftrace: Save module init functions kallsyms symbols for tracing")
Link: https://lore.kernel.org/20250529111955.2349189-2-yebin@huaweicloud.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1af952cba48d..84fd2f8263fa 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7438,9 +7438,10 @@ void ftrace_release_mod(struct module *mod)
 
 	mutex_lock(&ftrace_lock);
 
-	if (ftrace_disabled)
-		goto out_unlock;
-
+	/*
+	 * To avoid the UAF problem after the module is unloaded, the
+	 * 'mod_map' resource needs to be released unconditionally.
+	 */
 	list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
 		if (mod_map->mod == mod) {
 			list_del_rcu(&mod_map->list);
@@ -7449,6 +7450,9 @@ void ftrace_release_mod(struct module *mod)
 		}
 	}
 
+	if (ftrace_disabled)
+		goto out_unlock;
+
 	/*
 	 * Each module has its own ftrace_pages, remove
 	 * them from the list.
-- 
2.47.2



