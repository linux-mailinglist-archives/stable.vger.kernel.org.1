Return-Path: <stable+bounces-65215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22459440F3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 04:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3332811FA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085EC13B797;
	Thu,  1 Aug 2024 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Lojho8xF"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5213DB9F;
	Thu,  1 Aug 2024 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477817; cv=none; b=kzP8B2LlfTRGGFgZXOwPsQ3jdKA2SvjLk5S2hgQ0+XDfqlpU+CqwPVJijjC3l1skyoPhpceRtZMGA2SyesMFUnFN5HzA89oDH+k1XP7CRfF3gJW/aNErRIqJBsz6XU0Wjgf2JqTt7c8PKg6TGLnC8Sj7ehFrsiYqV+6wwK/Hu/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477817; c=relaxed/simple;
	bh=5jVf1oPR7w2V/tyzdze17flhrIPhOs35t0msRPjezaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OuWPFOZA6plIGEimkmlqQHT/qbXTIj7qMdVRjMrX5uMzH8LeGXEblwm/B2dxI0iXjq9HmIEykKriv+9RG43KsXOODltV/OzCvdUPhtGJsmRuIRJdD1+kD8bFra5umucdVLcmetpgPcHY3BxfStsVxB40PZ2lD3KE5PvUQ2BWOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Lojho8xF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1722477812;
	bh=8adUdvUW737uHA/RqkquHip5HZGx3zcFU9ygzrLxTNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lojho8xFX67N2BejJZkXmuky71fNDSqpFlfBXmegPmbrfZom5lbPEK1s31Uvpbi8u
	 qAqIzrivsyTVNnvQ8FnVOUOKUQNtkHDFoIjrhy4mUKZDsG5map1kezbCfewhgS2hjp
	 H0ehc3IJP+2FLnz2/BuNrRlKJy9v3Y2M6xYdjR6tbVhlZahtsPcesA9GC9XjA10J7z
	 wtiI4ZijWRWnUbv7IQ+plaMJwuWRMTPTLhCOSuNSnNu/cEFMe98dvMbe9aP2bKvDUM
	 VQqV4AxremTPak3mvhMqTFAWWis26wyRofXluqhgkNNEWqjTggMfFG4ZbbyVMSFbsD
	 ZyzlLqGtsIQbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WZC1H32JZz4x0C;
	Thu,  1 Aug 2024 12:03:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, James Houghton
 <jthoughton@google.com>, stable@vger.kernel.org, Oscar Salvador
 <osalvador@suse.de>, Muchun Song <muchun.song@linux.dev>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix hugetlb vs. core-mm PT locking
In-Reply-To: <2b0131cf-d066-44ba-96d9-a611448cbaf9@redhat.com>
References: <20240731122103.382509-1-david@redhat.com>
 <ZqpQILQ7A_7qTvtq@x1n> <2b0131cf-d066-44ba-96d9-a611448cbaf9@redhat.com>
Date: Thu, 01 Aug 2024 12:03:30 +1000
Message-ID: <871q39ov7x.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Hildenbrand <david@redhat.com> writes:
> On 31.07.24 16:54, Peter Xu wrote:
...
>> 
>> The other nitpick is, I didn't yet find any arch that use non-zero order
>> page for pte pgtables.  I would give it a shot with dropping the mask thing
>> then see what explodes (which I don't expect any, per my read..), but yeah
>> I understand we saw some already due to other things, so I think it's fine
>> in this hugetlb path (that we're removing) we do a few more math if you
>> think that's easier for you.
>
> I threw
> 	BUILD_BUG_ON(PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
> into pte_lockptr() and did a bunch of cross-compiles.
>
> And for some reason it blows up for powernv (powernv_defconfig) and
> pseries (pseries_defconfig).
>
>
> In function 'pte_lockptr',
>      inlined from 'pte_offset_map_nolock' at mm/pgtable-generic.c:316:11:
> ././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_291' declared with attribute error: BUILD_BUG_ON failed: PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE
>    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |                                             ^
> ././include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
>    491 |                         prefix ## suffix();                             \
>        |                         ^~~~~~
> ././include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
>    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |         ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>        |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>        |         ^~~~~~~~~~~~~~~~
> ./include/linux/mm.h:2926:9: note: in expansion of macro 'BUILD_BUG_ON'
>   2926 |         BUILD_BUG_ON(PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
>        |         ^~~~~~~~~~~~
...
>
> pte_alloc_one() ends up calling pte_fragment_alloc(mm, 0). But there we always
> end up calling pagetable_alloc(, 0).
>
> And fragments are supposed to be <= a single page.
>
> Now I'm confused what's wrong here ... am I missing something obvious?
>
> CCing some powerpc folks. Is this some pte_t oddity?

It will be because PTRS_PER_PTE is not a compile time constant :(

  $ git grep "define PTRS_PER_PTE" arch/powerpc/include/asm/book3s/64
  arch/powerpc/include/asm/book3s/64/pgtable.h:#define PTRS_PER_PTE        (1 << PTE_INDEX_SIZE)
  
  $ git grep "define PTE_INDEX_SIZE" arch/powerpc/include/asm/book3s/64
  arch/powerpc/include/asm/book3s/64/pgtable.h:#define PTE_INDEX_SIZE  __pte_index_size
  
  $ git grep __pte_index_size arch/powerpc/mm/pgtable_64.c
  arch/powerpc/mm/pgtable_64.c:unsigned long __pte_index_size;

Which is because the pseries/powernv (book3s64) kernel supports either
the HPT or Radix MMU at runtime, and they have different page table
geometry.

If you change it to use MAX_PTRS_PER_PTE it should work (that's defined
for all arches).

cheers


diff --git a/include/linux/mm.h b/include/linux/mm.h
index 381750f41767..1fd9c296c0b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2924,6 +2924,8 @@ static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
 {
        /* PTE page tables don't currently exceed a single page. */
+       BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
+
        return ptlock_ptr(virt_to_ptdesc(pte));
 }

