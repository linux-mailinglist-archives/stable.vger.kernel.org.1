Return-Path: <stable+bounces-230155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM6MISmKwmkLewQAu9opvQ
	(envelope-from <stable+bounces-230155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:57:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17E308C41
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2181307C808
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224D307492;
	Tue, 24 Mar 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxGj9ugq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83812241665;
	Tue, 24 Mar 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356385; cv=none; b=o1c73NztyPi5SWA2CaUFsuuJSSR6GeSNFzOQwPIuqvXOWrewoLK5WrR8wFoIXFTixVVqHaLCEFoD6D/e4QCcnw/aDl3v4vkxqEm3eVwYoUZneaYbAnkl5v0DHYY3NUk7u7aSvs8tOx0Wyu+dP5Kdgn/ciTzfs1Ain1cYDogzp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356385; c=relaxed/simple;
	bh=pj0qNOEO5MNCC+dnvNkS1WO0CHnBtfXliGY5/GqJgPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdZYdBNZ/gEwOIxWPLeDDKPUjU1plRnvI/DNhGGKCBxyAzl+rYXN8VkDvFiryIeXDG+DK6Wi3EFcRcuZksTGQo1LXp1dE9nNhbcWOw4aZybfXrrye2J4jXl1CBKyyw36zvdnCxjipLWHRSm8G+SdIj8+AEcBkdo8Gv2fUZlvQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxGj9ugq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D74C19424;
	Tue, 24 Mar 2026 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356385;
	bh=pj0qNOEO5MNCC+dnvNkS1WO0CHnBtfXliGY5/GqJgPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZxGj9ugqZy4OaUMpJcbotouHGeD9e5JDcxz4fZYcsg86sxfxHkxx433cdmP6HrAEk
	 qXrc+urtRiZjqJvUeYAlKqfJU2O5oGcJus9uZ5ePCueSrJA59iEYM99IQcRr4PxDlH
	 KR2TZMdSym3GbI/F8CtRnK2FK8tAZzywiVpIfZwenWzAG4o8YpIIKAz4APJU/J4EH3
	 HuNrojgkpeT74yfUIZdMspOlhkR/XG2gAPqEGY0Cs18hnO4xiJflg7epi7NmGOFXL/
	 hmBUkOTy7d52Nk6wEi1mzkb4YnlyeGzr0qP/D/mOd82RQdBtsyfCX6dPhhUmwM5o0i
	 MKglDcXVpi3pg==
Message-ID: <43cc2290-10b6-4db3-bfc0-169adb8201b7@kernel.org>
Date: Tue, 24 Mar 2026 13:46:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 Alex Williamson <alex@shazbot.org>, Max Boone <mboone@akamai.com>,
 stable@vger.kernel.org
References: <20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org>
 <b3b78722-c265-484b-acde-3aa4bee0aac7@lucifer.local>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <b3b78722-c265-484b-acde-3aa4bee0aac7@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230155-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E17E308C41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 12:04, Lorenzo Stoakes (Oracle) wrote:
> On Mon, Mar 23, 2026 at 09:20:18PM +0100, David Hildenbrand (Arm) wrote:
>> follow_pfnmap_start() suffers from two problems:
>>
>> (1) We are not re-fetching the pmd/pud after taking the PTL
>>
>> Therefore, we are not properly stabilizing what the lock lock actually
>> protects. If there is concurrent zapping, we would indicate to the
>> caller that we found an entry, however, that entry might already have
>> been invalidated, or contain a different PFN after taking the lock.
>>
>> Properly use pmdp_get() / pudp_get() after taking the lock.
>>
>> (2) pmd_leaf() / pud_leaf() are not well defined on non-present entries
>>
>> pmd_leaf()/pud_leaf() could wrongly trigger on non-present entries.
>>
>> There is no real guarantee that pmd_leaf()/pud_leaf() returns something
>> reasonable on non-present entries. Most architectures indeed either
>> perform a present check or make it work by smart use of flags.
> 
> It seems huge page split is the main user via pmd_invalidate() ->
> pmd_mkinvalid().
> 
> And I guess this is the kind of thing you mean by smart use of flags, for
> x86-64:

Exactly.

[...]

> 
>>
>> However, for example loongarch checks the _PAGE_HUGE flag in pmd_leaf(),
>> and always sets the _PAGE_HUGE flag in __swp_entry_to_pmd(). Whereby
>> pmd_trans_huge() explicitly checks pmd_present(), pmd_leaf() does not
>> do that.
> 
> But pmd_present() checks for _PAGE_HUGE in pmd_present(), and if set checks
> whether one of _PAGE_PRESENT, _PAGE_PROTNONE, _PAGE_PRESENT_INVALID is set,
> and pmd_mkinvalid() sets _PAGE_PRESENT_INVALID (clearing _PAGE_PRESENT,
> _VALID, _DIRTY, _PROTNONE) so it'd return true.

pmd_present() will correctly indicate "not present" for, say, a softleaf
migration entry.

However, pmd_leaf() will indicate "leaf" for a softleaf migration entry.

So not checking pmd_present() will actually treat non-present migration
entries as present leafs in this function, which is wrong in the context
of this function.

We're walking present entries where things like pmd_pfn(pmd) etc make sense.

> 
> pmd_leaf() simply checks to see if _PAGE_HUGE is set which should be
> retained on split so should all still have worked?
> 
> But anyway this is still worthwhile I think.
> 
>>
>> Let's check pmd_present()/pud_present() before assuming "the is a
>> present PMD leaf" when spotting pmd_leaf()/pud_leaf(), like other page
>> table handling code that traverses user page tables does.
>>
>> Given that non-present PMD entries are likely rare in VM_IO|VM_PFNMAP,
>> (1) is likely more relevant than (2). It is questionable how often (1)
>> would actually trigger, but let's CC stable to be sure.
>>
>> This was found by code inspection.
>>
>> Fixes: 6da8e9634bb7 ("mm: new follow_pfnmap API")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> This looks correct to me, so:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Thanks!

> 
>> ---
>> Gave it a quick test in a VM with MM selftests etc, but I am not sure if
>> I actually trigger the follow_pfnmap machinery.
>> ---
>>  mm/memory.c | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 219b9bf6cae0..2921d35c50ae 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -6868,11 +6868,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
>>
>>  	pudp = pud_offset(p4dp, address);
>>  	pud = pudp_get(pudp);
>> -	if (pud_none(pud))
>> +	if (!pud_present(pud))
>>  		goto out;
>>  	if (pud_leaf(pud)) {
>>  		lock = pud_lock(mm, pudp);
>> -		if (!unlikely(pud_leaf(pud))) {
>> +		pud = pudp_get(pudp);
>> +
>> +		if (unlikely(!pud_present(pud))) {
>> +			spin_unlock(lock);
>> +			goto out;
>> +		} else if (unlikely(!pud_leaf(pud))) {
> 
> Tiny nit, but no need for else here. Sometimes compilers complain about
> this but not sure if it such pedantry is enabled in default kernel compiler
> flags :)

You mean

if (unlikely(!pud_present(pud))) {
	spin_unlock(lock);
	goto out;
}
if (...) {

?

That just creates an additional LOC without any benefit IMHO. And we use
it all over the place :)

In fact, I will beat any C compiler with the C standard that complains
about that ;)

-- 
Cheers,

David

