Return-Path: <stable+bounces-154827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E09CAE0E2E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6721E7A2CCF
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177081D5AB7;
	Thu, 19 Jun 2025 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxpOAPpf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435230E854
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750362435; cv=none; b=hEGXNadUrxmFq7jqwimhsHGJSQsNUcfVuXY1MXw3oCIAf73duOdsIHz9MaMyPRuSvKQ6vpQBDA672JT2R1UbC4moSUb+4kbIuTQPAwhdAjAaxXqvjlmkuw/MQipAPEerep6dCY9YsAZwMIvHTFo5OmsRP5u21s/0yA+CvYM+1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750362435; c=relaxed/simple;
	bh=guA0skWOkwp8OyhQ1xFSJwpOdd3Kx+HxHdcZFkgpAWg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CAqRx2VI10iCrmCm0UfiE6+z//2YXRYKE49h2yz9smwWuW+1LBrCnZ5K4VS1M23omVjxHgQPxoD1WPfXjRG68kz6opMk3Cu89DUZOknjEZpdITl4+ViuonFem2PJkPbpMD3oaoASQiRppWQQxce9540ghlxSAVEBzCqAGOoUn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxpOAPpf; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-712be7e034cso7551797b3.0
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750362433; x=1750967233; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Vo05OOxTssGbcaMbipvLSwURoZXdUfKlhR1F0Yfd+g=;
        b=LxpOAPpfvCUQkaPK/S9mqZNWWmrZ//7XQlg3zSCvYoEd+vm81wpnywMoLpCVry2mY5
         4O9z4UxhkQm6jgdvdzB8BCeU9vrgRQuyVEzGruN5gyoFRF491Eb0IZ26s7vw2mHbbDNQ
         NPiwjSTSaG9/Rrv4J8ORYiwwLOb/UQUM4iL1LUp3kDKbM7Y5RrdRVb427C0YV8iIge1e
         dg+6sXOwtoRoFlL0S/Rrv/gNzlYmFPoXk/dh9iCn18jtKdMMunrzOCgKtvwc9L0x+Cg8
         wjDDroA2peXaxBXAcjPFJrYcQ89R+xyMqAApmZuvZo9lqzWqEc2/+tDP97bYLtr+8pn3
         f+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750362433; x=1750967233;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Vo05OOxTssGbcaMbipvLSwURoZXdUfKlhR1F0Yfd+g=;
        b=ve4BtmkSYZKzljBdyPIRXzjHGIkDYgdAbWwzisROIGrzz9GZ1zL1bFMYYpAs3VxN5l
         sGOWnWp1tBv8sH9f06lMLpUvbd52GDn8WCzed5UETWJv6fGlnqNajfCpv8d2OAVfy3JJ
         q560yoX+9il5HvI1twMc8m5pSye/RUK94n630ZIH99OlqLFiFDN2CWctoUaRYs9BfRI1
         GSQn0d0Yizw1QhdOTxZGf8+RXJoNdqD7FRL0co3Hxmin7/e5t7TSTyFlsJ+V9onlobmO
         79pPeHqZxjx+5vklhyfPk49c6TY7JoIrk60WU5WvybE4D1AAmyX4FN4M4IlJ6t6fuUPr
         n7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXlB2oksDk7aLsWWEUKwSfl69N5y/t/P3OOmyqHenlw/J5rsQ/8r4opOrg4Cx3QaMybovEbVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUDTBsry82L/D6L247Vi/IH3afNwX2+yfMn+hBVqwoyUVQ0qL
	Ivq8klBmGiSay5y9+GsMw9pPoUIxWhVFxrcc2zfBMrjIRWju6LvehP4hOAFKabXrhQ==
X-Gm-Gg: ASbGnctvZzKDvqqD0WqRlEFObITFmysB1bmowX5miPcNiEXUARMMtVIh6TVYTF6jxw9
	SrwdYZw9ZqPPGqjyIWAo2Q5rvW20YVxhAFvqLfSx72/wcOFbnS8rp/e7OXppnzM8PwYeOf5lQnv
	OvZDQfckkmr2zFGL1q4tE/i37518ZBOGb3PaRHrlnkrDIdOTg47GfGA7t8QwBeYibAnkc5NRiKy
	qHcifSNAxdMpQFRchHJxBqi+GqeUS5nKekek9zXL1PQ5iieYugeLng5+P1EjMYHrChlT/bpMnxo
	hbm2h+vSvf+krVokXUgImdmv0xzxlC2Q6YpVyhsem5IYmZbqblQHton4g4vqeyc4yq+0040KsXj
	PWhemA4Og+JJLKnrPhibNaLMQhIaIwVdKB2c5CdUmyPw1z7A=
X-Google-Smtp-Source: AGHT+IGTOmoVnbjALr+a4PXAld9jBZ3+VUJ1Fq2G3C22XhP26cW4MfFtjpUv0mhPvS0kkLJjDZTilg==
X-Received: by 2002:a05:690c:a082:10b0:710:f738:7125 with SMTP id 00721157ae682-712c64f923bmr5178107b3.19.1750362432920;
        Thu, 19 Jun 2025 12:47:12 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c49b9a9csm1217567b3.23.2025.06.19.12.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 12:47:11 -0700 (PDT)
Date: Thu, 19 Jun 2025 12:47:09 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Gavin Guo <gavinguo@igalia.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Zi Yan <ziy@nvidia.com>, Gavin Shan <gshan@redhat.com>, 
    Florent Revest <revest@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Miaohe Lin <linmiaohe@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
In-Reply-To: <20250619053001.3295791-1-gavinguo@igalia.com>
Message-ID: <bc275cfe-dd4f-ca7c-63bf-d26c93c09117@google.com>
References: <2025051203-thrift-spool-ebc8@gregkh> <20250619053001.3295791-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Jun 2025, Gavin Guo wrote:

> [ Upstream commit be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7 ]
> 
> When migrating a THP, concurrent access to the PMD migration entry during
> a deferred split scan can lead to an invalid address access, as
> illustrated below.  To prevent this invalid access, it is necessary to
> check the PMD migration entry and return early.  In this context, there is
> no need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
> equality of the target folio.  Since the PMD migration entry is locked, it
> cannot be served as the target.
> 
> Mailing list discussion and explanation from Hugh Dickins: "An anon_vma
> lookup points to a location which may contain the folio of interest, but
> might instead contain another folio: and weeding out those other folios is
> precisely what the "folio != pmd_folio((*pmd)" check (and the "risk of
> replacing the wrong folio" comment a few lines above it) is for."
> 
> BUG: unable to handle page fault for address: ffffea60001db008
> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
> Call Trace:
> <TASK>
> try_to_migrate_one+0x28c/0x3730
> rmap_walk_anon+0x4f6/0x770
> unmap_folio+0x196/0x1f0
> split_huge_page_to_list_to_order+0x9f6/0x1560
> deferred_split_scan+0xac5/0x12a0
> shrinker_debugfs_scan_write+0x376/0x470
> full_proxy_write+0x15c/0x220
> vfs_write+0x2fc/0xcb0
> ksys_write+0x146/0x250
> do_syscall_64+0x6a/0x120
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The bug is found by syzkaller on an internal kernel, then confirmed on
> upstream.
> 
> Link: https://lkml.kernel.org/r/20250421113536.3682201-1-gavinguo@igalia.com
> Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
> Link: https://lore.kernel.org/all/20250418085802.2973519-1-gavinguo@igalia.com/
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Cc: Florent Revest <revest@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [gavin: backport the migration checking logic to __split_huge_pmd]
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>

Thanks, yes, this new 6.1 version
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/huge_memory.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f53bc54dacb3..2c118713f771 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2282,12 +2282,14 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  {
>  	spinlock_t *ptl;
>  	struct mmu_notifier_range range;
> +	bool pmd_migration;
>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
>  				address & HPAGE_PMD_MASK,
>  				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
>  	mmu_notifier_invalidate_range_start(&range);
>  	ptl = pmd_lock(vma->vm_mm, pmd);
> +	pmd_migration = is_pmd_migration_entry(*pmd);
>  
>  	/*
>  	 * If caller asks to setup a migration entry, we need a folio to check
> @@ -2296,13 +2298,12 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  	VM_BUG_ON(freeze && !folio);
>  	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>  
> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> -	    is_pmd_migration_entry(*pmd)) {
> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
>  		/*
> -		 * It's safe to call pmd_page when folio is set because it's
> -		 * guaranteed that pmd is present.
> +		 * Do not apply pmd_folio() to a migration entry; and folio lock
> +		 * guarantees that it must be of the wrong folio anyway.
>  		 */
> -		if (folio && folio != page_folio(pmd_page(*pmd)))
> +		if (folio && (pmd_migration || folio != page_folio(pmd_page(*pmd))))
>  			goto out;
>  		__split_huge_pmd_locked(vma, pmd, range.start, freeze);
>  	}
> 
> base-commit: 58485ff1a74f6c5be9e7c6aafb7293e4337348e7
> -- 
> 2.43.0

