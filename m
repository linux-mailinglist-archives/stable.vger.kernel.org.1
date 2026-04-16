Return-Path: <stable+bounces-238295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDeZG1i14Gn5kwAAu9opvQ
	(envelope-from <stable+bounces-238295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:09:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0F40CBD5
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BBCE300D4C1
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC939D6C9;
	Thu, 16 Apr 2026 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="CoiBPKIC"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8B39D6F2
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334160; cv=none; b=XUeOJsPz6maJqOBeTPUNFraiXEUhqt/j28pR4L3fwNwt0DYXjsx6KEFgEiL1cyLY7f9G8DbENjIve2DPrK/xZAt92kIVW+Cpo1EcbiJYgCm5I8eyFysgMbHu+xXSelf23cDmP98XXA0r1TwJmM30vjb0hL8WerfKTK1gwmT5rqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334160; c=relaxed/simple;
	bh=OngsxZ1vCJg/+T4pPuDJWlgmT2km1gmr8fAAorvHZSU=;
	h=From:To:Subject:Date:Message-Id; b=D7zr7zWtwcWYX+GwiCgU49oHmN1d8+v+qDxBK9d0AydRUIVF6yCyhjnHL8HGCeAN7tciAlZ6OS5p0AiaImUdTqyf2Wmyasz/I9vM/6931rIu4VrtjkyfRaSPJXtjkHRW/nflgWA+IaK9m5QYhsnD7eDaMT/qHHvoRWc7OqLuOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=CoiBPKIC; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=CoiBPKICWqsly/tHchUVwLfDeKwjY97VexPAVtZJ5lDINuiQiNZ2BoYbSJlqofOzaQihN/f2OabNl
	 dHHEKLV5VNSNCbYp9hqAN3ll5n4XWjeC2Hqr2E/cucqS9byoRziNOewr1ac4MVWrKErhbuWs0PExU5
	 TGNOfoCnultQo/RU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.248.246])
	by rmsmtp-lg-appmail-15-12004 (RichMail) with SMTP id 2ee469e0b540c25-227e4;
	Thu, 16 Apr 2026 18:09:05 +0800 (CST)
X-RM-TRANSID:2ee469e0b540c25-227e4
From: Rajani Kantha <681739313@139.com>
To: shinichiro.kawasaki@wdc.com,
	rostedt@goodmis.org,
	kch@nvidia.com,
	axboe@kernel.dk,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] blktrace: fix __this_cpu_read/write in preemptible context
Date: Thu, 16 Apr 2026 18:08:59 +0800
Message-Id: <20260416100859.2492-1-681739313@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238295-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[139.com];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_SPAM(0.00)[0.057];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel.dk:email,qemu.org:url,goodmis.org:email,wdc.com:email]
X-Rspamd-Queue-Id: 63B0F40CBD5
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
index d5d94510afd3..ce797d8dd451 100644
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



