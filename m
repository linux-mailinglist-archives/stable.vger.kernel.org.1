Return-Path: <stable+bounces-155206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A18AE27E1
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 09:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186B77AD08F
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 07:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8881E5B7A;
	Sat, 21 Jun 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mng5kZyK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FF1E5713
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750492305; cv=none; b=dE9Y6KNQOTyl45y+W+iTTwZtkZ6OSE8ycylc6OalwHS7c4Uey1yLGuAzuuzO2NseOPTriItjpdBDMswGBWrJErSYeIQpWU9hU9/f10B1K19Dq9zpwf25cxwLMGjGnqLQzenSOfDgb/2B6u42p2pO1lB2iqeZ4qlFtZMIiE4SWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750492305; c=relaxed/simple;
	bh=jbwYzAPxvGpXLn3ba7meUPYSNPUBhx7BOFnyDw2kq8E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PuUj9d3xZt4iwxKUiudt496EwdoJHzpUTZdU6N7Px6V+m84PoOzchYI3cyS1FMpZP0p3oak6URQ5tQ7xnhYxbyBKSaTxhz5VIsqw2VVjqJ5BrK1s6MHb7YvvoPQojZcSpOTam9z8crBJZSzr3YzAIuP1P/+8PHX8OhD8zsWKizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mng5kZyK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-711a3dda147so27731927b3.2
        for <stable@vger.kernel.org>; Sat, 21 Jun 2025 00:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750492303; x=1751097103; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLT3vnxja5hlWsBwcyY5tklSuaYLTM5jpajuoKR8qg4=;
        b=mng5kZyKK+U8w+PrlXm85tRGYU821bjA/6XKm/73TCxZ2a0oIrYBXmqXxpRxwt7NWx
         x88JcSx0+Ad94vUg+AkiZpGdCMywJo2uSRhDozzuTfiau8G4LOuAIpQX/lzgUIknNaXO
         lK3xPnbwhV4OrI36KGOF1/UohVn4yJiv+YPD1nTKUimIWXhhkt5e5m7M2SIi+2x8z6WA
         MJhZiTSL0Unk3a0Wnj76ftL6cZvwYSrM8NmIKVscl0SjHPHTAujXUwZ5LLsQDedQkPNg
         uqoXVQbR9qt8VdB672XS17IBdW5Fz/9QZM2s59bxUXAUDCIlDnFhf0xN7f69LgYR6OXP
         9rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750492303; x=1751097103;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLT3vnxja5hlWsBwcyY5tklSuaYLTM5jpajuoKR8qg4=;
        b=OJoSxgUWmzwigzr1//RGso3J1RWtYt+5nw/3ec69S6f54JQ9MUzJW7YvwDtJHP8jK4
         Qw/MWNXanjUNP6iQC+kzy3FdX7BRxINZgnSFlU0zIsxDLuPysF/JX8xCmYqIGBz8Skyf
         RzzjSQTqenVSmUClZj//LIlBvGE66S/EJlK7b/fSq4a0mXaZ+CTiA6ZFAbhQQVWO3NLp
         uURL2BvfbQRRwuFcpl9nNclc3WDRdB9gYwduXT58DAdmac9nRp6+vvnEwUnzywfjSODY
         zF5/qNtVXPH8MNvm2JX1f5UskExwBFdUiGOlHWfr5MhUcABjSBkSJ6bteSCO7RmiECRu
         SliQ==
X-Forwarded-Encrypted: i=1; AJvYcCX46jewbyj7r0dnawwLBk2SJIsxrWcXhmy5Ol67pEzJ1IquBByf2GHSs4O7NMU2H+J6rA0pr4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmwqdXucj+kniW4S7JtYnpyMZ0YJI8RBxaA67X2NrXzFCyGJ4
	mqNMCmF/jvz0/i5t6BXm+fh1zm+IhgZJ4taSZ9zAmj/j9F3mpmOMizP0UFOigdf6Lg==
X-Gm-Gg: ASbGncuF4ZKJPaxFmNuD2MRPvnqOJOMOnFnWcv76gUYtSHhyuu01zYsiIwM1maVboQM
	Ssw9tuzlOpS8QQ9OjtBrUgFTj+Q8STHF+u1/WFTCL2wHl4sflWEC5TehsOIsTI1xNOcPiFZ+p+Y
	RZlbxei6y61LhNSAF5sXts4yukqispic/ZU8Pwmpnwnb5oBuO88PVDB09JiVuWJqzjxFLpZFQvc
	Kxdnd8XVCuRDUyk6BCFW8OSzxCFmI+9CTl0E75eQNZn8T6VyUM6S6wbr/OEeCpLqKkLX6NWadV5
	QSSLfB70KIa6Dk7nAvTa4Dt3ii5RsGJQyzgptWvqHkcOoQiSl+oGVomSZVVDp/0VGQjXL29B5B6
	y5jCAHyIS6kDBn5GljXKuOFPL/VeALaJSOsa1yJ5UsPfZ2xfFJUcDBSIPcw==
X-Google-Smtp-Source: AGHT+IEbAn5MKzajFV0TPF99wK013EoZywAuZoaxJKbltdyxUiQTbyhbK8fdPZ7xsM/GLhyKZKPynw==
X-Received: by 2002:a05:690c:490d:b0:70f:83ef:ddeb with SMTP id 00721157ae682-712c67772f6mr79253447b3.34.1750492302877;
        Sat, 21 Jun 2025 00:51:42 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4a162ddsm7408117b3.34.2025.06.21.00.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 00:51:41 -0700 (PDT)
Date: Sat, 21 Jun 2025 00:51:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Gavin Guo <gavinguo@igalia.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Zi Yan <ziy@nvidia.com>, Gavin Shan <gshan@redhat.com>, 
    Florent Revest <revest@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Miaohe Lin <linmiaohe@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH 5.4.y] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
In-Reply-To: <20250621053831.3647699-1-gavinguo@igalia.com>
Message-ID: <4b68a8ff-fd6a-1784-659d-24450e407f99@google.com>
References: <2025051206-t-shirt-wrist-ad33@gregkh> <20250621053831.3647699-1-gavinguo@igalia.com>
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

Thanks, yes, this new 5.4 version
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 03b57323c53b..ceb5b6d720f0 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2334,7 +2334,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  	VM_BUG_ON(freeze && !page);
>  	if (page) {
>  		VM_WARN_ON_ONCE(!PageLocked(page));
> -		if (page != pmd_page(*pmd))
> +		if (is_pmd_migration_entry(*pmd) || page != pmd_page(*pmd))
>  			goto out;
>  	}
>  
> 
> base-commit: 44613a259decccddd2bd4520f73cc4d5107546c6
> -- 
> 2.43.0

