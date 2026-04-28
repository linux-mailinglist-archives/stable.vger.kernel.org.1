Return-Path: <stable+bounces-241526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CldNYuC8GlwUQEAu9opvQ
	(envelope-from <stable+bounces-241526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:48:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C7481D42
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 778B6305BA81
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960B3CFF55;
	Tue, 28 Apr 2026 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urwQz9pP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389613D6CDA;
	Tue, 28 Apr 2026 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369404; cv=none; b=KQVU4ZfFNxhmmjPdZuH0tUGSe3DdBsfAcIbWPKIuHx/KIUWX1CMHQ0p+iFc1I80x86e5xDoInLTWU1GU654sFw/kwT5Ubv7FnTqEu7nqpDCpPifbGRoAPXX0yE5OI3ZvxMDsur+N0IYtej7BRiO1OC8oYG7OVFSu06+9dxog2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369404; c=relaxed/simple;
	bh=TYiXYjzHA8JHToeY0LvSF4bFP7UXxBQJ3HYswXAb9xU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ED5y8EZKDsrQTXXnqM7SA6rKAJJnJsB0EkNT8hR01r+5fuSzwAFoeE6uXB1jTtW0fPpQA3J7pbuUr9kENRT5nMcSvdfzznhmad93UL4mZ397w4TUKTOa7vgiynPWseXt7kj5fQL90TJP2khG/7fFuHFICoPH8k9dJlIKa7GhrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urwQz9pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5353C2BCAF;
	Tue, 28 Apr 2026 09:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777369403;
	bh=TYiXYjzHA8JHToeY0LvSF4bFP7UXxBQJ3HYswXAb9xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=urwQz9pPf2VrThLNS4hjIltM02UDZkMfyQFH/YMuroDy0q/QkFs3qkya6pQaG4MH1
	 gzzvQVMDhr4I4yOKChdCZljSg3iBiZshWNSNUasDL8IBnpUbWJ9MPYLqcxte8o7hy6
	 VRkmLNz+NJwMGipYttmSkuP4YKJcTucNkLO78gFvaCRB/oH8LV63lliUYRJcoqRZ3m
	 9Kz84yMWOiwnTNsnsOs+MQn4stBgQqpf85SM+5uY3MRe2Hk3TegaD5OJHKXFSnf9ic
	 hQPXyE8XfEs1an9gHzh+a6wB1jEacivarxa7nGYahNEt9cybuDLaaIHfJ+N5vc3ZZX
	 7LKx05O6V9QNA==
Date: Tue, 28 Apr 2026 18:43:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: <naveen@kernel.org>, <davem@davemloft.net>, <catalin.marinas@arm.com>,
 <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] kprobes: skip non-symbol addresses in
 kprobe_add_ksym_blacklist()
Message-Id: <20260428184321.309a48036892b8d23a08b566@kernel.org>
In-Reply-To: <20260427073545.3656835-1-jianpeng.chang.cn@windriver.com>
References: <20260427073545.3656835-1-jianpeng.chang.cn@windriver.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F2C7481D42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241526-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,windriver.com:email]

Hi,

On Mon, 27 Apr 2026 15:35:44 +0800
Jianpeng Chang <jianpeng.chang.cn@windriver.com> wrote:

> When kprobe_add_area_blacklist() iterates through a section like
> .kprobes.text, the start address may not correspond to a named symbol.
> On ARM64 with CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS=y (introduced by
> commit baaf553d3bc3 ("arm64: Implement
> HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")), the compiler flag
> -fpatchable-function-entry=4,2 inserts 2 NOPs before each function entry
> point for ftrace call_ops. These pre-function NOPs sit at the section base
> address, before the first named function symbol. The compiler emits a $x
> mapping symbol at offset 0x00 to mark the start of code, but
> find_kallsyms_symbol() ignores mapping symbols.
> 
> Without CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS (e.g. defconfig), no
> pre-function NOPs are inserted, the first function starts at offset
> 0x00, and the bug does not trigger.
> 
> This only affects modules that have a .kprobes.text section (i.e. those
> using the __kprobes annotation). Modules using NOKPROBE_SYMBOL() instead
> (like kretprobe_example.ko) blacklist exact function addresses via the
> _kprobe_blacklist section and are not affected.
> 
> For kprobe_example.ko on ARM64 with -fpatchable-function-entry=4,2,
> the .kprobes.text section layout is:
> 
>   offset 0x00: $x + 2 NOPs    (mapping symbol + ftrace preamble)
>   offset 0x08: handler_post   (64 bytes)
>   offset 0x50: handler_pre    (68 bytes)

Ah, OK. It is for __kprobes attribute. I recommend user to use NOKPROBE_SYMBOL()
but I understand the situation.

> 
> kprobe_add_area_blacklist() starts iterating from the section base
> address (offset 0x00), which only has the $x mapping symbol.
> kprobe_add_ksym_blacklist() then calls kallsyms_lookup_size_offset()
> for this address, which goes through:
> 
>   kallsyms_lookup_size_offset()
>     -> module_address_lookup()
>       -> find_kallsyms_symbol()
> 
> find_kallsyms_symbol() scans all module symbols to find the closest
> preceding symbol.
> 
> Since no named text symbol exists at offset 0x00,
> find_kallsyms_symbol() picks __UNIQUE_ID_vermagic (a .modinfo symbol
> whose address is in the temporary image) as the "best" match. The
> computed "size" = next_text_symbol - modinfo_symbol spans across
> these two unrelated memory regions, creating a blacklist entry with
> a bogus range of tens of terabytes.
> 
> Whether this causes a visible failure depends on address randomization,
> here is what happens on Raspberry Pi 4/5:
> 
>   - On RPi5, the bogus size was ~35 TB. start + size stayed within
>     64-bit range, so the blacklist entry covered the entire kernel
>     text. register_kprobe() in the module's own init function failed
>     with -EINVAL.
> 
>   - On RPi4, the bogus size was ~75 TB. start + size overflowed
>     64 bits and wrapped to a small address near zero. The range
>     check (addr >= start && addr < end) then failed because end
>     wrapped around, so the bogus entry was accidentally harmless
>     and kprobes worked by luck.
> 
> The same bug exists on both machines, but randomization determines whether
> the integer overflow masks it or not.
> 
> Fix this by checking the offset returned by kallsyms_lookup_size_offset().
> A non-zero offset means the address is not at a symbol boundary, so skip
> forward to the next symbol instead of creating a blacklist entry with a
> wrong size.
> 
> Fixes: baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")
> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
> ---
> Hi,
> 
> This patch skips non-symbol addresses, fixes the bogus blacklist entry,
> but leaves the NOP gap at the start of .kprobes.text unblacklisted.

That is OK because those NOPs are not executed in kprobe handler.

> 
> We can continue alloc the ent without return to add the gap to
> blacklist, or do some more works to add the gap to the first symbol in
> blacklist. I'm not sure if is this necessary, or is there a better way?

Are there any compiler option or attribute to avoid inserting these
NOPs to the specific section? (like notrace?)

Also, as you can see there is an alias symbol whose size is 0. and
in that case, we move the entry + 1 and call kprobe_add_ksym_blacklist()
again. Thus, the offset becomes 1. Please make sure it is correctly
handled.

Thanks,

> 
> Thanks,
> Jianpeng
> 
>  kernel/kprobes.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index bfc89083daa9..be700fb03198 100644
> --- a/kernel/kprobes.c>
> +++ b/kernel/kprobes.c
> @@ -2503,6 +2503,10 @@ int kprobe_add_ksym_blacklist(unsigned long entry)
>  	    !kallsyms_lookup_size_offset(entry, &size, &offset))
>  		return -EINVAL;
>  
> +	/* Not on a symbol boundary -- skip to the next symbol */
> +	if (offset)
> +		return (int)(size - offset);
> +
>  	ent = kmalloc_obj(*ent);
>  	if (!ent)
>  		return -ENOMEM;
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

