Return-Path: <stable+bounces-268247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TXtrHsmSPGoupggAu9opvQ
	(envelope-from <stable+bounces-268247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 04:30:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B66C2649
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 04:30:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=giYOnuqR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268247-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268247-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 828FF3056879
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9FC383980;
	Thu, 25 Jun 2026 02:30:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2414238399C;
	Thu, 25 Jun 2026 02:29:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354601; cv=none; b=UKTj9/G+dqPh4FTLCGqaRwZGK3IDwB3Mkx09rx2ZumgF1ZSwZh2eAZ73XtCCQNUlZsKvMs2BFajBMsBV7uo9lt7TGnpi3GshW5wD4+dYGkPwRWa/8f2kiEdzEchAF9pKNBzsQrA16HasEfXyyTHaPfS9jxwXjzliFbSGeGql04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354601; c=relaxed/simple;
	bh=H4FgjilvRhDxaejSOs5jXTlNlpdPoqb31yfgAlihuI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtpAcnbZg2Aj5jpvWHAB4Q5z9+hDBpT3WKygi1aW9Nz/yP2+t86Y/LhUhrkArP8l4kSI8OJEeW8Cy981lEyaaCmsBwQ8KbJuim/jSes4/j5Ew9M2IBDenGRMt0ObPpejqPpzCOZYtKCOgydp19v2lh6ZmPJEVBhjUPIgi1cP64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=giYOnuqR; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 719C72309;
	Wed, 24 Jun 2026 19:29:52 -0700 (PDT)
Received: from [10.164.18.48] (J09HK2D2RT.blr.arm.com [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE6E53F836;
	Wed, 24 Jun 2026 19:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782354597; bh=H4FgjilvRhDxaejSOs5jXTlNlpdPoqb31yfgAlihuI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=giYOnuqRdTISFy6hmWYZAGBzFNiE301udlj9j8E36XojIMm1id4IDbBt0Pz8fXMi+
	 lPks3QTwKXnd2PcNe+ZX+ft3eOkI9Mz0BwsIm2M8pVZLdSWoEim1eegI/oZYlyKXCU
	 8EfgGf/tcUo4PnBel4ckzDZ78lcKhuSctPtNojKI=
Message-ID: <b51f82ed-aa54-4c67-bcef-e59acd10c789@arm.com>
Date: Thu, 25 Jun 2026 07:59:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 337/522] arm64/mm: Enable batched TLB flush in
 unmap_hotplug_range()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, patches@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
 mark.rutland@arm.com
References: <20260616145125.307082728@linuxfoundation.org>
 <20260616145141.584613180@linuxfoundation.org>
 <b0d5836032ce3135bfc473f6bff791306d086925.camel@decadent.org.uk>
 <ajqXWqiAol6Shdd6@willie-the-truck>
 <d2a633c8-496e-48e1-bfa0-a0fc75bd0a08@arm.com>
 <2026062451-bluff-coherent-672d@gregkh>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <2026062451-bluff-coherent-672d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268247-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:ryan.roberts@arm.com,m:will@kernel.org,m:ben@decadent.org.uk,m:catalin.marinas@arm.com,m:david@kernel.org,m:patches@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:mark.rutland@arm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[anshuman.khandual@arm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anshuman.khandual@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C52B66C2649



On 24/06/26 9:59 PM, Greg Kroah-Hartman wrote:
> On Wed, Jun 24, 2026 at 04:05:01PM +0100, Ryan Roberts wrote:
>> On 23/06/2026 15:25, Will Deacon wrote:
>>> On Sun, Jun 21, 2026 at 05:02:27PM +0200, Ben Hutchings wrote:
>>>> On Tue, 2026-06-16 at 20:28 +0530, Greg Kroah-Hartman wrote:
>>>>> 6.1-stable review patch.  If anyone has any objections, please let me know.
>>>>>
>>>>> ------------------
>>>>>
>>>>> From: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>
>>>>> [ Upstream commit 48478b9f791376b4b89018d7afdfd06865498f65 ]
>>>> [...]
>>>>> @@ -949,15 +953,14 @@ static void unmap_hotplug_pmd_range(pud_
>>>>>  		WARN_ON(!pmd_present(pmd));
>>>>>  		if (pmd_sect(pmd)) {
>>>>>  			pmd_clear(pmdp);
>>>>> -
>>>>> -			/*
>>>>> -			 * One TLBI should be sufficient here as the PMD_SIZE
>>>>> -			 * range is mapped with a single block entry.
>>>>> -			 */
>>>>> -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>>>> -			if (free_mapped)
>>>>> +			if (free_mapped) {
>>>>> +				/* CONT blocks are not supported in the vmemmap */
>>>>> +				WARN_ON(pmd_cont(pmd));
>>>>> +				flush_tlb_kernel_range(addr, addr + PMD_SIZE);
>>>>
>>>> It wasn't clear to me from the commit message why this now adds PMD_SIZE
>>>> rather than PAGE_SIZE.  It seems like this change is fine for Linux
>>>> 6.13+ with a CPU that supports TLB range flushing, but otherwise results
>>>> in unnecessarily executing multiple TLB invalidations at intervals of
>>>> the base page size.
>>>
>>> Hmm, the commit message also makes very little sense to me and so I don't
>>> understand why this patch has us doing multiple TLB invalidations when
>>> we run into a !cont, block mapping at the PMD level. The old comment
>>> (which this patch removes) should still apply afaict.
>>>
>>> Anshuman, Ryan, any ideas what's going on here?
>>
>> I think this change was probably my fault; Given the API is called
>> flush_tlb_kernel_range() it seemed like an abuse/hack to pretend we are only
>> flushing the first PAGE_SIZE of the range. But as I understand it, even if the
>> HW shatters a block mapping into multiple TLB entries, all of the entries
>> relating to the block mapping will be invalidated if just one of them intersects
>> the TLBI range/address. So it should be safe to reapply this hack.
>>
>> Although ideally I think it would be better if this API took a stride argument;
>> then intent is clear.
>>
>> What's the best way to handle this? Submit a patch for mainline that reverts
>> this part, then get it backported to stable (implying this current patch will
>> have been applied to stable)?
> 
> yes, that's probably the best way.
Sure, will send out the change as suggested.

