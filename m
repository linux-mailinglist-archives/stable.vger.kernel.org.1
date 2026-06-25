Return-Path: <stable+bounces-268262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qh1TBUu3PGqqqwgAu9opvQ
	(envelope-from <stable+bounces-268262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 07:06:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FAF6C2B72
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 07:06:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=UiR8YwXC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268262-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268262-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03AB302D104
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F12F28EA;
	Thu, 25 Jun 2026 05:06:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DB2309AA;
	Thu, 25 Jun 2026 05:06:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782363972; cv=none; b=isuDwhRJFTmkaxlzl+w65oiqdZoNjajazcKC16T2B++0XOiYbj+sQzZ2C6HTucYM/eNWUJyD7ea1fC87/tRl532oU+GRdwiumbF6hIJtVTVo8MKQonEGe/4KICXroKg5Z1dPpYRnZBpJKjhc+fpjuk+D9jeP0gvzs4hDXisw0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782363972; c=relaxed/simple;
	bh=Lay1HVOEFuLeVqkTA0aGqyvQ+T34DBOYVeHMQyWlWxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZ6Ppp/SGRuYhYGL381tdtiBihUo5s5exuMAGUl9+7IzihQbf16mqI/g3jiKT2Np8GE4jWbsxv01MzvbcHD93yuknFi1J5glUoUL3oQ/g/iECA0bgWW04xQl6Axg/tVWFobovLSU8152vLZRzPXSTwxvjFh0RVMjxqnclFEMULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UiR8YwXC; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0E762BCE;
	Wed, 24 Jun 2026 22:06:04 -0700 (PDT)
Received: from [10.164.19.14] (unknown [10.164.19.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994CC3F905;
	Wed, 24 Jun 2026 22:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782363969; bh=Lay1HVOEFuLeVqkTA0aGqyvQ+T34DBOYVeHMQyWlWxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UiR8YwXC0OcWwu5H/2F2xG3WeZQPa7DTkaff1XDArWPQ5iDEW4vKBeqhsms5v91dY
	 nqB/Pji3MJWFNE6eJIjpqk1zLtQ/xjJKzh1aVx9RrmCi8V/V0xd7EUS57VvjCat5l4
	 CF/2pyXu3QWf/JrjUquDEykrcJRasB6AnnkTJwH4=
Message-ID: <c17ea0ca-1e6c-4504-87f5-219f13c846f5@arm.com>
Date: Thu, 25 Jun 2026 10:36:02 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, riel@surriel.com, liam@infradead.org,
 vbabka@kernel.org, harry@kernel.org, jannh@google.com, kas@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260625042853.2752898-1-dev.jain@arm.com>
 <20260624214230.4aff522ec8fa4a8f1607c942@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260624214230.4aff522ec8fa4a8f1607c942@linux-foundation.org>
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
	TAGGED_FROM(0.00)[bounces-268262-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51FAF6C2B72



On 25/06/26 10:12 am, Andrew Morton wrote:
> On Thu, 25 Jun 2026 04:28:51 +0000 Dev Jain <dev.jain@arm.com> wrote:
> 
>> try_to_unmap_one() handles hugetlb folios when memory failure needs
>> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
>> case page_vma_mapped_walk() returns the hugetlb entry in pvmw.pte, but
>> the code reads it with ptep_get() before decoding the PFN.
>>
>> That is wrong on architectures where hugetlb entries are not encoded as
>> regular PTEs. On s390, for example, a raw huge RSTE must be converted
>> by huge_ptep_get() before helpers such as pte_pfn() can inspect it. A
>> raw decode can select the wrong subpage, so try_to_unmap_one() can
>> install a hwpoison entry for the wrong PFN.
>>
>> The userspace-visible result is that a later access to the poisoned
>> hugetlb subpage can miss the expected SIGBUS. With DEBUG_VM, the wrong
>> subpage can also trip the PageHWPoison check.
>>
>> Use huge_ptep_get() for hugetlb mappings before decoding the PFN.
>>
>> Before c7ab0d2fdc84, the bug existed in the form of a plain dereference:
>> we would check the head page pfn of the hugetlb with pte_pfn(*pte), and
>> bail out on mismatch. This would mean that the hwpoisoned entry will not
>> get installed.
>>
>> I am not sure what is the procedure on such kinds of very old bugs - how
>> back should I really go?
> 
> I think 9 years is enough ;)
> 
>> There are similar old bugs present, in try_to_migrate_one(), check_pte(),
>> remove_migration_pte(), prot_none_hugetlb_entry().
> 
> Why now?  Was there some more recent (s390?) change which exposed this?

I was refactoring the hugetlb bits in try_to_unmap_one, so the bug got
caught in review by David (which reminds me to put a "Reported-by" tag
on this patch).

I guess if someone would run hugetlb-read-hwpoison.c on s390, this would
be caught. Turns out, this selftest is in a category of "destructive tests"
in run_vmtests.sh, so ./run_vmtests.sh or even ./run_vmtests.sh -a won't
run this. We are supposed to run this with ./run_vmtests.sh -d, and that
option was broken until one month ago, see 3432cbb291aa. So essentially
no one has been running that test.
> 


