Return-Path: <stable+bounces-256633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEDyBKiXGWrVxggAu9opvQ
	(envelope-from <stable+bounces-256633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:42:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADAB602FCB
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8759303BB2A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0232ED39;
	Fri, 29 May 2026 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VcGb9xqc"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F9A320A00
	for <stable@vger.kernel.org>; Fri, 29 May 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061920; cv=none; b=VBcoNXP1tXqFllznw3g1nYx3tlL7u+SAVpFfxXOrVx7HqXkaknvEc+7pGC30uCbWUoc4gTdSm6nNDfi6mlTvcFHKg81oIdtqPfLQk71pyRUkcXvTyal+qNW/T4iVcqsIGbOoSJ+a+v3ep/fHoi31173VH/8Kj3Y/P8GlBv4Aw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061920; c=relaxed/simple;
	bh=tMKc1VcaljFjvGOuLQm35r6sJ6W0mFRZl1t5KFAONDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=hWIlRwxmO4eMW+N1IqmduzttmsXgLB6RPqItkTWtsBIQlmcPVDfcjqeekC+sNULK/NVg4ecc2XGFbhq7orW8KmA9R2yU6C+rAHGyIdcCQ7Gudd3s5BhkNiigNWYDdCThV39gxiuRuD7k+z2KrB1HGBuPrrwmAYgf5f/q9VXi2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VcGb9xqc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2830B20E3;
	Fri, 29 May 2026 06:38:33 -0700 (PDT)
Received: from [10.57.36.140] (unknown [10.57.36.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1DE3F905;
	Fri, 29 May 2026 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780061918; bh=tMKc1VcaljFjvGOuLQm35r6sJ6W0mFRZl1t5KFAONDg=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=VcGb9xqcfGVz5S37uF13xnLV4QC29nnatENR2O2Be4Tjyb0kC2Dak9obD+4D/P5MA
	 /CXAs7g3e5AFXU/jyc1E815Z9ASUb+iYyb2942ASPYIpG0tuzdjZ+hFZExacEKgE+2
	 MHK3bSXeKSguFEvDMu+VX1G24dKnYElmLBIPcaPo=
Message-ID: <48316697-6c3b-465c-a49a-d2adb749d459@arm.com>
Date: Fri, 29 May 2026 14:38:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.12-stable 00/14] Backport: arm64: debug: remove hook
 registration, split exception entry
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, stable@vger.kernel.org
References: <20260528144825.850351-1-bigeasy@linutronix.de>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US, en-GB, fr
Organization: Arm Ltd.
In-Reply-To: <20260528144825.850351-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256633-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ada.coupriediaz@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: 7ADAB602FCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sebastian, thanks a lot for the backport !

I'll take a more thorough look soon just to check, but the original
series contained a bug with pseudo-NMIs, which I corrected
in a later patch[0] in commit ea0d55ae4b32 ("arm64: debug:
always unmask interrupts in el0_softstp()").

I see that the bug is present in the backport, so the fix should definitely
be added to the series !

Kind regards,
Ada

[0]: 
https://lore.kernel.org/all/20251014092536.18831-1-ada.coupriediaz@arm.com/

On 28/05/2026 15:48, Sebastian Andrzej Siewior wrote:
> Hi,
>
> this is a backport of the "arm64: debug: remove hook registration, split
> exception entry" series
> 	https://lore.kernel.org/all/20250707114109.35672-1-ada.coupriediaz@arm.com/
>
> which has been merged as of v6.17-rc1. It fixes the HW breakpoint issue
> on PREEMPT_RT.
>
> I only picked one dependency and manually fixed the other conflicts to
> avoid a larger backport.
>
> This has been prepared against v6.12.91. v6.12-stable is the only
> relevant tree for a backport (earlier stable version have no PREEMPT_RT
> support).
>
> Ada Couprie Diaz (13):
>    arm64: debug: clean up single_step_handler logic
>    arm64: refactor aarch32_break_handler()
>    arm64: debug: call software breakpoint handlers statically
>    arm64: debug: call step handlers statically
>    arm64: debug: remove break/step handler registration infrastructure
>    arm64: entry: Add entry and exit functions for debug exceptions
>    arm64: debug: split hardware breakpoint exception entry
>    arm64: debug: refactor reinstall_suspended_bps()
>    arm64: debug: split single stepping exception entry
>    arm64: debug: split hardware watchpoint exception entry
>    arm64: debug: split brk64 exception entry
>    arm64: debug: split bkpt32 exception entry
>    arm64: debug: remove debug exception registration infrastructure
>
> Mostafa Saleh (1):
>    arm64: Introduce esr_is_ubsan_brk()
>
>   arch/arm64/include/asm/debug-monitors.h       |  34 +--
>   arch/arm64/include/asm/esr.h                  |   5 +
>   arch/arm64/include/asm/exception.h            |  14 +-
>   arch/arm64/include/asm/kgdb.h                 |  12 +
>   arch/arm64/include/asm/kprobes.h              |   8 +
>   arch/arm64/include/asm/system_misc.h          |   4 -
>   arch/arm64/include/asm/traps.h                |   6 +
>   arch/arm64/include/asm/uprobes.h              |  11 +
>   arch/arm64/kernel/debug-monitors.c            | 258 +++++++-----------
>   arch/arm64/kernel/entry-common.c              | 146 +++++++++-
>   arch/arm64/kernel/hw_breakpoint.c             |  60 ++--
>   arch/arm64/kernel/kgdb.c                      |  39 +--
>   arch/arm64/kernel/probes/kprobes.c            |  31 +--
>   arch/arm64/kernel/probes/kprobes_trampoline.S |   2 +-
>   arch/arm64/kernel/probes/uprobes.c            |  24 +-
>   arch/arm64/kernel/traps.c                     |  80 +-----
>   arch/arm64/mm/fault.c                         |  75 -----
>   17 files changed, 338 insertions(+), 471 deletions(-)
>
> Sebastian

