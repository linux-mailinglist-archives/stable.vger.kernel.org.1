Return-Path: <stable+bounces-81534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E1994197
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9B21F2884A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8301E3DC6;
	Tue,  8 Oct 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXsDbxDW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BD1E3769
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373968; cv=none; b=ZBLHBLHLV649/Hn3aU60Z3dQiHgIg33wmPUopvGE1kq3+CAP8VmRYeLfYPfKRmP3VaiUcgBNJC/tiDT6VUPuutMFmuRb8Uhm17vyc4sPn66M+HGEppVuQUa4v2B0hbkqod8DjvvUrXCpkTN2jrNIuWclH7+Sqw86gzO8YPh1mYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373968; c=relaxed/simple;
	bh=B0Zd/SxC02PIQZK9wRMAHf0GJJUGb8QGgqvT+QxuqNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnEGRGAcLa01SnBGzDEFoFKIVmutgD6ckjRuV07HxmF/0OfCuzqTVMiDuSB+DXipr1wJYRatCtSZfnSFz/iZReA4e81AavRW2js02EwzvrI5mmPXRdxDwUyefbBhLojJWiubR1AlUDaSrRCCKWUA1OGiA4nD7smd3gN2Up2j1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXsDbxDW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728373965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=25lALwZwb1PU97HFjPipcsWkCDl7P4A0WPaz1iPQJQA=;
	b=YXsDbxDW+hiR/MgMLTOQdLS2C2LtmoXdf72GSeB082k+0VHUJzMO235bUhBV6/Ur3FFZNB
	UTufXfv3HxROXEZR3SzWVoDXm89DFMG4+GJeJ0Yx3S4i8fhQwPfP1Znlv2m8UrygCyoKZd
	dsebLuDVUe/MezFs47/FZn1xFkBYgXE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-MS_9gT4YMBySHKPCfDpETw-1; Tue, 08 Oct 2024 03:52:43 -0400
X-MC-Unique: MS_9gT4YMBySHKPCfDpETw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53987fc3625so4356327e87.0
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 00:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373960; x=1728978760;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25lALwZwb1PU97HFjPipcsWkCDl7P4A0WPaz1iPQJQA=;
        b=l5olqUI1pxhVeSVk9PuFLdFeKrMgEOYcUvjcK8ds5cOKEEDDdkPEPxQDCgzB0LoNl0
         7Y1Zf/sxV2eQpwxnIflovhAEUZrtU0Gg4vP29oFVTCKpfp2xW5ZmwjzAP6vYEAmLPJ5F
         YwZk1Yuq1yhnYdCYt0M9UW67TUsmPbGaUsOo7FC0X8o7quyCTswM9PktMzpZd8NVyjgE
         BjLiIfjFZodtPnl7NF1yCfsobl7Tu+61kCU7WpvXiZqnMpQoO6w468sKGVX6VBGPHNZp
         yORmzJuXHlwyac9juasZ0/K2NKQqzdgT5mLy0SIDTzh8uk4BSXGbULbJMA6W31lcSlcJ
         s1ng==
X-Forwarded-Encrypted: i=1; AJvYcCVA6bt+382LQxm69Gqf3RNdr3UKfZKub0kA4e6vHwOdNlQaACc8L1dii4HXz1I12cgHM1DEpdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1O1SqQUZVHayPjYFcEUEPkmPb5V9J4sK4eNX5d3O+hMSlPdpf
	m4nRrEDBFpzcgOc86I7OmCC8r3LPMXqQkPRqGdqT+HdGbwDVTTRXtXOfP559oDuqJjqs0So/aih
	fe2VEr3U4kInendjbXMojq71azaZ/P5WuGTJaVe+YsA90o8ZACc5STwZ45kMZsQ==
X-Received: by 2002:a05:6512:3d93:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-539ab9eae13mr7371329e87.38.1728373959651;
        Tue, 08 Oct 2024 00:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrLWQZap6ReWjPsbtxajYy1aDLLfJbV8H6PL5MUUysCkaPVdqC8/q5O52n67bkKlWj7ncI7w==
X-Received: by 2002:a05:6512:3d93:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-539ab9eae13mr7371313e87.38.1728373959149;
        Tue, 08 Oct 2024 00:52:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c700:a76f:473d:d5cf:25a8? (p200300cbc72fc700a76f473dd5cf25a8.dip0.t-ipconnect.de. [2003:cb:c72f:c700:a76f:473d:d5cf:25a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43017465f3bsm15971755e9.0.2024.10.08.00.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:52:38 -0700 (PDT)
Message-ID: <75fac79a-0ff2-4ba0-bdd7-954efe2d9f41@redhat.com>
Date: Tue, 8 Oct 2024 09:52:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
To: Qi Zheng <zhengqi.arch@bytedance.com>, Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, willy@infradead.org,
 hughd@google.com, lorenzo.stoakes@oracle.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
 <1c114925-9206-42b1-b24b-bb123853a359@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1c114925-9206-42b1-b24b-bb123853a359@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.24 05:53, Qi Zheng wrote:
> Hi Jann,
> 
> On 2024/10/8 05:42, Jann Horn wrote:
> 
> [...]
> 
>>
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 24712f8dbb6b..dda09e957a5d 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -238,6 +238,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>    {
>>    	spinlock_t *old_ptl, *new_ptl;
>>    	struct mm_struct *mm = vma->vm_mm;
>> +	bool res = false;
>>    	pmd_t pmd;
>>    
>>    	if (!arch_supports_page_table_move())
>> @@ -277,19 +278,25 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>    	if (new_ptl != old_ptl)
>>    		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>>    
>> -	/* Clear the pmd */
>>    	pmd = *old_pmd;
>> +
>> +	/* Racing with collapse? */
>> +	if (unlikely(!pmd_present(pmd) || pmd_leaf(pmd)))
> 
> Since we already hold the exclusive mmap lock, after a racing
> with collapse occurs, the pmd entry cannot be refilled with
> new content by page fault. So maybe we only need to recheck
> pmd_none(pmd) here?

My thinking was that it is cheap and more future proof to check that we 
really still have a page table here. For example, what if collapse code 
is ever changed to replace the page table by the collapsed PMD?

So unless there is a good reason not to have this check here, I would 
keep it like that.

Thanks!

-- 
Cheers,

David / dhildenb


