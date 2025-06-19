Return-Path: <stable+bounces-154825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEE8AE0E2B
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1FD7A2A7E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEE47DA6D;
	Thu, 19 Jun 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhN9jozY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2230E84F
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750362372; cv=none; b=YKmcGs4BqrVj7bLAtsGIVqVeScmfnuMwF2Rvi5NSAZGui5+OaaWXnfDMRWb8lZNZLyhPxibAXMXgMUu5Rgb+ElPJA7t73aRprxVf4NeX39kiFEv1+JWPL19j0X5ecyc1sB50MB3bomL6syOIBJOBA/fLaTuH+yfC25ZQTGGN5T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750362372; c=relaxed/simple;
	bh=RodpL2cg0ZHN/PqjhG7PzuHwT9IBkCrX5jyiIMOClJc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WEjfSY+R3jUtuRpFiVMk5YHglVY4jyLLP1LQfrhN5NUWujf0Zm7xHnpw/CCK7Z0XgwPNc9WmasnWxCugQLuKdl70Cj6r/eOSuwJavXZAG3WkAjdm6qKsoQ9VYKikTqQGumgzoINRL9rTipP18WTj69Q//LSckRYjcygToO4pcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhN9jozY; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e75668006b9so1177281276.3
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750362369; x=1750967169; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9lkueRT5WzLD+S/t5zUQH8HJV70k2jPNYZIOrXLTy4=;
        b=QhN9jozYbSktD095rqnn3HyyYaZX5UhxQUWL8aLWZIFg8T47hp4XwkS5fBGSVeSUQz
         KJLBHKCfstTgtznfarHfZ6tZjywZ+aJZedCpcdHwttckYF9UinIIFvi3ibNSRRheyL8E
         SJSDncEviZfVC2igRnZAbqc3EJ2/FjMO1jxuRJrWPUqFV83wMFji50IEyhV1twZGbkzy
         sGCpGX+wkXTpEG6Aa6qZ/OZP5TauRvwrwv+rcpR4JaOXTzSZ/oiLAIZZjmFbc6HEST/l
         JomfgZ4nnMS+8sylJdZAHEP2+Pf/xT5zrD4IwQcpdYrX9vE2ynBT4YqeOdNRS7PNs6N3
         nTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750362369; x=1750967169;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9lkueRT5WzLD+S/t5zUQH8HJV70k2jPNYZIOrXLTy4=;
        b=LdVxPo0nR4K9/d85c6ogPH6CYWbCsV2C+usPiQK+MtVV8OuMItVnjFqAhXfHLwgjwI
         dAvopHfMETZwolpdvx7ZdvCqms3ATbvJhUwnuGyNGGVgPNb4JbFvyzdtvqu9XmABYsSW
         n7oLtdfuJaFR0R55dCimLKClNuiqxg7LjllPFM+0DcZGSKWxn2P3H0ygam4/i3cHOV84
         DFKoZmP+pAvhQgCR4WXDVFg5YOpZkGUKn7JlOdS8ZXdfqoiKGGOhILEnYsRGxTnb4Fq0
         PGcR2Jjke9Y08Oy6YD+D7cgvqys+/wn0sGwlhVdQwBCsURvAflTBNrSldracdjoMa3GQ
         7s/w==
X-Forwarded-Encrypted: i=1; AJvYcCW7rTTiKacVM3aHEiyTfbR/UQkkfoHbr8QrB5tJJdHK+LrdUEG66lT0Xiev19kVd2XMFyNR/U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNsmY3IpJC89w0wcxr3j3HYuoLw/e4dqaxnjfU1c4fxJRC26K
	ypj0Xag9WB1NcuxR691zRrbiQP8uXgRkmyNm/qyTt2MuVJjevtrwtAjLwK5BBfLC9RDKVkXJVtp
	TcdON4zd9
X-Gm-Gg: ASbGnctyjRomq5Cx9BLxWUua/4r+/o7KNhtnSs9wZ3z1MsIRQwfaHM8YGxyLELO/EfR
	MCFKIFbnp3W4HZIBOjyRZ+GqgdKDi46lxv5OE/j7gAw2UdXJy5h6tY6nhpEvlx1AgGZsmovQHaD
	crExH+oSYK45UKYhzg+mLsVH7WLTuEpi5cmOBTbFqIE9rVeUodgt12RUcpKBj7Sxoiu9mQAZje5
	2QfqgeGt35hT0F4jp/4oVYZYKpR69ZWFbtqp2QbSyT47TP7q1RvAjZHPqlpgI+OODLuW6bWgqv2
	xjltPWgl/bbTtidIjM0spEEbiTpLUmXxiFcl0jRZ3GFYcQG6t4+Kr9/y1DOH3iTtfaWaPE9mVOT
	8tWfR5YkoYpAzDjQndCCWfJ9woppk1VLlVpXBF46cqUVAsDU=
X-Google-Smtp-Source: AGHT+IEOLJnSpSUSVJW06qrn4WpBmT+FgMtyFJvbcIqIlOl72NpxdAYkSI474r8SMjxID+Pv43tEEA==
X-Received: by 2002:a05:6902:1894:b0:e80:cff4:5d1f with SMTP id 3f1490d57ef6-e842bd03bd9mr599666276.33.1750362369179;
        Thu, 19 Jun 2025 12:46:09 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aaee76asm189223276.18.2025.06.19.12.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 12:46:08 -0700 (PDT)
Date: Thu, 19 Jun 2025 12:45:58 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Gavin Guo <gavinguo@igalia.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Zi Yan <ziy@nvidia.com>, Gavin Shan <gshan@redhat.com>, 
    Florent Revest <revest@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Miaohe Lin <linmiaohe@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
In-Reply-To: <20250619052842.3294731-1-gavinguo@igalia.com>
Message-ID: <3ebb02ac-c9ea-53ac-8d42-b5f3cc9f14f5@google.com>
References: <2025051202-nutrient-upswing-4a86@gregkh> <20250619052842.3294731-1-gavinguo@igalia.com>
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

Thanks, yes, this new 6.6 version
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/huge_memory.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 635f0f0f6860..78f5df12b8eb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2260,12 +2260,14 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  {
>  	spinlock_t *ptl;
>  	struct mmu_notifier_range range;
> +	bool pmd_migration;
>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
>  				address & HPAGE_PMD_MASK,
>  				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
>  	mmu_notifier_invalidate_range_start(&range);
>  	ptl = pmd_lock(vma->vm_mm, pmd);
> +	pmd_migration = is_pmd_migration_entry(*pmd);
>  
>  	/*
>  	 * If caller asks to setup a migration entry, we need a folio to check
> @@ -2274,13 +2276,12 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
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
> base-commit: c2603c511feb427b2b09f74b57816a81272932a1
> -- 
> 2.43.0

