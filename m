Return-Path: <stable+bounces-183443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACEBBE6DC
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 17:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614561889246
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898BE27F754;
	Mon,  6 Oct 2025 15:04:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9645819F115;
	Mon,  6 Oct 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763069; cv=none; b=reRI2zs4S4gF3TmLZf4PmtSbJcigKjrknpbyRdFb2kfSD2F8MKVduNROZ87PccfpOY6PpLiy86a5wLL1E5VddUi3gHTU5oJQfce7dren/kpduv+NU1HBZEjOwj9fJRql9ciUjud9xrI+oxTDxMhC2sm68LUpxSzJKX3NPnnnFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763069; c=relaxed/simple;
	bh=0B0iR2A3/3ULUTFpkpZyX/WPowk5NM3sAUJwWo0eieE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtJYdaU1diEDg9O8WD3tuSV+XTS3jLAT3+rabzpV32+ibI/c5dLe+YC8i7X9lDh6u6cGeQC6r0KO2qmOADVKrVAf7qDYBH/9rK9pfIwQnc9/1hblTeMuz8aUUcBOL5h7hT4rZn10kGj+UoFLgwCU2QBtcR8NQPJamtZc0xHJEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D19BB1515;
	Mon,  6 Oct 2025 08:04:18 -0700 (PDT)
Received: from [10.57.81.160] (unknown [10.57.81.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F30893F66E;
	Mon,  6 Oct 2025 08:04:24 -0700 (PDT)
Message-ID: <ae61f721-3d07-4908-ad31-9c25e8b8119e@arm.com>
Date: Mon, 6 Oct 2025 16:04:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Amir Goldstein <amir73il@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
 <uyh6y4qjuj6vcpsdnexwl2xqf2jnp6ejj7esr3g3hix66ml2zi@pqsbsjtt6apl>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <uyh6y4qjuj6vcpsdnexwl2xqf2jnp6ejj7esr3g3hix66ml2zi@pqsbsjtt6apl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/2025 15:55, Jan Kara wrote:
> On Fri 03-10-25 16:52:36, Ryan Roberts wrote:
>> fsnotify_mmap_perm() requires a byte offset for the file about to be
>> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
>> Previously the conversion was done incorrectly so let's fix it, being
>> careful not to overflow on 32-bit platforms.
>>
>> Discovered during code review.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>> Applies against today's mm-unstable (aa05a436eca8).
> 
> Thanks Ryan! I've added the patch to my tree. As a side note, I know the
> callsite is in mm/ but since this is clearly impacting fsnotify, it would
> be good to add to CC relevant people (I'm not following linux-mm nor
> linux-kernel) and discovered this only because of Kiryl's link...

Ahh good point... Sorry I was sleepwalking through the process on Friday
afternoon and blindly sent it to the maintainers and reviewers that
get_maintainer.pl spat out. It didn't even occur to me that this wasn't an mm
thing. :-|

> 
> 								Honza
> 
>>  mm/util.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index 6c1d64ed0221..8989d5767528 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -566,6 +566,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>>  	unsigned long len, unsigned long prot,
>>  	unsigned long flag, unsigned long pgoff)
>>  {
>> +	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
>>  	unsigned long ret;
>>  	struct mm_struct *mm = current->mm;
>>  	unsigned long populate;
>> @@ -573,7 +574,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>>
>>  	ret = security_mmap_file(file, prot, flag);
>>  	if (!ret)
>> -		ret = fsnotify_mmap_perm(file, prot, pgoff >> PAGE_SHIFT, len);
>> +		ret = fsnotify_mmap_perm(file, prot, off, len);
>>  	if (!ret) {
>>  		if (mmap_write_lock_killable(mm))
>>  			return -EINTR;
>> --
>> 2.43.0
>>


