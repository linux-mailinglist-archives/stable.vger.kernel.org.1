Return-Path: <stable+bounces-155203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35845AE27CF
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 09:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78DB189F928
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 07:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D781AA1D9;
	Sat, 21 Jun 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqW4H/4z"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5EC19E975
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750492106; cv=none; b=OjjenNi0emuk8gHvU5jedrBeFgrG98YQ8SMAdCxp0PXz9WTH8Wq73Um2r3eREFB8yVC57nODZ7spMqwoEox1Vu15O9KijnGwyiY+0w9C8j7el9IdMVEm5euuYwF+CyHb/rSc/MM5oHp5GxhbOMWJa1dlNXpimIbJG3PnuyjP8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750492106; c=relaxed/simple;
	bh=YpOQ5bORykw5w1bSCXck0qi2KbNCTi1BbkCGkMmSS6Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uuJZ854f2hEBWcyTng0KRazgNrTGjVuheXKiGNXvVsrJxkfOnyHZJE1OLicb2lt1FUGcQ+4v2GKl6FEaxnd8ShjrV1l+2PrAxVI647KlGBrFBFSgpfEiCq7Xhr3IVYNISJc0ZqhSid2yLDfDxWAmy8V9Zr0C86bMfRt2/myeCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqW4H/4z; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70a57a8ffc3so22808297b3.0
        for <stable@vger.kernel.org>; Sat, 21 Jun 2025 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750492103; x=1751096903; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcodFaBkhV7hU3TQMrblcNjRimJgnOZ7K+9mus8vTOE=;
        b=HqW4H/4zkIg8iwzoBF3EYZ4i84dgVCtbeb7xt4+OJYVAhk9ppjLgj9sdN1EpGCQ8KP
         o4a5s9b/tIdgKkVs33Soab99cS3e6az9NuNet53MXh3TSJ8WV6yQ9OtQ1oSQR3ZxAk8U
         0E0Da3YE1O/2iMh+RYNMlkcPdc5jy/XZxSPjYJ4WM9yrkAnvDdNHBq2GXXPwjI8E1p8F
         t8XT0pHLDJSylYc+/K8zlFHaShpyLk9jhQiV7u3uYkkmhLFkbpt0Fj/GYK3AUFX6VJ/o
         ELimquy+RvbxIWaQAK+qALZiUdJ/4NeoYs/kyM9rhwHtlyd68GqNBfPF5eUpTwW46Bdj
         zrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750492103; x=1751096903;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcodFaBkhV7hU3TQMrblcNjRimJgnOZ7K+9mus8vTOE=;
        b=onNyUu9l1WTH6GP31sZyOGAgFe6LBGM20ht6k4dlH2qYkN6VXHDpawbEHKi3WgCHes
         KGpCqS24zMa4fn33ZvaLBbVPKMQwl5gl6o0rftDuc0zso0mxxQGuGaXYKyyLRmT4S6A1
         OTcWVlkbCmVyMRPEs3RV/KmYRd/2YHJDZZxfueHuIWdgj3KTWtta5vKsNzgyrUZVVJbX
         7ktLXM3JtvIeivKBID9bJexI9yb52UsgRQCSULhlFhWp4DWbHBBmsv5GkQdVjyYRnF5x
         SQ3HpDnF8Ju0C7JhlN2gerHJUvwSa13mzwrsD0tz3snm6yyN7XGAnj4/FQN7VaYfmvPV
         /Ldw==
X-Forwarded-Encrypted: i=1; AJvYcCV5T5+tJfFGLtwE3e1wgR7BiznyagUJ7XpXFICC2kDYNReMDTZLY0lYyyA8tNqLu3FGozUredM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjveEypOj+QLECtPfsWy8lnxKiGUu4nJpjL0E64uoCcz7O2MXy
	YnS6xSHPzM2roBaI9gOjTDuKlut+LeoioAO4sSnWJZyozzklJvAXOC7XtDlKDA427JNhBdt6VTO
	0beyTgaFC
X-Gm-Gg: ASbGnctveegJLIlfEuQ6XdZq6eb8gphc7UI0oy6ZuURePMskytyTrvVuMTz6btxAm+o
	WDMM+YY0xCTii2fMt9ASrnm+8rzzDEXQou5K/Jsl8/+Vfi8i7TOgV6jFmXyWUWy7GV+AvHU5QZV
	1o0uXDQKcmvc8JCaySifHvQfwVV1UdJY6ISoR3dq+dt7NzkKO0XpVXCbzJ79V6tE47FUNFJLGgj
	oTehsmnnQEHP7jElJRRk++9jevJmOewAdfRIoWvByPpMo/1pRUb7vdmjr/6PXWRKd/J+k3CQipD
	dSOuHiCKxk7Vbd7AI3+NhFP1Y+uwcWWTqVC87dwr1vbdJSRMzLWxPNL7st/iJyDezQV1BXDoVyH
	Ws74C4vyOYrCv1HDCC8EtPgZWk6Vk4stPY4Ljq0cmEzy5UzTFQ2Y9c2G82Q==
X-Google-Smtp-Source: AGHT+IGU8Sx9ougBmTg0sNA1/pUALQD4zdh9Nr0bImsOL1vZBDC0yUCBKbDR0eq4w0Zpia69/JG7Uw==
X-Received: by 2002:a05:690c:6407:b0:70e:82d6:9af2 with SMTP id 00721157ae682-712c679b2b3mr80546167b3.34.1750492103257;
        Sat, 21 Jun 2025 00:48:23 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4b96754sm7495287b3.67.2025.06.21.00.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 00:48:21 -0700 (PDT)
Date: Sat, 21 Jun 2025 00:48:11 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Gavin Guo <gavinguo@igalia.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Zi Yan <ziy@nvidia.com>, Gavin Shan <gshan@redhat.com>, 
    Florent Revest <revest@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Miaohe Lin <linmiaohe@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
In-Reply-To: <20250621054106.3649809-1-gavinguo@igalia.com>
Message-ID: <3c928718-09f7-5194-2069-0058c04c909c@google.com>
References: <2025051204-tidal-lake-6ae7@gregkh> <20250621054106.3649809-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 21 Jun 2025, Gavin Guo wrote:

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

Thanks, yes, this new 5.15 version
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9139da4baa39..e9c5de967b2c 100644
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
> 
> base-commit: 1c700860e8bc079c5c71d73c55e51865d273943c
> -- 
> 2.43.0

