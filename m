Return-Path: <stable+bounces-214365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLIxDoevg2l1swMAu9opvQ
	(envelope-from <stable+bounces-214365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:43:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BAFEC8A0
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAD293010BB5
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 20:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127FA4219F3;
	Wed,  4 Feb 2026 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmNAkM8P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A52436343
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770237827; cv=none; b=FGC39FSd0X+VtOtqusr++3/gwK/yCtk0UlrhV0650ituDRLaDIjcQhX3ieuXH5aGZJpbSN0TffzeFvzzD0O5ZKjuHyZJnnIIDtapSHPScMjmtl6ul4uE2oYgkvIG8HDfYuedNozidx+KuN+EKi+42C0h91inAgi/OVhriJEK+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770237827; c=relaxed/simple;
	bh=KWSG6PWanp5dDS8uJVMx5rjP8FzfGf3/ZzBMjhgV2us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoRjVrD2+6pJ0YbA27hddJkgq4r9cTVG6yG1z4exyFrmVr1icxD4s3mkmEKgb1seVqHfVBc7+Q6PZkte59LRcDkoOZDIffljiwE23XiQyTZ+WSIjKLZrZcVzHl/J07CXsYCXf+GcbwN6KNNGm4c12/n0jFRJVY3uxFiBK9uO75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmNAkM8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB711C4CEF7;
	Wed,  4 Feb 2026 20:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770237827;
	bh=KWSG6PWanp5dDS8uJVMx5rjP8FzfGf3/ZzBMjhgV2us=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FmNAkM8PJqKCYA2j+QcaaxVSh/GQI62iNvi9qqTy29je5IVbNYHuS9Y76g5ccjw2e
	 DdP6cjPjrL+P4RrglwS2Bw0/kcXaLWuYzP7KmF8ShPaqM8KGTsKVSF++5AiEEXUisR
	 57nIvYwX20tWGjTkHSDtfZAfWN9DGtjhYZfM41Ci9zp/MQGxaMqb80k9OaVa7UOqDF
	 3AwMiWZArvxgOqndgNBYMpFC6HaqpsOXNnOkHHrxa3sfRJ5woBNjGOuY1HwBWsIIBe
	 b3Acm4Qm0cHnbbcdjlwU6ZC1Q0omVMKbWy8+O+IgkVMltkCsITtW+z8ilsFoAl0c0V
	 Qu4WWUuZiUR/w==
Message-ID: <df86ccfd-68a5-416e-81cc-02858e395b70@kernel.org>
Date: Wed, 4 Feb 2026 21:43:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, riel@surriel.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, harry.yoo@oracle.com, jannh@google.com, gavinguo@igalia.com,
 baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
 Lance Yang <lance.yang@linux.dev>, stable@vger.kernel.org
References: <20260204004219.6524-1-richard.weiyang@gmail.com>
 <d3f4456d-f2e1-4d8f-aa92-77ccd1606d59@kernel.org>
 <E4DA2E02-DE3B-4D26-A427-5D53FCA36A58@nvidia.com>
From: "David Hildenbrand (arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <E4DA2E02-DE3B-4D26-A427-5D53FCA36A58@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214365-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,oracle.com,surriel.com,suse.cz,google.com,igalia.com,linux.alibaba.com,kvack.org,linux.dev,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 75BAFEC8A0
X-Rspamd-Action: no action

On 2/4/26 21:02, Zi Yan wrote:
> On 4 Feb 2026, at 14:36, David Hildenbrand (arm) wrote:
> 
>> Sorry for the late reply. I saw that I was CCed in v1 but I am only now catching up with mails ... slowly but steadily.
>>
>>> Without the above commit, we can successfully split to order 0.
>>> With the above commit, the folio is still a large folio.
>>>
>>> The reason is the above commit return false after split pmd
>>> unconditionally in the first process and break try_to_migrate().
>>>
>>> The tricky thing in above reproduce method is current debugfs interface
>>> leverage function split_huge_pages_pid(), which will iterate the whole
>>> pmd range and do folio split on each base page address. This means it
>>> will try 512 times, and each time split one pmd from pmd mapped to pte
>>> mapped thp. If there are less than 512 shared mapped process,
>>> the folio is still split successfully at last. But in real world, we
>>> usually try it for once.
>>
>> Ah, that explains magic number 513.
>>
>>>
>>> This patch fixes this by restart page_vma_mapped_walk() after
>>> split_huge_pmd_locked(). Because split_huge_pmd_locked() may fall back to
>>> (freeze = false) if folio_try_share_anon_rmap_pmd() fails and the PMD is
>>> just split instead of split to migration entry.
>>
>> Right, but folio_try_share_anon_rmap_pmd() should never fail on the folios that have already been shared? (above you write that it is shared with 512 children)
>>
>> The only case where  folio_try_share_anon_rmap_pmd() could fail would be if the folio would not be shared, and there would only be a single PMD then, so there is nothing you can do -> abort.
>>
>> Returning "false" from try_to_migrate_one() is the real issue, as it makes rmap_walk_anon() to just stop -> abort the walk.
>>
>>
>> So I suspect v1 was actually sufficient, or what am I missing where the restart would actually be required?
> 
> The explanation is not for the shared case mentioned above. It is for unshared
> folio. If an unshared folio’s PAE cannot be cleared, try_to_migrate_one() return
> true, indicating a success.

Oh. You mean that should be something like

"This patch fixes this by restart page_vma_mapped_walk() after 
split_huge_pmd_locked(). We cannot simply return "true" to fix the 
problem, as that would affect another case: 
split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and 
leave the folio mapped through PTEs; we would return "true" from 
try_to_migrate_one() in that case as well. While that is mostly 
harmless, we could end up walking the rmap, wasting some cycles.".


> Yeah, since it is an unshared folio, the return
> value of try_to_migrate_one() does not matter. This fix makes try_to_migrate_one()
> return false.

Right, it's not really problematic. We could end up walking the rmap and 
burn some cycles.

> 
>>
>>
>> (maybe we should get rid of the usage of booleans here at some point, an enum like abort/continue would have been much clearer)
>>
>>> Restart
>>> page_vma_mapped_walk() and let try_to_migrate_one() try on each PTE
>>> again and fail try_to_migrate() early if it fails.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: Lance Yang <lance.yang@linux.dev>
>>> Cc: <stable@vger.kernel.org>
>>>
>>> ---
>>> v2:
>>>     * restart page_vma_mapped_walk() after split_huge_pmd_locked()
>>> ---
>>>    mm/rmap.c | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 618df3385c8b..5b853ec8901d 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -2446,11 +2446,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>    			__maybe_unused pmd_t pmdval;
>>>     			if (flags & TTU_SPLIT_HUGE_PMD) {
>>> +				/*
>>> +				 * After split_huge_pmd_locked(), restart the
>>> +				 * walk to detect PageAnonExclusive handling
>>> +				 * failure in __split_huge_pmd_locked().
>>> +				 */
>>>    				split_huge_pmd_locked(vma, pvmw.address,
>>>    						      pvmw.pmd, true);
>>> -				ret = false;
>>> -				page_vma_mapped_walk_done(&pvmw);
>>> -				break;
>>> +				flags &= ~TTU_SPLIT_HUGE_PMD;
>>> +				page_vma_mapped_walk_restart(&pvmw);
>>> +				continue;
>>>    			}
>>
>> The change looks more consistent to what we have in try_to_unmap().
>>
>> But the explanation above is not quite right I think. And consequently the comment above as well.
>>
>> PAE being set implies "single PMD" -> unshared.
> 
> The commit message might be improved with some additional context. The comment
> above pairs with the comment in __split_huge_pmd_locked()
> “In case we cannot clear PageAnonExclusive(), split the PMD
> only and let try_to_migrate_one() fail later”. What is problem with it?

With your explanation it's much clearer, thanks.

I'd remove some details from the comments about PAE like:

"split_huge_pmd_locked() might leave the folio mapped through PTEs. 
Retry the walk so we can detect this scenario and properly abort the walk."


With some clarifications along those lines

Acked-by: David Hildenbrand (arm) <david@kernel.org>

-- 
Cheers,

David

