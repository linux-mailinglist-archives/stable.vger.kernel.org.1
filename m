Return-Path: <stable+bounces-268178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QNqlH7z0O2qugQgAu9opvQ
	(envelope-from <stable+bounces-268178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:16:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7946BF8B2
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:16:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Q35MDHB4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268178-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268178-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60526302CF22
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1F3D812C;
	Wed, 24 Jun 2026 15:05:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7167E2BDC2F;
	Wed, 24 Jun 2026 15:05:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313506; cv=none; b=ABcP1Kwt/HWkihQWYULPHhuPezWAfPTKFAsreQWNkwgIZwurL9n+nPgdDMrfCwmPiJfH7kKHTuC5E2fCeAkvk5E+S7B26SstdGDKRdlblUBSZ7P9E5vKVIoKQIWfCVCKfaGPxXO/5bsD68gEl5IpiUeTm+A8rImKrKRzkGKfTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313506; c=relaxed/simple;
	bh=t/6bTMiWUaEV1IYOjK8N+ioKve+8nIP8GwG/6p2eaTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acfbzFSHXAKIkgmGkS1IBwGFbJlU+1tvhJgM0NyacP8LPOLYj9vnB8wwRPHmSygFDyw1TxOKVdlIFH6oLcfcJRUApUNMDq6Vlyf7aixP2qqpEZu2QPfBfuKCyAcuhdn4AmY2Zv9tPVk0VBakPnpDapBh3W2UjV3wya018Wuo4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q35MDHB4; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 392592308;
	Wed, 24 Jun 2026 08:05:00 -0700 (PDT)
Received: from [10.1.25.171] (XHFQ2J9959-4.cambridge.arm.com [10.1.25.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 228DF3F905;
	Wed, 24 Jun 2026 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782313504; bh=t/6bTMiWUaEV1IYOjK8N+ioKve+8nIP8GwG/6p2eaTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q35MDHB4NR7gxpgq4eAorP8mtkFCyLvLaC/Od24ga5UC549ID02pnOqRcnH6WRw4y
	 VnXBa8D8vtzVB1X31ZHO7sAz9n5a5CeMqqgaSGy+h846vop4qVp5pdAvA41zoByrv1
	 2c2Jsp9lHo0JDLD48N/06IdttEj2eHmNG5YdxR8c=
Message-ID: <d2a633c8-496e-48e1-bfa0-a0fc75bd0a08@arm.com>
Date: Wed, 24 Jun 2026 16:05:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 337/522] arm64/mm: Enable batched TLB flush in
 unmap_hotplug_range()
To: Will Deacon <will@kernel.org>, Ben Hutchings <ben@decadent.org.uk>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, patches@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>, mark.rutland@arm.com
References: <20260616145125.307082728@linuxfoundation.org>
 <20260616145141.584613180@linuxfoundation.org>
 <b0d5836032ce3135bfc473f6bff791306d086925.camel@decadent.org.uk>
 <ajqXWqiAol6Shdd6@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <ajqXWqiAol6Shdd6@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268178-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:will@kernel.org,m:ben@decadent.org.uk,m:anshuman.khandual@arm.com,m:catalin.marinas@arm.com,m:david@kernel.org,m:patches@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:mark.rutland@arm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B7946BF8B2

On 23/06/2026 15:25, Will Deacon wrote:
> On Sun, Jun 21, 2026 at 05:02:27PM +0200, Ben Hutchings wrote:
>> On Tue, 2026-06-16 at 20:28 +0530, Greg Kroah-Hartman wrote:
>>> 6.1-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: Anshuman Khandual <anshuman.khandual@arm.com>
>>>
>>> [ Upstream commit 48478b9f791376b4b89018d7afdfd06865498f65 ]
>> [...]
>>> @@ -949,15 +953,14 @@ static void unmap_hotplug_pmd_range(pud_
>>>  		WARN_ON(!pmd_present(pmd));
>>>  		if (pmd_sect(pmd)) {
>>>  			pmd_clear(pmdp);
>>> -
>>> -			/*
>>> -			 * One TLBI should be sufficient here as the PMD_SIZE
>>> -			 * range is mapped with a single block entry.
>>> -			 */
>>> -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>> -			if (free_mapped)
>>> +			if (free_mapped) {
>>> +				/* CONT blocks are not supported in the vmemmap */
>>> +				WARN_ON(pmd_cont(pmd));
>>> +				flush_tlb_kernel_range(addr, addr + PMD_SIZE);
>>
>> It wasn't clear to me from the commit message why this now adds PMD_SIZE
>> rather than PAGE_SIZE.  It seems like this change is fine for Linux
>> 6.13+ with a CPU that supports TLB range flushing, but otherwise results
>> in unnecessarily executing multiple TLB invalidations at intervals of
>> the base page size.
> 
> Hmm, the commit message also makes very little sense to me and so I don't
> understand why this patch has us doing multiple TLB invalidations when
> we run into a !cont, block mapping at the PMD level. The old comment
> (which this patch removes) should still apply afaict.
> 
> Anshuman, Ryan, any ideas what's going on here?

I think this change was probably my fault; Given the API is called
flush_tlb_kernel_range() it seemed like an abuse/hack to pretend we are only
flushing the first PAGE_SIZE of the range. But as I understand it, even if the
HW shatters a block mapping into multiple TLB entries, all of the entries
relating to the block mapping will be invalidated if just one of them intersects
the TLBI range/address. So it should be safe to reapply this hack.

Although ideally I think it would be better if this API took a stride argument;
then intent is clear.

What's the best way to handle this? Submit a patch for mainline that reverts
this part, then get it backported to stable (implying this current patch will
have been applied to stable)?

Thanks,
Ryan


> 
> Will


