Return-Path: <stable+bounces-256467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH+AO+UFGWrlpggAu9opvQ
	(envelope-from <stable+bounces-256467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:20:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F96F5FCA5A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2C0730954ED
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F436AB57;
	Fri, 29 May 2026 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="DbAfHPv+"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A475364E84;
	Fri, 29 May 2026 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024583; cv=none; b=P9bjE3VdwIKMk18gaioLvJ76NoccgI2TZn933QQyKgSDNEpSfHkoQFUUgGObJNYqRNHRvdXR6nOz1/Wa1YIC7R2vau1PYoZrW0PGiGudnwHbtFC4V2peCZHsao9z+sgLKtLQ3w4qjrN2enFZBXn/kK1S0l9msS1THG2ve3NYYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024583; c=relaxed/simple;
	bh=ji4XNpNrHeX1lSv651ize4ocYofTslBKE81TYCQeusc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJm5CrSq2cRZ+jqle4h2iX5foudL2xmlc3HvuAsuDWahzi77jLPHfanx6bNzcFY9r3xpDdJSVkAxLjpsA3afjOyLrLLwTii/XJAa+cfe6pC6k51HUe1fRsB3bt4bpmjje3JEaSVvva6sxfs4CummG4F1vCgNWLtAqlq78g1wcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=DbAfHPv+; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40433aa46;
	Fri, 29 May 2026 11:10:53 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: martin.lau@linux.dev
Cc: emil@etsalapatis.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2 1/3] bpf: cgroup: use kvfree() for replaced sysctl write buffer
Date: Fri, 29 May 2026 11:10:24 +0800
Message-Id: <20260529031026.2716641-2-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
References: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e71b69dab03a2kunm60a0b1e7a414e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQhpIVkpPTRhCSBkdH0kdTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=DbAfHPv+SKPG0GRhQWN6y3k8d0ogH0d3DwRnBzzRFXXIalNBrc4fTawixjI+DQV3KxKlp09iOU4m8ef/Mscsv+7LNSOZyR2X+JKN4Nij8FaocfwlPV2QLgxto41r1TvlYvyfI51pvKfIZ30hhIHHBtwIUtFvmoVk4GI0IR/gGew=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Vl++bPpgvUs/uCHoO66ivP2N+ke/BWD3sZ+Jr9RKM6w=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[etsalapatis.com,kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,seu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256467-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: 5F96F5FCA5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

proc_sys_call_handler() allocates its temporary sysctl buffer with
kvzalloc() and passes it to __cgroup_bpf_run_filter_sysctl(). Since
kvzalloc() may fall back to vmalloc() for large allocations, freeing
that buffer with kfree() is wrong and can corrupt memory.

Use kvfree() to safely handle both kmalloc and kvzalloc()/vmalloc
allocations.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc5.

Reproduced the bug based on v7.1-rc4 in a QEMU x86_64 guest booted with
KASAN and CONFIG_FAILSLAB enabled. To exercise the replacement path, the
test tree also included the accompanying fix for the stale ret == 1
check in __cgroup_bpf_run_filter_sysctl(). The reproducer confines
failslab injections to the proc_sys_call_handler() range, uses
stacktrace-depth=32, and injects fail-nth=1 while writing 8191 bytes to
/proc/sys/kernel/domainname from a task in the target cgroup. Under
that setup, fail-nth=1 triggered the fault:

  BUG: unable to handle page fault for address: ffffeb0200024d48
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000  SMP KASAN NOPTI
  CPU: 2 UID: 0 PID: 209 Comm: repro_proc_sys_ Not tainted 7.1.0-rc4-00686-g97625979a5d4  PREEMPT(lazy)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
  RIP: 0010:kfree+0x6e/0x510
  Code: 80 48 01 ef 0f 82 ae 04 00 00 48 c7 c0 00 00 00 80 48 2b 05 04 1b 23 04 48 01 c7 48 c1 ef 0c 48 c1 e7 06 48 03 3d e2 1a 23 04 <4c> 8b 57 08 4c 89 d0 83 e0 01 48 83 e8 01 49 09 c2 49 >
  RSP: 0018:ffff888108de7ab8 EFLAGS: 00010282
  RAX: 0000777f80000000 RBX: ffff88815af398c0 RCX: 0000000000000080
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffeb0200024d40
  RBP: ffffc90000935000 R08: 0000000000000001 R09: 0000000000000001
  R10: ffffffff86b4b297 R11: 0000000000000000 R12: ffffffff819b71fd
  R13: 0000000000000001 R14: ffff888108de7cc0 R15: 0000000000000000
  FS:  00007f8988cc2b80(0000) GS:ffff8881d3256000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffeb0200024d48 CR3: 0000000101d6b000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   ? __cgroup_bpf_run_filter_sysctl+0x626/0xc30
   __cgroup_bpf_run_filter_sysctl+0x74d/0xc30
   ? __pfx___cgroup_bpf_run_filter_sysctl+0x10/0x10
   ? srso_return_thunk+0x5/0x5f
   ? __kvmalloc_node_noprof+0x345/0x870
   ? proc_sys_call_handler+0x250/0x480
   ? srso_return_thunk+0x5/0x5f
   proc_sys_call_handler+0x3a2/0x480
   ? __pfx_proc_sys_call_handler+0x10/0x10
   ? srso_return_thunk+0x5/0x5f
   ? selinux_file_permission+0x39f/0x500
   ? srso_return_thunk+0x5/0x5f
   ? lock_is_held_type+0x9e/0x120
   vfs_write+0x98e/0x1000
   ? srso_return_thunk+0x5/0x5f
   ? kmem_cache_free+0x308/0x550
   ? __pfx_vfs_write+0x10/0x10
   ? __pfx_do_sys_openat2+0x10/0x10
   ksys_write+0xf2/0x1d0
   ? __pfx_ksys_write+0x10/0x10
   ? srso_return_thunk+0x5/0x5f
   ? trace_irq_enable.constprop.0+0x110/0x140
   do_syscall_64+0x115/0x690
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   RIP: 0033:0x7f8988dd8907
   Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8  01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 >
   RSP: 002b:00007fff4069b878 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8988dd8907
   RDX: 0000000000001fff RSI: 0000564f97ef46b0 RDI: 0000000000000005
   RBP: 0000564f97ef46b0 R08: 0000000000000000 R09: 0000564f97ef46b0
   R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
   R13: 0000000000001fff R14: 0000000000000005 R15: 0000000000000001
   </TASK>
With this fix applied on top of the same test setup, rerunning the
reproducer with fail-nth=1 yields no corresponding Oops reports.

Fixes: 4508943794ef ("proc: use kvzalloc for our kernel buffer")
Cc: stable@vger.kernel.org

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 876f6a81a9b6..faadcfb9b5e5 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1936,7 +1936,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 	kfree(ctx.cur_val);
 
 	if (ret == 1 && ctx.new_updated) {
-		kfree(*buf);
+		kvfree(*buf);
 		*buf = ctx.new_val;
 		*pcount = ctx.new_len;
 	} else {
-- 
2.34.1


