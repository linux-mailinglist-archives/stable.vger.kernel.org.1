Return-Path: <stable+bounces-222623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBWmLHOrpWmpDgAAu9opvQ
	(envelope-from <stable+bounces-222623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:23:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C49D1DBBF1
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94BC2312713C
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BEE40B6DB;
	Mon,  2 Mar 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQhIyJuZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6840B6F1
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464476; cv=none; b=QTG3r8HX4nct32NgRwCwtPEeD1RmUhMyhNaU5euihpAyq2msC2MB5C4teksalvGJdv9KFHe/gMM5c3DWeAkfeo7iqIHVMWppjSCubmhzoVQzdxEG7lSps+RHYhz1iY6oVgV2cV1tm8KU5qQNC8pQumNKbnjjrB85+U8wqV6U8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464476; c=relaxed/simple;
	bh=HKZRcSRAOXVOFB8CLIC5vgmIzc89fmsHnsdGjPNHH64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6VROC/d85YkCGLkYv5GCWE1kghioInayY9DI8/E/Z9o1zP9pINKeLCI5Z1z1XH//5zm5OOSWAfdG5XyIHu4IBCzVtXBnEDCugELKce4fR9F9xiFrXpzThx/ZjLrQ2eX9dBowiZII8e+9SnWGRrxkl2Js2p14wkw4BDF2RLeVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQhIyJuZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772464474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8zzTG2R0eOCQTbAfQXWXLurUXdad//xQ9kMoH+SbIJw=;
	b=HQhIyJuZea1Q1bKfORmLcVyFn8pRuFtki3hjVOD8NFwBdch27Ho2RCGgMGtQIxG+IUZXL/
	FEZxM2YjBaEzfa4ftgqoUt9PRpKiwCS5vezn2rBsZEsoFC3sSPctSeXXhOWlOoDuZc45EI
	TPFWyUEgYetrvXQDo4G2HA5VVFA99WY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-GzuSfCDNMM6CiBHW8i-GTQ-1; Mon,
 02 Mar 2026 10:14:33 -0500
X-MC-Unique: GzuSfCDNMM6CiBHW8i-GTQ-1
X-Mimecast-MFC-AGG-ID: GzuSfCDNMM6CiBHW8i-GTQ_1772464472
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D35F21800869;
	Mon,  2 Mar 2026 15:14:31 +0000 (UTC)
Received: from fedora (unknown [10.45.224.37])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 129FC19560B2;
	Mon,  2 Mar 2026 15:14:28 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  2 Mar 2026 16:14:31 +0100 (CET)
Date: Mon, 2 Mar 2026 16:14:27 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paulo Andrade <pandrade@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 6.12.y] x86/uprobes: Fix XOL allocation failure for 32-bit
 tasks
Message-ID: <aaWpUw-27PQmY0Wa@redhat.com>
References: <20260301012146.1677811-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301012146.1677811-1-sashal@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 2C49D1DBBF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222623-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,msgid.link:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

[ Upstream commit d55c571e4333fac71826e8db3b9753fadfbead6a ]

This script

	#!/usr/bin/bash

	echo 0 > /proc/sys/kernel/randomize_va_space

	echo 'void main(void) {}' > TEST.c

	# -fcf-protection to ensure that the 1st endbr32 insn can't be emulated
	gcc -m32 -fcf-protection=branch TEST.c -o test

	bpftrace -e 'uprobe:./test:main {}' -c ./test

"hangs", the probed ./test task enters an endless loop.

The problem is that with randomize_va_space == 0
get_unmapped_area(TASK_SIZE - PAGE_SIZE) called by xol_add_vma() can not
just return the "addr == TASK_SIZE - PAGE_SIZE" hint, this addr is used
by the stack vma.

arch_get_unmapped_area_topdown() doesn't take TIF_ADDR32 into account and
in_32bit_syscall() is false, this leads to info.high_limit > TASK_SIZE.
vm_unmapped_area() happily returns the high address > TASK_SIZE and then
get_unmapped_area() returns -ENOMEM after the "if (addr > TASK_SIZE - len)"
check.

handle_swbp() doesn't report this failure (probably it should) and silently
restarts the probed insn. Endless loop.

I think that the right fix should change the x86 get_unmapped_area() paths
to rely on TIF_ADDR32 rather than in_32bit_syscall(). Note also that if
CONFIG_X86_X32_ABI=y, in_x32_syscall() falsely returns true in this case
because ->orig_ax = -1.

But we need a simple fix for -stable, so this patch just sets TS_COMPAT if
the probed task is 32-bit to make in_ia32_syscall() true.

Fixes: 1b028f784e8c ("x86/mm: Introduce mmap_compat_base() for 32-bit mmap()")
Reported-by: Paulo Andrade <pandrade@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/aV5uldEvV7pb4RA8@redhat.com/
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/aWO7Fdxn39piQnxu@redhat.com
---
 arch/x86/kernel/uprobes.c | 24 ++++++++++++++++++++++++
 include/linux/uprobes.h   |  1 +
 kernel/events/uprobes.c   | 10 +++++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695662b2..6abb25ca9cd1 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1223,3 +1223,27 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 	else
 		return regs->sp <= ret->stack;
 }
+
+#ifdef CONFIG_IA32_EMULATION
+unsigned long arch_uprobe_get_xol_area(void)
+{
+	struct thread_info *ti = current_thread_info();
+	unsigned long vaddr;
+
+	/*
+	 * HACK: we are not in a syscall, but x86 get_unmapped_area() paths
+	 * ignore TIF_ADDR32 and rely on in_32bit_syscall() to calculate
+	 * vm_unmapped_area_info.high_limit.
+	 *
+	 * The #ifdef above doesn't cover the CONFIG_X86_X32_ABI=y case,
+	 * but in this case in_32bit_syscall() -> in_x32_syscall() always
+	 * (falsely) returns true because ->orig_ax == -1.
+	 */
+	if (test_thread_flag(TIF_ADDR32))
+		ti->status |= TS_COMPAT;
+	vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE, PAGE_SIZE, 0, 0);
+	ti->status &= ~TS_COMPAT;
+
+	return vaddr;
+}
+#endif
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index d0cb0e02cd6a..34be2d579045 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -146,6 +146,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
+extern unsigned long arch_uprobe_get_xol_area(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e30c4dd345f4..80cd12eb5854 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1496,6 +1496,12 @@ static const struct vm_special_mapping xol_mapping = {
 	.fault = xol_fault,
 };
 
+unsigned long __weak arch_uprobe_get_xol_area(void)
+{
+	/* Try to map as high as possible, this is only a hint. */
+	return get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE, PAGE_SIZE, 0, 0);
+}
+
 /* Slot allocation for XOL */
 static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 {
@@ -1511,9 +1517,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	if (!area->vaddr) {
-		/* Try to map as high as possible, this is only a hint. */
-		area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
-						PAGE_SIZE, 0, 0);
+		area->vaddr = arch_uprobe_get_xol_area();
 		if (IS_ERR_VALUE(area->vaddr)) {
 			ret = area->vaddr;
 			goto fail;
-- 
2.52.0



