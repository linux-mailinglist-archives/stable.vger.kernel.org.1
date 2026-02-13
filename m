Return-Path: <stable+bounces-216079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MB6NCclj2lNKAEAu9opvQ
	(envelope-from <stable+bounces-216079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:20:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2211364F2
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD19A3009817
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEFB35DD15;
	Fri, 13 Feb 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV5Cd02R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D834F46F
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988832; cv=none; b=USafMkCSYtANxK73pzji5KNtlmiJhTRuVeUYbWH4sOgy8NxuzD6tu56py7sLU3cWj9UwS0XJ+rnf1CUdILhc7IOMsF/Fz9durDIJT+NZjS0II+kIS5KJuqkDQv9zvt5Gb1rhzEhssTlOoAGUaa3AeCP00dFmAEHTlqG1Ol+RzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988832; c=relaxed/simple;
	bh=BU2EBK6ScK0eZs5mPwyghgVg8OFhmpdXUl0yw26EfeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcNHbiXnTZ8kbgAesjFzgHybWD9JxMc2XgrVO2/ASAUPFa9fpUn25UfakP60KxxdSn1Ax155giXY4j/TKcNcq+CP+9YFNiCyuxSU0hGAcnEjk5zt/W3ALs6/SSMTOK1eYFBJh2e66N/lhN3pY+UFbuVWvgFq5I0St+dGUW9TD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV5Cd02R; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65a431e305eso1550040a12.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 05:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770988829; x=1771593629; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilGj6lLTzRpN3r1IcDnTGNS5aDBCBmpZcWwGQt282V8=;
        b=cV5Cd02RN5ofyZKg8mv+R04pMbOZ0XdEj8Bb0H0nnew1bthtYeaoyrfgbjBdvu9nUM
         oX/0KYDZAfh5PT2gbztxRcfOtltVLQwLGxpTE58FsZ9xL7sPezt+J/0FMAhytZ+918fi
         LzEf6n5PJ56MYUvsre4JIa36CqCBTIHAhATSBKl4LuSlYzShi6NInf8b4p45qXchPcry
         V9JD4tfdkUDEOp7pMRGAmEI5wRlpd0xBO2jcmV2OPh+bTDHQEbr9LaoOpKBT6ViDYL+C
         uyG5QbBuTYw6u/0XFP41qoaEdPLPeM8l4SOL8PyUhk4odrhnJoBEXn7376Erpeu3OodK
         +aOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770988829; x=1771593629;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilGj6lLTzRpN3r1IcDnTGNS5aDBCBmpZcWwGQt282V8=;
        b=vxxCaFwJuE7WIYKhIPkUfKlc0QVaTf3ZNr1oXTjjr1CBtWtpgoksDdOwPqlhK1Y4Qm
         P25ENtgqkjyOc7z/zq4/j6pnQH6PadpmlVnfXKryVmZVW0ZfhBKYSgUdcClG3En9JYmI
         GKTGMykSdL4nIM9DBZdhHgrovoyQ3bRHJ5AJzRrNz2Ry2pX0iwqVsBAM5+Tl6zdUIThn
         wFwAhiQGURr8GSGKOEKbuOeAVj8wawUCpwuYJIVUdiy12PFplhAQzh5cPBJ14Xv2qBwL
         j97XqLN+hw7vOZVaT/9IptH3cN2m5oricxazIyZFbRCO3SHBZRgimwIXqVvgzM/FwPJ4
         V+1A==
X-Forwarded-Encrypted: i=1; AJvYcCVTisY+PlFvNkicTZHqea6VZpZkEE/I8UVsFxAg8plQ8i1BcNnpC2qD2SVI9k650ur+1cbDrSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzDgLOLXw09U8LBCB4BfVktEYiWrZKXFlv97saQYy+BmFbDVZJ
	/FJb8NlvAVIgzC3wDBmeVoKPaWaALK2wztarqVGujfIcfgb1p/7uWhvd
X-Gm-Gg: AZuq6aKcMqlIbZi4VGa6Osd7yNvz8d2kP+p64N6CQa52IjmloTzwUqe9FezNZeljrlB
	vgrrqxelo/eaX+SlfBLTpZ9r9KJKsCurCxtE+MMQa2G23vaKKwV0hKGMDNw8kQll/6HTvSLdWQ3
	/WwFEunIFi7LiUpfY0SsLI9e8oJ7pClp0e8YbE7Uw3XI8Og/o52GKZek8h+tnPGHJbDPmqQkr3w
	HX1omStWQFzZdZ5MvQM5FcQMUYH+VNxjKHfWdFpck0q7frmN2ryFHQ2ecNu0BzGiwTtV22oZx5h
	i5T/mAazas2CA/JJHrJwL+7QmcysPzuZuIujRF+sklQ0FAvjTWtQ0/6xD1aXwDn+mvWLkxtmCMl
	9r4y/XXYt7PQ/Xk73ow3s5a/u+MLr2zWlvK541cjxSaS1H6B6i7DkFYhBGubfydp7c3qA7cru27
	WJcHe4WrosalA9hxlAm5ARrNB7Wte9mD5b
X-Received: by 2002:a05:6402:5243:b0:658:1304:b699 with SMTP id 4fb4d7f45d1cf-65bb140c533mr943778a12.31.1770988829196;
        Fri, 13 Feb 2026 05:20:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29d471sm658523a12.9.2026.02.13.05.20.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Feb 2026 05:20:27 -0800 (PST)
Date: Fri, 13 Feb 2026 13:20:27 +0000
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
Message-ID: <20260213132027.wm75sh6trz7n24kd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260205033113.30724-1-richard.weiyang@gmail.com>
 <fbd6c31f-7f35-4986-86e3-76bf8963433d@lucifer.local>
 <20260210032304.j4k5izweewouabqb@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210032304.j4k5izweewouabqb@master>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email,nvidia.com:email];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-216079-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9A2211364F2
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 03:23:04AM +0000, Wei Yang wrote:
>On Mon, Feb 09, 2026 at 05:08:16PM +0000, Lorenzo Stoakes wrote:
>>On Thu, Feb 05, 2026 at 03:31:13AM +0000, Wei Yang wrote:
>>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>>> split_huge_pmd_locked()") return false unconditionally after
>>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>>> shared thp. This will lead to unexpected folio split failure.
>>
>>I think this could be put more clearly. 'When splitting a PMD THP migration
>>entry in try_to_migrate_one() in a rmap walk invoked by try_to_migrate() when
>
>split_huge_pmd_locked() could split a PMD THP migration entry, but here we
>expect a PMD THP normal entry.
>
>>TTU_SPLIT_HUGE_PMD is specified.' or something like that.
>>
>>>
>>> One way to reproduce:
>>>
>>>     Create an anonymous thp range and fork 512 children, so we have a
>>>     thp shared mapped in 513 processes. Then trigger folio split with
>>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>>     order 0.
>>
>>I think you should explain the issue before the repro. This is just confusing
>>things. Mention the repro _afterwards_.
>>
>
>OK, will move afterwards.
>
>>>
>>> Without the above commit, we can successfully split to order 0.
>>> With the above commit, the folio is still a large folio.
>>>
>>> The reason is the above commit return false after split pmd
>>
>>This sentence doesn't really make sense. Returns false where? And under what
>>circumstances?
>>
>>I'm having to look through 60fbb14396d5 to understand this which isn't a good
>>sign.
>>
>>'This patch adjusted try_to_migrate_one() to, when a PMD-mapped THP migration
>
>I am afraid the original intention of commit 60fbb14396d5 is not just for
>migration entry.
>
>>entry is found, and TTU_SPLIT_HUGE_PMD is specified (for example, via
>>unmap_folio()), exit the walk and return false unconditionally'.
>>
>>> unconditionally in the first process and break try_to_migrate().
>>>
>>> On memory pressure or failure, we would try to reclaim unused memory or
>>> limit bad memory after folio split. If failed to split it, we will leave
>>
>>Limit bad memory? What does that mean? Also should be If '_we_' or '_it_' or
>>something like that.
>>
>
>What I want to mean is in memory_failure() we use try_to_split_thp_page() and
>the PG_has_hwpoisoned bit is only set in the after-split folio contains
>@split_at.
>
>>> some more memory unusable than expected.
>>
>>'We will leave some more memory unusable than expected' is super unclear.
>>
>>You mean we will fail to migrate THP entries at the PTE level?
>>
>
>No. 
>
>Hmm... I would like to clarify before continue.
>
>This fix is not to fix migration case. This is to fix folio split for a shared
>mapped PMD THP. Current folio split leverage migration entry during split
>anonymous folio. So the action here is not to migrate it.
>
>I am a little lost here.
>
>>Can we say this instead please?
>>

Hi, Lorenzo

I am not sure understand you correctly. If not, please let me know.

>>>
>>> The tricky thing in above reproduce method is current debugfs interface
>>> leverage function split_huge_pages_pid(), which will iterate the whole
>>> pmd range and do folio split on each base page address. This means it
>>> will try 512 times, and each time split one pmd from pmd mapped to pte
>>> mapped thp. If there are less than 512 shared mapped process,
>>> the folio is still split successfully at last. But in real world, we
>>> usually try it for once.
>>
>>This whole sentence could be dropped I think I don't think it adds anything.
>>
>>And you're really confusing the issue by dwelling on this I think.
>>

It is intended to explain why the reproduce method should fork 512 child. In
case it is not helpful, I will drop it.

>>You need to restart the walk in this case in order for the PTEs to be correctly
>>handled right?
>>
>>Can you explain why we can't just essentially revert 60fbb14396d5? Or at least
>>the bit that did this change?

Commit 60fbb14396d5 removed some duplicated check covered by
page_vma_mapped_walk(), so just reverting it may not good?

You mean a sentence like above is preferred in commit msg?

>>
>>Also is unmap_folio() the only caller with TTU_SPLIT_HUGE_PMD as the comment
>>that was deleted by 60fbb14396d5 implied? Or are there others? If it is, please
>>mention the commit msg.
>>

Currently there are two core users of TTU_SPLIT_HUGE_PMD:

  * try_to_unmap_one()
  * try_to_migrate_one()

And another two indirect user by calling try_to_unmap():

  * try_folio_split_or_unmap()
  * shrink_folio_list()

try_to_unmap_one() doesn't fail early, so only try_to_migrate_one() is
affected.

So you prefer some description like above to be added in commit msg?

>>
>>>
>>> This patch fixes this by restart page_vma_mapped_walk() after
>>> split_huge_pmd_locked(). We cannot simply return "true" to fix the
>>> problem, as that would affect another case:
>>
>>I mean how would it fix the problem to incorrectly have it return true when the
>>walk had not in fact completed?
>>
>>I'm not sure why you're dwelling on this idea in the commit msg?
>>
>>> split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and
>>> leave the folio mapped through PTEs; we would return "true" from
>>> try_to_migrate_one() in that case as well. While that is mostly
>>> harmless, we could end up walking the rmap, wasting some cycles.
>>
>>I mean I think we can just drop this whole paragraph no?
>>

I had an original explanation in [1], which is not clear.
Then David proposed this version in [2], which looks good to me. So I took it
in v3.

If this is not necessary, I am ok to drop it.

[1]: http://lkml.kernel.org/r/20260204004219.6524-1-richard.weiyang@gmail.com
[2]: http://lkml.kernel.org/r/df86ccfd-68a5-416e-81cc-02858e395b70@kernel.org

>>You might think I'm being picky about the commit msg here, but as is I find it
>>pretty much incomprehensible and that's not helpful if we have to go back and
>>read this in future.
>>
>
>Never mind.
>
>A clearer and comprehensive change log is helpful for all. And my English is
>not native language, so your suggestion helps a lot.
>
>>>
>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>> Tested-by: Lance Yang <lance.yang@linux.dev>
>>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>>> Reviewed-by: Gavin Guo <gavinguo@igalia.com>
>>> Acked-by: David Hildenbrand (arm) <david@kernel.org>
>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: Lance Yang <lance.yang@linux.dev>
>>> Cc: <stable@vger.kernel.org>
>>>
>>> ---
>>> v3:
>>>   * gather RB
>>>   * adjust the commit log and comment per David
>>
>>Clearly not enough :)
>>
>>>   * add userspace-visible runtime effect in change log
>>
>>Which one was that?
>>
>>> v2:
>>>   * restart page_vma_mapped_walk() after split_huge_pmd_locked()
>>> ---
>>>  mm/rmap.c | 12 +++++++++---
>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 618df3385c8b..1041a64b8e6b 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -2446,11 +2446,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>  			__maybe_unused pmd_t pmdval;
>>>
>>>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>>> +				/*
>>> +				 * split_huge_pmd_locked() might leave the
>>> +				 * folio mapped through PTEs. Retry the walk
>>> +				 * so we can detect this scenario and properly
>>> +				 * abort the walk.
>>> +				 */
>>
>>This comment is a lot clearer than the commit msg :)
>>
>>>  				split_huge_pmd_locked(vma, pvmw.address,
>>>  						      pvmw.pmd, true);
>>> -				ret = false;
>>> -				page_vma_mapped_walk_done(&pvmw);
>>> -				break;
>>> +				flags &= ~TTU_SPLIT_HUGE_PMD;
>>> +				page_vma_mapped_walk_restart(&pvmw);
>>> +				continue;
>>
>>This logic does lok reasonable.
>>
>>>  			}
>>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>>  			pmdval = pmdp_get(pvmw.pmd);
>>> --
>>> 2.34.1
>>>
>>
>>Cheers, Lorenzo
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me

