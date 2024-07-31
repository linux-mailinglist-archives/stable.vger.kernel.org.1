Return-Path: <stable+bounces-64781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5042D94327C
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BE0286CCA
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9C71BBBD0;
	Wed, 31 Jul 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejDdzrgX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DDF186E4F
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437673; cv=none; b=p4dNiL0TvgWQZS4pdjH9hKi1FJUyZIucKGtOYGX8NX36DZmayvotBnE/upAGMGWX9WXQUjWGanUtoCk68YWJiykTLyKeTMvhFaAo9k4DClrUJdeHX/JpjSPcXXJj29o7JG/wk3hnQyW3hlpi6OYl1Ly8RdK9ab3OVys9thi5xGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437673; c=relaxed/simple;
	bh=RG1ZTDwc212jfYUgpyrOzTI8JADghBOyl1tlLGGXRqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS2UCi54ogOB/05YbCjWwXpIUtG5QWQrf/yr1MGQZ0tOIPqIsIcAO1X99+zj9OYV227vVy2XEdBw32qToHtwWNsSmVG4vQizCcZycuDP6IUWLIzAoUO0C6PlOd5q/N8dhmsuDYHR+j/yMDwjB8wQa1AIENU4gR9QDBwCE8vEtLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejDdzrgX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722437671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GBTw0W2rbsk4F+ekcQcaksXYFFFBotjI+RQovJOgbjU=;
	b=ejDdzrgXrfym7xHppSKOr4cvKnE6wwKYrk5/1uN8yfwX07FIeZCcZWazLZ7RY/pAwUI9qA
	NKsQzIVila339MNUUcYWeN6BoBnA/zgScSjsY4QHfQEbDmzduwGym8yEChCvFs4ScKTSgZ
	2IEYRV5fEUJzBNeO1JYATkmIAcpqgUw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-QhL_qShhOSGp8vNM-tNU0w-1; Wed, 31 Jul 2024 10:54:28 -0400
X-MC-Unique: QhL_qShhOSGp8vNM-tNU0w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1da9c3d40so40013185a.2
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 07:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722437667; x=1723042467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBTw0W2rbsk4F+ekcQcaksXYFFFBotjI+RQovJOgbjU=;
        b=lfu7ZmwAO5cA7ddyN0otZL5tunafZOSYsqv4XV1NdDmV7ppsyko23XzEb/B53yJIGN
         t7hPQQsnbU6QDwVm/4GVQx0NNwo9QoGpRwmkdtoYU0cal6O72EV6479xo0UTDtV9FMou
         yilWcP0T/F+VM6mrMI+bn1iTaeLEQxTClw41Z+XO9xi4PSXh4U2goZGB1HRlQoJvj31a
         7w8A87jTe3mv+UtGtzuN+ST2dKECZNOjzQh1JbIiZZGxMBPPbVrq/UpdjVzEZB5qigBs
         2dR4Y9B+bnJ+bT9SunKmE9bDMpjzCf/6DOQuRWe+J/fbxlSDRwtz0VISYrupjYyW/wpD
         r+gw==
X-Forwarded-Encrypted: i=1; AJvYcCXbDvf1FwiDABQ3Bm/vaKsxAISiCTnzXo9spJlRKaemgSE8aHrNdht9jSj2wS3GVon56ZMPg0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMhDRDIsypd7+3H5PTuJ9U/Qdt5wg/7bKVMIMHOuSYAqghwvad
	Nxj8HE53684ACY4ZREYZMCdsbnw1a9pJelcX+y2mdlxA7lDqXvOH0qtae//5T6PJfc48uD6jcDQ
	Ce9pFEEjXrIzdw1vcvFJeqo8sSAw4qzO+wZLFxHoI8ulmYoiDENMyog==
X-Received: by 2002:a05:620a:3198:b0:79d:6273:9993 with SMTP id af79cd13be357-7a1d697f7bdmr1364523285a.6.1722437667452;
        Wed, 31 Jul 2024 07:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEB61L/K7pQEACsFHzusBL/JC7NLuKoHSkhKCOykCWw/2D3jzpOFiVeWNKiYGZ886kry2gcA==
X-Received: by 2002:a05:620a:3198:b0:79d:6273:9993 with SMTP id af79cd13be357-7a1d697f7bdmr1364521485a.6.1722437667024;
        Wed, 31 Jul 2024 07:54:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1f3840e29sm338681985a.79.2024.07.31.07.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:54:26 -0700 (PDT)
Date: Wed, 31 Jul 2024 10:54:24 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	James Houghton <jthoughton@google.com>, stable@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Message-ID: <ZqpQILQ7A_7qTvtq@x1n>
References: <20240731122103.382509-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731122103.382509-1-david@redhat.com>

On Wed, Jul 31, 2024 at 02:21:03PM +0200, David Hildenbrand wrote:
> We recently made GUP's common page table walking code to also walk hugetlb
> VMAs without most hugetlb special-casing, preparing for the future of
> having less hugetlb-specific page table walking code in the codebase.
> Turns out that we missed one page table locking detail: page table locking
> for hugetlb folios that are not mapped using a single PMD/PUD.
> 
> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
> page tables, will perform a pte_offset_map_lock() to grab the PTE table
> lock.
> 
> However, hugetlb that concurrently modifies these page tables would
> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
> locks would differ. Something similar can happen right now with hugetlb
> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
> 
> This issue can be reproduced [1], for example triggering:
> 
> [ 3105.936100] ------------[ cut here ]------------
> [ 3105.939323] WARNING: CPU: 31 PID: 2732 at mm/gup.c:142 try_grab_folio+0x11c/0x188
> [ 3105.944634] Modules linked in: [...]
> [ 3105.974841] CPU: 31 PID: 2732 Comm: reproducer Not tainted 6.10.0-64.eln141.aarch64 #1
> [ 3105.980406] Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-4.fc40 05/24/2024
> [ 3105.986185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 3105.991108] pc : try_grab_folio+0x11c/0x188
> [ 3105.994013] lr : follow_page_pte+0xd8/0x430
> [ 3105.996986] sp : ffff80008eafb8f0
> [ 3105.999346] x29: ffff80008eafb900 x28: ffffffe8d481f380 x27: 00f80001207cff43
> [ 3106.004414] x26: 0000000000000001 x25: 0000000000000000 x24: ffff80008eafba48
> [ 3106.009520] x23: 0000ffff9372f000 x22: ffff7a54459e2000 x21: ffff7a546c1aa978
> [ 3106.014529] x20: ffffffe8d481f3c0 x19: 0000000000610041 x18: 0000000000000001
> [ 3106.019506] x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000000
> [ 3106.024494] x14: ffffb85477fdfe08 x13: 0000ffff9372ffff x12: 0000000000000000
> [ 3106.029469] x11: 1fffef4a88a96be1 x10: ffff7a54454b5f0c x9 : ffffb854771b12f0
> [ 3106.034324] x8 : 0008000000000000 x7 : ffff7a546c1aa980 x6 : 0008000000000080
> [ 3106.038902] x5 : 00000000001207cf x4 : 0000ffff9372f000 x3 : ffffffe8d481f000
> [ 3106.043420] x2 : 0000000000610041 x1 : 0000000000000001 x0 : 0000000000000000
> [ 3106.047957] Call trace:
> [ 3106.049522]  try_grab_folio+0x11c/0x188
> [ 3106.051996]  follow_pmd_mask.constprop.0.isra.0+0x150/0x2e0
> [ 3106.055527]  follow_page_mask+0x1a0/0x2b8
> [ 3106.058118]  __get_user_pages+0xf0/0x348
> [ 3106.060647]  faultin_page_range+0xb0/0x360
> [ 3106.063651]  do_madvise+0x340/0x598
> 
> Let's make huge_pte_lockptr() effectively use the same PT locks as any
> core-mm page table walker would. Add ptep_lockptr() to obtain the PTE
> page table lock using a pte pointer -- unfortunately we cannot convert
> pte_lockptr() because virt_to_page() doesn't work with kmap'ed page
> tables we can have with CONFIG_HIGHPTE.
> 
> Take care of PTE tables possibly spanning multiple pages, and take care of
> CONFIG_PGTABLE_LEVELS complexity when e.g., PMD_SIZE == PUD_SIZE. For
> example, with CONFIG_PGTABLE_LEVELS == 2, core-mm would detect
> with hugepagesize==PMD_SIZE pmd_leaf() and use the pmd_lockptr(), which
> would end up just mapping to the per-MM PT lock.
> 
> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
> folio being mapped using two PTE page tables.  While hugetlb wants to take
> the PMD table lock, core-mm would grab the PTE table lock of one of both
> PTE page tables.  In such corner cases, we have to make sure that both
> locks match, which is (fortunately!) currently guaranteed for 8xx as it
> does not support SMP and consequently doesn't use split PT locks.
> 
> [1] https://lore.kernel.org/all/1bbfcc7f-f222-45a5-ac44-c5a1381c596d@redhat.com/
> 
> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
> Reviewed-by: James Houghton <jthoughton@google.com>
> Cc: <stable@vger.kernel.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Nitpick: I wonder whether some of the lines can be simplified if we write
it downwards from PUD, like,

huge_pte_lockptr()
{
        if (size >= PUD_SIZE)
           return pud_lockptr(...);
        if (size >= PMD_SIZE)
           return pmd_lockptr(...);
        /* Sub-PMD only applies to !CONFIG_HIGHPTE, see pte_alloc_huge() */
        WARN_ON(IS_ENABLED(CONFIG_HIGHPTE));
        return ptep_lockptr(...);
}

The ">=" checks should avoid checking over pgtable level, iiuc.

The other nitpick is, I didn't yet find any arch that use non-zero order
page for pte pgtables.  I would give it a shot with dropping the mask thing
then see what explodes (which I don't expect any, per my read..), but yeah
I understand we saw some already due to other things, so I think it's fine
in this hugetlb path (that we're removing) we do a few more math if you
think that's easier for you.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


