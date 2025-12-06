Return-Path: <stable+bounces-200217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C16CAA1D3
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 07:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288F130EC096
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 06:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77E1D63F3;
	Sat,  6 Dec 2025 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KLI+QUb1"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA678F2E
	for <stable@vger.kernel.org>; Sat,  6 Dec 2025 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765002278; cv=none; b=a+DGRunoEHmtYc8GxtfZxfxm00dbEdedihz3zP0fUZ4Uxu3i9ZQtDvg9vY24gjw3zkwD8QXUa1v/0TRS8acGY8wjwziPs5Lua6Zgvi8PX3kK2vGXwug1moqfrveYezV4Q3otXf84V+X9N+KbqPoYyn2x5MvV58bMXYSKnNfWeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765002278; c=relaxed/simple;
	bh=q79djST1oUNb6IYyXItw3iB3CvLdDCdBWoHj3jk/kkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVPzV6thQtBKS4+dp3iB0WUhxJsGA/X0tbPrmZfbOU2TV+YTsG1EN2vT4LO2Fpv8VUKdKvF01oKSrGHb36Yl1rzGXz5njOuB4W4MUZ3aU4Xici3YhUNoJcVu6MgJCR1+uOZT3jED4oG54tEfGeQnK+lzd3eOz/DGTUqirZgXvhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KLI+QUb1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d93e5427-7cc9-4b34-a9f3-c9e8e991736b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765002273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5oVSgIBCafXEGoSSuuxX91QRDxQwxmfl7EtVipaGVo=;
	b=KLI+QUb1SrT79p/Z0YWBn5xVhcImTk/B+taONF5EGVMXeTYbjz9LRf9VUpmkV7LiGzl2CA
	AQF9RYrHIkAQZXsOKzQ5dDUCssikkK/5FlUHMNjORPQKfyUZQ2SFsv/sNbI45/XDWdxzAd
	LJ0SZRZJnLbuM6vyiBBmfH6ghgwaOEs=
Date: Sat, 6 Dec 2025 14:24:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/4] mm/hugetlb: fix hugetlb_pmd_shared()
To: david@kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 aneesh.kumar@kernel.org, arnd@arndb.de, harry.yoo@oracle.com,
 jannh@google.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, liushixin2@huawei.com, loberman@redhat.com,
 lorenzo.stoakes@oracle.com, muchun.song@linux.dev, nadav.amit@gmail.com,
 npiggin@gmail.com, osalvador@suse.de, peterz@infradead.org,
 pfalcato@suse.de, prakash.sangappa@oracle.com, riel@surriel.com,
 stable@vger.kernel.org, vbabka@suse.cz, will@kernel.org,
 Lance Yang <ioworker0@gmail.com>
References: <20251205213558.2980480-2-david@kernel.org>
 <20251206055553.21759-1-ioworker0@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251206055553.21759-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/6 13:55, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> 
> On Fri,  5 Dec 2025 22:35:55 +0100, David Hildenbrand (Red Hat) wrote:
>> We switched from (wrongly) using the page count to an independent
>> shared count. Now, shared page tables have a refcount of 1 (excluding
>> speculative references) and instead use ptdesc->pt_share_count to
>> identify sharing.
>>
>> We didn't convert hugetlb_pmd_shared(), so right now, we would never
>> detect a shared PMD table as such, because sharing/unsharing no longer
>> touches the refcount of a PMD table.
>>
>> Page migration, like mbind() or migrate_pages() would allow for migrating
>> folios mapped into such shared PMD tables, even though the folios are
>> not exclusive. In smaps we would account them as "private" although they
>> are "shared", and we would be wrongly setting the PM_MMAP_EXCLUSIVE in the
>> pagemap interface.
>>
>> Fix it by properly using ptdesc_pmd_is_shared() in hugetlb_pmd_shared().
>>
>> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
>> Cc: <stable@vger.kernel.org>
>> Cc: Liu Shixin <liushixin2@huawei.com>
>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> ---
> 
> Good catch! Feel free to add:
> 
> Reviewed-by: Lance yang <lance.yang@linux.dev>

Actually:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

