Return-Path: <stable+bounces-212995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPGxBtdPf2kmnwIAu9opvQ
	(envelope-from <stable+bounces-212995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 14:06:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604A9C5F84
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 14:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77F23008D3C
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CC634676B;
	Sun,  1 Feb 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ig+iuG3h"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F633345CA3
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951187; cv=none; b=kzts9aiVH50eBxp1QpP3hel+T2oe6lkvSz1D/1nLtDk5gYH4II/2DYFiVULrBcEQr4jvubIaHfolKd5uBOMF23Pf5mZUmDBwcuTKV5oskWzGGZJSVA42EvdHv+R4rav/RfxQZq2a3B3Am4XYIvjIF9H2Ys7kw2QoUstXrLuzX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951187; c=relaxed/simple;
	bh=GTquO7qbPU5ksuTrLT1mh/RQaFU+5LQ6Ub/HGyH7SCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzc4MQsZlek0d2o2E2zj3oWZVuX7UiAy6PjYt9iEaMNm+eMbiFhLZPu4xy1btYu/6Xep+MmkzL1cPyAQT0Tbbj0jaDc5i+8Jk54UAFIUiphOCWHWtGKSzXI5JWvCddMq8Y4kSJbh1pZZ3CPd9xJDKylhP0RJ4Q7+wPtB7jv8YuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ig+iuG3h; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BZqm1/Smx1ZhncMV3at0HOf6nRzc5QtCzZ65lye7cbw=; b=Ig+iuG3hGUOc4saO2uzXOQhLdG
	s8GrYWf1HZBf+l+mb0eUkypYbc348rkmg5cGU9bErhLsYudhXk6THWveyRtzd7OzQmvr8M9yy83eK
	oFji07abBD5Bq8YQ3cUGkfCbCbDIfBDEYeUkz0MY8iyxQxKz8xFaRDXbw37tdJMmEW2/dbtFd1C1v
	suvaV46FSeYgoZJwlGw8GVl/7blBmQqB0PQ6g5l7yJHvV5HDlvga/eEPZ1dHxRP7dKgFPhRIPjhfT
	JHGhcYlmDgoo+P9cEOUXbB9f8v5UhOAIxhkrlQJU8r62cRwHnFY8zoXykEvJASZGIaXJ6oZGdP7P4
	N3dW7EOA==;
Received: from ppp-27-55-83-89.revip3.asianet.co.th ([27.55.83.89] helo=[10.37.212.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vmX9E-00CPgF-8D; Sun, 01 Feb 2026 14:05:53 +0100
Message-ID: <08f0f26b-8a53-4903-a9dc-16f571b5cfee@igalia.com>
Date: Sun, 1 Feb 2026 21:04:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
 david@kernel.org
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
 stable@vger.kernel.org, Gavin Shan <gshan@redhat.com>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
 <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
 <20260201020950.p6aygkkiy4hxbi5r@master>
 <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212995-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gavinguo@igalia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 604A9C5F84
X-Rspamd-Action: no action

On 2/1/26 11:39, Zi Yan wrote:
> On 31 Jan 2026, at 21:09, Wei Yang wrote:
> 
>> On Fri, Jan 30, 2026 at 09:44:10PM -0500, Zi Yan wrote:
>>> On 30 Jan 2026, at 18:00, Wei Yang wrote:
>>>
>>>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>>>> split_huge_pmd_locked()") return false unconditionally after
>>>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>>>> shared thp. This will lead to unexpected folio split failure.
>>>>
>>>> One way to reproduce:
>>>>
>>>>      Create an anonymous thp range and fork 512 children, so we have a
>>>>      thp shared mapped in 513 processes. Then trigger folio split with
>>>>      /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>>>      order 0.
>>>>
>>>> Without the above commit, we can successfully split to order 0.
>>>> With the above commit, the folio is still a large folio.
>>>>
>>>> The reason is the above commit return false after split pmd
>>>> unconditionally in the first process and break try_to_migrate().
>>>
>>> The reasoning looks good to me.
>>>
>>>>
>>>> The tricky thing in above reproduce method is current debugfs interface
>>>> leverage function split_huge_pages_pid(), which will iterate the whole
>>>> pmd range and do folio split on each base page address. This means it
>>>> will try 512 times, and each time split one pmd from pmd mapped to pte
>>>> mapped thp. If there are less than 512 shared mapped process,
>>>> the folio is still split successfully at last. But in real world, we
>>>> usually try it for once.
>>>>
>>>> This patch fixes this by removing the unconditional false return after
>>>> split_huge_pmd_locked(). Later, we may introduce a true fail early if
>>>> split_huge_pmd_locked() does fail.
>>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: <stable@vger.kernel.org>
>>>> ---
>>>>   mm/rmap.c | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 618df3385c8b..eed971568d65 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>   			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>   				split_huge_pmd_locked(vma, pvmw.address,
>>>>   						      pvmw.pmd, true);
>>>> -				ret = false;
>>>>   				page_vma_mapped_walk_done(&pvmw);
>>>>   				break;
>>>>   			}
>>>
>>> How about the patch below? It matches the pattern of set_pmd_migration_entry() below.
>>> Basically, continue if the operation is successful, break otherwise.
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 618df3385c8b..83cc9d98533e 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -2448,9 +2448,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>> 			if (flags & TTU_SPLIT_HUGE_PMD) {
>>> 				split_huge_pmd_locked(vma, pvmw.address,
>>> 						      pvmw.pmd, true);
>>> -				ret = false;
>>> -				page_vma_mapped_walk_done(&pvmw);
>>> -				break;
>>> +				continue;
>>> 			}
>>
>> Per my understanding if @freeze is trur, split_huge_pmd_locked() may "fail" as
>> the comment says:
>>
>> 		 * Without "freeze", we'll simply split the PMD, propagating the
>> 		 * PageAnonExclusive() flag for each PTE by setting it for
>> 		 * each subpage -- no need to (temporarily) clear.
>> 		 *
>> 		 * With "freeze" we want to replace mapped pages by
>> 		 * migration entries right away. This is only possible if we
>> 		 * managed to clear PageAnonExclusive() -- see
>> 		 * set_pmd_migration_entry().
>> 		 *
>> 		 * In case we cannot clear PageAnonExclusive(), split the PMD
>> 		 * only and let try_to_migrate_one() fail later.
>>
>> While currently we don't return the status of split_huge_pmd_locked() to
>> indicate whether it does replaced PMD with migration entries successfully. So
>> we are not sure this operation succeed.
> 
> This is the right reasoning. This means to properly handle it, split_huge_pmd_locked()
> needs to return whether it inserts migration entries or not when freeze is true.
> 
>>
>> Another difference from set_pmd_migration_entry() is split_huge_pmd_locked()
>> would change the page table from PMD mapped to PTE mapped.
>> page_vma_mapped_walk() can handle it now for (pvmw->pmd && !pvmw->pte), but I
>> am not sure this is what we expected. For example, in try_to_unmap_one(), we
>> use page_vma_mapped_walk_restart() after pmd splitted.
>>
>> So I prefer just remove the "ret = false" for a fix. Not sure this is
>> reasonable to you.
>>
>> I am thinking two things after this fix:
>>
>>    * add one similar test in selftests
>>    * let split_huge_pmd_locked() return value to indicate freeze is degrade to
>>      !freeze, and fail early on try_to_migrate() like the thp migration branch
>>
>> Look forward your opinion on whether it worth to do it.
> 
> This is not the right fix, neither was mine above. Because before commit 60fbb14396d5,
> the code handles PAE properly. If PAE is cleared, PMD is split into PTEs and each
> PTE becomes a migration entry, page_vma_mapped_walk(&pvmw) returns false,
> and try_to_migrate_one() returns true. If PAE is not cleared, PMD is split into PTEs
> and each PTE is not a migration entry, inside while (page_vma_mapped_walk(&pvmw)),
> PAE will be attempted to get cleared again and it will fail again, leading to
> try_to_migrate_one() returns false. After commit 60fbb14396d5, no matter PAE is
> cleared or not, try_to_migrate_one() always returns false. It causes folio split
> failures for shared PMD THPs.
> 
> Now with your fix (and mine above), no matter PAE is cleared or not, try_to_migrate_one()
> always returns true. It just flips the code to a different issue. So the proper fix
> is to let split_huge_pmd_locked() returns whether it inserts migration entries or not
> and do the same pattern as THP migration code path.

How about aligning with the try_to_unmap_one()? The behavior would be 
the same before applying the commit 60fbb14396d5:

diff --git a/mm/rmap.c b/mm/rmap.c
index 7b9879ef442d..0c96f0883013 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2333,9 +2333,9 @@ static bool try_to_migrate_one(struct folio 
*folio, struct vm_area_struct *vma,
                         if (flags & TTU_SPLIT_HUGE_PMD) {
                                 split_huge_pmd_locked(vma, pvmw.address,
                                                       pvmw.pmd, true);
-                               ret = false;
-                               page_vma_mapped_walk_done(&pvmw);
-                               break;
+                               flags &= ~TTU_SPLIT_HUGE_PMD;
+                               page_vma_mapped_walk_restart(&pvmw);
+                               continue;
                         }
  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
                         pmdval = pmdp_get(pvmw.pmd);


> 
> 
> Hi David,
> 
> In terms of unmap_folio(), which is the only user of split_huge_pmd_locked(..., freeze=true),
> there is no folio_mapped() check afterwards. That might be causing an issue,
> when the folio is pinned between the refcount check and unmap_folio(), unmap_folio()
> fails, but folio split code proceeds. That means the folio is still accessible
> via PTEs and later remove_migration_pte() will try to remove non migration PTEs.
> It needs to be fixed separately, right?
> 
> 
>>
>>> #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>> 			pmdval = pmdp_get(pvmw.pmd);
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
>>
>> -- 
>> Wei Yang
>> Help you, Help me
> 
> 
> --
> Best Regards,
> Yan, Zi


