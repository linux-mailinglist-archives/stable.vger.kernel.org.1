Return-Path: <stable+bounces-210775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OgyKHHoAcWkubQAAu9opvQ
	(envelope-from <stable+bounces-210775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:36:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B432D59FAD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B94772ED46
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CB369212;
	Wed, 21 Jan 2026 14:59:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2A4A5AE5
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007570; cv=none; b=GL3wUkkolsMu+3iQ3+hrWNyj9oGqz3DTgk5gf+VnWZYCkY9xUKu0eVQp37AN/yn0oQEZxUcCVjIQ9uM0Oggk7EhZXvQxdFg+tN23y1cQWciVViPV37q9hheDZ9iGSKLEBwwrgma7ZKGRPzEvtP7TevoQ+XIfkPz7XWQhQ1XSCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007570; c=relaxed/simple;
	bh=T+wsF1csgrRRSavWScms7pxQTpZum+R1X6AXsU3TuJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3BjsilGbF9qAvZAoQFewnzcPw5i8eeLN59GE5OEgRA7Vvv21f9g89cv2haDAjv+CLf0YV/NpIn6itNSjDxiZIoJZ09X7nuD2y2r2hd9ddZexXnnZruu3q5j2Hx3lL9+rp867lIinw7fkRXtBopq2aIm1py3ovmMesJrhUkW4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260C81476;
	Wed, 21 Jan 2026 06:59:20 -0800 (PST)
Received: from [10.57.49.179] (unknown [10.57.49.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 004DA3F632;
	Wed, 21 Jan 2026 06:59:24 -0800 (PST)
Message-ID: <4f4b9dd9-02ed-4899-b17d-24415e50e5c3@arm.com>
Date: Wed, 21 Jan 2026 15:59:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: poe: fix stale POR_EL0 values for ptrace
To: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: david.spickett@arm.com, mark.rutland@arm.com, stable@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20260121135639.1835784-1-joey.gouly@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260121135639.1835784-1-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.brodsky@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210775-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,arm.com:email,arm.com:mid]
X-Rspamd-Queue-Id: B432D59FAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 14:56, Joey Gouly wrote:
> If a process wrote to POR_EL0 and then crashed before a context switch
> happened, the coredump would contain an incorrect value for POR_EL0.

Isn't that also a problem if using ptrace(PTRACE_GETREGSET, REGSET_POE)?
Just like for fpsimd, etc.

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

Nit: no need for {}.

Otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin

> +
>  	return membuf_write(&to, &target->thread.por_el0,
>  			    sizeof(target->thread.por_el0));
>  }

