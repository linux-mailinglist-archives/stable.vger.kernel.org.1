Return-Path: <stable+bounces-210787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPXgL5cNcWlEcgAAu9opvQ
	(envelope-from <stable+bounces-210787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:32:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8985A902
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3B6B7C2D56
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB741C316;
	Wed, 21 Jan 2026 15:44:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139D38BDD4
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010268; cv=none; b=V8vQpDnwEOPgzMGs2/VaIrK4iF4ORS3qYegaG4t3JpjKGfTXYKaCE/PwaPJ7um4BQTDpP5EwB9DCVlwMCiggkiTXtmw+45a7LCX4bPAwLY8uRlg5PL7rZIYYfx+8eZynhKyn6BU6fMYlISLcBuPHcvS7dszU/LmnoG7lnSE83oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010268; c=relaxed/simple;
	bh=k0CKwpUw5TEZq6srR4eVPhA9a2+nZic8Ra2HB/lE6nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhVF9pyFmCTMvVyLkByy2LB0fW8CE1n/g/dbvjojUj1NhEf90GJ3g8Yd2KJYkWERwcE/WwPgDJv48E8k/bQv7r2txeNMiZKYyMKrmDmLJbF5nUKwZ8Vrb1clkVO+gbgZGPF8L7ETyZS1MtUb5xBScYGxrr7a/ipt07mf7NfiuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15771476;
	Wed, 21 Jan 2026 07:44:18 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 057743F632;
	Wed, 21 Jan 2026 07:44:23 -0800 (PST)
Date: Wed, 21 Jan 2026 15:44:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, david.spickett@arm.com,
	kevin.brodsky@arm.com, stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1] arm64: poe: fix stale POR_EL0 values for ptrace
Message-ID: <aXD0VUDsHxQbCegJ@J2N7QTR9R3>
References: <20260121135639.1835784-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121135639.1835784-1-joey.gouly@arm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-210787-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2E8985A902
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Joey,

On Wed, Jan 21, 2026 at 01:56:39PM +0000, Joey Gouly wrote:
> If a process wrote to POR_EL0 and then crashed before a context switch
> happened, the coredump would contain an incorrect value for POR_EL0.
> 
> The value read in poe_get() would be a stale value left in thread.por_el0.  Fix
> this by reading the value from the system register, if the target thread is the
> current thread.
> 
> This matches what gcs/fpsimd do.
> 
> Fixes: 175198199262 ("arm64/ptrace: add support for FEAT_POE")
> Reported-by: David Spickett <david.spickett@arm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>

I have a couple of comments below, but as-is this looks functionally
correct to me. With or without the changes suggested below:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  arch/arm64/include/asm/por.h | 2 ++
>  arch/arm64/kernel/process.c  | 7 ++++++-
>  arch/arm64/kernel/ptrace.c   | 5 +++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
> index d913d5b529e4..46f1356837e2 100644
> --- a/arch/arm64/include/asm/por.h
> +++ b/arch/arm64/include/asm/por.h
> @@ -31,4 +31,6 @@ static inline bool por_elx_allows_exec(u64 por, u8 pkey)
>  	return perm & POE_X;
>  }
>  
> +void poe_preserve_current_state(void);

Is it possible to have a static inline here, i.e.

	static inline void poe_preserve_current_state(void)
	{
		current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
	}

... or will that cause some header dependency problem?

If we can have this as a static inline, we can use it everywhere
consistently, and avoid needing a function call for a trivial number of
instructions.

Otherwise, see below for another option.

> +
>  #endif /* _ASM_ARM64_POR_H */
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 489554931231..400182099784 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -665,12 +665,17 @@ static int do_set_tsc_mode(unsigned int val)
>  	return 0;
>  }
>  
> +void poe_preserve_current_state(void)
> +{
> +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> +}
> +
>  static void permission_overlay_switch(struct task_struct *next)
>  {
>  	if (!system_supports_poe())
>  		return;
>  
> -	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> +	poe_preserve_current_state();
>  	if (current->thread.por_el0 != next->thread.por_el0) {
>  		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
>  		/*
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index b9bdd83fbbca..276d8ee630cd 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -37,6 +37,7 @@
>  #include <asm/gcs.h>
>  #include <asm/mte.h>
>  #include <asm/pointer_auth.h>
> +#include <asm/por.h>
>  #include <asm/stacktrace.h>
>  #include <asm/syscall.h>
>  #include <asm/traps.h>
> @@ -1486,6 +1487,10 @@ static int poe_get(struct task_struct *target,
>  	if (!system_supports_poe())
>  		return -EINVAL;
>  
> +	if (target == current) {
> +		poe_preserve_current_state();
> +	}

If we can't do the static inline, it might be best to just open code the
read here, i.e. make this:

	if (target == current)
		current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);

... since permission_overlay_switch() writes the register directly,
we're not really gaining abstraction by factoring this out. Open coding
would make the diff a bit smaller, and avoid the function call.

That all said, this is functionally correct either way, so if Catalin or
Will disagree, go with whatever they prefer!

Mark.

