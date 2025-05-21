Return-Path: <stable+bounces-145812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68505ABF27D
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69D43A4FE1
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B3261568;
	Wed, 21 May 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="C4sdW6bp"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C152609F7;
	Wed, 21 May 2025 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825966; cv=none; b=nhMIiy1O2XyruxzIsV3EJ8QJqshmVjhkEUMbFHpcj//zVQRpWW4dwNYrarQ0ioyWjUqruHaJQdGW2eX9g3kUyfE/x5/1sO5+xCOVQkOlF/GiKDCWQFbBkzO4PtFsTIGbMtdAME8127tpivMICo/40iuc08qUY6mY1VL3ScvKW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825966; c=relaxed/simple;
	bh=9Au4dQP0dx3s3vkEGLl4Kw26cdqdICGruUq5OhoabIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmo6xN3d+M2/q54ZKR9Ka6G9+Ct5aee4qEZ8yRs/cITCeXfY9r65WtXI3INDBtnMnwSZVzLeA2LbEYlL9/+MkSAvtaIsKbV9P1hxQ8agVT2lXH7+AX4J1EkE+6LQowknHLXpQhO79v6lQubbri0SA/dsWyuwMtz03u/wlsc9Bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=C4sdW6bp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tSZLmeHxhklcvtBKwZ8YgYV6AoGGikz4OO4w/hxhhKs=; b=C4sdW6bp4/QGVyGGEHLe5UvnEB
	QB3dunN1B6Sj9DdlBjAbe0Di5DDvo7TPLEZ43BqcE0TLorcKaYOggAxsNV0zYpSg38Ye3us0+TTA5
	sl85HOxLT+GO4lA5ZW2BBVXcKxdvqGZjjfS44jEJ4MokB+8zECQlVSL4jSHJDVRGzy6HeJNvuDe+h
	/yTJHaTzBJlGfR7gZ0Kx2E9h9XRs+sSjB9ydZuTBdn3rhLQM78L5y90oZeV7OEpaGEsDz/0iQXgZ4
	RJJ4ul6PCpwxSMHQ/agxerOIW6SxWytb7OVdH7rCO1N2O6hV0UfZaGMX0jTIUmn7LCEnXq0MlU1la
	7Al9j6YQ==;
Received: from 27-52-98-155.adsl.fetnet.net ([27.52.98.155] helo=[192.168.238.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uHhNA-00BAFP-Rp; Wed, 21 May 2025 13:12:33 +0200
Message-ID: <3b167142-7c1a-4d6b-b41e-8c067ab737df@igalia.com>
Date: Wed, 21 May 2025 19:12:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 akpm@linux-foundation.org, mike.kravetz@oracle.com, kernel-dev@igalia.com,
 stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>
References: <20250513093448.592150-1-gavinguo@igalia.com>
 <aCzdnAmuOylilU1p@localhost.localdomain>
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <aCzdnAmuOylilU1p@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/25 03:53, Oscar Salvador wrote:
> On Tue, May 13, 2025 at 05:34:48PM +0800, Gavin Guo wrote:
>> The patch fixes a deadlock which can be triggered by an internal
>> syzkaller [1] reproducer and captured by bpftrace script [2] and its log
>> [3] in this scenario:
>>
>> Process 1                              Process 2
>> ---				       ---
>> hugetlb_fault
>>    mutex_lock(B) // take B
>>    filemap_lock_hugetlb_folio
>>      filemap_lock_folio
>>        __filemap_get_folio
>>          folio_lock(A) // take A
>>    hugetlb_wp
>>      mutex_unlock(B) // release B
>>      ...                                hugetlb_fault
>>      ...                                  mutex_lock(B) // take B
>>                                           filemap_lock_hugetlb_folio
>>                                             filemap_lock_folio
>>                                               __filemap_get_folio
>>                                                 folio_lock(A) // blocked
>>      unmap_ref_private
>>      ...
>>      mutex_lock(B) // retake and blocked
>>
> ...
>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> 
> I think this is more convoluted that it needs to be?
> 
> hugetlb_wp() is called from hugetlb_no_page() and hugetlb_fault().
> hugetlb_no_page() locks and unlocks the lock itself, which leaves us
> with hugetlb_fault().
> 
> hugetlb_fault() always passed the folio locked to hugetlb_wp(), and the
> latter only unlocks it when we have a cow from owner happening and we
> cannot satisfy the allocation.
> So, should not checking whether the folio is still locked after
> returning enough?
> What speaks against:
> 
>   diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>   index bd8971388236..23b57c5689a4 100644
>   --- a/mm/hugetlb.c
>   +++ b/mm/hugetlb.c
>   @@ -6228,6 +6228,12 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>    			u32 hash;
>   
>    			folio_put(old_folio);
>   +			/*
>   +			* The pagecache_folio needs to be unlocked to avoid
>   +			* deadlock when the child unmaps the folio.
>   +			*/
>   +			if (pagecache_folio)
>   +				folio_unlock(pagecache_folio);
>    			/*
>    			 * Drop hugetlb_fault_mutex and vma_lock before
>    			 * unmapping.  unmapping needs to hold vma_lock
>   @@ -6825,7 +6831,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>    	spin_unlock(vmf.ptl);
>   
>    	if (pagecache_folio) {
>   -		folio_unlock(pagecache_folio);
>   +		/*
>   +		 * hugetlb_wp() might have already unlocked pagecache_folio, so
>   +		 * skip it if that is the case.
>   +		 */
>   +		if (folio_test_locked(pagecache_folio))
>   +			folio_unlock(pagecache_folio);
>    		folio_put(pagecache_folio);
>    	}
>    out_mutex:

Really appreciate your review. Good catch! This is elegant. The patch is 
under testing and I'll send out the v2 patch soon.

> 
>> ---
>>   mm/hugetlb.c | 33 ++++++++++++++++++++++++++++-----
>>   1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index e3e6ac991b9c..ad54a74aa563 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -6115,7 +6115,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>>    * Keep the pte_same checks anyway to make transition from the mutex easier.
>>    */
>>   static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>> -		       struct vm_fault *vmf)
>> +		       struct vm_fault *vmf,
>> +		       bool *pagecache_folio_unlocked)
>>   {
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	struct mm_struct *mm = vma->vm_mm;
>> @@ -6212,6 +6213,22 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>>   			u32 hash;
>>   
>>   			folio_put(old_folio);
>> +			/*
>> +			 * The pagecache_folio needs to be unlocked to avoid
>> +			 * deadlock and we won't re-lock it in hugetlb_wp(). The
>> +			 * pagecache_folio could be truncated after being
>> +			 * unlocked. So its state should not be relied
>> +			 * subsequently.
>> +			 *
>> +			 * Setting *pagecache_folio_unlocked to true allows the
>> +			 * caller to handle any necessary logic related to the
>> +			 * folio's unlocked state.
>> +			 */
>> +			if (pagecache_folio) {
>> +				folio_unlock(pagecache_folio);
>> +				if (pagecache_folio_unlocked)
>> +					*pagecache_folio_unlocked = true;
>> +			}
>>   			/*
>>   			 * Drop hugetlb_fault_mutex and vma_lock before
>>   			 * unmapping.  unmapping needs to hold vma_lock
>> @@ -6566,7 +6583,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>>   	hugetlb_count_add(pages_per_huge_page(h), mm);
>>   	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
>>   		/* Optimization, do the COW without a second fault */
>> -		ret = hugetlb_wp(folio, vmf);
>> +		ret = hugetlb_wp(folio, vmf, NULL);
>>   	}
>>   
>>   	spin_unlock(vmf->ptl);
>> @@ -6638,6 +6655,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>   	struct hstate *h = hstate_vma(vma);
>>   	struct address_space *mapping;
>>   	int need_wait_lock = 0;
>> +	bool pagecache_folio_unlocked = false;
>>   	struct vm_fault vmf = {
>>   		.vma = vma,
>>   		.address = address & huge_page_mask(h),
>> @@ -6792,7 +6810,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>   
>>   	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>>   		if (!huge_pte_write(vmf.orig_pte)) {
>> -			ret = hugetlb_wp(pagecache_folio, &vmf);
>> +			ret = hugetlb_wp(pagecache_folio, &vmf,
>> +					&pagecache_folio_unlocked);
>>   			goto out_put_page;
>>   		} else if (likely(flags & FAULT_FLAG_WRITE)) {
>>   			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
>> @@ -6809,10 +6828,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>   out_ptl:
>>   	spin_unlock(vmf.ptl);
>>   
>> -	if (pagecache_folio) {
>> +	/*
>> +	 * If the pagecache_folio is unlocked in hugetlb_wp(), we skip
>> +	 * folio_unlock() here.
>> +	 */
>> +	if (pagecache_folio && !pagecache_folio_unlocked)
>>   		folio_unlock(pagecache_folio);
>> +	if (pagecache_folio)
>>   		folio_put(pagecache_folio);
>> -	}
>>   out_mutex:
>>   	hugetlb_vma_unlock_read(vma);
>>   
>>
>> base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
>> -- 
>> 2.43.0
>>
>>
> 


