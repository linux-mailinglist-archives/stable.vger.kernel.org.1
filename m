Return-Path: <stable+bounces-241843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGKsOszC8WkbkQEAu9opvQ
	(envelope-from <stable+bounces-241843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:35:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 607034913D9
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C38D930325B5
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820CF3B38BE;
	Wed, 29 Apr 2026 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLtDEt5n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271764;
	Wed, 29 Apr 2026 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451458; cv=none; b=pRi4ZB0ZE2NyUZsmX5cj8KSOctHYUqL6RzDbCvdZpNmbPRhtFo8ZFyE8z5pD2wsnn19r1LNMPHuyJPJ0rgydZCbKzaCUEiMzHbZMh6npG+xtjsI1qx7FwtHcHNWIf4QG3D5Vts7YlSEx9RMkJtwtvQp0ackbK7X6eKDcjbve3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451458; c=relaxed/simple;
	bh=vcY38yTKvWkxySh/dD05p89rm20lKz93L1O70nV5J54=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=neyRCkwWNZOngwX5dIXHoi0/QP8PRQ0szcQcXN5lBiCZLU8HOLsU4GNQz41ZEUAuAu/BBorLoC4Y2i4lRkWny1XfB/IF5kCIUTKG6Zpzdrv/De6EDQOyFpD/5mFlRnzVPF5ddG+iFfMhycUAzKJcKTDeG3/2zxDCuoJ1UwDP7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLtDEt5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A02EC19425;
	Wed, 29 Apr 2026 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777451457;
	bh=vcY38yTKvWkxySh/dD05p89rm20lKz93L1O70nV5J54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hLtDEt5nzmTCHxFreB34FsVERb6gaI9wed9EeSHBYVqdAuvzbGqRJjqr7j5qWUJ9n
	 gKqaL4f4Ns8MyixQl/W4Rxl5kGkPPRCJZ52yz8/pIzwdIbNZT1ztJ2LpcTnrXICHrw
	 RL5hAwq2glnqoRsmitRP5ZTGeMbW3jnGhsD9js8axnFCqNHScZpl3A8GEmwjsdZYT2
	 JG1VP3bXq89VKzWQS9AAWYj5kQ+vi0oJhci7EdsrJLkgFqNWTv/CMb81mYCG7xcGSI
	 gWfLV3Iihgn/Zc69LMRFUvocXjWjzbr4f7v3TQBrZYHG68tYQcYfCgAK01uALxdzEW
	 19UQRjxgBkLng==
Date: Wed, 29 Apr 2026 17:30:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: naveen@kernel.org, davem@davemloft.net, catalin.marinas@arm.com,
 mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kprobes: skip non-symbol addresses in
 kprobe_add_ksym_blacklist()
Message-Id: <20260429173054.a3420e0a49fe8946f6eaf7f5@kernel.org>
In-Reply-To: <a298419e-c581-41c9-b6d5-9319c24b7995@windriver.com>
References: <20260427073545.3656835-1-jianpeng.chang.cn@windriver.com>
	<20260428184321.309a48036892b8d23a08b566@kernel.org>
	<a298419e-c581-41c9-b6d5-9319c24b7995@windriver.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 607034913D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241843-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:email]

On Wed, 29 Apr 2026 16:16:44 +0800
Jianpeng Chang <jianpeng.chang.cn@windriver.com> wrote:

> 
> 
> 在 2026/4/28 下午5:43, Masami Hiramatsu (Google) 写道:
> > CAUTION: This email comes from a non Wind River email account! Do
> > not click links or open attachments unless you recognize the sender
> > and know the content is safe.
> > 
> > Hi,
> > 
> > On Mon, 27 Apr 2026 15:35:44 +0800 Jianpeng Chang
> > <jianpeng.chang.cn@windriver.com> wrote:
> > 
> >> When kprobe_add_area_blacklist() iterates through a section like 
> >> .kprobes.text, the start address may not correspond to a named
> >> symbol. On ARM64 with CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS=y
> >> (introduced by commit baaf553d3bc3 ("arm64: Implement 
> >> HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")), the compiler flag -
> >> fpatchable-function-entry=4,2 inserts 2 NOPs before each function
> >> entry point for ftrace call_ops. These pre-function NOPs sit at
> >> the section base address, before the first named function symbol.
> >> The compiler emits a $x mapping symbol at offset 0x00 to mark the
> >> start of code, but find_kallsyms_symbol() ignores mapping symbols.
> >> 
> >> Without CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS (e.g. defconfig), no 
> >> pre-function NOPs are inserted, the first function starts at
> >> offset 0x00, and the bug does not trigger.
> >> 
> >> This only affects modules that have a .kprobes.text section (i.e.
> >> those using the __kprobes annotation). Modules using
> >> NOKPROBE_SYMBOL() instead (like kretprobe_example.ko) blacklist
> >> exact function addresses via the _kprobe_blacklist section and are
> >> not affected.
> >> 
> >> For kprobe_example.ko on ARM64 with -fpatchable-function-
> >> entry=4,2, the .kprobes.text section layout is:
> >> 
> >> offset 0x00: $x + 2 NOPs    (mapping symbol + ftrace preamble) 
> >> offset 0x08: handler_post   (64 bytes) offset 0x50: handler_pre
> >> (68 bytes)
> > 
> > Ah, OK. It is for __kprobes attribute. I recommend user to use
> > NOKPROBE_SYMBOL() but I understand the situation.
> > 
> >> 
> >> kprobe_add_area_blacklist() starts iterating from the section base 
> >> address (offset 0x00), which only has the $x mapping symbol. 
> >> kprobe_add_ksym_blacklist() then calls
> >> kallsyms_lookup_size_offset() for this address, which goes
> >> through:
> >> 
> >> kallsyms_lookup_size_offset() -> module_address_lookup() ->
> >> find_kallsyms_symbol()
> >> 
> >> find_kallsyms_symbol() scans all module symbols to find the
> >> closest preceding symbol.
> >> 
> >> Since no named text symbol exists at offset 0x00, 
> >> find_kallsyms_symbol() picks __UNIQUE_ID_vermagic (a .modinfo
> >> symbol whose address is in the temporary image) as the "best"
> >> match. The computed "size" = next_text_symbol - modinfo_symbol
> >> spans across these two unrelated memory regions, creating a
> >> blacklist entry with a bogus range of tens of terabytes.
> >> 
> >> Whether this causes a visible failure depends on address
> >> randomization, here is what happens on Raspberry Pi 4/5:
> >> 
> >> - On RPi5, the bogus size was ~35 TB. start + size stayed within 
> >> 64-bit range, so the blacklist entry covered the entire kernel 
> >> text. register_kprobe() in the module's own init function failed 
> >> with -EINVAL.
> >> 
> >> - On RPi4, the bogus size was ~75 TB. start + size overflowed 64
> >> bits and wrapped to a small address near zero. The range check
> >> (addr >= start && addr < end) then failed because end wrapped
> >> around, so the bogus entry was accidentally harmless and kprobes
> >> worked by luck.
> >> 
> >> The same bug exists on both machines, but randomization determines
> >> whether the integer overflow masks it or not.
> >> 
> >> Fix this by checking the offset returned by
> >> kallsyms_lookup_size_offset(). A non-zero offset means the address
> >> is not at a symbol boundary, so skip forward to the next symbol
> >> instead of creating a blacklist entry with a wrong size.
> >> 
> >> Fixes: baaf553d3bc3 ("arm64: Implement
> >> HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS") Signed-off-by: Jianpeng Chang
> >> <jianpeng.chang.cn@windriver.com> --- Hi,
> >> 
> >> This patch skips non-symbol addresses, fixes the bogus blacklist
> >> entry, but leaves the NOP gap at the start of .kprobes.text
> >> unblacklisted.
> > 
> > That is OK because those NOPs are not executed in kprobe handler.
> > 
> >> 
> >> We can continue alloc the ent without return to add the gap to 
> >> blacklist, or do some more works to add the gap to the first
> >> symbol in blacklist. I'm not sure if is this necessary, or is
> >> there a better way?
> > 
> > Are there any compiler option or attribute to avoid inserting these 
> > NOPs to the specific section? (like notrace?)
> > 
> > Also, as you can see there is an alias symbol whose size is 0. and 
> > in that case, we move the entry + 1 and call
> > kprobe_add_ksym_blacklist() again. Thus, the offset becomes 1.
> > Please make sure it is correctly handled.
> > 
> Regarding the alias symbol concern: kallsyms_lookup_size_offset() 
> computes size as the distance to the next different-address symbol, not 
> from ELF st_size. I tested with a module containing alias symbols in 
> .kprobes.text (created via __attribute__((alias))), and the lookup 
> returned a correct size with offset=0 — the if (ret == 0) ret = 1 path 
> was never triggered.
> 
> That said, #define __kprobes notrace __section(".kprobes.text") is a 
> cleaner fix. The NOPs in .kprobes.text are unnecessary since these 
> functions should never be traced by ftrace. I've tested this on RPi5 — 
> the bug is resolved and all .kprobes.text functions are correctly 
> blacklisted. I'll send the notrace approach in v2.

Ah, great! thanks!

> 
> Thanks,
> Jianpeng> Thanks,
> > 
> >> 
> >> Thanks, Jianpeng
> >> 
> >> kernel/kprobes.c | 4 ++++ 1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/kernel/kprobes.c b/kernel/kprobes.c index
> >> bfc89083daa9..be700fb03198 100644 --- a/kernel/kprobes.c> +++ b/
> >> kernel/kprobes.c @@ -2503,6 +2503,10 @@ int
> >> kprobe_add_ksym_blacklist(unsigned long entry) !
> >> kallsyms_lookup_size_offset(entry, &size, &offset)) return -
> >> EINVAL;
> >> 
> >> +     /* Not on a symbol boundary -- skip to the next symbol */ 
> >> +     if (offset) +             return (int)(size - offset); + ent
> >> = kmalloc_obj(*ent); if (!ent) return -ENOMEM; -- 2.54.0
> >> 
> > 
> > 
> > -- Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

