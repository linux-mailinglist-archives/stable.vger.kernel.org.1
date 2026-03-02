Return-Path: <stable+bounces-222555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO9FA7JcpWlc+QUAu9opvQ
	(envelope-from <stable+bounces-222555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:47:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 654551D5BE8
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CCF23055DE6
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66BC37703E;
	Mon,  2 Mar 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNLr1yVQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0B430BA1
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444724; cv=none; b=f6otqSZz/9Zp0zZ98Z4a4/LR4ZEHO5gNk5G3r1EoQeYaWLDPx0oowUR8dNhB3rqbQXz/O8k7GEMAmnxldMHS8ir4DYeUDiyriH6KIR2PKw0T7dasn6TbixB8WKAcVU5q3oEWg/QNhL0WUzWZcRNqILwcvqYqo2RrDKerUMT4t2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444724; c=relaxed/simple;
	bh=LoTwO3EeQS+4MjHXcMfxYZRi+8u5iJZGZBFTvyVt7Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuI0BPqpoouywH5cW1ilrj93ZCJHi9wfuIcsaNoZUjyQQwR2aN00JlVELjCSfZtveSMTt77DGtvwO2QSouAnNfqTTU4+0pjhZr7dmvKvRRvmwMcsSTEpFHffXY8tJakJMpG8nO6eBxRtxW5awBGxXJZA/teKubH5kkcIXM9brCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNLr1yVQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772444722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yPtVXkP8KA5UW6r/Q7mKGuCwCo9/GepMlst5FcQcDt4=;
	b=gNLr1yVQEH9pSmkjefc6F8ihjtqNBuniQZ/OfRakV/TkIgxEAWDXgWkcZWCGmCag3w9uLY
	XMjfD7KlKTJqD/YQFaRiZZf7Ezg319TYs7ezKXRyMsUOGh+o9j768tSmpNbcMmjWerNpCF
	N8++g9oY9QNAdCReYJ8V0J/MUt9GTHM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-o2-0LF2ZO9ichR68xRjLMw-1; Mon,
 02 Mar 2026 04:45:18 -0500
X-MC-Unique: o2-0LF2ZO9ichR68xRjLMw-1
X-Mimecast-MFC-AGG-ID: o2-0LF2ZO9ichR68xRjLMw_1772444717
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7C4E1956058;
	Mon,  2 Mar 2026 09:45:17 +0000 (UTC)
Received: from fedora (unknown [10.45.224.37])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 983871800598;
	Mon,  2 Mar 2026 09:45:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  2 Mar 2026 10:45:17 +0100 (CET)
Date: Mon, 2 Mar 2026 10:45:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paulo Andrade <pandrade@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: FAILED: Patch "x86/uprobes: Fix XOL allocation failure for
 32-bit tasks" failed to apply to 6.18-stable tree
Message-ID: <aaVcKHr3GMmOIdvM@redhat.com>
References: <20260301011537.1669125-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301011537.1669125-1-sashal@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222555-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 654551D5BE8
X-Rspamd-Action: no action

On 02/28, Sasha Levin wrote:
>
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I never know how to react to "failed to apply to stabe" emails. I am going
to send [PATCH 6.18.y] in reply to this email.

Is it OK?

Oleg.

> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From d55c571e4333fac71826e8db3b9753fadfbead6a Mon Sep 17 00:00:00 2001
> From: Oleg Nesterov <oleg@redhat.com>
> Date: Sun, 11 Jan 2026 16:00:37 +0100
> Subject: [PATCH] x86/uprobes: Fix XOL allocation failure for 32-bit tasks
> 
> This script
> 
> 	#!/usr/bin/bash
> 
> 	echo 0 > /proc/sys/kernel/randomize_va_space
> 
> 	echo 'void main(void) {}' > TEST.c
> 
> 	# -fcf-protection to ensure that the 1st endbr32 insn can't be emulated
> 	gcc -m32 -fcf-protection=branch TEST.c -o test
> 
> 	bpftrace -e 'uprobe:./test:main {}' -c ./test
> 
> "hangs", the probed ./test task enters an endless loop.
> 
> The problem is that with randomize_va_space == 0
> get_unmapped_area(TASK_SIZE - PAGE_SIZE) called by xol_add_vma() can not
> just return the "addr == TASK_SIZE - PAGE_SIZE" hint, this addr is used
> by the stack vma.
> 
> arch_get_unmapped_area_topdown() doesn't take TIF_ADDR32 into account and
> in_32bit_syscall() is false, this leads to info.high_limit > TASK_SIZE.
> vm_unmapped_area() happily returns the high address > TASK_SIZE and then
> get_unmapped_area() returns -ENOMEM after the "if (addr > TASK_SIZE - len)"
> check.
> 
> handle_swbp() doesn't report this failure (probably it should) and silently
> restarts the probed insn. Endless loop.
> 
> I think that the right fix should change the x86 get_unmapped_area() paths
> to rely on TIF_ADDR32 rather than in_32bit_syscall(). Note also that if
> CONFIG_X86_X32_ABI=y, in_x32_syscall() falsely returns true in this case
> because ->orig_ax = -1.
> 
> But we need a simple fix for -stable, so this patch just sets TS_COMPAT if
> the probed task is 32-bit to make in_ia32_syscall() true.
> 
> Fixes: 1b028f784e8c ("x86/mm: Introduce mmap_compat_base() for 32-bit mmap()")
> Reported-by: Paulo Andrade <pandrade@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/all/aV5uldEvV7pb4RA8@redhat.com/
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/aWO7Fdxn39piQnxu@redhat.com
> ---
>  arch/x86/kernel/uprobes.c | 24 ++++++++++++++++++++++++
>  include/linux/uprobes.h   |  1 +
>  kernel/events/uprobes.c   | 10 +++++++---
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 7be8e361ca55b..619dddf54424e 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1823,3 +1823,27 @@ bool is_uprobe_at_func_entry(struct pt_regs *regs)
>  
>  	return false;
>  }
> +
> +#ifdef CONFIG_IA32_EMULATION
> +unsigned long arch_uprobe_get_xol_area(void)
> +{
> +	struct thread_info *ti = current_thread_info();
> +	unsigned long vaddr;
> +
> +	/*
> +	 * HACK: we are not in a syscall, but x86 get_unmapped_area() paths
> +	 * ignore TIF_ADDR32 and rely on in_32bit_syscall() to calculate
> +	 * vm_unmapped_area_info.high_limit.
> +	 *
> +	 * The #ifdef above doesn't cover the CONFIG_X86_X32_ABI=y case,
> +	 * but in this case in_32bit_syscall() -> in_x32_syscall() always
> +	 * (falsely) returns true because ->orig_ax == -1.
> +	 */
> +	if (test_thread_flag(TIF_ADDR32))
> +		ti->status |= TS_COMPAT;
> +	vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE, PAGE_SIZE, 0, 0);
> +	ti->status &= ~TS_COMPAT;
> +
> +	return vaddr;
> +}
> +#endif
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index ee3d36eda45dd..f548fea2adec8 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -242,6 +242,7 @@ extern void arch_uprobe_clear_state(struct mm_struct *mm);
>  extern void arch_uprobe_init_state(struct mm_struct *mm);
>  extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
>  extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
> +extern unsigned long arch_uprobe_get_xol_area(void);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index a7d7d83ca1d78..dfbce021fb027 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1694,6 +1694,12 @@ static const struct vm_special_mapping xol_mapping = {
>  	.mremap = xol_mremap,
>  };
>  
> +unsigned long __weak arch_uprobe_get_xol_area(void)
> +{
> +	/* Try to map as high as possible, this is only a hint. */
> +	return get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE, PAGE_SIZE, 0, 0);
> +}
> +
>  /* Slot allocation for XOL */
>  static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  {
> @@ -1709,9 +1715,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  	}
>  
>  	if (!area->vaddr) {
> -		/* Try to map as high as possible, this is only a hint. */
> -		area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
> -						PAGE_SIZE, 0, 0);
> +		area->vaddr = arch_uprobe_get_xol_area();
>  		if (IS_ERR_VALUE(area->vaddr)) {
>  			ret = area->vaddr;
>  			goto fail;
> -- 
> 2.51.0
> 
> 
> 
> 


