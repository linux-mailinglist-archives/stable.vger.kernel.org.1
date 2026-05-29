Return-Path: <stable+bounces-256666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCeVJRrTGWodzQgAu9opvQ
	(envelope-from <stable+bounces-256666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:55:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB210606E72
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2417F329216A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC143769FA;
	Fri, 29 May 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ABQLmk1c"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E6378D82
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074333; cv=none; b=bRh55OeKR7iRpGdP3hBjoxL4y/IGqaBvdD3darskUmHRzL0baSpAVBqHcD1TFXCwEqXSWqCOvXcmleHbr/lMjVps/NEYjxHeykCPH5lAtaEixEwGNjfd3PK3g5QLbOovAk7oiLJlYMvFrYAHRdxhERomjCO1U24WLtdPKpraxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074333; c=relaxed/simple;
	bh=fhv+F4PMFpsg55KDSG9Z1A+Pt8O7O/9mlFmEknERxGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=j2OJzAxMAYN1FaM0sdDcYFpC4MwBYqq2hXMxRVCVYsFUjpMMsbjuXWAF7rCGngGhI3a+u+tk0ItQ/q9X4U89ttg57jQkDuOXyOuUKwpCRPDr3JSV2Kh3gag3Ob7byyw/fjV37O41qrnixuiVzhamvfs/3pI0xnhQe45Co/0VNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ABQLmk1c; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB70A34FB;
	Fri, 29 May 2026 10:05:25 -0700 (PDT)
Received: from [10.57.36.140] (unknown [10.57.36.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4953F905;
	Fri, 29 May 2026 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780074330; bh=fhv+F4PMFpsg55KDSG9Z1A+Pt8O7O/9mlFmEknERxGE=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=ABQLmk1cufg9gpt7uCZFlyS5DspuAcLnWSZSB3mGuwbri1mSIjTgCjvazUcsjHmoG
	 hja2d6sxnFSqXyMn+lUmw2C4lPAhbVgj5TGybBKk8dEhz8ocOCpdKyasjCeDV66t1/
	 Ko28on+dqg4IhTE8OmqwJOSHnTRsMXdBAQtJLH8A=
Message-ID: <a328aaa6-0e34-4dfc-b4ab-0193e8bca6ee@arm.com>
Date: Fri, 29 May 2026 18:05:27 +0100
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
 <48316697-6c3b-465c-a49a-d2adb749d459@arm.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US, en-GB, fr
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <48316697-6c3b-465c-a49a-d2adb749d459@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256666-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ada.coupriediaz@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: BB210606E72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29/05/2026 14:38, Ada Couprie Diaz wrote:

> Hi Sebastian, thanks a lot for the backport !
>
> I'll take a more thorough look soon just to check, but the original
> series contained a bug with pseudo-NMIs, which I corrected
> in a later patch[0] in commit ea0d55ae4b32 ("arm64: debug:
> always unmask interrupts in el0_softstp()").
>
> I see that the bug is present in the backport, so the fix should 
> definitely
> be added to the series !
>
> Kind regards,
> Ada
>
> [0]: 
> https://lore.kernel.org/all/20251014092536.18831-1-ada.coupriediaz@arm.com/
>
> On 28/05/2026 15:48, Sebastian Andrzej Siewior wrote:
>> Hi,
>>
>> this is a backport of the "arm64: debug: remove hook registration, split
>> exception entry" series
>>     https://lore.kernel.org/all/20250707114109.35672-1-ada.coupriediaz@arm.com/ 
>>
>>
>> which has been merged as of v6.17-rc1. It fixes the HW breakpoint issue
>> on PREEMPT_RT.
>>
>> I only picked one dependency and manually fixed the other conflicts to
>> avoid a larger backport.

Given the conflicts do not seem to have required significant code changes,
I don't know how useful it is but it all looks good to me ; conditional 
on pulling
the EL0 soft-step fix for pseudo-NMIs with the backport.

Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Thanks again for backporting the series !
Kind regards,
Ada

>>
>> This has been prepared against v6.12.91. v6.12-stable is the only
>> relevant tree for a backport (earlier stable version have no PREEMPT_RT
>> support).
>>
>> [...]
>>
>> Sebastian

