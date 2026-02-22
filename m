Return-Path: <stable+bounces-217657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pTFxHdNSmmnsagMAu9opvQ
	(envelope-from <stable+bounces-217657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 01:50:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE016E5A6
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 01:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FEF63007640
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 00:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728392AE8D;
	Sun, 22 Feb 2026 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2AXhOQN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF61E531
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771721424; cv=none; b=R8MGOgVu6aruEYlolXs+c3wSYyiFZcqsPfrxdJEGehDBUKHWnG4+q6ORF0i7oR8TQQ1JqR+Cb9VK0R4j/EkJMHMa/obsZH99xDcTx2NCHzsaIEY7YJDkQGCd6+R22sd6fFkc20DeqyxYAfGz5FXV4Ctg/0jPsFs7ep6AT4xT7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771721424; c=relaxed/simple;
	bh=PHBNTFaTaT6OY4v4pK8tmUNSJe/tczUeIN41qBBKSa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1V5UD+h8OXAIuKfUxDCxorUb00EOxmr2jcoIYNrpWc5kY9uchcbbMcPD1LHilEmpkmmM4qDLZZ+BDo22CB/ttjW3TIgMqdB3zHPXv6Qf5H/J9orL8E2+xuBBWyiqS8NmblAcMRw5GYBftwZdPg7dRqahsZPAdMf33XmcULOxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2AXhOQN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65c20dc9577so6147945a12.2
        for <stable@vger.kernel.org>; Sat, 21 Feb 2026 16:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771721421; x=1772326221; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOsZ7e+n4Df/rAkGWvwEqzAHF8yQZV7IIGzEvzqRKR4=;
        b=C2AXhOQN9Ya66EGlmiEROCEQhFTX5VJDCjmq0qwt0SlxFeJyvYjocSrTO20Ls5ja0u
         UAckD3D2pqBtpfpgkC4+fqRezjic1BHbhf/d9VpEcNfZEtv0F+oDRXXND+GU1Sbv4plm
         vXigOVfJ8uCS+i5mMxtNyS4WJbv5Wqx0pmN4uYf4+r9wSpGEMNUYLd3ASr/y6Thv+810
         OxrkifBFOxvg560NXDXk6MU1WwMaoTT1iVoi9vtJ+WxVlkOaTMpcEmyRJlDKGdtMXI7e
         5169MiPEptfvU/UippOJvaDb8CGeNphYzknFEIyE4sXGRcvI9UFHPhSxdVqGfE/Aq2ch
         gd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771721421; x=1772326221;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOsZ7e+n4Df/rAkGWvwEqzAHF8yQZV7IIGzEvzqRKR4=;
        b=oqCs7CjfiEjOOx2YEKtuCilTeFTUKG1jkOj5NetK0b1QBjaZ17m44q/cdoLp4QKMpn
         93CKuJ3Ih8vLXVHtj9veYwZrEGZMXqfEvssDaxuy6GZzrZhpkWouCRvcdWge8igfx+9e
         1gXlrQMwavM5ACgBpaO8zced4bCIp2tQMu0LcXgMEgVO+iEyB8NQg9K/y0aLESDfyhbR
         6uF8CKrFhdX/UwBPqgygS5/tbHIRDuR76VYNry+wC8whFoLWMUxQ48JLXq4GaUf7v6xa
         H7DnqGfberot1bTQjB5QAfm0r7a1HG70We124paGhsAvIupCbUj+Y/uwaTxnPU9KtCJv
         r4YA==
X-Forwarded-Encrypted: i=1; AJvYcCWwwxZwcC/8cezHU5RHdyPjMWizgFQuyENTe72edSX9tgQ0Q24G9XAcIPae9HsZxNaoLa786rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKeJ8VIDxMbfeWC4IO7IfHTXLjA6us9o0x7P0kbFUduRGq921u
	6SRKFnXp9j+RRnPXMIs/h7HSt5SScDh9px8cEvbeHTYy5a5YnXyxNjiC
X-Gm-Gg: AZuq6aJA2sO5RLzA1SUejjYioLYPzfei1e2FJkpNiGPl5YO2XjACdrRC5MdyQYqnKqy
	obj3sNuYgnl+Zwx/u4Kmfwgrio8HiXb0ggYvOG55OAuwsXxejHr1zE0SWZMfzMAmZAQLYeYT8Ds
	5p8aPwvr6pnzkWTPheepEEd3hByeRFw+iangVOOBCVD2YLQjwWp4p/R0VKBO4bhitlx845m/pj8
	3t3Slfv3XpEYq/8Fddum+lag7sSh4Cj/D/jO3GpNx1H0XzG93sHZ68uDmq4eYtVocv1fpWge/Y9
	XHVuUTiZ2yascbssLAzc5b+wHMrA7IWQGnKei5JHlSJbNNrfAhHE1qbpPnTtFhIKwbu40k7Sgb9
	SanWeyS9nQAS38NEjpocNoijgU+r7pJAaV8WE28nEMYKW1v33/A6MZDspyXtRZhkDW0+PWW1A6j
	oc7jtw0xmkFNleHG8oOWixbQ==
X-Received: by 2002:a17:907:1b05:b0:b8e:fe3c:2264 with SMTP id a640c23a62f3a-b9081b81c72mr294266366b.41.1771721420552;
        Sat, 21 Feb 2026 16:50:20 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5de72sm157083866b.12.2026.02.21.16.50.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Feb 2026 16:50:19 -0800 (PST)
Date: Sun, 22 Feb 2026 00:50:18 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
	david@kernel.org, riel@surriel.com, Liam.Howlett@oracle.com,
	vbabka@suse.cz, harry.yoo@oracle.com, jannh@google.com,
	gavinguo@igalia.com, baolin.wang@linux.alibaba.com, ziy@nvidia.com,
	linux-mm@kvack.org, Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [Patch v3] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Message-ID: <20260222005018.r4xum26tfxgnnvys@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260205033113.30724-1-richard.weiyang@gmail.com>
 <fbd6c31f-7f35-4986-86e3-76bf8963433d@lucifer.local>
 <20260210032304.j4k5izweewouabqb@master>
 <20260213132027.wm75sh6trz7n24kd@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213132027.wm75sh6trz7n24kd@master>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email,igalia.com:email];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217657-lists,stable=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: CFCE016E5A6
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:20:27PM +0000, Wei Yang wrote:
>On Tue, Feb 10, 2026 at 03:23:04AM +0000, Wei Yang wrote:
>>On Mon, Feb 09, 2026 at 05:08:16PM +0000, Lorenzo Stoakes wrote:
>>>On Thu, Feb 05, 2026 at 03:31:13AM +0000, Wei Yang wrote:
>>>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>>>> split_huge_pmd_locked()") return false unconditionally after
>>>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>>>> shared thp. This will lead to unexpected folio split failure.
>>>
>>>I think this could be put more clearly. 'When splitting a PMD THP migration
>>>entry in try_to_migrate_one() in a rmap walk invoked by try_to_migrate() when
>>
>>split_huge_pmd_locked() could split a PMD THP migration entry, but here we
>>expect a PMD THP normal entry.
>>
>>>TTU_SPLIT_HUGE_PMD is specified.' or something like that.
>>>
>>>>
>>>> One way to reproduce:
>>>>
>>>>     Create an anonymous thp range and fork 512 children, so we have a
>>>>     thp shared mapped in 513 processes. Then trigger folio split with
>>>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>>>     order 0.
>>>
>>>I think you should explain the issue before the repro. This is just confusing
>>>things. Mention the repro _afterwards_.
>>>
>>
>>OK, will move afterwards.
>>
>>>>
>>>> Without the above commit, we can successfully split to order 0.
>>>> With the above commit, the folio is still a large folio.
>>>>
>>>> The reason is the above commit return false after split pmd
>>>
>>>This sentence doesn't really make sense. Returns false where? And under what
>>>circumstances?
>>>
>>>I'm having to look through 60fbb14396d5 to understand this which isn't a good
>>>sign.
>>>
>>>'This patch adjusted try_to_migrate_one() to, when a PMD-mapped THP migration
>>
>>I am afraid the original intention of commit 60fbb14396d5 is not just for
>>migration entry.
>>
>>>entry is found, and TTU_SPLIT_HUGE_PMD is specified (for example, via
>>>unmap_folio()), exit the walk and return false unconditionally'.
>>>
>>>> unconditionally in the first process and break try_to_migrate().
>>>>
>>>> On memory pressure or failure, we would try to reclaim unused memory or
>>>> limit bad memory after folio split. If failed to split it, we will leave
>>>
>>>Limit bad memory? What does that mean? Also should be If '_we_' or '_it_' or
>>>something like that.
>>>
>>
>>What I want to mean is in memory_failure() we use try_to_split_thp_page() and
>>the PG_has_hwpoisoned bit is only set in the after-split folio contains
>>@split_at.
>>
>>>> some more memory unusable than expected.
>>>
>>>'We will leave some more memory unusable than expected' is super unclear.
>>>
>>>You mean we will fail to migrate THP entries at the PTE level?
>>>
>>
>>No. 
>>
>>Hmm... I would like to clarify before continue.
>>
>>This fix is not to fix migration case. This is to fix folio split for a shared
>>mapped PMD THP. Current folio split leverage migration entry during split
>>anonymous folio. So the action here is not to migrate it.
>>
>>I am a little lost here.
>>
>>>Can we say this instead please?
>>>
>
>Hi, Lorenzo
>
>I am not sure understand you correctly. If not, please let me know.
>
>>>>
>>>> The tricky thing in above reproduce method is current debugfs interface
>>>> leverage function split_huge_pages_pid(), which will iterate the whole
>>>> pmd range and do folio split on each base page address. This means it
>>>> will try 512 times, and each time split one pmd from pmd mapped to pte
>>>> mapped thp. If there are less than 512 shared mapped process,
>>>> the folio is still split successfully at last. But in real world, we
>>>> usually try it for once.
>>>
>>>This whole sentence could be dropped I think I don't think it adds anything.
>>>
>>>And you're really confusing the issue by dwelling on this I think.
>>>
>
>It is intended to explain why the reproduce method should fork 512 child. In
>case it is not helpful, I will drop it.
>
>>>You need to restart the walk in this case in order for the PTEs to be correctly
>>>handled right?
>>>
>>>Can you explain why we can't just essentially revert 60fbb14396d5? Or at least
>>>the bit that did this change?
>
>Commit 60fbb14396d5 removed some duplicated check covered by
>page_vma_mapped_walk(), so just reverting it may not good?
>
>You mean a sentence like above is preferred in commit msg?
>
>>>
>>>Also is unmap_folio() the only caller with TTU_SPLIT_HUGE_PMD as the comment
>>>that was deleted by 60fbb14396d5 implied? Or are there others? If it is, please
>>>mention the commit msg.
>>>
>
>Currently there are two core users of TTU_SPLIT_HUGE_PMD:
>
>  * try_to_unmap_one()
>  * try_to_migrate_one()
>
>And another two indirect user by calling try_to_unmap():
>
>  * try_folio_split_or_unmap()
>  * shrink_folio_list()
>
>try_to_unmap_one() doesn't fail early, so only try_to_migrate_one() is
>affected.
>
>So you prefer some description like above to be added in commit msg?
>
>>>
>>>>
>>>> This patch fixes this by restart page_vma_mapped_walk() after
>>>> split_huge_pmd_locked(). We cannot simply return "true" to fix the
>>>> problem, as that would affect another case:
>>>
>>>I mean how would it fix the problem to incorrectly have it return true when the
>>>walk had not in fact completed?
>>>
>>>I'm not sure why you're dwelling on this idea in the commit msg?
>>>
>>>> split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and
>>>> leave the folio mapped through PTEs; we would return "true" from
>>>> try_to_migrate_one() in that case as well. While that is mostly
>>>> harmless, we could end up walking the rmap, wasting some cycles.
>>>
>>>I mean I think we can just drop this whole paragraph no?
>>>
>
>I had an original explanation in [1], which is not clear.
>Then David proposed this version in [2], which looks good to me. So I took it
>in v3.
>
>If this is not necessary, I am ok to drop it.
>
>[1]: http://lkml.kernel.org/r/20260204004219.6524-1-richard.weiyang@gmail.com
>[2]: http://lkml.kernel.org/r/df86ccfd-68a5-416e-81cc-02858e395b70@kernel.org
>

Hi, Lorenzo

I am not certain on how you prefer the commit msg, would you mind taking a
look at my question when you have time slot? So I could prepare next version.

Thanks a lot.

>>>You might think I'm being picky about the commit msg here, but as is I find it
>>>pretty much incomprehensible and that's not helpful if we have to go back and
>>>read this in future.
>>>
>>
>>Never mind.
>>
>>A clearer and comprehensive change log is helpful for all. And my English is
>>not native language, so your suggestion helps a lot.
>>
>>>>
>>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>> Tested-by: Lance Yang <lance.yang@linux.dev>
>>>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>>>> Reviewed-by: Gavin Guo <gavinguo@igalia.com>
>>>> Acked-by: David Hildenbrand (arm) <david@kernel.org>
>>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: Lance Yang <lance.yang@linux.dev>
>>>> Cc: <stable@vger.kernel.org>
>>>>
>>>> ---
>>>> v3:
>>>>   * gather RB
>>>>   * adjust the commit log and comment per David
>>>
>>>Clearly not enough :)
>>>
>>>>   * add userspace-visible runtime effect in change log
>>>
>>>Which one was that?
>>>
>>>> v2:
>>>>   * restart page_vma_mapped_walk() after split_huge_pmd_locked()
>>>> ---
>>>>  mm/rmap.c | 12 +++++++++---
>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 618df3385c8b..1041a64b8e6b 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -2446,11 +2446,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>  			__maybe_unused pmd_t pmdval;
>>>>
>>>>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>> +				/*
>>>> +				 * split_huge_pmd_locked() might leave the
>>>> +				 * folio mapped through PTEs. Retry the walk
>>>> +				 * so we can detect this scenario and properly
>>>> +				 * abort the walk.
>>>> +				 */
>>>
>>>This comment is a lot clearer than the commit msg :)
>>>
>>>>  				split_huge_pmd_locked(vma, pvmw.address,
>>>>  						      pvmw.pmd, true);
>>>> -				ret = false;
>>>> -				page_vma_mapped_walk_done(&pvmw);
>>>> -				break;
>>>> +				flags &= ~TTU_SPLIT_HUGE_PMD;
>>>> +				page_vma_mapped_walk_restart(&pvmw);
>>>> +				continue;
>>>
>>>This logic does lok reasonable.
>>>
>>>>  			}
>>>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>>>  			pmdval = pmdp_get(pvmw.pmd);
>>>> --
>>>> 2.34.1
>>>>
>>>
>>>Cheers, Lorenzo
>>
>>-- 
>>Wei Yang
>>Help you, Help me
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me

