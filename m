Return-Path: <stable+bounces-210790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKuDBI8WcWmodQAAu9opvQ
	(envelope-from <stable+bounces-210790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:10:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A11CE5B101
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C886A7E398A
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8514B30DD34;
	Wed, 21 Jan 2026 16:04:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27543E4A6
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011455; cv=none; b=oFfqnbBsvNYqi0u45P6Hv8cUhiwtfxsui2mVF9va4d8yx4mvJ+Q8w2BMkCp595lpsCHb2ETz3sbrtFIz8YS4agdTgF55V/I5BEMbi1pQHFpTUvFPIGsIVBzWhktYtbcxqt7GjgbRCl8nzNU4nsmkvO8UfN48iQEC89myePc+7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011455; c=relaxed/simple;
	bh=ZXsNa/HKBld4onzBriua4Zl8F07PJEDl23YA4bFkd/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGDIZmAcWx8dVrmXAS0Zvp9r9wpLMXeFyIgOnspiO7xo540Nes1LiIblYQo7N/yLktlxIh/X7tJAr+Nu9Qf2Xgp6ifgoU3dH9G/0M+2Q309VXqNyQXdeSciU3rPuLIPCqV01h0OsHPEydB+XYyZ8W9qD1isu5j2QABbj1LT/43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECA3B1476;
	Wed, 21 Jan 2026 08:04:05 -0800 (PST)
Received: from [10.57.49.179] (unknown [10.57.49.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240CA3F694;
	Wed, 21 Jan 2026 08:04:10 -0800 (PST)
Message-ID: <6bffe794-b5d5-421e-9091-594201bb3b6d@arm.com>
Date: Wed, 21 Jan 2026 17:04:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: poe: fix stale POR_EL0 values for ptrace
To: Mark Rutland <mark.rutland@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
 david.spickett@arm.com, stable@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20260121135639.1835784-1-joey.gouly@arm.com>
 <4f4b9dd9-02ed-4899-b17d-24415e50e5c3@arm.com> <aXDynm0YGuNzi7B3@J2N7QTR9R3>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <aXDynm0YGuNzi7B3@J2N7QTR9R3>
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
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
	TAGGED_FROM(0.00)[bounces-210790-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A11CE5B101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 16:37, Mark Rutland wrote:
> On Wed, Jan 21, 2026 at 03:59:22PM +0100, Kevin Brodsky wrote:
>> On 21/01/2026 14:56, Joey Gouly wrote:
>>> If a process wrote to POR_EL0 and then crashed before a context switch
>>> happened, the coredump would contain an incorrect value for POR_EL0.
>> Isn't that also a problem if using ptrace(PTRACE_GETREGSET, REGSET_POE)?
> In the case of manipulating a tracee (i.e. target != current), the core
> code ensures that the tracee is stopped (has context-switched out, an
> hence has saved its registrer contents to memory) before the relevant
> regset functions can be called.

Right, hadn't thought that through!

>> Just like for fpsimd, etc.
> Just FYI, The FPSIMD/SVE/SME registers are a special case relative to
> all the other regsets.
>
> The FPSIMD/SVE/SME registers eagerly saved to memory (and so when a task
> is scheduled out, the value in memory will be up-to-date), but they're
> lazily restored (so the value in registers can be transiently stale
> while the task is running), and there's a special case when scheduling a
> task in where we attempt to spot if the CPU registers happen to be
> up-to-date with the task.
>
> The gist of this is that when manipulating the FPSIMD/SVE/SME regsets of
> a task:
>
> * For reads, we know that the value in memory is up-to-date unless the
>   task is the current task.
>
> * For writes (which can only occur for a tracee which is not the current
>   task), we need to update some tracking data to prevent context-switch
>   from reusing stale values on a CPU. That's what
>   fpsimd_flush_task_state() does.
>
> Pretty much all other regsets don't need the "flush" on writes, since
> the value in memory will be loaded when the task is next scheduled in.

That is good to know, thanks! I actually meant to write TLS/TPIDR as
that's a more comparable case (not saved/restored on exception
entry/return), but as you pointed out above a task must be scheduled out
before its register state is inspected so there's no concern here.

- Kevin

