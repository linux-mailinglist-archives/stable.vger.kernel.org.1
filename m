Return-Path: <stable+bounces-183300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B7DBB7A6F
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 19:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 568CD4EDEDA
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DB12D7DD4;
	Fri,  3 Oct 2025 17:08:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC621C84BD;
	Fri,  3 Oct 2025 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511290; cv=none; b=fMEF7zlz+bQLD3SGBlhtvFyAZdZXZVfkLNreNBWTyPpZILxIrmjzrPMGHziGae4SNptTr/w/4gtDDPDa2cFebdcKIRH6pSOrxdvb2NXAsE4jkANOLZxVneHbBYACiMYzq5EWANOIuHKnOSMBZ9LKUmJ3rRv3wgE7nbrHL71DGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511290; c=relaxed/simple;
	bh=8jTBgrGrwWB9+jxyxwwLyOqmNS2/62GCLGeAF5T8Tjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOBCz77L3OdTN3oYedUzpndavkAaopsK5r4UPCwDJxt2CFeg4z3blalFxLZ08F2Oa0DOh5vRjykOEZqaayWccdO62SjAmQmoguKzHZaMEnw95u3nxbn2rYKkzv6+1j0PbW+9ZCicj0Se1ekpH7+hFPcvMjD5B+n+D6L1cHN8Wt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 955931688;
	Fri,  3 Oct 2025 10:07:58 -0700 (PDT)
Received: from [10.163.65.114] (unknown [10.163.65.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878833F66E;
	Fri,  3 Oct 2025 10:08:00 -0700 (PDT)
Message-ID: <cb93234b-9a4f-406b-9a82-04ced1453fc0@arm.com>
Date: Fri, 3 Oct 2025 22:37:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mmap: Fix fsnotify_mmap_perm() call in vm_mmap_pgoff()
To: Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>
References: <20251003155804.1571242-1-kirill@shutemov.name>
 <bqmxwfi4kohx744fa5ggoiovrhiwsoehqn57kptoni64lgflim@ibt5bjvcbhdx>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <bqmxwfi4kohx744fa5ggoiovrhiwsoehqn57kptoni64lgflim@ibt5bjvcbhdx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 03/10/25 10:26 pm, Kiryl Shutsemau wrote:
> On Fri, Oct 03, 2025 at 04:58:04PM +0100, Kiryl Shutsemau wrote:
>> From: Kiryl Shutsemau <kas@kernel.org>
>>
>> vm_mmap_pgoff() includes a fsnotify call that allows for pre-content
>> hooks on mmap().
>>
>> The fsnotify_mmap_perm() function takes, among other arguments, an
>> offset in the file in the form of loff_t. However, vm_mmap_pgoff() has
>> file offset in the form of pgoff. This offset needs to be converted
>> before being passed to fsnotify_mmap_perm().
>>
>> The conversion from pgoff to loff_t is incorrect. The pgoff value needs
>> to be shifted left by PAGE_SHIFT to obtain loff_t, not right.
>>
>> This issue was identified through code inspection.
>>
>> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
>> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
>> Cc: stable@vger.kernel.org
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: Amir Goldstein <amir73il@gmail.com>
>> Cc: Jan Kara <jack@suse.cz>
>> ---
>>   mm/util.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index f814e6a59ab1..52a667157264 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -573,7 +573,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>>   
>>   	ret = security_mmap_file(file, prot, flag);
>>   	if (!ret)
>> -		ret = fsnotify_mmap_perm(file, prot, pgoff >> PAGE_SHIFT, len);
>> +		ret = fsnotify_mmap_perm(file, prot, pgoff << PAGE_SHIFT, len);
> It misses the case to (loff_t) and it broken for 32-bit machines.
>
> Luckily, Ryan submitted another fix for the same bug at the almost the
> same time. And he was more careful around types:
>
> https://lore.kernel.org/all/20251003155238.2147410-1-ryan.roberts@arm.com

Oops! I need to be more careful...

>

