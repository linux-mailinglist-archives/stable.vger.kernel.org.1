Return-Path: <stable+bounces-213130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMEBBKo6gWmUEwMAu9opvQ
	(envelope-from <stable+bounces-213130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:00:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F47D2CD0
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A853017013
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 23:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E4D361668;
	Mon,  2 Feb 2026 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntnD+YAt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF188318ED4
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076638; cv=none; b=pKfuM4Vi0ty04kNA9PaZG316wRxDJHRidVbhtId+r7PdAiAvdlinbGUq5vOYgiYP4XR2k7qIYZLXooBbE9OwU89oS0OOf688Srv3EJAvIo4d9PuvO8NXJ7wMfNyqhb3/7WIY23MhmpGvRmvE93Lqc51Gjfmrpk19zpRM8DvzVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076638; c=relaxed/simple;
	bh=KvWKPlBL1tT+8QvvqFKF393q8srAuCzQN6d8xGSGOTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGLu6PZuaiJpget1nPImb3QH9UmgXXZ6GsQu2/KB2iu2Bl8cOgBKcR5DywbEJ49ehFDxTMbfmcnQx+EaNIUozts+1Uvq4uchbfyt0k3rOaxI1TH974+M+iNpZIYR2j948Yc5CNoZsfU6n/GPMjlE6gDh+i7M0yrnrYvtRTmAYFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntnD+YAt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8715a4d9fdso586766966b.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770076635; x=1770681435; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYOQCYoVLtUoF5usiYIjTFsy3/SBgdQV8AlY2B4RB9M=;
        b=ntnD+YAtgw8ksZjxxwg2AdN7Zo3dhKPDA4jw+0WQSGanLmU2UprFtrkLtwA+VXJJXV
         ENrNG9e/lLLZx56l3BwvVFS5ASduozZDvGVnqT4k4YkOFh1EkOZ0gSYcYQcY2DVhTY19
         q3ocn4mHMjH7Py2xJRX6XKdqp4FI8Qn1H82rMu2c5gLUY0hp173hxMOz+EajPqz2VSOK
         x/P4wN54W9zEKTDfiTA38KySzZbY9dixQ9uGfcYguEQKHOwrAGe20QUoiDpr+Kdrouiz
         ZvPvkMrVj7vvW9s4RMdCGtW6WBLDmegVoVZ0IMHN54mSBbwAynkJuN1e5F8WrjRfhlEA
         m7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770076635; x=1770681435;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYOQCYoVLtUoF5usiYIjTFsy3/SBgdQV8AlY2B4RB9M=;
        b=VPgGErYnSQc55+f+TPCZ5D7QZeyEorN+b7C23ElFOmJ6LyrqBIuRai163sbPVK9Ag+
         aIejcZX3quQoJMLTDzDGYHz0cP6mUBSjRiEwZ1pHQiK1NvXhScrh0GNydjWS8dJ1FWoc
         HY4ont7JELyBC4KkKwgrc/OhCrwikhFmPBmJBUzEkbZPQlav2OGeymxXJuKvczW8/c68
         DYfcc2Yp89pz2EpwV6hPXexyQpnKiK0FVkvPsaZ7sUTTGKvbA47cHwge42CDqRGmYj7c
         362ov+qwqNwEJtEoLMLPgK59C4wz/9lZT9BJj9cD5KrZS0ksP+nQClqyAHEBZy01WTX0
         hPmg==
X-Forwarded-Encrypted: i=1; AJvYcCWekZnla3C5M2nUnRXTWDzClPNLPd72fsbv7Xp2i80qI3v6a1/JYZA7j+QNRXlz44qSYjM9zLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUByxZfMNU/xeKvsrK9ke61TU3Y1We/hY9q/gCjeHYvWRiMQQ2
	RISbW+Uz7I16JWD5L0LNEBXbhsKcYWMcTOsRPm4l5qTvR/8rwwp0Yrrd
X-Gm-Gg: AZuq6aKsud3zGFy2UCTr+Ho84tMnhn6fChzxec5IXOWZrNNikKA57Kt1lcLrwgLfN48
	eiPVMO2Ir+c9yQwzWO+2w1fg5z06xCCGPQoN05ZJXi7FR12Svgzc1rmO999dcKELlNq/w5Cv+7H
	Tl/fnTYR9MoXvX0+cY9tIG5InTiab2UevtwoM2NVgPcrM73UmH5p5CSsXaWyhFpF3X9IZ1mHtXR
	QMEVOlfVv5P/zFCuPshE1VHccbi9RFB90iH+54nM5qEUjJC8GW6Zo2yIPwHMZZ7xhVQ3PDxWYSk
	AOIdMQasP2nVyvfLf2hHHqKLe/wa4XRfvZIz7oNlm9TpWfaqhrtBMHR+1IUGfOH8OVHlgpU55Lo
	pzhLA5UsJX3Q8qbl/yFxINnLuCFgmvERs2gZ6L5/dZlk3rdCHrlAQ0CeKSMSr9Ys2kyOkCSFe1g
	jGDZJhGEmqCQ==
X-Received: by 2002:a17:906:4783:b0:b84:2075:b902 with SMTP id a640c23a62f3a-b8dff7a365amr890704466b.36.1770076634993;
        Mon, 02 Feb 2026 15:57:14 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2f3e26sm954868966b.67.2026.02.02.15.57.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Feb 2026 15:57:14 -0800 (PST)
Date: Mon, 2 Feb 2026 23:57:14 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, david@kernel.org,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	harry.yoo@oracle.com, jannh@google.com, gavinguo@igalia.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
Message-ID: <20260202235714.5wvxveurjfdka5pl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
 <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
 <20260201020950.p6aygkkiy4hxbi5r@master>
 <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-213130-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,oracle.com,surriel.com,suse.cz,google.com,igalia.com,linux.alibaba.com,kvack.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 32F47D2CD0
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 10:39:40PM -0500, Zi Yan wrote:
>On 31 Jan 2026, at 21:09, Wei Yang wrote:
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
>>>>     Create an anonymous thp range and fork 512 children, so we have a
>>>>     thp shared mapped in 513 processes. Then trigger folio split with
>>>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>>>     order 0.
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
>>>>  mm/rmap.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 618df3385c8b..eed971568d65 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>  				split_huge_pmd_locked(vma, pvmw.address,
>>>>  						      pvmw.pmd, true);
>>>> -				ret = false;
>>>>  				page_vma_mapped_walk_done(&pvmw);
>>>>  				break;
>>>>  			}
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
>This is the right reasoning. This means to properly handle it, split_huge_pmd_locked()
>needs to return whether it inserts migration entries or not when freeze is true.
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
>>   * add one similar test in selftests
>>   * let split_huge_pmd_locked() return value to indicate freeze is degrade to
>>     !freeze, and fail early on try_to_migrate() like the thp migration branch
>>
>> Look forward your opinion on whether it worth to do it.
>
>This is not the right fix, neither was mine above. Because before commit 60fbb14396d5,
>the code handles PAE properly. If PAE is cleared, PMD is split into PTEs and each
>PTE becomes a migration entry, page_vma_mapped_walk(&pvmw) returns false,
>and try_to_migrate_one() returns true. If PAE is not cleared, PMD is split into PTEs
>and each PTE is not a migration entry, inside while (page_vma_mapped_walk(&pvmw)),
>PAE will be attempted to get cleared again and it will fail again, leading to
>try_to_migrate_one() returns false. After commit 60fbb14396d5, no matter PAE is
>cleared or not, try_to_migrate_one() always returns false. It causes folio split
>failures for shared PMD THPs.
>
>Now with your fix (and mine above), no matter PAE is cleared or not, try_to_migrate_one()
>always returns true. It just flips the code to a different issue. So the proper fix
>is to let split_huge_pmd_locked() returns whether it inserts migration entries or not
>and do the same pattern as THP migration code path.
>

You are right.

BTW, I thought PAE stands for Physical Address Extension and confused a while :-(

>
>Hi David,
>
>In terms of unmap_folio(), which is the only user of split_huge_pmd_locked(..., freeze=true),
>there is no folio_mapped() check afterwards. That might be causing an issue,
>when the folio is pinned between the refcount check and unmap_folio(), unmap_folio()
>fails, but folio split code proceeds. That means the folio is still accessible
>via PTEs and later remove_migration_pte() will try to remove non migration PTEs.
>It needs to be fixed separately, right?
>

Current __folio_split() logic is like below:

    if (folio_expected_ref_count(folio) != folio_ref_count(folio) - 1) {     --- (1)
    	ret = -EAGAIN;
	goto out_unlock;
    }

    unmap_folio(folio);                                                      --- (2)

    ret = __folio_freeze_and_split_unmapped()
        if (folio_ref_freeze(folio, folio_cache_ref_count(folio) + 1)) {     --- (3)
	} else {
	    return -EAGAIN;
	}

You mean after (1) and (2), we don't check folio_mapped() and continue
spliting? Hmm... before continue split we tried to freeze folio with expected
refcount at (3). This makes sure there is not extra refcount except in
pagecache or swapcache.

You mean this is not enough? Not sure I follow you correctly.

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
>--
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

