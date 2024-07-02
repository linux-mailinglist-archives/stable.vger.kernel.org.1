Return-Path: <stable+bounces-56361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCE192425D
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350791F23817
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A971BBBD7;
	Tue,  2 Jul 2024 15:29:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB161BB6B0;
	Tue,  2 Jul 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934150; cv=none; b=b8eXsZkEYA0ofwTTq02jqQCm9QO+y1H/F2bXgtN0+X/5zDqVE//g/czgyQcluxXL04RQpAoGElv9/TK4fWD9ULLs4zj9UDUDVPy2EmMYyCBD5K9ZQqQktQh5cEGtqXw9hBVQWF+qxCY9kAFzwspVjrhUBR6jN4j4ZdrsBMLaGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934150; c=relaxed/simple;
	bh=k9zcHWSU3SVCDd1jDmuhPlvQkn/cGB17Vzw6wwxarDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpTbI2kTuxp5zsy177bvPQx2bPgmIIVtr7a3GFAboeermMx82o+h+D+O1uTMeZNS6imqZiARSJPk2NkVLH5jieIcdRiB3B2RPYrZ26Ht9uPzwTzZYs2yJ7K1mZ+nFXLEVSN15euEdrrYcQIcIOk5NLCBa1t1MZRc5uFS/4FJ5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69935339;
	Tue,  2 Jul 2024 08:29:32 -0700 (PDT)
Received: from [10.1.32.193] (XHFQ2J9959.cambridge.arm.com [10.1.32.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6B7A3F766;
	Tue,  2 Jul 2024 08:29:05 -0700 (PDT)
Message-ID: <ed5042af-b12f-4a36-a2e7-9d8983141099@arm.com>
Date: Tue, 2 Jul 2024 16:29:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix khugepaged activation policy
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lance Yang <ioworker0@gmail.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240702144617.2291480-1-ryan.roberts@arm.com>
 <c877a136-4294-4f00-b0ac-7194fe170452@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c877a136-4294-4f00-b0ac-7194fe170452@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/07/2024 15:57, David Hildenbrand wrote:
> On 02.07.24 16:46, Ryan Roberts wrote:
>> Since the introduction of mTHP, the docuementation has stated that
>> khugepaged would be enabled when any mTHP size is enabled, and disabled
>> when all mTHP sizes are disabled. There are 2 problems with this; 1.
>> this is not what was implemented by the code and 2. this is not the
>> desirable behavior.
>>
>> Desirable behavior is for khugepaged to be enabled when any PMD-sized
>> THP is enabled, anon or file. (Note that file THP is still controlled by
>> the top-level control so we must always consider that, as well as the
>> PMD-size mTHP control for anon). khugepaged only supports collapsing to
>> PMD-sized THP so there is no value in enabling it when PMD-sized THP is
>> disabled. So let's change the code and documentation to reflect this
>> policy.
>>
>> Further, per-size enabled control modification events were not
>> previously forwarded to khugepaged to give it an opportunity to start or
>> stop. Consequently the following was resulting in khugepaged eroneously
>> not being activated:
>>
>>    echo never > /sys/kernel/mm/transparent_hugepage/enabled
>>    echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
>> Closes:
>> https://lore.kernel.org/linux-mm/7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com/
>> Cc: stable@vger.kernel.org
>> ---
>>
>> Hi All,
>>
>> Applies on top of today's mm-unstable (9bb8753acdd8). No regressions observed in
>> mm selftests.
>>
>> When fixing this I also noticed that khugepaged doesn't get (and never has been)
>> activated/deactivated by `shmem_enabled=`. I'm not sure if khugepaged knows how
>> to collapse shmem - perhaps it should be activated in this case?
>>
> 
> Call me confused.
> 
> khugepaged_scan_mm_slot() and madvise_collapse() only all
> hpage_collapse_scan_file() with ... IS_ENABLED(CONFIG_SHMEM) ?

Looks like khugepaged_scan_mm_slot() was converted from:

  if (shmem_file(vma->vm_file)) {

to:

  if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {

By 99cb0dbd47a15d395bf3faa78dc122bc5efe3fc0 which adds THP collapse support for
non-shmem files. Clearly that looks wrong, but I guess never spotted in practice
because noone disables shemem?

I guess madvise_collapse() was a copy/paste?

> 
> collapse_file() is only called by hpage_collapse_scan_file() ... and there we
> check "shmem_file(file)".
> 
> So why is the IS_ENABLED(CONFIG_SHMEM) check in there if collapse_file() seems
> to "collapse filemap/tmpfs/shmem pages into huge one".
> 
> Anyhow, we certainly can collapse shmem (that's how it all started IIUC).

Yes, thanks for pointing me at it. Should have just searched "shmem" in
khugepaged.c :-/

> 
> Besides that, khugepaged only seems to collapse !shmem with
>   VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);

That makes sense. I guess I could use IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) to
tighen the (non-shmem) file THP check in hugepage_pmd_enabled() (currently I'm
unconditionally using the top-level enabled setting as a "is THP enabled for
files" check).

But back to my original question, I think hugepage_pmd_enabled() should also be
explicitly checking the appropriate shmem_enabled controls and ORing in the
result? Otherwise in a situation where only shmem is THP enabled (and file/anon
THP is disabled) khugepaged won't run.

> 
> The thp_vma_allowable_order() check tests if we are allowed to collapse a
> PMD_ORDER in that VMA.

I don't follow the relevance of this statement.


