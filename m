Return-Path: <stable+bounces-118567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B4A3F1F6
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 11:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E1A165AA0
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AB205AC4;
	Fri, 21 Feb 2025 10:27:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0941205504;
	Fri, 21 Feb 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133627; cv=none; b=d/CFHYQUh+V3nTK1fsSzcJPsU7Bv+/JtNOrlmEFF2jnzANlx34aPHv2WZpC+Q35UHx29sRtdsU0BFLKvX422vMVwyzkhO7VqgEWgARvxggePBR0z4qfi7Zx49MpX0d0iROnfqB9Oix7dlXHNv9HKoS3gXbWOCzpfHjJnkH977EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133627; c=relaxed/simple;
	bh=DTOaY89TL5e87zq5u+s/rMIusW8ifyGJo0qjCcMeWsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhqK3c44IphUbok4HufeYdpILkalFBFQ+FgSMUIMU/9xYAMpWZv83uV+actkgo1sGlQRuWiFxziMCeGtUOxDillXFpYmTd7k51OFLdBe5b+viyFo3BJaUDyBwtl51mP/ylCcjBx8a4FXSZR7K5VX4kZ7H7R9BZua+bwTPvLbEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D36C6169C;
	Fri, 21 Feb 2025 02:27:21 -0800 (PST)
Received: from [10.57.85.120] (unknown [10.57.85.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 320623F5A1;
	Fri, 21 Feb 2025 02:26:59 -0800 (PST)
Message-ID: <1ac64c39-419b-4fac-8820-bbfb4e6afec4@arm.com>
Date: Fri, 21 Feb 2025 10:26:57 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 Mark Rutland <mark.rutland@arm.com>, Dev Jain <dev.jain@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-3-ryan.roberts@arm.com>
 <e26a59a1-ff9a-49c7-b10a-c3f5c096a2c4@arm.com>
 <5477d161-12e7-4475-a6e9-ff3921989673@arm.com>
 <50f48574-241d-42d8-b811-3e422c41e21a@arm.com> <Z7hNgSBw6lfwwcch@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z7hNgSBw6lfwwcch@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2025 09:55, Catalin Marinas wrote:
> On Thu, Feb 20, 2025 at 12:07:35PM +0530, Anshuman Khandual wrote:
>> On 2/19/25 14:28, Ryan Roberts wrote:
>>> On 19/02/2025 08:45, Anshuman Khandual wrote:
>>>> On 2/17/25 19:34, Ryan Roberts wrote:
>>>>> +	while (--ncontig) {
>>>>
>>>> Should this be converted into a for loop instead just to be in sync with other
>>>> similar iterators in this file.
>>>>
>>>> for (i = 1; i < ncontig; i++, addr += pgsize, ptep++)
>>>> {
>>>> 	tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
>>>> 	if (present) {
>>>> 		if (pte_dirty(tmp_pte))
>>>> 			pte = pte_mkdirty(pte);
>>>> 		if (pte_young(tmp_pte))
>>>> 			pte = pte_mkyoung(pte);
>>>> 	}
>>>> }
>>>
>>> I think the way you have written this it's incorrect. Let's say we have 16 ptes
>>> in the block. We want to iterate over the last 15 of them (we have already read
>>> pte 0). But you're iterating over the first 15 because you don't increment addr
>>> and ptep until after you've been around the loop the first time. So we would
>>> need to explicitly increment those 2 before entering the loop. But that is only
>>> neccessary if ncontig > 1. Personally I think my approach is neater...
>>
>> Thinking about this again. Just wondering should not a pte_present()
>> check on each entries being cleared along with (ncontig > 1) in this
>> existing loop before transferring over the dirty and accessed bits -
>> also work as intended with less code churn ?
> 
> Shouldn't all the ptes in a contig block be either all present or all
> not-present? Is there any point in checking each individually?

I agree, that's why I was just testing it once outside the loop. I'm confident
my code and Anshuman's alternative are both correct. So it's just a stylistic
choice really. I'd prefer to leave it as is, but will change if there is
consensus. I'm not sure I'm hearing that though.

Catalin, do you want me to respin the series to fix up the typos that Anshuman
highlighted, or will you handle that?

Thanks,
Ryan


