Return-Path: <stable+bounces-246651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEeFNZJ5A2oR6QEAu9opvQ
	(envelope-from <stable+bounces-246651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:03:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37F528666
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D75230970CB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE55357A3E;
	Tue, 12 May 2026 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6wQtfYO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCC2D7D2E
	for <stable@vger.kernel.org>; Tue, 12 May 2026 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612155; cv=none; b=Oad110cVewF3U9MzYt/o6k5ZM4d6Wkxv/4VdINQluL/Jhriz9JFNnZZ2bMMHPvg5pVtiOotgWcOE7eysUJB2rlYBDgFkOx9+OtaDCQFYtAd65l0Uu9vytiMgDZADD8yVt9ZxIP7GVRAUL3ogOH8hit9A4Ei3scp2JXUPloTjTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612155; c=relaxed/simple;
	bh=YpNkICHwO3jCdKAl0LL5HmWKMFmNgj4OCEDikfq3svo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOYPay8lk+VnAcQJZvKTYpdhvcqQgkauM91Kt1YrpaTCbdUQrN7yCNqb6kmxstRb+6UDTyhIV40PkC2cc4TmKLHOo9PlO+7vJntMc4PAuQNwLwptvOqSJ/TamTP2nUlmOsel0hXtUgdaC8zIaBF/vS8ona8UflhwTEl7R7bQZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6wQtfYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A10C2BCB0;
	Tue, 12 May 2026 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778612154;
	bh=YpNkICHwO3jCdKAl0LL5HmWKMFmNgj4OCEDikfq3svo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6wQtfYON2Lo65wpxSC2KY3N3ETpsdAh0mAs3IpVAIoLlyWrSEoAGOwtAXQy/kQV2
	 b5kcexlK+Zc/LTP6q608vEkFO9tLtb+LmsFA7M0fqFtsfgghYyLvU0f3yK1GESb67N
	 bs5iwV/1KijpkOlb9Sk7dgOZML1JcNDPTaxdjmph6JRGeB67If/iWuYKST0m1XGc7/
	 3i8f88qIW1XWfXworlXF9yKKH1oXVujLBEM8ylGEkUw0jO1SeGhFycTkiTxqqL89ow
	 j6Dwlx3xX6ISfWUQ+1dztTeKihqzLo0/CVuK3QpFdpHlf9F5cKFSn5lLiuuoJ0DFGU
	 rhk+2ZqAMbljA==
Message-ID: <113dddc5-27e3-4e9e-a90c-f076a4629f51@kernel.org>
Date: Tue, 12 May 2026 20:55:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check before
 return device-private pmd
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Balbir Singh <balbirs@nvidia.com>, akpm@linux-foundation.org,
 ljs@kernel.org, riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, sj@kernel.org, ziy@nvidia.com,
 linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 stable@vger.kernel.org
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
 <0aab59b8-71c5-4059-8281-5dd876946528@kernel.org>
 <20260512143542.izpp3gu4iqxttw3f@master>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260512143542.izpp3gu4iqxttw3f@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3F37F528666
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246651-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 16:35, Wei Yang wrote:
> On Tue, May 12, 2026 at 02:43:54PM +0200, David Hildenbrand (Arm) wrote:
>> On 5/9/26 00:48, Balbir Singh wrote:
>>>
>>> Could you elaborate a more on the improper situation?
>>>
>>>
>>> Do we need to check softleaf_is_device_private() twice, can't we hold the pmd
>>> lock and check once?
>>
>> I think what we try to do here is, is to only grab the lock if we verified that there is something of interest in there.
>>
>> I wonder if we should rewrite that whole thing to just do a pmd_same() check after grabbing the lock.
>>
>> Something a lot cleaner like:
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index a4d52fdb3056..de6a255cc847 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -242,40 +242,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>                 */
>>                pmde = pmdp_get_lockless(pvmw->pmd);
>>
>> -               if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>> -                       pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> -                       pmde = *pvmw->pmd;
>> -                       if (!pmd_present(pmde)) {
>> -                               softleaf_t entry;
>> -
>> -                               if (!thp_migration_supported() ||
>> -                                   !(pvmw->flags & PVMW_MIGRATION))
>> -                                       return not_found(pvmw);
>> -                               entry = softleaf_from_pmd(pmde);
>> -
>> -                               if (!softleaf_is_migration(entry) ||
>> -                                   !check_pmd(softleaf_to_pfn(entry), pvmw))
>> -                                       return not_found(pvmw);
>> -                               return true;
>> -                       }
>> -                       if (likely(pmd_trans_huge(pmde))) {
>> -                               if (pvmw->flags & PVMW_MIGRATION)
>> -                                       return not_found(pvmw);
>> -                               if (!check_pmd(pmd_pfn(pmde), pvmw))
>> -                                       return not_found(pvmw);
>> -                               return true;
>> -                       }
>> -                       /* THP pmd was split under us: handle on pte level */
>> -                       spin_unlock(pvmw->ptl);
>> -                       pvmw->ptl = NULL;
>> -               } else if (!pmd_present(pmde)) {
>> -                       const softleaf_t entry = softleaf_from_pmd(pmde);
>> -
>> -                       if (softleaf_is_device_private(entry)) {
>> -                               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> -                               return true;
>> -                       }
>> +               if (pmd_present(pmde)) {
>> +                       if (!pmd_leaf(pmde))
>> +                               goto pte_table;
>> +                       if (pvmw->flags & PVMW_MIGRATION)
>> +                               return not_found(pvmw);
>> +                       if (!check_pmd(pmd_pfn(pmde), pvmw))
>> +                               return not_found(pvmw);
>> +               } else if (pmd_is_migration_entry(pmde)) {
>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>> +
>> +                       if (!(pvmw->flags & PVMW_MIGRATION))
>> +                               return not_found(pvmw);
>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> +                               return not_found(pvmw);
>> +               } else if (pmd_is_device_private_entry(pmde)) {
>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>>
>> +                       if (pvmw->flags & PVMW_MIGRATION)
>> +                               return not_found(pvmw);
>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> +                               return not_found(pvmw);
>> +               } else {
>>                        if ((pvmw->flags & PVMW_SYNC) &&
>>                            thp_vma_suitable_order(vma, pvmw->address,
>>                                                   PMD_ORDER) &&
>> @@ -285,6 +273,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>                        step_forward(pvmw, PMD_SIZE);
>>                        continue;
>>                }
>> +
>> +               /* Double-check under PTL that the PMD didn't change. */
>> +               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> +               if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
>> +                       return true;
>> +               spin_unlock(pvmw->ptl);
>> +               pvmw->ptl = NULL;
>> +               goto restart;
>> +pte_table:
>>                if (!map_pte(pvmw, &pmde, &ptl)) {
>>                        if (!pvmw->pte)
>>
>>
>>
>>
>> There is likely room to clean this up / compress it further.
> 
> I tried to compress above logic like this, hope it could look cleaner.
> 
> 	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
> 		unsigned long pfn;
> 		bool is_migration = pmd_is_migration_entry(pmde);
> 		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);
> 
> 		if (is_migration != for_migration)
> 			return not_found(pvmw);
> 
> 		if (pmd_trans_huge(pmde))
> 			pfn = pmd_pfn(pmde);
> 		else
> 			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));
> 
> 		if (!check_pmd(pfn, pvmw))
> 			return not_found(pvmw);
> 	} else if (!pmd_present(pmde)) {

It's more compact, but not necessarily cleaner. In particular, I detest
pmd_trans_huge(), we should phase it out.

if (pmd_present(pmde) && !pmd_leaf(pmde)) {
	goto pte_table;
} else if (pmd_present(pmde) || pmd_is_valid_softleaf(pmde))

...

Might work as well. But once we add support for other softleaf types, we'll have
to touch it again. So I'd rather just list what we actually expect.

-- 
Cheers,

David

