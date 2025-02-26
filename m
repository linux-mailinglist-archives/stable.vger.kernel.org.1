Return-Path: <stable+bounces-119629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D0FA457B2
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E2116B81E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08793258CFB;
	Wed, 26 Feb 2025 08:09:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FA5258CC8;
	Wed, 26 Feb 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557380; cv=none; b=sHM2bY5pzKB5vjp9b9L9SAND/Ca40ByslkEHUs98Lc19JjCtui5pr/SNORTlyp+6tHpjXj/MnGFW4iliv89PU4GA95h7Y8NPRttjW2cRfa4zIDNFzTKyOK/5hyQBNARUZ0AEpdQN+LptOEfXbveu0t6etJbHcJzQ2hHCwrw7xOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557380; c=relaxed/simple;
	bh=hQgGQD0iEqWSkNezcvW26OJ79Eo6Fn3C6DHORQOOWkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0FmAs/cXP+JemIF+XwfvIDzTio+mbN0ahKSbNnstd2wNFFTHWrCALqcVfqlSfROaMPr6Mm5JUQ0Lqpj1P2SMeSNLijXkaOIEAoIlUm5ADaXgy9nYNSOzgkUt/E5rqys2Q5HLJ0he6/7DgfBmq7q5HKWw80EBqWIsowTFY+HO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A0441516;
	Wed, 26 Feb 2025 00:09:54 -0800 (PST)
Received: from [10.57.84.229] (unknown [10.57.84.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9B03F673;
	Wed, 26 Feb 2025 00:09:32 -0800 (PST)
Message-ID: <bc5af769-6d3a-4003-81c2-f5fe5cf8550c@arm.com>
Date: Wed, 26 Feb 2025 08:09:32 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: hugetlb: Fix huge_ptep_get_and_clear() for
 non-present ptes
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Dev Jain <dev.jain@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-3-ryan.roberts@arm.com>
 <20250221153156.GC20567@willie-the-truck>
 <6ebf36f2-2e55-49b2-8764-90fd972d6e66@arm.com>
 <20250225221812.GA23870@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250225221812.GA23870@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2025 22:18, Will Deacon wrote:
> On Mon, Feb 24, 2025 at 12:11:19PM +0000, Ryan Roberts wrote:
>> On 21/02/2025 15:31, Will Deacon wrote:
>>> On Mon, Feb 17, 2025 at 02:04:15PM +0000, Ryan Roberts wrote:
>>>> +	pte = __ptep_get_and_clear(mm, addr, ptep);
>>>> +	present = pte_present(pte);
>>>> +	while (--ncontig) {
>>>> +		ptep++;
>>>> +		addr += pgsize;
>>>> +		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
>>>> +		if (present) {
>>>> +			if (pte_dirty(tmp_pte))
>>>> +				pte = pte_mkdirty(pte);
>>>> +			if (pte_young(tmp_pte))
>>>> +				pte = pte_mkyoung(pte);
>>>> +		}
>>>>  	}
>>>
>>> nit: With the loop now structured like this, we really can't handle
>>> num_contig_ptes() returning 0 if it gets an unknown size. Granted, that
>>> really shouldn't happen, but perhaps it would be better to add a 'default'
>>> case with a WARN() to num_contig_ptes() and then add an early return here?
>>
>> Looking at other users of num_contig_ptes() it looks like huge_ptep_get()
>> already assumes at least 1 pte (it calls __ptep_get() before calling
>> num_contig_ptes()) and set_huge_pte_at() assumes 1 pte for the "present and
>> non-contig" case. So num_contig_ptes() returning 0 is already not really
>> consumed consistently.
>>
>> How about we change the default num_contig_ptes() return value to 1 and add a
>> warning if size is invalid:
> 
> Fine by me!
> 
> I assume you'll fold that in and send a new version, along with the typo
> fixes?

Yep, I'll aim to post this today. I have a few review comments for s390 to add
in too.

> 
> Cheers,
> 
> Will


