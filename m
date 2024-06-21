Return-Path: <stable+bounces-54834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C178912B6D
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0DD2898A9
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB58161322;
	Fri, 21 Jun 2024 16:34:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF181607B3
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987658; cv=none; b=ckJDEGNwQNA7EJ1wLp0WDMMnhcrZJyvovEAioZUIu13wwtkOntgwUW8YV0XaLQF2qosbH5BRTqixgiiNzb7nI6KiN9/5fxRaJlfIEfbkd6iyICB6cPf0BbvsKscjbeD8Wva0eCeXeUBOSAKoqDYNKAHUFtCdmHe+Dya5MYL8WU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987658; c=relaxed/simple;
	bh=R/dsGjFbFgJi/gQSKzZPRIwgg9qhaxfY1auB/rC7z/w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rIoc7FKZBsOlMDv3TwKaF61yMlyPtJPzHAQJz/zN548z37yppe/zD2pHEDshFgj32e//XO5qD/aeNZ2s19XaaooyCihvbz7tz4HvfUCl3lITvVzTwOj+zx7NiLmkfSMjoBa51A87yEwhao0e8/qe7vy2xiBI0xDDgM95FdU5dhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD8C3DA7;
	Fri, 21 Jun 2024 09:34:39 -0700 (PDT)
Received: from [10.57.74.104] (unknown [10.57.74.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9936D3F73B;
	Fri, 21 Jun 2024 09:34:11 -0700 (PDT)
Message-ID: <d4cadbc3-05b7-4d65-8d67-79b62a09724c@arm.com>
Date: Fri, 21 Jun 2024 17:34:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] mm: fix race between __split_huge_pmd_locked() and
 GUP-fast
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Andreas Larsson <andreas@gaisler.com>,
 Andy Lutomirski <luto@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <2024061316-brook-imaging-a202@gregkh>
 <20240621152243.131800-1-ryan.roberts@arm.com>
 <f6454225-dd2d-4e22-8d86-b41ec6fe48cd@arm.com>
In-Reply-To: <f6454225-dd2d-4e22-8d86-b41ec6fe48cd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/06/2024 16:31, Ryan Roberts wrote:
> Sorry, please ignore this patch (see below)...
> 
> 

[...]

>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 4e640baf9794..3bfc31a7cb38 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -194,6 +194,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  		     pmd_t *pmdp)
>>  {
>> +	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
>>  	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
> 
> old needs to be defined before the warning; I'm getting a compile warning on
> 5.15. I fixed that up but failed to add it to this commit. But the real question
> is why I'm not seeing the same warning on mainline? Let me investigate and
> resend appropriate patches.

OK, it turns out that commit b5ec6fd286df ("kbuild: Drop
-Wdeclaration-after-statement") (v6.5 timeframe) stopped emitting compiler
warnings for statements that appear before declarations, so when I did the
original fix for mainline, there was no warning for this.

Current status with backports for this patch is; you have applied to kernels
back to 5.15, and from 5.15 backwards there are conflicts. Clearly when applied
to any kernel prior to v6.5 this will result in warning when DEBUG_VM is enabled.

What's the best way to proceed? Should we just fix up the backports, or am I
going to have to deliver a separate (technically uneccessary) patch to mainline
that can then be backported?

Thanks,
Ryan

> 
>>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>  	return old;
> 


