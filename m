Return-Path: <stable+bounces-235580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPpnHwut2GljgwgAu9opvQ
	(envelope-from <stable+bounces-235580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:55:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF873D3A4D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AE49300C7C8
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49F3A5E94;
	Fri, 10 Apr 2026 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="khOv6f0+"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0B3A1A2B
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807747; cv=none; b=kD2pHcnBol1WynDp2EKBm65yfXJ4u9fi0nBXtvwsM8Ux3PFr/VQtgv6epGDU/oWY5p3HsmC77Glu/bbVj+BHxJVNYG/3rzlIaMHFfgnY9Ab3ikNqklTqS6Dy2xj8XsEUZMQ6hKERfVfZixvql0Us1qLz8H3CzMnz2Wbs/rzzK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807747; c=relaxed/simple;
	bh=nMKvFZN+VKPYDMK2Ij0nfGHpyRU2xcgstGP6IC8uTdo=;
	h=From:To:Subject:Date:Message-Id; b=ZVbFZQYq0drlsAljUWDLgPSe7FT1uvuc3bOY8mO23WmrEhhWIN7KogUUqIFHV90XNqPpwI9dXKoRzgK4u9kvdehVfSJEW2OTLiOKTCUXGLoe6he6SkN6uwShxZTGG0pZ11mGvMyJw9yRU0G7tvTvoo3u1C+s3K8FGj7CLm/3NS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=khOv6f0+; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=khOv6f0+dIwBIKDDcNjTdqkl6f20ljjwF7Pc3khUO/ji1bvRlFqvV4bFYxOMX+cT83WWo8mpdfTBj
	 6rEikWBl3ufLIuIUwkrh1mc/VjVQ5xdbvLSOpDdHw5DMYXMs9Fn4ItzcsXnfalcPwOfh3YFDDEA+IB
	 rw9K+qfwE/bTTgrM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.248.246])
	by rmsmtp-lg-appmail-04-12082 (RichMail) with SMTP id 2f3269d8acf3c9f-5eef5;
	Fri, 10 Apr 2026 15:55:32 +0800 (CST)
X-RM-TRANSID:2f3269d8acf3c9f-5eef5
From: Rajani Kantha <681739313@139.com>
To: shinichiro.kawasaki@wdc.com,
	rostedt@goodmis.org,
	kch@nvidia.com,
	axboe@kernel.dk,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y] blktrace: fix __this_cpu_read/write in preemptible context
Date: Fri, 10 Apr 2026 15:55:28 +0800
Message-Id: <20260410075528.1996-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235580-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.950];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,139.com:email,139.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: DCF873D3A4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chaitanya Kulkarni <kch@nvidia.com>

[ Upstream commit da46b5dfef48658d03347cda21532bcdbb521e67 ]

tracing_record_cmdline() internally uses __this_cpu_read() and
__this_cpu_write() on the per-CPU variable trace_cmdline_save, and
trace_save_cmdline() explicitly asserts preemption is disabled via
lockdep_assert_preemption_disabled(). These operations are only safe
when preemption is off, as they were designed to be called from the
scheduler context (probe_wakeup_sched_switch() / probe_wakeup()).

__blk_add_trace() was calling tracing_record_cmdline(current) early in
the blk_tracer path, before ring buffer reservation, from process
context where preemption is fully enabled. This triggers the following
using blktests/blktrace/002:

blktrace/002 (blktrace ftrace corruption with sysfs trace)   [failed]
    runtime  0.367s  ...  0.437s
    something found in dmesg:
    [   81.211018] run blktests blktrace/002 at 2026-02-25 22:24:33
    [   81.239580] null_blk: disk nullb1 created
    [   81.357294] BUG: using __this_cpu_read() in preemptible [00000000] code: dd/2516
    [   81.362842] caller is tracing_record_cmdline+0x10/0x40
    [   81.362872] CPU: 16 UID: 0 PID: 2516 Comm: dd Tainted: G                 N  7.0.0-rc1lblk+ #84 PREEMPT(full)
    [   81.362877] Tainted: [N]=TEST
    [   81.362878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
    [   81.362881] Call Trace:
    [   81.362884]  <TASK>
    [   81.362886]  dump_stack_lvl+0x8d/0xb0
    ...
    (See '/mnt/sda/blktests/results/nodev/blktrace/002.dmesg' for the entire message)

[   81.211018] run blktests blktrace/002 at 2026-02-25 22:24:33
[   81.239580] null_blk: disk nullb1 created
[   81.357294] BUG: using __this_cpu_read() in preemptible [00000000] code: dd/2516
[   81.362842] caller is tracing_record_cmdline+0x10/0x40
[   81.362872] CPU: 16 UID: 0 PID: 2516 Comm: dd Tainted: G                 N  7.0.0-rc1lblk+ #84 PREEMPT(full)
[   81.362877] Tainted: [N]=TEST
[   81.362878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[   81.362881] Call Trace:
[   81.362884]  <TASK>
[   81.362886]  dump_stack_lvl+0x8d/0xb0
[   81.362895]  check_preemption_disabled+0xce/0xe0
[   81.362902]  tracing_record_cmdline+0x10/0x40
[   81.362923]  __blk_add_trace+0x307/0x5d0
[   81.362934]  ? lock_acquire+0xe0/0x300
[   81.362940]  ? iov_iter_extract_pages+0x101/0xa30
[   81.362959]  blk_add_trace_bio+0x106/0x1e0
[   81.362968]  submit_bio_noacct_nocheck+0x24b/0x3a0
[   81.362979]  ? lockdep_init_map_type+0x58/0x260
[   81.362988]  submit_bio_wait+0x56/0x90
[   81.363009]  __blkdev_direct_IO_simple+0x16c/0x250
[   81.363026]  ? __pfx_submit_bio_wait_endio+0x10/0x10
[   81.363038]  ? rcu_read_lock_any_held+0x73/0xa0
[   81.363051]  blkdev_read_iter+0xc1/0x140
[   81.363059]  vfs_read+0x20b/0x330
[   81.363083]  ksys_read+0x67/0xe0
[   81.363090]  do_syscall_64+0xbf/0xf00
[   81.363102]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   81.363106] RIP: 0033:0x7f281906029d
[   81.363111] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d 66 63 0a 00 e8 59 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 41 33 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
[   81.363113] RSP: 002b:00007ffca127dd48 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   81.363120] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f281906029d
[   81.363122] RDX: 0000000000001000 RSI: 0000559f8bfae000 RDI: 0000000000000000
[   81.363123] RBP: 0000000000001000 R08: 0000002863a10a81 R09: 00007f281915f000
[   81.363124] R10: 00007f2818f77b60 R11: 0000000000000246 R12: 0000559f8bfae000
[   81.363126] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000a
[   81.363142]  </TASK>

The same BUG fires from blk_add_trace_plug(), blk_add_trace_unplug(),
and blk_add_trace_rq() paths as well.

The purpose of tracing_record_cmdline() is to cache the task->comm for
a given PID so that the trace can later resolve it. It is only
meaningful when a trace event is actually being recorded. Ring buffer
reservation via ring_buffer_lock_reserve() disables preemption, and
preemption remains disabled until the event is committed :-

__blk_add_trace()
       	__trace_buffer_lock_reserve()
       		__trace_buffer_lock_reserve()
       			ring_buffer_lock_reserve()
       				preempt_disable_notrace();  <---

With this fix blktests for blktrace pass:

  blktests (master) # ./check blktrace
  blktrace/001 (blktrace zone management command tracing)      [passed]
      runtime  3.650s  ...  3.647s
  blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
      runtime  0.411s  ...  0.384s

Fixes: 7ffbd48d5cab ("tracing: Cache comms only after an event occurred")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 kernel/trace/blktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8fd292d34d89..6cb5772e6aa9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -251,8 +251,6 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	cpu = raw_smp_processor_id();
 
 	if (blk_tracer) {
-		tracing_record_cmdline(current);
-
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
@@ -260,6 +258,8 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 						  trace_ctx);
 		if (!event)
 			return;
+
+		tracing_record_cmdline(current);
 		t = ring_buffer_event_data(event);
 		goto record_it;
 	}
-- 
2.17.1



