Return-Path: <stable+bounces-213233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGwRCvDzgWkMNAMAu9opvQ
	(envelope-from <stable+bounces-213233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:11:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A8D9B61
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3979F30576EE
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0970734B697;
	Tue,  3 Feb 2026 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSwfWY2f"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A834D92C
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123872; cv=none; b=k4tO1/nZRZTWiZ3Cem2WIxX7AEWw7g8OxVPlZejdBgZ0As5LHOnyofOHklNoe3+bdDiZN+VyMFBDHFdtdRs4cEegblXt+XAPSJH+0mn0vM0H7C8UmlWsiQ2tsVgffwE4aJ5E9ge42ID6QHTJha8dERAGBxdkCPZ3rDnX6EPlVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123872; c=relaxed/simple;
	bh=iYwIl+ADz2oIqaGn9gwWYTtbhRVSRryCeMNqhfZvzPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERPnu1KQyazC/kLo3KHMDnXkP7pr+p0XaumtskahkehlwEH+6auCwgX21y6hbtiILd89f7GNIyZFZLMZawvW7MYWNpJ4LyuNi5nQIQ7w7N6CgyppqDP2E2KvIssAtFuxwlTjDeX2oDWa/+b4I7342OS/gdI1LIDYroSCKDU4TMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSwfWY2f; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so8305776a12.1
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770123869; x=1770728669; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBPpNKanZj6K3Gi0ydO3+Vz58hBdosQfpGmuDZsKE14=;
        b=KSwfWY2fT28SoYH0RLl5FsrMn1uWgYcL8Sya1KFume1aPIy0N8FRGRa1WcunEdsY0O
         VPP2NM1xjtKzS5cahfxhkVz2b/ulm0gXhICQdj++Oksz+5cD0Ehzn4mU9kShOK4smce9
         GhxCYHRiQNyprWOY4tFAzg4MINHTNdkJhed7wbEMtJ9vNjpLSnEYc1kSMFfZ5YZtkJtE
         FRBgb3ZeEATXxyvcJdI0AdyjQRMMMrEfuIQMoqQCo7ICa2awkUClJkOjUXKtRvxydu8p
         RbPmkDF1ggE0hNOPzTTou0B9CEusVWYQ5/f5jU3NmR1/CpbE4pLo1/juCqVNg6Rmu9yu
         0Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770123869; x=1770728669;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBPpNKanZj6K3Gi0ydO3+Vz58hBdosQfpGmuDZsKE14=;
        b=JgRT3f3S1en75zmedV0+Y0hOHQ8qzPfltjFD1/WoX9onB9n1bC96sWDElIBBhOFBc1
         r4zwFcEN6GKa6UB1Ib1+emeKVa4y+ACv/lDwB1LSlrttx/oxyRo4ywmlsx1/8ql9Q+7T
         +bMtNCTZ5k3JwI3QpOM/GfBSo2gbsNxvfTBPR9ACC7yPwYsbzNB5lM35Q9d+m0ZmcHHH
         JAUPEMUSUCGOXFuTWXPCSuQxt7B1cWhgC3mMAXyfUQicK+Fhh9WQDR6qGMShVpvoJjFQ
         Y+k9rPq/kGloFcVNxJGShNWZnwiyx7o6vRbZ3k+6aGTJ3MuvBX5S5BCoAwDyvaPpS+1w
         tg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrNlZBVklMmqp46Pyak0zDAvAssz9LG4rh94MC8PQ3mxI5QjndcJQ9wOOhShAATTiGI/FEje4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpq+YsTAecd+yuuprrrqn4wSM2XQ+nTuxaoQOlnIn/fGPtos34
	SC9ixDsL7pOZSAShy4Y591MIbp2KvMMKDk3mgZ1x2SOSa/5yxPTrBKCN
X-Gm-Gg: AZuq6aJSVENnGOA2RnrFjbDn62PWtO0dQ3fX6guw6r3OmQK04nowqZSI7WnA+D1ERdP
	6dyVYQR6rTr0x7PuUd/EDQOXpx4LXnj74afagbMhoZLJ8T+HoG0zvgojNslMSSmeMFUZVZPRs+F
	6p4Y8qj0Khh2EJlKMmQ1MVqxwmcNPNodGx3G8iy4JqLXCWutd+/TmwdFlXzPLi29EUzwVZjnvai
	K5oVyedbx1FUH0UeAz8O1GBQVGs/cyWNLOMK4iPBQWcvwOjLSMNtwZ+09JsZ3ZyCqpb4fiqeFsW
	RYsWudPhL/FpmvCWTBKeiolfcAFXRfZOVo9jkuuVmAYseRKwWJQiUTFOJqx0aauM1DBsE8mekEU
	+jdAJ34ZwLNnxO5+1eqY2rLY2yg/U8z7F7/rP16SayxO1dsNh0LPAIzTN+U8G7eYfgiDoUElr3R
	U/3lG1j+5GnQ==
X-Received: by 2002:a05:6402:84e:b0:64d:1d2b:238f with SMTP id 4fb4d7f45d1cf-658de58b535mr8663098a12.19.1770123869007;
        Tue, 03 Feb 2026 05:04:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b46aba2fsm9311104a12.30.2026.02.03.05.04.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Feb 2026 05:04:28 -0800 (PST)
Date: Tue, 3 Feb 2026 13:04:27 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Gavin Guo <gavinguo@igalia.com>,
	david@kernel.org, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, riel@surriel.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
	jannh@google.com, baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	stable@vger.kernel.org, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
Message-ID: <20260203130427.n2td43cb275ybi7j@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
 <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
 <20260201020950.p6aygkkiy4hxbi5r@master>
 <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
 <08f0f26b-8a53-4903-a9dc-16f571b5cfee@igalia.com>
 <4D8CC775-A86C-4D80-ADB3-6F5CD0FF9330@nvidia.com>
 <20260203000035.opgq74myrja54zir@master>
 <EF19148C-5365-4D00-AF21-B0D71E799740@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EF19148C-5365-4D00-AF21-B0D71E799740@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-213233-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,igalia.com:email];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,igalia.com,kernel.org,linux-foundation.org,oracle.com,surriel.com,suse.cz,google.com,linux.alibaba.com,kvack.org,vger.kernel.org,redhat.com];
	NEURAL_HAM(-0.00)[-0.896];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 692A8D9B61
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 07:07:12PM -0500, Zi Yan wrote:
>On 2 Feb 2026, at 19:00, Wei Yang wrote:
>
>> On Sun, Feb 01, 2026 at 09:20:35AM -0500, Zi Yan wrote:
>>> On 1 Feb 2026, at 8:04, Gavin Guo wrote:
>>>
>>>> On 2/1/26 11:39, Zi Yan wrote:
>>>>> On 31 Jan 2026, at 21:09, Wei Yang wrote:
>>>>>
>>>>>> On Fri, Jan 30, 2026 at 09:44:10PM -0500, Zi Yan wrote:
>>>>>>> On 30 Jan 2026, at 18:00, Wei Yang wrote:
>>>>>>>
>>>>>>>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>>>>>>>> split_huge_pmd_locked()") return false unconditionally after
>>>>>>>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>>>>>>>> shared thp. This will lead to unexpected folio split failure.
>>>>>>>>
>>>>>>>> One way to reproduce:
>>>>>>>>
>>>>>>>>      Create an anonymous thp range and fork 512 children, so we have a
>>>>>>>>      thp shared mapped in 513 processes. Then trigger folio split with
>>>>>>>>      /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>>>>>>>      order 0.
>>>>>>>>
>>>>>>>> Without the above commit, we can successfully split to order 0.
>>>>>>>> With the above commit, the folio is still a large folio.
>>>>>>>>
>>>>>>>> The reason is the above commit return false after split pmd
>>>>>>>> unconditionally in the first process and break try_to_migrate().
>>>>>>>
>>>>>>> The reasoning looks good to me.
>>>>>>>
>>>>>>>>
>>>>>>>> The tricky thing in above reproduce method is current debugfs interface
>>>>>>>> leverage function split_huge_pages_pid(), which will iterate the whole
>>>>>>>> pmd range and do folio split on each base page address. This means it
>>>>>>>> will try 512 times, and each time split one pmd from pmd mapped to pte
>>>>>>>> mapped thp. If there are less than 512 shared mapped process,
>>>>>>>> the folio is still split successfully at last. But in real world, we
>>>>>>>> usually try it for once.
>>>>>>>>
>>>>>>>> This patch fixes this by removing the unconditional false return after
>>>>>>>> split_huge_pmd_locked(). Later, we may introduce a true fail early if
>>>>>>>> split_huge_pmd_locked() does fail.
>>>>>>>>
>>>>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>>>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>>>>>>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>>>>>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>>> Cc: <stable@vger.kernel.org>
>>>>>>>> ---
>>>>>>>>   mm/rmap.c | 1 -
>>>>>>>>   1 file changed, 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>>>> index 618df3385c8b..eed971568d65 100644
>>>>>>>> --- a/mm/rmap.c
>>>>>>>> +++ b/mm/rmap.c
>>>>>>>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>>>>   			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>>>>>   				split_huge_pmd_locked(vma, pvmw.address,
>>>>>>>>   						      pvmw.pmd, true);
>>>>>>>> -				ret = false;
>>>>>>>>   				page_vma_mapped_walk_done(&pvmw);
>>>>>>>>   				break;
>>>>>>>>   			}
>>>>>>>
>>>>>>> How about the patch below? It matches the pattern of set_pmd_migration_entry() below.
>>>>>>> Basically, continue if the operation is successful, break otherwise.
>>>>>>>
>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>>> index 618df3385c8b..83cc9d98533e 100644
>>>>>>> --- a/mm/rmap.c
>>>>>>> +++ b/mm/rmap.c
>>>>>>> @@ -2448,9 +2448,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>>> 			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>>>> 				split_huge_pmd_locked(vma, pvmw.address,
>>>>>>> 						      pvmw.pmd, true);
>>>>>>> -				ret = false;
>>>>>>> -				page_vma_mapped_walk_done(&pvmw);
>>>>>>> -				break;
>>>>>>> +				continue;
>>>>>>> 			}
>>>>>>
>>>>>> Per my understanding if @freeze is trur, split_huge_pmd_locked() may "fail" as
>>>>>> the comment says:
>>>>>>
>>>>>> 		 * Without "freeze", we'll simply split the PMD, propagating the
>>>>>> 		 * PageAnonExclusive() flag for each PTE by setting it for
>>>>>> 		 * each subpage -- no need to (temporarily) clear.
>>>>>> 		 *
>>>>>> 		 * With "freeze" we want to replace mapped pages by
>>>>>> 		 * migration entries right away. This is only possible if we
>>>>>> 		 * managed to clear PageAnonExclusive() -- see
>>>>>> 		 * set_pmd_migration_entry().
>>>>>> 		 *
>>>>>> 		 * In case we cannot clear PageAnonExclusive(), split the PMD
>>>>>> 		 * only and let try_to_migrate_one() fail later.
>>>>>>
>>>>>> While currently we don't return the status of split_huge_pmd_locked() to
>>>>>> indicate whether it does replaced PMD with migration entries successfully. So
>>>>>> we are not sure this operation succeed.
>>>>>
>>>>> This is the right reasoning. This means to properly handle it, split_huge_pmd_locked()
>>>>> needs to return whether it inserts migration entries or not when freeze is true.
>>>>>
>>>>>>
>>>>>> Another difference from set_pmd_migration_entry() is split_huge_pmd_locked()
>>>>>> would change the page table from PMD mapped to PTE mapped.
>>>>>> page_vma_mapped_walk() can handle it now for (pvmw->pmd && !pvmw->pte), but I
>>>>>> am not sure this is what we expected. For example, in try_to_unmap_one(), we
>>>>>> use page_vma_mapped_walk_restart() after pmd splitted.
>>>>>>
>>>>>> So I prefer just remove the "ret = false" for a fix. Not sure this is
>>>>>> reasonable to you.
>>>>>>
>>>>>> I am thinking two things after this fix:
>>>>>>
>>>>>>    * add one similar test in selftests
>>>>>>    * let split_huge_pmd_locked() return value to indicate freeze is degrade to
>>>>>>      !freeze, and fail early on try_to_migrate() like the thp migration branch
>>>>>>
>>>>>> Look forward your opinion on whether it worth to do it.
>>>>>
>>>>> This is not the right fix, neither was mine above. Because before commit 60fbb14396d5,
>>>>> the code handles PAE properly. If PAE is cleared, PMD is split into PTEs and each
>>>>> PTE becomes a migration entry, page_vma_mapped_walk(&pvmw) returns false,
>>>>> and try_to_migrate_one() returns true. If PAE is not cleared, PMD is split into PTEs
>>>>> and each PTE is not a migration entry, inside while (page_vma_mapped_walk(&pvmw)),
>>>>> PAE will be attempted to get cleared again and it will fail again, leading to
>>>>> try_to_migrate_one() returns false. After commit 60fbb14396d5, no matter PAE is
>>>>> cleared or not, try_to_migrate_one() always returns false. It causes folio split
>>>>> failures for shared PMD THPs.
>>>>>
>>>>> Now with your fix (and mine above), no matter PAE is cleared or not, try_to_migrate_one()
>>>>> always returns true. It just flips the code to a different issue. So the proper fix
>>>>> is to let split_huge_pmd_locked() returns whether it inserts migration entries or not
>>>>> and do the same pattern as THP migration code path.
>>>>
>>>> How about aligning with the try_to_unmap_one()? The behavior would be the same before applying the commit 60fbb14396d5:
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 7b9879ef442d..0c96f0883013 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -2333,9 +2333,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>                         if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>                                 split_huge_pmd_locked(vma, pvmw.address,
>>>>                                                       pvmw.pmd, true);
>>>> -                               ret = false;
>>>> -                               page_vma_mapped_walk_done(&pvmw);
>>>> -                               break;
>>>> +                               flags &= ~TTU_SPLIT_HUGE_PMD;
>>>> +                               page_vma_mapped_walk_restart(&pvmw);
>>>> +                               continue;
>>>>                         }
>>>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>>>                         pmdval = pmdp_get(pvmw.pmd);
>>>
>>> Yes, it works and definitely needs a comment like "After split_huge_pmd_locked(), restart
>>> the walk to detect PageAnonExclusive handling failure in __split_huge_pmd_locked()".
>>> The change is good for backporting, but an additional patch to fix it properly by adding
>>> a return value to split_huge_pmd_locked() is also necessary.
>>>
>>
>> If my understanding is correct, this approach is good for backporting.
>>
>> And yes, we could further improve it by return a value to indicate whether
>> split_huge_pmd_locked() do split to migration entry.
>>
>> Thanks both for your thoughtful inputs.
>
>Are you going to send two patches in a series, one is the above fix with a comment
>and the other changes split_huge_pmd_locked() to return a value?
>

Hmm... as the above fix is supposed to be cc stable and backported, I think
separate them is the correct process. And for the return value of
split_huge_pmd_locked(), I will take another look at all the call places. Are
you ok with this? 

Well, do you think we need to wait for David's comment? If not, I will prepare
the v2 fix with the above change.

>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

