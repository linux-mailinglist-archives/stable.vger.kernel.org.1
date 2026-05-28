Return-Path: <stable+bounces-254782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCu0FCYVGGrKbggAu9opvQ
	(envelope-from <stable+bounces-254782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:12:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC7D5F0509
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E5433303E4B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12B3B2FE7;
	Thu, 28 May 2026 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGBP1jLJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA133B5F5D
	for <stable@vger.kernel.org>; Thu, 28 May 2026 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962317; cv=none; b=EKk55MFa59cu4GgxREDrIBg0M5OmgRdGtG7gOdltnMVQ5GFHkCe3SOwV8MeiWKrkEbIwIS83h2CWCxcWF7la/HuTHm3wqOza4qlgPyfiQmCwgwzUFTKyEmhEpb971E1Hr5kIdAHLZaXLFQ3JoBMH96qSHNjzycJFYfMUr6U60fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962317; c=relaxed/simple;
	bh=fgvqhFpjt7wUmxA1ehFfvOu+IwRBsUgns1WpYJA+hMY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B9Laz6VpaSi81TkuBSgmJ/F/lEjvQ21PFGWrch6Q/C1UOv24ZIhZVNAqs5RmJP+BAhVxmOd+TXZ8h7/F/2HHd4OlcNVXB7aJXMYqzwKjJomNIkDA43JERTYQaDHgE2pRY6SstQgDxvudY3D0nrX+I7ybZ2QpcipLcWHw0udbTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGBP1jLJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BC91F000E9;
	Thu, 28 May 2026 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962314;
	bh=1zMHe5v8Ekhs61fFOHvrDNxs6nixFLQKCkfmSlLUKcc=;
	h=Subject:To:Cc:From:Date;
	b=XGBP1jLJIJ27As8FA0BWVfCooYJ4qkP+9McKcKz/K7X52+NcPdISzlTakZPzPtdpt
	 IyinGFkgVhVm1HUQQxREx9gHzm2+4cOuVLplDSloGeui1/LWhk75BMxchbsTrLFVl+
	 0k8Bf/6TTUJp/Alk/oHHV3yX9w4HUWJyke+okV14=
Subject: FAILED: patch "[PATCH] ring-buffer: Flush and stop persistent ring buffer on panic" failed to apply to 6.12-stable tree
To: mhiramat@kernel.org,catalin.marinas@arm.com,geert@linux-m68k.org,irogers@google.com,mathieu.desnoyers@efficios.com,rostedt@goodmis.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 11:57:40 +0200
Message-ID: <2026052840-curve-charger-8597@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254782-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linux-m68k.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,gregkh:email,efficios.com:email]
X-Rspamd-Queue-Id: BCC7D5F0509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a494d3c8d5392bcdff83c2a593df0c160ff9f322
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052840-curve-charger-8597@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a494d3c8d5392bcdff83c2a593df0c160ff9f322 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Thu, 30 Apr 2026 12:28:16 +0900
Subject: [PATCH] ring-buffer: Flush and stop persistent ring buffer on panic

On real hardware, panic and machine reboot may not flush hardware cache
to memory. This means the persistent ring buffer, which relies on a
coherent state of memory, may not have its events written to the buffer
and they may be lost. Moreover, there may be inconsistency with the
counters which are used for validation of the integrity of the
persistent ring buffer which may cause all data to be discarded.

To avoid this issue, stop recording of the ring buffer on panic and
flush the cache of the ring buffer's memory.

Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Cc: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ian Rogers <irogers@google.com>
Link: https://patch.msgid.link/177751969602.2136606.12031934362587643488.stgit@mhiramat.tok.corp.google.com
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 483965c5a4de..b154b4e3dfa8 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -5,4 +5,5 @@ generic-y += agp.h
 generic-y += asm-offsets.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += text-patching.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 4c69522e0328..483caacc6988 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -5,5 +5,6 @@ generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += text-patching.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 03657ff8fbe3..decad5f2c826 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += early_ioremap.h
 generic-y += extable.h
 generic-y += flat.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 
 generated-y += mach-types.h
 generated-y += unistd-nr.h
diff --git a/arch/arm64/include/asm/ring_buffer.h b/arch/arm64/include/asm/ring_buffer.h
new file mode 100644
index 000000000000..62316c406888
--- /dev/null
+++ b/arch/arm64/include/asm/ring_buffer.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_ARM64_RING_BUFFER_H
+#define _ASM_ARM64_RING_BUFFER_H
+
+#include <asm/cacheflush.h>
+
+/* Flush D-cache on persistent ring buffer */
+#define arch_ring_buffer_flush_range(start, end)	dcache_clean_pop(start, end)
+
+#endif /* _ASM_ARM64_RING_BUFFER_H */
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 3a5c7f6e5aac..7dca0c6cdc84 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += qrwlock.h
 generic-y += qrwlock_types.h
 generic-y += qspinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
 generic-y += text-patching.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 1efa1e993d4b..0f887d4238ed 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -5,4 +5,5 @@ generic-y += extable.h
 generic-y += iomap.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += text-patching.h
diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 9034b583a88a..7e92957baf6a 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -10,5 +10,6 @@ generic-y += qrwlock.h
 generic-y += user.h
 generic-y += ioctl.h
 generic-y += mmzone.h
+generic-y += ring_buffer.h
 generic-y += statfs.h
 generic-y += text-patching.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index b282e0dd8dc1..62543bf305ff 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -3,5 +3,6 @@ generated-y += syscall_table.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += spinlock.h
 generic-y += text-patching.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 7178f990e8b3..0030309b47ad 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += syscalls.h
 generic-y += tlb.h
 generic-y += user.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 684569b2ecd6..9771c3d85074 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -12,5 +12,6 @@ generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += text-patching.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 28004301c236..0a2530964413 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += spinlock.h
 generic-y += user.h
 generic-y += text-patching.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index cef49d60d74c..8aa34621702d 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -8,4 +8,5 @@ generic-y += spinlock_types.h
 generic-y += spinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 4fb596d94c89..d48d158f7241 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -4,4 +4,5 @@ generated-y += syscall_table_64.h
 generic-y += agp.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 2e23533b67e3..805b5aeebb6f 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -5,4 +5,5 @@ generated-y += syscall_table_spu.h
 generic-y += agp.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
+generic-y += ring_buffer.h
 generic-y += early_ioremap.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index bd5fc9403295..7721b63642f4 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -14,5 +14,6 @@ generic-y += ticket_spinlock.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
 generic-y += qspinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 80bad7de7a04..0c1fc47c3ba0 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -7,3 +7,4 @@ generated-y += unistd_nr.h
 generic-y += asm-offsets.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
+generic-y += ring_buffer.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 4d3f10ed8275..f0403d3ee8ab 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -3,4 +3,5 @@ generated-y += syscall_table.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += text-patching.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 17ee8a273aa6..49c6bb326b75 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -4,4 +4,5 @@ generated-y += syscall_table_64.h
 generic-y += agp.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += text-patching.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 1b9b82bbe322..2a1629ba8140 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -17,6 +17,7 @@ generic-y += module.lds.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
+generic-y += ring_buffer.h
 generic-y += runtime-const.h
 generic-y += softirq_stack.h
 generic-y += switch_to.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 4566000e15c4..078fd2c0d69d 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -14,3 +14,4 @@ generic-y += early_ioremap.h
 generic-y += fprobe.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
+generic-y += ring_buffer.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 13fe45dea296..e57af619263a 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -6,5 +6,6 @@ generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += text-patching.h
diff --git a/include/asm-generic/ring_buffer.h b/include/asm-generic/ring_buffer.h
new file mode 100644
index 000000000000..201d2aee1005
--- /dev/null
+++ b/include/asm-generic/ring_buffer.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Generic arch dependent ring_buffer macros.
+ */
+#ifndef __ASM_GENERIC_RING_BUFFER_H__
+#define __ASM_GENERIC_RING_BUFFER_H__
+
+#include <linux/cacheflush.h>
+
+/* Flush cache on ring buffer range if needed. Do nothing by default. */
+#define arch_ring_buffer_flush_range(start, end)	do { } while (0)
+
+#endif /* __ASM_GENERIC_RING_BUFFER_H__ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fcd93d49851e..7b07d2004cc6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7,6 +7,7 @@
 #include <linux/ring_buffer_types.h>
 #include <linux/sched/isolation.h>
 #include <linux/trace_recursion.h>
+#include <linux/panic_notifier.h>
 #include <linux/trace_events.h>
 #include <linux/ring_buffer.h>
 #include <linux/trace_clock.h>
@@ -31,6 +32,7 @@
 #include <linux/oom.h>
 #include <linux/mm.h>
 
+#include <asm/ring_buffer.h>
 #include <asm/local64.h>
 #include <asm/local.h>
 #include <asm/setup.h>
@@ -559,6 +561,7 @@ struct trace_buffer {
 
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
+	struct notifier_block		flush_nb;
 
 	struct ring_buffer_meta		*meta;
 
@@ -2521,6 +2524,16 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+/* Stop recording on a persistent buffer and flush cache if needed. */
+static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
+
+	ring_buffer_record_off(buffer);
+	arch_ring_buffer_flush_range(buffer->range_addr_start, buffer->range_addr_end);
+	return NOTIFY_DONE;
+}
+
 static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
@@ -2651,6 +2664,12 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	mutex_init(&buffer->mutex);
 
+	/* Persistent ring buffer needs to flush cache before reboot. */
+	if (start && end) {
+		buffer->flush_nb.notifier_call = rb_flush_buffer_cb;
+		atomic_notifier_chain_register(&panic_notifier_list, &buffer->flush_nb);
+	}
+
 	return_ptr(buffer);
 
  fail_free_buffers:
@@ -2749,6 +2768,9 @@ ring_buffer_free(struct trace_buffer *buffer)
 {
 	int cpu;
 
+	if (buffer->range_addr_start && buffer->range_addr_end)
+		atomic_notifier_chain_unregister(&panic_notifier_list, &buffer->flush_nb);
+
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
 	irq_work_sync(&buffer->irq_work.work);


