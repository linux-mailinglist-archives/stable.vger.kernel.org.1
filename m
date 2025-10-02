Return-Path: <stable+bounces-183005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735C3BB26C0
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 05:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C516EE6F
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 03:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516A28DC4;
	Thu,  2 Oct 2025 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlId8bCp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2AA34BA50
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759375068; cv=none; b=MvPnVNv84m90QPeoumAj+/ijZUgs4u1J4oZXN9XWA9KiEZT/6i66rVFUTIl3rbvUBOXKyrI74DMKjy/IJDUo43X/Acqppm9d1kyIPiwPXnFbnQi4RK5yGFbFLxNTYJfn3LWXFqKkzn9o/27ap5D7Onh+uNCzYeK6twCuoikf5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759375068; c=relaxed/simple;
	bh=bma062V6Yy0cp8342vbMIqP2vsCbmtrUyHVbtgqDiq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyUQTMP0l+rlDlyJRQOX54M3Xg+ASmq0BTueW50F7vYNRmhfys1taTbUfVib7CkkvlIZflwg3PpsAGaUXyFtjHT2mEoX6OnPb8DU2cwKdh6H7uPRmQv2wJNFHD23GIMRpvrE1xSP4qcg5WZkIzQM552FY4+VAnzV5VuBdqPLcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlId8bCp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a16441so99189166b.2
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759375065; x=1759979865; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukIjXlnpeq1rHbLV2IaXOhdHQVb6iKLF8mmZ545G2bI=;
        b=GlId8bCppnHGI4pzyyIIpFrSAilYdQkHKSHdQzHm3YX+/r0rkjiPL+HSh2AJ9sP99v
         KqvH9jxF5TZ+foGGlpGGnyaRwnGX49JhvOurzynEkn3x1GRGFuuONO0qp4KZny9lit0O
         bm3OP44TeHc3ayMiB8bsBG7csg2l42W/4mY7SwCb4kQlVdYiKBuKmf8dyW+XzPDZGSBN
         dtHogxfgL0bvR2N4IwQ5yK5eIO5gjF27j+4YsldzJEerCiEdXlmoGpOL7kI2XunnaPUE
         Sgf6WHX1I7vkX6IsGH8R0QzydOWX2mrMg9DZT9hT12DlUbHDCLk3QoMcH1EYLorkT9Gq
         rOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759375065; x=1759979865;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ukIjXlnpeq1rHbLV2IaXOhdHQVb6iKLF8mmZ545G2bI=;
        b=r1w58Xpmah4MHM7cwK7D6KRgHmG7/WWLK9Bpl9EpLtfKuKb7JCDDQO//kPbIByKsNB
         WPiAqjx4CScnlI2BJZKwi8622AyBmfdcfK21FQTsTWqEAKyUxYuNw+Pmb6i6j8KfjE77
         S/bsGfLwU1wAwKIlatL97vK37jHYKmuqAsothbc+15ju01HKnhwcGl4d83lIiyekKu2E
         Om/WjSVEpPqkvsgltajevlrnLVoBmIbNFU8niFdDtvKZ1kOxo9HiV9aqyjBC5P5G3TuQ
         KiYosHxbFuGGNwq7z7JFathT2IOvfuBJBrf9Gd5RIj7MnmHikDrY3ogF/WjjqAZO/6hh
         xzHw==
X-Forwarded-Encrypted: i=1; AJvYcCVsm9oAWwWSEyNg+bB6jSo5EE1BjIPRYjpV+QYtMNJupl+rDvu0Vg0h4xxPQ1izcPlzqG9OhVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyMffJI522g+T3C//IsJqxEnMvYvrujU4hV0o/0XYH7RN8066/
	xGwyXgAWcV0YJsXMJWg6O5KtsQToP50nGS2oUbl770566OiA6WIIQRiT
X-Gm-Gg: ASbGncvH3bLizwu0zuBMoFDh+G6/3aOml9BGWPzp8RNHVGQ9eBYng5p6NuQxHcEr+yD
	l10cwO/u8rC25Gl16YCENTg2p+gZv38R/tMzoCtCeCi0lxC15wQfsO0wo+AMz/CF75gSn0VEMFB
	zHSOTQuVxh6Av3RdYcGQbPZNt1Exc8TZNdZa+JYaCb8fRGDfvBqoq+5aLkLjeZIy+0VQpgeKTXx
	9JX9iXE+lkUJgTf4REwbPGaf78/MeVerAIjt+gwqFsi+8Ah1P9KQ60xX/jYAm3hkubDqlpDjeNy
	y98qpuJIlWn4wR4jJuQjulXKA6tTGCT+MRRPnj5oyoqhB9fJu/cc1TY5BBNXC3DQQDKUw/kvnwO
	uI+zcn906mgOnsTj1GVsoQnzQGsDW9bikJ/84Bh/zHAZx3kuTiyJCaKjvyXFS
X-Google-Smtp-Source: AGHT+IGz5qdn7Z8WqPdcaSzQRnRcwjhB2iTUbVl5Nl2cC+78S079TdI9YWxGEdwKvxX3OhBhqheR9g==
X-Received: by 2002:a17:906:7314:b0:b3f:b7ca:26c5 with SMTP id a640c23a62f3a-b46e68103bbmr711840066b.59.1759375064743;
        Wed, 01 Oct 2025 20:17:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a173b4csm101736166b.86.2025.10.01.20.17.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Oct 2025 20:17:44 -0700 (PDT)
Date: Thu, 2 Oct 2025 03:17:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, wangkefeng.wang@huawei.com, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Message-ID: <20251002031743.4anbofbyym5tlwrt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
 <20251002014604.d2ryohvtrdfn7mvf@master>
 <fa3f9e82-c6c8-43f2-803f-b8bb0fe56f37@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3f9e82-c6c8-43f2-803f-b8bb0fe56f37@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Oct 02, 2025 at 10:31:53AM +0800, Lance Yang wrote:
>
>
>On 2025/10/2 09:46, Wei Yang wrote:
>> On Thu, Oct 02, 2025 at 01:38:25AM +0000, Wei Yang wrote:
>> > We add pmd folio into ds_queue on the first page fault in
>> > __do_huge_pmd_anonymous_page(), so that we can split it in case of
>> > memory pressure. This should be the same for a pmd folio during wp
>> > page fault.
>> > 
>> > Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
>> > to add it to ds_queue, which means system may not reclaim enough memory
>> > in case of memory pressure even the pmd folio is under used.
>> > 
>> > Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
>> > folio installation consistent.
>> > 
>> 
>> Since we move deferred_split_folio() into map_anon_folio_pmd(), I am thinking
>> about whether we can consolidate the process in collapse_huge_page().
>> 
>> Use map_anon_folio_pmd() in collapse_huge_page(), but skip those statistic
>> adjustment.
>
>Yeah, that's a good idea :)
>
>We could add a simple bool is_fault parameter to map_anon_folio_pmd()
>to control the statistics.
>
>The fault paths would call it with true, and the collapse paths could
>then call it with false.
>
>Something like this:
>
>```
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 1b81680b4225..9924180a4a56 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -1218,7 +1218,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct
>vm_area_struct *vma,
> }
>
> static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
>-		struct vm_area_struct *vma, unsigned long haddr)
>+		struct vm_area_struct *vma, unsigned long haddr, bool is_fault)
> {
> 	pmd_t entry;
>
>@@ -1228,10 +1228,15 @@ static void map_anon_folio_pmd(struct folio *folio,
>pmd_t *pmd,
> 	folio_add_lru_vma(folio, vma);
> 	set_pmd_at(vma->vm_mm, haddr, pmd, entry);
> 	update_mmu_cache_pmd(vma, haddr, pmd);
>-	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>-	count_vm_event(THP_FAULT_ALLOC);
>-	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>-	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>+
>+	if (is_fault) {
>+		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>+		count_vm_event(THP_FAULT_ALLOC);
>+		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>+		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>+	}
>+
>+	deferred_split_folio(folio, false);
> }
>
> static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index d0957648db19..2eddd5a60e48 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -1227,17 +1227,10 @@ static int collapse_huge_page(struct mm_struct *mm,
>unsigned long address,
> 	__folio_mark_uptodate(folio);
> 	pgtable = pmd_pgtable(_pmd);
>
>-	_pmd = folio_mk_pmd(folio, vma->vm_page_prot);
>-	_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>-
> 	spin_lock(pmd_ptl);
> 	BUG_ON(!pmd_none(*pmd));
>-	folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>-	folio_add_lru_vma(folio, vma);
> 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
>-	set_pmd_at(mm, address, pmd, _pmd);
>-	update_mmu_cache_pmd(vma, address, pmd);
>-	deferred_split_folio(folio, false);
>+	map_anon_folio_pmd(folio, pmd, vma, address, false);
> 	spin_unlock(pmd_ptl);
>
> 	folio = NULL;
>```
>
>Untested, though.
>

This is the same as I thought.

Will prepare a patch for it.


-- 
Wei Yang
Help you, Help me

