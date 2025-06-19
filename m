Return-Path: <stable+bounces-154828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14241AE0E83
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 22:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3B53B4272
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 20:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E228C5A1;
	Thu, 19 Jun 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiS1qvuk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C628C865
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750364244; cv=none; b=JcZQUOTIfMHa0IjVVg57iwMd0AEe+c25kDjjyDmdwqSI2l3M4mNwcnVGV0z7lghxSbscuSE57eVk3GvTfoqpnQUA9Y7HzX0HykPEuS2enXu3b9If55FWNBlFlPlPZjmA9EjDZJiUNOhVbHRc1Ry6W9C9g4yQKY2UOVgpsnyavpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750364244; c=relaxed/simple;
	bh=t8zLaTxwtmUhuYSMSh/fL9Ruw+UYu/FJDJHfy9n33p8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gZpSAOQmC9ci4aCFNI4K7dwKyEmMJOiqyEvJNDp3vEsHqpHHM8eT1nr12u12S/iWC87SqmQfeuPXQhNlLdKXhW8c830GdHq9qmc5cfj8oOTI7apozsFf+8qZk7zv6V2tyhypFDl4LwMx613CysrFPSGFwIzwFSM1jP+0Dqlhyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiS1qvuk; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso1077452276.2
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750364241; x=1750969041; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CCYBuhMacljzmcYaEQlE37wjOyMIvimv5SnNIBgtgQ=;
        b=qiS1qvukevnexzGa6SGcB5k3s3NvQBJwAjUVi9iXx9QX8mJQnRlnoifOnUTvev70eR
         gx/fiwqFRXwiVOHFvSO8wnaNuvdwQToT4IdeXeVk7z6X95Y6tlCf2yymAlTrWZQPT4E6
         I4dktt/G1R+uMyILNPyBzTCY8Zr3fhvFbX2L63IlPTkb/IWP+lJ1VRUo5MQ9hpWY818c
         0HWFNUSHcdYxWZspqnkWgefCRCMC6CZfumNfpHsPh9wsIo4ldEpf38o4kp80q/DMBl1u
         3hTE8DPFfbsOapVJR8fnueCn09ozUpRm8m7wmiOyTic9pJaaL5aQKWuCvOVbBmvjLaGq
         PKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750364241; x=1750969041;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CCYBuhMacljzmcYaEQlE37wjOyMIvimv5SnNIBgtgQ=;
        b=MzPCRd3A/9LElQrpBmONkoN9AD2JPHnawX0RU2Jlu+r63n67N5YFmyQT9/6bbxLf2s
         MmLSgYEUBNGX+dN7XWu7NrKDTWqxzI+C3jQLOn1mazd52IDyHumeny8lyBbigZRPOisE
         3IEbjwIqtDSOymGn8RDwD6GtTXyumF5vho53EOKpDHtcuU2Nju0zO8GE31DwZ5zo5Kyx
         r1hTLhyHGISJL6naWXmiKkIZJR3Y53apotv82SYryVCLP06KzzSTpsqjpRwYspcRchZv
         g8d85rcICaVRztEBvwydz/VWN9cxB65UgIzp0ruw7JY625dcsEBfX2iJN01gc/2QvKfp
         XOxg==
X-Forwarded-Encrypted: i=1; AJvYcCVM+n7POYTy9sjUN7Zq0B663mmj7npeaAYDMsUetOvi9RsgdomBut22ByMt/qhLzJuOa99/Ui8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/QDXRacpl5FXZk9DVrUDkuelPK5r5jNndpceD3FoG9G7g16VS
	vZ55tc7fay4UtqK2lnLLMFsvnIxcd0qbh5lVItvmYnFjCudC47O/SAzemvdhsxG6Zg==
X-Gm-Gg: ASbGnct6wvJHXf+QnlRYMxGjbCixe14PpSqE86T8fujUhtrLe3m73/A1GM1LaKlgI+v
	4UI8PeWKPB3xC7FWHpBqGCSP+ZRMggPNy+bPNUZGjmsABlidjNaP6xe85vlPgj280EtGzl4FeSO
	pseTQSrtEqJqQ+py1n7s3oY/5oC7iqrlhhhmAoV3WLSdxbDEfRhGrKjjtAbYvSfWhCAC/VDruQm
	/NZJxYNukOtM84lXFw/+Gy6bQ4uosmIPehHvekR8/qhQPbKqYtABj62nGHcVPyLIr0Izi+sOWo+
	/TR80j8+1C8YDgnkVgNFPnI0huYMH1z+KYBdZSPBt91c1pPXlMW/NN83pyY5PfjttN7FTm5GGXv
	yjQ6SJU0AR06Nf0rN14cZ8X+NviPFasEgBD6COjfsDx3r9FkyqLMDsVEosw==
X-Google-Smtp-Source: AGHT+IHdbOdXOMuo6a+tvJWTdWML2x2M26CwdKb3vPegUAnBA7Mli0UIzjPVCsVEi0wRIeNZeHL05A==
X-Received: by 2002:a05:6902:15c6:b0:e81:9f79:d023 with SMTP id 3f1490d57ef6-e842bd3a684mr629629276.45.1750364241267;
        Thu, 19 Jun 2025 13:17:21 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac684e2sm193368276.32.2025.06.19.13.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 13:17:20 -0700 (PDT)
Date: Thu, 19 Jun 2025 13:17:18 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Gavin Guo <gavinguo@igalia.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
    Gavin Shan <gshan@redhat.com>, Florent Revest <revest@google.com>, 
    Matthew Wilcox <willy@infradead.org>, Miaohe Lin <linmiaohe@huawei.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
In-Reply-To: <c6eed86d-9a79-4845-8289-e9b24c46b88a@igalia.com>
Message-ID: <1993fdd9-656a-6c25-fb83-cb2993bc18eb@google.com>
References: <2025051204-tidal-lake-6ae7@gregkh> <20250616024203.1783486-1-gavinguo@igalia.com> <f903c761-8399-04f3-0f32-475b365177fb@google.com> <c6eed86d-9a79-4845-8289-e9b24c46b88a@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Jun 2025, Gavin Guo wrote:
> On 6/19/25 11:30, Hugh Dickins wrote:
> > On Mon, 16 Jun 2025, Gavin Guo wrote:
> > 
> >> [ Upstream commit be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7 ]
> >>
> >> When migrating a THP, concurrent access to the PMD migration entry during
> >> a deferred split scan can lead to an invalid address access, as
> >> illustrated below.  To prevent this invalid access, it is necessary to
> >> check the PMD migration entry and return early.  In this context, there is
> >> no need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
> >> equality of the target folio.  Since the PMD migration entry is locked, it
> >> cannot be served as the target.
> >>
> >> Mailing list discussion and explanation from Hugh Dickins: "An anon_vma
> >> lookup points to a location which may contain the folio of interest, but
> >> might instead contain another folio: and weeding out those other folios is
> >> precisely what the "folio != pmd_folio((*pmd)" check (and the "risk of
> >> replacing the wrong folio" comment a few lines above it) is for."
> >>
> >> BUG: unable to handle page fault for address: ffffea60001db008
> >> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> >> 1.16.3-debian-1.16.3-2 04/01/2014
> >> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
> >> Call Trace:
> >> <TASK>
> >> try_to_migrate_one+0x28c/0x3730
> >> rmap_walk_anon+0x4f6/0x770
> >> unmap_folio+0x196/0x1f0
> >> split_huge_page_to_list_to_order+0x9f6/0x1560
> >> deferred_split_scan+0xac5/0x12a0
> >> shrinker_debugfs_scan_write+0x376/0x470
> >> full_proxy_write+0x15c/0x220
> >> vfs_write+0x2fc/0xcb0
> >> ksys_write+0x146/0x250
> >> do_syscall_64+0x6a/0x120
> >> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>
> >> The bug is found by syzkaller on an internal kernel, then confirmed on
> >> upstream.
> >>
> >> Link: https://lkml.kernel.org/r/20250421113536.3682201-1-gavinguo@igalia.com
> >> Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
> >> Link: https://lore.kernel.org/all/20250418085802.2973519-1-gavinguo@igalia.com/
> >> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> >> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >> Acked-by: Hugh Dickins <hughd@google.com>
> >> Acked-by: Zi Yan <ziy@nvidia.com>
> >> Reviewed-by: Gavin Shan <gshan@redhat.com>
> >> Cc: Florent Revest <revest@google.com>
> >> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> Cc: Miaohe Lin <linmiaohe@huawei.com>
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >> [gavin: backport the migration checking logic to __split_huge_pmd]
> >> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> >> ---
> >>   mm/huge_memory.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 9139da4baa39..bcefc17954d6 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -2161,7 +2161,7 @@ void __split_huge_pmd(struct vm_area_struct *vma,
> >> pmd_t *pmd,
> >>    VM_BUG_ON(freeze && !page);
> >>    if (page) {
> >>   		VM_WARN_ON_ONCE(!PageLocked(page));
> >> -		if (page != pmd_page(*pmd))
> >> +		if (is_pmd_migration_entry(*pmd) || page != pmd_page(*pmd))
> >>    		goto out;
> >>    }
> >>   @@ -2196,7 +2196,7 @@ void __split_huge_pmd(struct vm_area_struct *vma,
> >> pmd_t *pmd,
> >>     }
> >>     if (PageMlocked(page))
> >>   			clear_page_mlock(page);
> >> -	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
> >> +	} else if (!pmd_devmap(*pmd))
> >>     goto out;
> > 
> > I'm sorry, Gavin, but this 5.15 and the 5.10 and 5.4 backports look wrong
> > to me, because here you drop the is_pmd_migration_entry(*pmd) condition,
> > but if !page then that has not been checked earlier (this check here is
> > specifically allowing a pmd migration entry to proceed to the split).
> > 
> > Hugh
> 
> Hi Hugh,
> 
> Thank you again for the review.
> 
> Regarding the 5.4/5.10/5.15. How do you think about the following changes?

I think you are going way off track with the following changes.

The first hunk of your backport (the pmd_page line) was fine, it was the
second hunk (the pmd_devmap line) that I objected to: that second hunk
should just be deleted, to make no change on the pmd_devmap line.

Maybe you're misreading that pmd_devmap line, it is easy to get lost
in its ! and parentheses.

> 
> @@ -2327,6 +2327,8 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t
> *pmd,
>         mmu_notifier_invalidate_range_start(&range);
>         ptl = pmd_lock(vma->vm_mm, pmd);
> 
> +       if (is_pmd_migration_entry(*pmd))
> +               goto out;

No.  In general, __split_huge_pmd_locked() works on pmd migration entries;
the bug you are fixing is not with pmd migration entries as such, but with
applying pmd_page(*pmd) when *pmd is a migration entry.

I do not recall offhand how important it is that __split_huge_pmd_locked()
should apply to pmd migration entries (when page here is NULL), and I do
not wish to spend time researching that: maybe it's just an optimization,
or maybe it's essential on some path.  What is clear is that this bugfix
backport should not be making any change to that behaviour.

>         /*
>          * If caller asks to setup a migration entries, we need a page to
> check
>          * pmd against. Otherwise we can end up replacing wrong page.
> @@ -2369,7 +2371,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t
> *pmd,
>                 }
>                 if (PageMlocked(page))
>                         clear_page_mlock(page);
> -       } else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
> +       } else if (!pmd_devmap(*pmd) )
>                 goto out;
>         __split_huge_pmd_locked(vma, pmd, range.start, freeze);
>  out:
> 
> There is still an access, page = pmd_page(*pmd), inside the if(!page). I'm not
> sure if pmd could be a migration entry when the page is NULL. To avoid this as
> well, maybe just goto out directly in the beginning?

No.  The other pmd_page(*pmd) is inside a pmd_trans_huge(*pmd) block,
so it's safe, *pmd cannot be a migration entry there.  (Though admittedly
I have to check rather carefully, because, at least in the x86 case,
pmd_trans_huge(*pmd) does not guarantee that the present bit is set.)

Hugh

> 
> > 
> >>   	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
> >>   out:
> >>
> >> base-commit: 1c700860e8bc079c5c71d73c55e51865d273943c
> >> -- 
> >> 2.43.0

