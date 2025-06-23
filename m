Return-Path: <stable+bounces-156462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EB9AE4FE6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC477A2718
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC354223DF0;
	Mon, 23 Jun 2025 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmu3TIHT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B5223DE5;
	Mon, 23 Jun 2025 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713470; cv=none; b=A0l+bmu0CKEx6WblkTEnaONf790gtjCB+h277WocwcaZJV48J8I8xC6dlO2A+2Msj3Fp5FuykSskUwf6sCwos6S+pRtUni1imTuSGfT21iJloxb9/25MP/47SkRglLcun5ADsmHSYQQU/iJZYYjz4VngTYZqPti9rxuwFY49GhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713470; c=relaxed/simple;
	bh=Y/bUpwAc1LLz24fUdsPhwBtsHDlmH7XfmlzmzFTg0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vx1GRwjJH2MguvlYMAjSEZDwe1kOJq95xE1AFL9NCOMiAtbxLpREdSVUZrNsToyAYvm+Rzsv1j+wJ3ko3fzTF6CDg0cIKR6b0aPeeymrk8ByI1w1ox3b+I2DBnpYWndiTzi69k1fYHbijHt2yfNllNKBmjLAETJarKvncM8hY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mmu3TIHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33745C4CEEA;
	Mon, 23 Jun 2025 21:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713470;
	bh=Y/bUpwAc1LLz24fUdsPhwBtsHDlmH7XfmlzmzFTg0/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmu3TIHT0MVK7U7ZOhie0XbOo4SrXYmlN1mM7frwWvkKGRODlZxZdiyES5ylkypk8
	 vzh50gnzXLuVx3D0EIIJ0kYtPm2IpqTYSG88hJ8KXc5hGBA43JqPacqZfuIZPP9ItK
	 +h5VCMUREoC0vmg7G8DFmK47aUlUAV3wT4f4UYmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 092/290] ftrace: Fix UAF when lookup kallsym after ftrace disabled
Date: Mon, 23 Jun 2025 15:05:53 +0200
Message-ID: <20250623130629.738838163@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ye Bin <yebin10@huawei.com>

commit f914b52c379c12288b7623bb814d0508dbe7481d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ftrace.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6772,9 +6772,10 @@ void ftrace_release_mod(struct module *m
 
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
@@ -6783,6 +6784,9 @@ void ftrace_release_mod(struct module *m
 		}
 	}
 
+	if (ftrace_disabled)
+		goto out_unlock;
+
 	/*
 	 * Each module has its own ftrace_pages, remove
 	 * them from the list.



