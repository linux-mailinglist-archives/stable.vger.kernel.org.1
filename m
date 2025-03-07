Return-Path: <stable+bounces-121386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE6EA56926
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F817A867D
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824321A44E;
	Fri,  7 Mar 2025 13:42:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE63EBE;
	Fri,  7 Mar 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354939; cv=none; b=soz9DbUTswpVxzAz+1CjRrmbk3VUWrgIj1ovyBOF1rAraFlQT3ule556XCd0osHS0K7kJYzl7vPGTr69r1zsGbJkbewC4to1T+SajUdK8IxYJDab8+yky6bcd9bN6keu5VY2SeJyPYrj14R+PC+fV8brruJrcGrv4rvoIw/ESUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354939; c=relaxed/simple;
	bh=Q81dlDq1ruIEwRIRX5DraIRa9T4BWccpcCxweDZRP9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huA1tSi8JYEfCqRzlMI8RXHAoPRTGmHUYLDavfW7ThSyOFnjBJSJwsWbnQ4J6G4R1Sz22azsu5xNR1GBWMXYmgUVw7IMRh8Uu239LId4ODNDlq/sRdFuyvmtmmTusCRVf5n5GdtUXXelL5lfM+EOXQ6u0aS+km4oZ9UupknB1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 831931477;
	Fri,  7 Mar 2025 05:42:28 -0800 (PST)
Received: from [10.57.84.99] (unknown [10.57.84.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F17883F66E;
	Fri,  7 Mar 2025 05:42:14 -0800 (PST)
Message-ID: <03997253-0717-4ecb-8ac8-4a7ba49481a3@arm.com>
Date: Fri, 7 Mar 2025 13:42:13 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/madvise: Always set ptes via arch helpers
Content-Language: en-GB
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250307123307.262298-1-ryan.roberts@arm.com>
 <dbdeb4d7-f7b9-4b10-ada3-c2d37e915f6d@lucifer.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <dbdeb4d7-f7b9-4b10-ada3-c2d37e915f6d@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2025 13:04, Lorenzo Stoakes wrote:
> On Fri, Mar 07, 2025 at 12:33:06PM +0000, Ryan Roberts wrote:
>> Instead of writing a pte directly into the table, use the set_pte_at()
>> helper, which gives the arch visibility of the change.
>>
>> In this instance we are guaranteed that the pte was originally none and
>> is being modified to a not-present pte, so there was unlikely to be a
>> bug in practice (at least not on arm64). But it's bad practice to write
>> the page table memory directly without arch involvement.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/madvise.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 388dc289b5d1..6170f4acc14f 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -1101,7 +1101,7 @@ static int guard_install_set_pte(unsigned long addr, unsigned long next,
>>  	unsigned long *nr_pages = (unsigned long *)walk->private;
>>
>>  	/* Simply install a PTE marker, this causes segfault on access. */
>> -	*ptep = make_pte_marker(PTE_MARKER_GUARD);
>> +	set_pte_at(walk->mm, addr, ptep, make_pte_marker(PTE_MARKER_GUARD));
> 
> I agree with you, but I think perhaps the arg name here is misleading :) If
> you look at mm/pagewalk.c and specifically, in walk_pte_range_inner():
> 
> 		if (ops->install_pte && pte_none(ptep_get(pte))) {
> 			pte_t new_pte;
> 
> 			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
> 					       walk);
> 			if (err)
> 				break;
> 
> 			set_pte_at(walk->mm, addr, pte, new_pte);
> 
> 			...
> 		}
> 
> So the ptep being assigned here is a stack value, new_pte, which we simply
> assign to, and _then_ the page walker code handles the set_pte_at() for us.
> 
> So we are indeed doing the right thing here, just in a different place :P

Ahh my bad. In that case, please ignore the patch.

But out of interest, why are you doing it like this? I find it a bit confusing
as all the other ops (e.g. pte_entry()) work directly on the pgtable's pte
without the intermediate.

Thanks,
Ryan

> 
>>  	(*nr_pages)++;
>>
>>  	return 0;
>> --
>> 2.43.0
>>


