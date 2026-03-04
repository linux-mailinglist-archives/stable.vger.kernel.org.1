Return-Path: <stable+bounces-222962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNW7OBWGp2m5iAAAu9opvQ
	(envelope-from <stable+bounces-222962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 02:08:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B31F912F
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 02:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 511FD3024A0F
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E697F2F5321;
	Wed,  4 Mar 2026 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g15zCDu8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8229408
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586513; cv=none; b=MYmbI3wOft51L7NkceH3Zi+wP4XR8Cvis0cqqQgbn41fF9Mzvehc0ccYwdy2P/l+3DlULkGFoOR3wfDpGlPJ1TXmhVYrKtqjf2c8YcL8yOMbeZZ9uHoVs1sfJiwvCKpfRp5f90c6Tm1Bdc205bOjc49CgBM4uq3VBMzHek5tj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586513; c=relaxed/simple;
	bh=LgmqqKOuR6hvAvI1memUqtNUxx565nSqbIsSMg8wdgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcWLPNnzyPIDB4ku5VjJXNowynmu0OhtU2LkGuVSZIuZiN2InW/dvflI8+vpdI44KwH3baf19ttXG6+C7tQkxUL3ZcJ03eZpqPHe9SHoHLSY2CHnXx3ohurWJfCJN5/9kWhJpuYd0lYCmeVmzhmp2ZjddsJHUVNVHsr7YMC9BP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g15zCDu8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-660b497acd1so1512038a12.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 17:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772586510; x=1773191310; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90j8x42X7s075F4Kb7j/ju7Nz6t7T+bBhLBoYSSvU/w=;
        b=g15zCDu8Zxy0IUn0SI/9Fap/uKsyQoIyMLvq7XsTUdoMAJ7Oyal2uG481pB4CfZcLr
         DQe5obtFCi2O787oCOWEoFjbgSpj6/fGthHI7WwDmRV5Y6G5eVVWAxRCmmWj22/h6HTJ
         jBCTpyUkSBDlFUqUfMrNTn8fNvXfbBJwFEzF6dZFPS/usFDGjyGtq9r5/z3s/PkcSqgN
         +rG206bB95YwK1TuOs7gu1ag+BX27pPZ/ysk2JJNXIRH2Gmu8bancO5PuC5W9elLIZdo
         5z/4xSAWPN9+Rss9zXyUIY+yyxKlQKIWXWOHXd0vSTHcO8N5cHKKzbeqCeptC6Qidxx4
         PjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772586510; x=1773191310;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90j8x42X7s075F4Kb7j/ju7Nz6t7T+bBhLBoYSSvU/w=;
        b=LtclEahiYJ8wQjMQsqaXyFUm5f1w1s5Dgfw8aQhZBl8/itWHnrLUVv0gh6Ny6sBazI
         Czfw0o+zi9p6PkOubqqyO8x7AXsaso9QSEWZXy83Ed+ldopSbBJAawYfYhAKcqVMKL/j
         ExuwC+PemQGqZ4EAj3VsARuWKI1rCHfvnbGn3p5SeraeFlpMEVebIlOVokAeKefJmRho
         8jupDrmK6CXy86yG9RTu22qqawVx9F9I/S2vdlv/ShWniQS7FaU6ZJl+Gcl9arUkxeAs
         l0cHzCrNpeBCxDOfzPvS4BW3eV7Oo6+mdhMLfhTpEJPGE90KPJytxez0mgXredM8gtc1
         Kdzg==
X-Forwarded-Encrypted: i=1; AJvYcCX606uKA1AgVPuy1YidwWM5hpLJUULSV6loyacIZe0B/Nd7RGFLxSNAb4U0c49bdMNd+ygHNQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+mVf/EfGTcgfLKHIQQaYyU1kTyyuHDZLFF3/HDAwys8rFCgI
	GQZ/7tRZZPftbEp4m9KrqWZECy0l3ZZlMo42rMizUSvMAtrwP00YDtqr
X-Gm-Gg: ATEYQzysEzJU56KUSCVIZRjQpRf+/pU1xI6AUn7XQqA9yaEN8b0C7r7qSzLJ545+YaP
	fixQynhSvP5m8wiOi9GMAcKige5+rXaruRmIKM/HPmSEdaIkeFq7Pqo7H8Z4ClX5BGVsZpW5x7K
	h7l7nwf1wjBahVyxwNwksDyLMdOWfwB0AfVKc9aQVeqNdT5UCdB9hT20hP+3JGNC9SP9vO6goY+
	GUy7sby9D5xo9ZmNlERkK9Na5Bg3MM07o4B93MTVbANZ5Dag7jAzm0uwneNUlT/7TSq77Xthg5A
	McE0WrxsQg30LnmqS9VUaJvj7F6U9YCBOYQthT3h6hQ9uZNbc+LRietxnJm1qsNHxpOe6OqoXLu
	NrCc0gMjiBGT0dGTGWkMBzDp2HTmjL72zcD6HlEvjwXc1fcIUqfXXoEacGk3DpR9C+Esj02If7C
	UyQtKdiAWY4B6EVl+hQ1yJYw==
X-Received: by 2002:a05:6402:2354:b0:659:38ea:c4e3 with SMTP id 4fb4d7f45d1cf-660f00cf1damr80946a12.25.1772586509688;
        Tue, 03 Mar 2026 17:08:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-660e793b7d4sm168504a12.7.2026.03.03.17.08.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2026 17:08:29 -0800 (PST)
Date: Wed, 4 Mar 2026 01:08:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, riel@surriel.com, Liam.Howlett@oracle.com,
	vbabka@suse.cz, harry.yoo@oracle.com, jannh@google.com,
	gavinguo@igalia.com, baolin.wang@linux.alibaba.com, ziy@nvidia.com,
	linux-mm@kvack.org, Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [Patch v3] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Message-ID: <20260304010828.ulp5i3v2drwhzytc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260205033113.30724-1-richard.weiyang@gmail.com>
 <fbd6c31f-7f35-4986-86e3-76bf8963433d@lucifer.local>
 <20260210032304.j4k5izweewouabqb@master>
 <20260213132027.wm75sh6trz7n24kd@master>
 <c820d6a1-4283-46a5-a639-04f6849e4e73@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c820d6a1-4283-46a5-a639-04f6849e4e73@lucifer.local>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Queue-Id: 5C9B31F912F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222962-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,surriel.com,oracle.com,suse.cz,google.com,igalia.com,linux.alibaba.com,nvidia.com,kvack.org,linux.dev,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:12:35AM +0000, Lorenzo Stoakes wrote:
>On Fri, Feb 13, 2026 at 01:20:27PM +0000, Wei Yang wrote:
>> On Tue, Feb 10, 2026 at 03:23:04AM +0000, Wei Yang wrote:
>> >On Mon, Feb 09, 2026 at 05:08:16PM +0000, Lorenzo Stoakes wrote:
>> >>On Thu, Feb 05, 2026 at 03:31:13AM +0000, Wei Yang wrote:
>> >>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>> >>> split_huge_pmd_locked()") return false unconditionally after
>> >>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>> >>> shared thp. This will lead to unexpected folio split failure.
>> >>
>> >>I think this could be put more clearly. 'When splitting a PMD THP migration
>> >>entry in try_to_migrate_one() in a rmap walk invoked by try_to_migrate() when
>> >
>> >split_huge_pmd_locked() could split a PMD THP migration entry, but here we
>> >expect a PMD THP normal entry.
>> >
>> >>TTU_SPLIT_HUGE_PMD is specified.' or something like that.
>> >>
>> >>>
>> >>> One way to reproduce:
>> >>>
>> >>>     Create an anonymous thp range and fork 512 children, so we have a
>> >>>     thp shared mapped in 513 processes. Then trigger folio split with
>> >>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>> >>>     order 0.
>> >>
>> >>I think you should explain the issue before the repro. This is just confusing
>> >>things. Mention the repro _afterwards_.
>> >>
>> >
>> >OK, will move afterwards.
>> >
>> >>>
>> >>> Without the above commit, we can successfully split to order 0.
>> >>> With the above commit, the folio is still a large folio.
>> >>>
>> >>> The reason is the above commit return false after split pmd
>> >>
>> >>This sentence doesn't really make sense. Returns false where? And under what
>> >>circumstances?
>> >>
>> >>I'm having to look through 60fbb14396d5 to understand this which isn't a good
>> >>sign.
>> >>
>> >>'This patch adjusted try_to_migrate_one() to, when a PMD-mapped THP migration
>> >
>> >I am afraid the original intention of commit 60fbb14396d5 is not just for
>> >migration entry.
>> >
>> >>entry is found, and TTU_SPLIT_HUGE_PMD is specified (for example, via
>> >>unmap_folio()), exit the walk and return false unconditionally'.
>> >>
>> >>> unconditionally in the first process and break try_to_migrate().
>> >>>
>> >>> On memory pressure or failure, we would try to reclaim unused memory or
>> >>> limit bad memory after folio split. If failed to split it, we will leave
>> >>
>> >>Limit bad memory? What does that mean? Also should be If '_we_' or '_it_' or
>> >>something like that.
>> >>
>> >
>> >What I want to mean is in memory_failure() we use try_to_split_thp_page() and
>> >the PG_has_hwpoisoned bit is only set in the after-split folio contains
>> >@split_at.
>
>I mean is this the case you're asserting in your repro or is it the only one in
>which the issue can arise?
>
>You should make this clear with reference to the actual functions where this
>happens in the commit msg.
>
>> >
>> >>> some more memory unusable than expected.
>> >>
>> >>'We will leave some more memory unusable than expected' is super unclear.
>> >>
>> >>You mean we will fail to migrate THP entries at the PTE level?
>> >>
>> >
>> >No.
>> >
>> >Hmm... I would like to clarify before continue.
>> >
>> >This fix is not to fix migration case. This is to fix folio split for a shared
>> >mapped PMD THP. Current folio split leverage migration entry during split
>> >anonymous folio. So the action here is not to migrate it.
>> >
>> >I am a little lost here.
>> >
>> >>Can we say this instead please?
>> >>
>>
>> Hi, Lorenzo
>>
>> I am not sure understand you correctly. If not, please let me know.
>>
>> >>>
>> >>> The tricky thing in above reproduce method is current debugfs interface
>> >>> leverage function split_huge_pages_pid(), which will iterate the whole
>> >>> pmd range and do folio split on each base page address. This means it
>> >>> will try 512 times, and each time split one pmd from pmd mapped to pte
>> >>> mapped thp. If there are less than 512 shared mapped process,
>> >>> the folio is still split successfully at last. But in real world, we
>> >>> usually try it for once.
>> >>
>> >>This whole sentence could be dropped I think I don't think it adds anything.
>> >>
>> >>And you're really confusing the issue by dwelling on this I think.
>> >>
>>
>> It is intended to explain why the reproduce method should fork 512 child. In
>> case it is not helpful, I will drop it.
>
>Yeah it's not too helpful I don't think. You could say 'forking many children'
>or something.
>
>>
>> >>You need to restart the walk in this case in order for the PTEs to be correctly
>> >>handled right?
>> >>
>> >>Can you explain why we can't just essentially revert 60fbb14396d5? Or at least
>> >>the bit that did this change?
>>
>> Commit 60fbb14396d5 removed some duplicated check covered by
>> page_vma_mapped_walk(), so just reverting it may not good?
>>
>> You mean a sentence like above is preferred in commit msg?
>
>I mean you need to explain why you're not just reverting it, saying why in
>the commit msg would be helpful yes, thanks!
>
>>
>> >>
>> >>Also is unmap_folio() the only caller with TTU_SPLIT_HUGE_PMD as the comment
>> >>that was deleted by 60fbb14396d5 implied? Or are there others? If it is, please
>> >>mention the commit msg.
>> >>
>>
>> Currently there are two core users of TTU_SPLIT_HUGE_PMD:
>>
>>   * try_to_unmap_one()
>>   * try_to_migrate_one()
>>
>> And another two indirect user by calling try_to_unmap():
>>
>>   * try_folio_split_or_unmap()
>>   * shrink_folio_list()
>>
>> try_to_unmap_one() doesn't fail early, so only try_to_migrate_one() is
>> affected.
>>
>> So you prefer some description like above to be added in commit msg?
>
>Yes please! Thanks.
>
>>
>> >>
>> >>>
>> >>> This patch fixes this by restart page_vma_mapped_walk() after
>> >>> split_huge_pmd_locked(). We cannot simply return "true" to fix the
>> >>> problem, as that would affect another case:
>> >>
>> >>I mean how would it fix the problem to incorrectly have it return true when the
>> >>walk had not in fact completed?
>> >>
>> >>I'm not sure why you're dwelling on this idea in the commit msg?
>> >>
>> >>> split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and
>> >>> leave the folio mapped through PTEs; we would return "true" from
>> >>> try_to_migrate_one() in that case as well. While that is mostly
>> >>> harmless, we could end up walking the rmap, wasting some cycles.
>> >>
>> >>I mean I think we can just drop this whole paragraph no?
>> >>
>>
>> I had an original explanation in [1], which is not clear.
>> Then David proposed this version in [2], which looks good to me. So I took it
>> in v3.
>>
>> If this is not necessary, I am ok to drop it.
>
>Hmm :P well I don't want to contradict David, his suggestions are usually
>excellent, but I think that paragraph needs rework at the very least. It's
>useful to mention functions explicitly, I think something like:
>
>'when invoking folio_try_share_anon_rmap_pmd() from split_huge_pmd_locked(), the
>latter can fail and leave a large folio mapped using PTEs, in which case we
>ought to return true from try_to_migrate_one(). This might result in unnecesary
>walking of the rmap but is relatively harmless'
>
>Might work better?
>

Hi, Lorenzo

Thanks for your reply.  Since there are several suggestions scattered in
several mails, I would like to consolidate all of them here.

Below is the updated version of commit msg with change marked. If I miss or
misunderstand your point, please let me know.


Subject: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when split
 huge pmd for shared THP

Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and          <--- simplify a little and 
split_huge_pmd_locked()") return false unconditionally after                        put reasoning in next paragraph
split_huge_pmd_locked(). This may fail try_to_migrate() early when
TTU_SPLIT_HUGE_PMD is specified.

The reason is the above commit adjusted try_to_migrate_one() to, when a        <--- specify the function affected
PMD-mapped THP entry is found, and TTU_SPLIT_HUGE_PMD is specified (for             try explain reason clearly
example, via unmap_folio()), return false unconditionally. This breaks the
rmap walk and fail try_to_migrate() early, if this PMD-mapped THP is mapped in
multiple processes.

The user sensible impact of this bug could be:                                 <--- more detail on the user sensible impact

  * On memory pressure, shrink_folio_list() may split partially mapped folio
    with split_folio_to_list(). Then free unmapped pages without IO. If
    failed, it may not be reclaimed.
  * On memory failure, memory_failure() would call try_to_split_thp_page()
    to split folio contains the bad page. If succeed, the PG_has_hwpoisoned
    bit is only set in the after-split folio contains @split_at. By doing
    so, we limit bad memory. If failed to split, the whole folios is not
    usable.

One way to reproduce:                                                          <--- move repo after reasoning
                                                                                    remove explanation on tricky number
                                                                         
    Create an anonymous THP range and fork 512 children, so we have a
    THP shared mapped in 513 processes. Then trigger folio split with
    /sys/kernel/debug/split_huge_pages debugfs to split the THP folio to
    order 0.

Without the above commit, we can successfully split to order 0.
With the above commit, the folio is still a large folio.

And currently there are two core users of TTU_SPLIT_HUGE_PMD:                  <--- only try_to_migrate_one() affected

  * try_to_unmap_one()
  * try_to_migrate_one()

try_to_unmap_one() would restart the rmap walk, so only try_to_migrate_one()
is affected.

We can't simply revert commit 60fbb14396d5 ("mm/huge_memory: adjust            <--- why not just revert it
try_to_migrate_one() and split_huge_pmd_locked()"), since it removed some
duplicated check covered by page_vma_mapped_walk().

This patch fixes this by restart page_vma_mapped_walk() after
split_huge_pmd_locked(). Since we cannot simply return "true" to fix the
problem, as that would affect another case:

    When invoking folio_try_share_anon_rmap_pmd() from                         <--- rephrase the explanation
    split_huge_pmd_locked(), the latter can fail and leave a large folio            on not return "true"
    mapped through PTEs, in which case we ought to return true from
    try_to_migrate_one(). This might result in unnecessary walking of the rmap
    but is relatively harmless.

Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Gavin Guo <gavinguo@igalia.com>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Cc: Gavin Guo <gavinguo@igalia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: <stable@vger.kernel.org>

---
v4:
  * only commit msg adjustment
    - rephrase the reason analysis
    - move reproduce method afterward
    - more explanation on user sensible effect of the bug, especially expand
      what "Limit bad page" means
    - remove the explanation on whey it need to fork 512 child for reproduce
    - explain why simply revert commit 60fbb14396d5 is not taken
    - mention TTU_SPLIT_HUGE_PMD users and confirm not affect others
    - rephrase the reason why can't simply return true
v3:
  * gather RB
  * adjust the commit log and comment per David
  * add userspace-visible runtime effect in change log
v2:
  * restart page_vma_mapped_walk() after split_huge_pmd_locked()
---
 mm/rmap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index beb423f3e8ec..e609dd5b382f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2444,11 +2444,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			__maybe_unused pmd_t pmdval;
 
 			if (flags & TTU_SPLIT_HUGE_PMD) {
+				/*
+				 * split_huge_pmd_locked() might leave the
+				 * folio mapped through PTEs. Retry the walk
+				 * so we can detect this scenario and properly
+				 * abort the walk.
+				 */
 				split_huge_pmd_locked(vma, pvmw.address,
 						      pvmw.pmd, true);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				flags &= ~TTU_SPLIT_HUGE_PMD;
+				page_vma_mapped_walk_restart(&pvmw);
+				continue;
 			}
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 			pmdval = pmdp_get(pvmw.pmd);
-- 
2.34.1


-- 
Wei Yang
Help you, Help me

