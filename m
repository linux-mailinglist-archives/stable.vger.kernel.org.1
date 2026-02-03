Return-Path: <stable+bounces-213131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J3dIVU7gWmUEwMAu9opvQ
	(envelope-from <stable+bounces-213131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:03:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D4D2D17
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4311A30490CB
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA51218580;
	Tue,  3 Feb 2026 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dynRAeX+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1041684BE
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076839; cv=none; b=Ukg4svM1dMPKjn1MWGt/Pqa8XlNR6B4uRHkr32uAzH4MGoIR8xUqACV8zO5868b7niz3RrE902nMo9Ndj3aLZFnUVO5b9m9Ks6iXT9hDBa44g3PNp5Ki5iHjjWjKUdTShKNzSR0grYEFhaeoP0uQfKAE90H+TVyfLlFWie0f0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076839; c=relaxed/simple;
	bh=q+LYT5h7wXXFPRoTUJKkweKlViVV22KzH5tPZ6a9MEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZiW21/dHNzl+uUx5liI2e6Se2h2UlUdq4QkCesGCunuBKQnWCoCtr25jkhuP/F/imLeNUtZAQBmQfWJkLGg+ZRRVB9/99651TQt6t59YKNJjcoUgnMweJfvUJbpkRAbqlr4t2fxk8sjwmDDSg7VAeC1W0ENC3wcPivQrWfgG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dynRAeX+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8d7f22d405so796043966b.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770076836; x=1770681636; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbvMPaqv/A6c1xhFd8174Sn7MBIjDpvGdBQf/z5G8ds=;
        b=dynRAeX+Wk3wKHsvjXVY3BiLkePZwEi2wpAq6hnA83ENSAy97QQCa+P7hoW1IaM2Fy
         3+/J3078AS0Gbd8cqey0f2Zg+3jzrpKUCR6dCeLC6bNdcJTectp2AqXGXa/fCrsuIGsJ
         mVLGvutDRlBdrPfE+doq1QAeSWgZClm3NXjU/jCj+JAUW7wngDfBhQvRa7bPY3aSuZbT
         b0wyJ1qHH8vhuX/O81oJElw61V32oBPALzfzWDs0QfsqwHHds2s3bmZd/dDQmx3NOOXc
         qsBB26OG1AkEWv0MxxuwcYdimPhtLYjesEQJ1HKWBKmoaIEQgRxEoqHNkMre8crDRRwH
         7EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770076836; x=1770681636;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbvMPaqv/A6c1xhFd8174Sn7MBIjDpvGdBQf/z5G8ds=;
        b=M4QG7aPEQPGvrspSIrs6tg0uiWqkaHR3Lnr//bSLpJpig3dwHxmOKkEQ17p6cc6TlT
         3Pg186aHMRt3ayup2MyfbbCp8lyO+Nbz91yYvR6AOnWAoqQmKsLso9LWvtbcc0dwLyd9
         42mNGQ63IrpME6uoz6YMe0rkQw1CPqJ2ljnB82s3cTG/YsBUJsk0yLuso8fpBEA6Uro1
         4swcn5VvnvTCZUpGOcxErXRxIFOKZonxJb4wMLMEN1+PUNj393IzNULp0mKF+ShRqnVl
         1v8PQEdNjID9Q/GiOnQD1Sb0IYizcu4fU7yfUuQiw9ERy+JLzOVz+n7fSlovXxQkkdtu
         sGKw==
X-Forwarded-Encrypted: i=1; AJvYcCUfG0oudpdQDkVBi8fa7k/00++uNZyJSEtjt/dz6FAjZ0axOHOy791rpezRaaDRV4P89JQNcPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qFyIYpD0xS12Hk+WscMUaXJ8QjeG+WOzrtlkHBPIPAm3xvzE
	Gl/T3v0OZcfYqxBzwVEJyXGfOfRTDtelRJ+Z7KdfGW0hJgZLlpuRNylm
X-Gm-Gg: AZuq6aLJm3ihT8JH2L9wPBiyrZdCzrRIOJqEkvq3nNWx3fFJn7q/6EfuUQFfXkSTIA0
	vTIzVhzWeIaXOxnMVbRsA5GjQrN/5p+7ZjlbuW42VcI7KhirleKjbayhYpJi7qjs1LSBA/G6RyR
	ExFY/pf8UEl9piWdFv1yVOvC8dUTGUoF8CVIPCXql7yCFCu0uhmBgzv+lKAtuTRSFD1VWZ9+yv2
	qxPLkT6U2tfsHqAUNjUgP3UraRxtmqd1Lif3Bb8Z1hzWufivWgUs8tRSTEqaarBXnrB/xo5r9U7
	QDZQnCXEzpIqJz7BlXtCiDqj+uyVggfZtGRISJOTSPCLtyvfi6Gw9xoe4FmSD2ctIB3iygJvvVn
	9oyCrQRKSd0tRWx4f3NznAHjP2AVkYl4Dktb16pn9XfWKTwDxOedqm7VVJys18yst0t3QY7Qmdv
	VufjBuQLZABg==
X-Received: by 2002:a17:907:7b99:b0:b80:3346:496 with SMTP id a640c23a62f3a-b8dff6677f1mr869096966b.42.1770076836009;
        Mon, 02 Feb 2026 16:00:36 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e32a91885sm466312066b.18.2026.02.02.16.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Feb 2026 16:00:35 -0800 (PST)
Date: Tue, 3 Feb 2026 00:00:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Gavin Guo <gavinguo@igalia.com>, Wei Yang <richard.weiyang@gmail.com>,
	david@kernel.org, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, riel@surriel.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
	jannh@google.com, baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	stable@vger.kernel.org, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
Message-ID: <20260203000035.opgq74myrja54zir@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
 <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
 <20260201020950.p6aygkkiy4hxbi5r@master>
 <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
 <08f0f26b-8a53-4903-a9dc-16f571b5cfee@igalia.com>
 <4D8CC775-A86C-4D80-ADB3-6F5CD0FF9330@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D8CC775-A86C-4D80-ADB3-6F5CD0FF9330@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-213131-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[igalia.com,gmail.com,kernel.org,linux-foundation.org,oracle.com,surriel.com,suse.cz,google.com,linux.alibaba.com,kvack.org,vger.kernel.org,redhat.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: D60D4D2D17
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 09:20:35AM -0500, Zi Yan wrote:
>On 1 Feb 2026, at 8:04, Gavin Guo wrote:
>
>> On 2/1/26 11:39, Zi Yan wrote:
>>> On 31 Jan 2026, at 21:09, Wei Yang wrote:
>>>
>>>> On Fri, Jan 30, 2026 at 09:44:10PM -0500, Zi Yan wrote:
>>>>> On 30 Jan 2026, at 18:00, Wei Yang wrote:
>>>>>
>>>>>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>>>>>> split_huge_pmd_locked()") return false unconditionally after
>>>>>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>>>>>> shared thp. This will lead to unexpected folio split failure.
>>>>>>
>>>>>> One way to reproduce:
>>>>>>
>>>>>>      Create an anonymous thp range and fork 512 children, so we have a
>>>>>>      thp shared mapped in 513 processes. Then trigger folio split with
>>>>>>      /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>>>>>      order 0.
>>>>>>
>>>>>> Without the above commit, we can successfully split to order 0.
>>>>>> With the above commit, the folio is still a large folio.
>>>>>>
>>>>>> The reason is the above commit return false after split pmd
>>>>>> unconditionally in the first process and break try_to_migrate().
>>>>>
>>>>> The reasoning looks good to me.
>>>>>
>>>>>>
>>>>>> The tricky thing in above reproduce method is current debugfs interface
>>>>>> leverage function split_huge_pages_pid(), which will iterate the whole
>>>>>> pmd range and do folio split on each base page address. This means it
>>>>>> will try 512 times, and each time split one pmd from pmd mapped to pte
>>>>>> mapped thp. If there are less than 512 shared mapped process,
>>>>>> the folio is still split successfully at last. But in real world, we
>>>>>> usually try it for once.
>>>>>>
>>>>>> This patch fixes this by removing the unconditional false return after
>>>>>> split_huge_pmd_locked(). Later, we may introduce a true fail early if
>>>>>> split_huge_pmd_locked() does fail.
>>>>>>
>>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>>>>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>>>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>> ---
>>>>>>   mm/rmap.c | 1 -
>>>>>>   1 file changed, 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index 618df3385c8b..eed971568d65 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>>   			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>>>   				split_huge_pmd_locked(vma, pvmw.address,
>>>>>>   						      pvmw.pmd, true);
>>>>>> -				ret = false;
>>>>>>   				page_vma_mapped_walk_done(&pvmw);
>>>>>>   				break;
>>>>>>   			}
>>>>>
>>>>> How about the patch below? It matches the pattern of set_pmd_migration_entry() below.
>>>>> Basically, continue if the operation is successful, break otherwise.
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 618df3385c8b..83cc9d98533e 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -2448,9 +2448,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>> 			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>> 				split_huge_pmd_locked(vma, pvmw.address,
>>>>> 						      pvmw.pmd, true);
>>>>> -				ret = false;
>>>>> -				page_vma_mapped_walk_done(&pvmw);
>>>>> -				break;
>>>>> +				continue;
>>>>> 			}
>>>>
>>>> Per my understanding if @freeze is trur, split_huge_pmd_locked() may "fail" as
>>>> the comment says:
>>>>
>>>> 		 * Without "freeze", we'll simply split the PMD, propagating the
>>>> 		 * PageAnonExclusive() flag for each PTE by setting it for
>>>> 		 * each subpage -- no need to (temporarily) clear.
>>>> 		 *
>>>> 		 * With "freeze" we want to replace mapped pages by
>>>> 		 * migration entries right away. This is only possible if we
>>>> 		 * managed to clear PageAnonExclusive() -- see
>>>> 		 * set_pmd_migration_entry().
>>>> 		 *
>>>> 		 * In case we cannot clear PageAnonExclusive(), split the PMD
>>>> 		 * only and let try_to_migrate_one() fail later.
>>>>
>>>> While currently we don't return the status of split_huge_pmd_locked() to
>>>> indicate whether it does replaced PMD with migration entries successfully. So
>>>> we are not sure this operation succeed.
>>>
>>> This is the right reasoning. This means to properly handle it, split_huge_pmd_locked()
>>> needs to return whether it inserts migration entries or not when freeze is true.
>>>
>>>>
>>>> Another difference from set_pmd_migration_entry() is split_huge_pmd_locked()
>>>> would change the page table from PMD mapped to PTE mapped.
>>>> page_vma_mapped_walk() can handle it now for (pvmw->pmd && !pvmw->pte), but I
>>>> am not sure this is what we expected. For example, in try_to_unmap_one(), we
>>>> use page_vma_mapped_walk_restart() after pmd splitted.
>>>>
>>>> So I prefer just remove the "ret = false" for a fix. Not sure this is
>>>> reasonable to you.
>>>>
>>>> I am thinking two things after this fix:
>>>>
>>>>    * add one similar test in selftests
>>>>    * let split_huge_pmd_locked() return value to indicate freeze is degrade to
>>>>      !freeze, and fail early on try_to_migrate() like the thp migration branch
>>>>
>>>> Look forward your opinion on whether it worth to do it.
>>>
>>> This is not the right fix, neither was mine above. Because before commit 60fbb14396d5,
>>> the code handles PAE properly. If PAE is cleared, PMD is split into PTEs and each
>>> PTE becomes a migration entry, page_vma_mapped_walk(&pvmw) returns false,
>>> and try_to_migrate_one() returns true. If PAE is not cleared, PMD is split into PTEs
>>> and each PTE is not a migration entry, inside while (page_vma_mapped_walk(&pvmw)),
>>> PAE will be attempted to get cleared again and it will fail again, leading to
>>> try_to_migrate_one() returns false. After commit 60fbb14396d5, no matter PAE is
>>> cleared or not, try_to_migrate_one() always returns false. It causes folio split
>>> failures for shared PMD THPs.
>>>
>>> Now with your fix (and mine above), no matter PAE is cleared or not, try_to_migrate_one()
>>> always returns true. It just flips the code to a different issue. So the proper fix
>>> is to let split_huge_pmd_locked() returns whether it inserts migration entries or not
>>> and do the same pattern as THP migration code path.
>>
>> How about aligning with the try_to_unmap_one()? The behavior would be the same before applying the commit 60fbb14396d5:
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 7b9879ef442d..0c96f0883013 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2333,9 +2333,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>                         if (flags & TTU_SPLIT_HUGE_PMD) {
>>                                 split_huge_pmd_locked(vma, pvmw.address,
>>                                                       pvmw.pmd, true);
>> -                               ret = false;
>> -                               page_vma_mapped_walk_done(&pvmw);
>> -                               break;
>> +                               flags &= ~TTU_SPLIT_HUGE_PMD;
>> +                               page_vma_mapped_walk_restart(&pvmw);
>> +                               continue;
>>                         }
>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>                         pmdval = pmdp_get(pvmw.pmd);
>
>Yes, it works and definitely needs a comment like "After split_huge_pmd_locked(), restart
>the walk to detect PageAnonExclusive handling failure in __split_huge_pmd_locked()".
>The change is good for backporting, but an additional patch to fix it properly by adding
>a return value to split_huge_pmd_locked() is also necessary.
>

If my understanding is correct, this approach is good for backporting.

And yes, we could further improve it by return a value to indicate whether
split_huge_pmd_locked() do split to migration entry.

Thanks both for your thoughtful inputs.

-- 
Wei Yang
Help you, Help me

