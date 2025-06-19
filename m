Return-Path: <stable+bounces-154725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB43ADFBE2
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 05:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A039A1897EC7
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 03:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8852AEF5;
	Thu, 19 Jun 2025 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmzKc1wM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF65634
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750303840; cv=none; b=go0jQWXfyl0xdfSfkikfGrMRgVsEa8FVvdr/wnYFKQKln21Fxo8R768ultnJsIjxIXVbOxQGA1BXvXwawUbBUBGdINc7CwV3Um9JqfsUqeqygZU2yNY1rNXlfs8tP62Eon9RV2Xq+RlsJwV7YB9w1JTMOss+10wLTMoTEUQ/+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750303840; c=relaxed/simple;
	bh=Fzft8rwglCzp7gMkddsofhrnu2r+CBUBtK0DfH5YGiI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k29l3ewQsg7nyvd7zUjdKGXusbtBFAV6d70Juq/g2jTd9idSQKZYWx3m1xKlW0dPwSY1rAMB/2pAlSxITH9x6jFmw0QaQgQQ3eXc/DxORh/jBwPlf0QQEUBlM/9ugTDTkxDRwhvcO2MbafJs+phfEt3+iUON57Ac0IiRKSPFaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmzKc1wM; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81f8679957so348059276.2
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 20:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750303836; x=1750908636; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjT65Ba4cWJUnaWkfnhfPjoWgFmTRVCnqzzWsFGc0GI=;
        b=xmzKc1wMIuLS3GllNaEk1XOe8bwlNXu7dB4Pnfzs2nrSOOdJ7PtcAjPBR6cnAIeMi8
         cXkisvQ+t1CZHKhr6cFP6z3FM4OqI0IR5Q14P2JklZ/HkRHXL8nQ2Y3woZmtIn+p5ODz
         SNOuBbUsTw50AtLyLBl/BMWGKyzTJF+cxb1WyeKfIcT6jjMttpa9DCUSSKI5ORzOwWim
         //aRViG+nsGTCbinbhNTUIPHp07SXyOQGdmRkoFehK2k6hl4mVlNWD49sSg7ezD81p3+
         fIQzlfLyuQfdxvPc9zWfmNJZwlGsJTdLB2g8GIC8x8HtKJooBd+SDdhIZgxVY7XQmaI6
         NPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750303836; x=1750908636;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjT65Ba4cWJUnaWkfnhfPjoWgFmTRVCnqzzWsFGc0GI=;
        b=WjxcdcieNNJq2yUG1j0gqY6UNouJ/1QFS3wwauiBhU1Rwd7D4rqSwQhuuYB6Fep3Fk
         FU4tIiITgkS9rZrM+X9ZpvFedjrckVwJzXAlAjZQMF1CxnKrM476dCkWkqDRAmQMEtlG
         Y2KemnLGZNy9pRnz9TytanXR9CibF88lkJP4CcEA1s3qn0kysD/nbnag3pR58w+LGJXp
         yEdmst2sv1Iq1ySLyNQbETpOHybkmqtdByRwVCnJkk1xFGFrOiLgrN0pQBiXIr2mMuvy
         BPVtitlFIKlgckir1/Z3Wq+CDD24RqOCigz6kdS3E9nTgcnzCOsYLAi5GN7iR3mbHW9o
         tErA==
X-Forwarded-Encrypted: i=1; AJvYcCV1qZGNUlQP5qFaQi7M5Ox1fsa1oM0Zd53a71rbD6zEMcaeLesJ+nJQQjWsQN2MBOyYi1/2UOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aMcPn7jUFoUeX2FTEp9dRkvz5tgMwAjhPEgOdcSpsA6x2s3j
	pX9V/YmdwfOsrpqADOl6xc9vjO1TtjYw+k2AidAFbV7LCmhdYyb6XISTL/3OibA+ob91+uvhqpK
	qIY+0NxQ4
X-Gm-Gg: ASbGncs2SNN1kafiX1r+dvdJO1dJIkk9Rymhv1eCG7Ml09tyB6QQy6pKW2++KiNSOVD
	B37Awd3t/Y7itdBTAgvOjdG9lp4q41uk0cidQjXrvsqO2luySHfaJKYvnHCUgt5sA3g+NydjMG2
	B/I11iHmooRJWhxgymqAE4HXRCwNkHcpTUb47d6MeZuxgUyq3/oXW0wEPT5qHUOm6BRVF9Sdfd2
	s/jrtnnUKfvoTYfe83uaGpQeYpA7IreVAZuSNqqfSdmBlL0hQQ2uihnv61EKBegruLugxcS/kXC
	mEgCzPZtPKnDQL7a8dRJ5xxj20g5izYE639uWmMy1GPKSNHg3pzo+rJLRp/HvKUV9Vu8WMRIe5D
	G4ygBvbGxd74Hg8BSBTfBhGrvMhpqMNL0FZpW90Lm7+Kpwg==
X-Google-Smtp-Source: AGHT+IFeddQRDjsjDeFMf8pcB96EiwRka138I/m6NyQy+sXPaFXBnZXqoF3kLh3+Sh0hua11YDQyiQ==
X-Received: by 2002:a05:6902:108e:b0:e75:c2d7:53d6 with SMTP id 3f1490d57ef6-e822ac5c6e6mr28099183276.13.1750303835672;
        Wed, 18 Jun 2025 20:30:35 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e841eac43d3sm180151276.52.2025.06.18.20.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 20:30:33 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:30:30 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Gavin Guo <gavinguo@igalia.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Zi Yan <ziy@nvidia.com>, Gavin Shan <gshan@redhat.com>, 
    Florent Revest <revest@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Miaohe Lin <linmiaohe@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
In-Reply-To: <20250616024203.1783486-1-gavinguo@igalia.com>
Message-ID: <f903c761-8399-04f3-0f32-475b365177fb@google.com>
References: <2025051204-tidal-lake-6ae7@gregkh> <20250616024203.1783486-1-gavinguo@igalia.com>
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
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9139da4baa39..bcefc17954d6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2161,7 +2161,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  	VM_BUG_ON(freeze && !page);
>  	if (page) {
>  		VM_WARN_ON_ONCE(!PageLocked(page));
> -		if (page != pmd_page(*pmd))
> +		if (is_pmd_migration_entry(*pmd) || page != pmd_page(*pmd))
>  			goto out;
>  	}
>  
> @@ -2196,7 +2196,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		}
>  		if (PageMlocked(page))
>  			clear_page_mlock(page);
> -	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
> +	} else if (!pmd_devmap(*pmd))
>  		goto out;

I'm sorry, Gavin, but this 5.15 and the 5.10 and 5.4 backports look wrong
to me, because here you drop the is_pmd_migration_entry(*pmd) condition,
but if !page then that has not been checked earlier (this check here is
specifically allowing a pmd migration entry to proceed to the split).

Hugh

>  	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
>  out:
> 
> base-commit: 1c700860e8bc079c5c71d73c55e51865d273943c
> -- 
> 2.43.0

