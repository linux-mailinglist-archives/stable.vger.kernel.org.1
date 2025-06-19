Return-Path: <stable+bounces-154724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65556ADFBDA
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 05:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC0D188995C
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 03:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9F238C39;
	Thu, 19 Jun 2025 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoVHx8Q6"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76C3214
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750303440; cv=none; b=Uip6PJdgsUHj5rimTnLuR1PNsX+7VTE7DeV5WBaNgy7KRNkc0ZTI6NukWejYqbe5AAH8MOJbviQNGt/VUh4M4sXEsoWGKQhhii66xAR8aRzHmNzhcTh2haYiF3pNvp7i073kWKSGXiD008fFlq+5UzEbXrTOF3kBnCkYfhkPpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750303440; c=relaxed/simple;
	bh=4zJ9aixQh42+p9hywr/0FYPacHtgkvBwyLzAzVTQPk0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sCd4sh0M1YW5f32BM2GjP4vC33vwYSqEXsMGn3qtGTs0gz7jdfuknD8kRXflCobuJuF5roT7sFhPdEgh0qycDO32re38lwczktxT2inv8mWybB44E23R6igkORu2rVZJIPJYJrAJDXJoEP8lgj9WocYp+oS6e+zj+q2gACBkruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoVHx8Q6; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7086dcab64bso2951947b3.1
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750303437; x=1750908237; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LY2AeSqPKj/lMJgU+/uYO0VfcbUWvWv9zlE0PRywmXc=;
        b=ZoVHx8Q6DbvHladK/xbQRYUAsD31QiK7MkMO9kQvL35cMEL3VMIP8eBog2HGSMKAHI
         kj/2vbCO0hC6FmxYmgZ8KkVCspX7n/7KECDghzI+4zp7Zu8vsjR2r8kVUN6gql/kx58H
         DNkg7Su6fEGiSUGFsanXTmJkamIOWbBekyfdmlmFXFgfuRNbw4JlytFY/ddBNci330m6
         us/oEGBi730mr7OKekoWZtBZ8JSd8i+g0Ee1CJwgO6NiIJAaBZLW1hfY4e67tWXxlA3L
         ZfzELCdUUp2dS7AN4Pv1po0QbVJzKnCEadhzKcyh9ppOa0fEJExrw8OPCLDWEP4YOlB9
         0VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750303437; x=1750908237;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LY2AeSqPKj/lMJgU+/uYO0VfcbUWvWv9zlE0PRywmXc=;
        b=qWgvvfV3t3p8k6JeGYutSBMWYWtxDPmk3Dn0Ffy75hfzkHc/QelHrbwz6VJN+wfHzs
         QijaGoMbMqFpjprVjyY8daPU7rTBcp8xTFs9sLCGURSfFXBN+sk5GZfQQRAhyN1AULdp
         91rjwCUBWEmp2ojGuxFi8LEcLWi6sHYhlT+JCpleaN/OsJG3ThaHm13gkTZzYxU6/AOz
         gOiz4RXXyhRgyvK0cqG2+Hig435oaT6hnoRmhQ15gNXYya6MLIzoPmx9txZDQqvw6wq2
         RWfyvvPMvMUygDBrcAGcN7dS4F5PcMRNoCfmEu9j6hOvaQTkFjEQM5W0UVoKfd0qz0/Y
         ig1g==
X-Forwarded-Encrypted: i=1; AJvYcCV8W9pI2NqseChJxfvfNXs+yH5/Y0ykj467C2m+6bLjoy+LoxPnROfgktJUT21OvXiFvW1bhyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZs+OiilgTq2DXk+f8h813nWmPtN/qp/EGcn3kTxIIQggCd6xx
	KVTn7Yye3hgP0OEBpzXwQeMuReJpeQWdoXgmVpW0oRGMumf4+8bNdTBm+339X91FdA==
X-Gm-Gg: ASbGncvzfV5G0le/jlyrQF3M9xU1eCi+KT9Hf3eMc8f1uatPZUbX+DslVeBZmLD0lsm
	cGtaKv81f/R66K/C1tOpqbiKBPP9AwakOcOukE+OpevW4nxN84klqqCYc0+t1+r/e5XpLgkQBlt
	c6F7IbsADeHvholka/TS3q7C9jgKLWEcPG5A1yOK2tWc6CH2gXMk3IVuPacb/ir0mgxvMhEVDY8
	x0yZsB8iH/ybFtuzWYxiRdxJu4KcBaA9i2Rl6dtOcmVjpcPt6ivSwNtJ2litzf7cjT3YiNOWru5
	Vv/Vl7lTchIWr++WuRNsv0u6/9fsXkPUqYRkn/EW/x/50DyrwftripxQ2n+fBZkw1Dg8g0ibU9B
	meyrGThtWmsB22pnykPVHuc703ANRE658RBJWeXrJjBXtmw==
X-Google-Smtp-Source: AGHT+IGQabIdAJtA1Zrl3REFvkx2OD43bVK8Q+qhaTDK8QrdWQO7qu6Nj8+RnPiN7TXhikBdldt+Kw==
X-Received: by 2002:a05:690c:6e03:b0:70c:c013:f26 with SMTP id 00721157ae682-71175476568mr299600207b3.33.1750303437511;
        Wed, 18 Jun 2025 20:23:57 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712b7a885bdsm1224857b3.44.2025.06.18.20.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 20:23:54 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:23:44 -0700 (PDT)
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
In-Reply-To: <20250616024952.1791381-1-gavinguo@igalia.com>
Message-ID: <3269e319-a13d-a85a-7668-7fd2a370752d@google.com>
References: <2025051202-nutrient-upswing-4a86@gregkh> <20250616024952.1791381-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 16 Jun 2025, Gavin Guo wrote:

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
> ---
>  mm/huge_memory.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 635f0f0f6860..ad04162f637c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2260,6 +2260,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  {
>  	spinlock_t *ptl;
>  	struct mmu_notifier_range range;
> +	bool pmd_migration = is_pmd_migration_entry(*pmd);

I'm sorry, Gavin, but this 6.6 and the 6.1 backport look wrong to me,
because here you are deciding pmd_migration outside of the pmd_lock(),
whereas your original commit decided it while the pmd_lock() is held.

Hugh

>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
>  				address & HPAGE_PMD_MASK,
> @@ -2274,13 +2275,12 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
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

