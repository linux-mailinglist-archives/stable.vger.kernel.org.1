Return-Path: <stable+bounces-195194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB6C702F2
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 17:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 974BB3C4CAE
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1736923C;
	Wed, 19 Nov 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaDzWdP6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E9274666
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569765; cv=none; b=GW3GTvIsWksQ0UF0G/l79B8J1tLoKzrJ+jVrHBq/vBtzjzkdHdwcYv9Hn2O4FnnXB15xFtdIwXW2dTtomU0zf5tgpP41uA+TDAAPUxMWRTfesKtUGL8e4Xt4Hnc+J2DC2+oqvirTc5biEW3/QvyZLBvgYcv1LCLnQ6J7+ZSQmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569765; c=relaxed/simple;
	bh=TZ758d5/YEZLhoc4VSMgt5fLw/xbPcRGb/+cc267KEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awzwjfZdOTC/F9O4eqQhZxSbzLzgIk0yzfTbI/+/xg5ssn6th052gorGv8XGLBA7ni7A7PoSPDW23waXB3ksIhC1UBKUgHYEhBxvX1I58FaB+xFHl6FtvIcljweuMHobOgT8C8UgYlqwaNWNo+daiARAORpqPI17bubLnDT1FtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaDzWdP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAC0C4CEF5;
	Wed, 19 Nov 2025 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763569764;
	bh=TZ758d5/YEZLhoc4VSMgt5fLw/xbPcRGb/+cc267KEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MaDzWdP675KOgfaKESTfH59kXVQiWdke3+ygU+0OqRL7Sv1m8nQcmarXn+HUWfdyd
	 LCpBntydGltnMTi7A3/308fmvWGG9h955ph5tCtIstowAO37pRffmDPBk7LzBVlzg8
	 zwmgikgOwuTp1muye8MZlGwpBQ2ssgKDdZZ6sAjexroFvTjWU1q3m4oGKT7/37UzjR
	 9cZMW/spKryFmgq20PCPZH5m2h88ALKdSgknqVoFh0+IIoQULdY9xeO+pH7fpaB8ih
	 b7ULLq6ZEIe7/wBE0325qcBbgdNuYAwffq6r0D+LFXdyn+lXi5R7e3Fa21LPNnmnTN
	 brtT9OTr0MumA==
Message-ID: <968d5458-7d2b-4a8d-a2a6-0931cd87898f@kernel.org>
Date: Wed, 19 Nov 2025 17:29:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, "Uschakow, Stanislav" <suschako@amazon.de>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com"
 <trix@redhat.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
 "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
 "osalvador@suse.de" <osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
 <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
 <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
 <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
 <2bff49c4-6292-446b-9cd4-1563358fe3b4@redhat.com>
 <0dabc80e-9c68-41be-b936-8c6e55582c79@lucifer.local>
 <944a09b0-77a6-40c9-8bea-d6b86a438d8a@kernel.org>
 <1d53ef79-c88c-4c5b-af82-1eb22306993b@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <1d53ef79-c88c-4c5b-af82-1eb22306993b@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> So what I am currently looking into is simply reducing (batching) the number
>> of IPIs.
> 
> As in the IPIs we are now generating in tlb_remove_table_sync_one()?
> 
> Or something else?

Yes, for now. I'm essentially reducing the number of 
tlb_remove_table_sync_one() calls.

> 
> As this bug is only an issue when we don't use IPIs for pgtable freeing right
> (e.g. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set), as otherwise
> tlb_remove_table_sync_one() is a no-op?

Right. But it's still confusing: I think for page table unsharing we 
always need an IPI one way or the other to make sure GUP-fast was called.

At least for preventing that anybody would be able to reuse the page 
table in the meantime.

That is either:

(a) The TLB shootdown implied an IPI

(b) We manually send one

But that's where it gets confusing: nowadays x86 also selects 
MMU_GATHER_RCU_TABLE_FREE, meaning we would get a double IPI?

This is so complicated, so I might be missing something.

But it's the same behavior we have in collapse_huge_page() where we first

> 
>>
>> In essence, we only have to send one IPI when unsharing multiple page
>> tables, and we only have to send one when we are the last one sharing the
>> page table (before it can get reused).
> 
> Right, hopefully that significantly cuts down on the amount genrated.

I'd assume that the problem of the current approach is that when we fork 
a child and it quits, that we call __unmap_hugepage_range(). If the 
range is large enough to cover many PMD tables (multiple gigabytes?), we
essentially send one IPI per PMD table we are unsharing, when we really 
only have to send one.

That's the theory ...

-- 
Cheers

David

