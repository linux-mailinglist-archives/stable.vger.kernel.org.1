Return-Path: <stable+bounces-61854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03293D07A
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 11:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFBF1C218F4
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 09:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0B176AAF;
	Fri, 26 Jul 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P6qesZcF"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C31A286;
	Fri, 26 Jul 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986739; cv=none; b=S9RogqHSrPwmaGPWgFhkTrtJ2N5J6OeMhAji0E7G9K3AjToQto91Uz1hGg64eZJ/H2YnHV8eV39k/i0Z+EZj9+Qbl0PxwGd0nJkWbfrlysS5ijZaITcRwsocmP/t1zWS80DV4hKYkvLVwqxDYYcipLuUMrZll/JMyX7VP0BADyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986739; c=relaxed/simple;
	bh=lQe+wBRcsk0ZyYkVQL0n/nKRWVZoQpNAw1NCjhW4FYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjV3biisJWpppG1et0If2aGRaBn9YVQLL5sSPOSBDM7TQJ0dVsWjnNIff9C3jp/zq+ZMcCqD1c1T2rVdbXQED30p2UwR7utsR47NN5A91MtLDD73Q4G/9aQ33cABNArqM76WPG081zLkBVGs1k/C60g9zicMDSkaryHQPsqrXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P6qesZcF; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721986728; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=t048/vV/d5nEHrbgDDl8oC6lorOHiJTnPFFh8ETL5eA=;
	b=P6qesZcFjUicdwIut4W9Wciz6NvtOuthCdAXpvPlTTOHMnMOTBJhD6ZpVkhtMFlVhXHOZzCQmujO7p+jdaNhXLzVYycNhjPvHLZNr5vjHJUa+UqD9VNLHWzS6jZ//3y1JRCMq+i5bKsHqGmOwbDA/SaIRejsk1DkOfjdy0BX2wE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WBLNct._1721986727;
Received: from 30.97.56.64(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBLNct._1721986727)
          by smtp.aliyun-inc.com;
          Fri, 26 Jul 2024 17:38:47 +0800
Message-ID: <4439d559-5acf-4688-a1ad-7626bf027027@linux.alibaba.com>
Date: Fri, 26 Jul 2024 17:38:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com>
 <0067dfe6-b9a6-4e98-9eef-7219299bfe58@linux.alibaba.com>
 <c16a731f-1029-4ede-bbea-af2218c566d1@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <c16a731f-1029-4ede-bbea-af2218c566d1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/26 16:04, David Hildenbrand wrote:
> On 26.07.24 04:33, Baolin Wang wrote:
>>
>>
>> On 2024/7/26 02:39, David Hildenbrand wrote:
>>> We recently made GUP's common page table walking code to also walk
>>> hugetlb VMAs without most hugetlb special-casing, preparing for the
>>> future of having less hugetlb-specific page table walking code in the
>>> codebase. Turns out that we missed one page table locking detail: page
>>> table locking for hugetlb folios that are not mapped using a single
>>> PMD/PUD.
>>>
>>> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
>>> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
>>> page tables, will perform a pte_offset_map_lock() to grab the PTE table
>>> lock.
>>>
>>> However, hugetlb that concurrently modifies these page tables would
>>> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
>>> locks would differ. Something similar can happen right now with hugetlb
>>> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
>>>
>>> Let's make huge_pte_lockptr() effectively uses the same PT locks as any
>>> core-mm page table walker would.
>>
>> Thanks for raising the issue again. I remember fixing this issue 2 years
>> ago in commit fac35ba763ed ("mm/hugetlb: fix races when looking up a
>> CONT-PTE/PMD size hugetlb page"), but it seems to be broken again.
>>
> 
> Ah, right! We fixed it by rerouting to hugetlb code that we then removed :D
> 
> Did we have a reproducer back then that would make my live easier?

I don't have any reproducers right now. I remember I added some ugly 
hack code (adding delay() etc.) in kernel to analyze this issue, and not 
easy to reproduce. :(

