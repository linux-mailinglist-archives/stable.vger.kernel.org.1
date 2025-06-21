Return-Path: <stable+bounces-155204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9951AE27D6
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 09:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C97017E6A0
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5791A3165;
	Sat, 21 Jun 2025 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ityYgHdy"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC1196C7C
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750492233; cv=none; b=Lo9X5oLx1OJp3lv7Igohe7NUUQWFl1o2f20UyVBzwhnzTudPnat70O5AlZDEQn4oQ4EleUdS4gi3e3jL4ZY6kjUj8iMqwQfBA5Srw/Qp8bZ9Fn9k5NIjGgUSMhE24ymqeeFSE42T4UYj+OMBXGcc+VLG3i/0L7X0r7d3ko7Qr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750492233; c=relaxed/simple;
	bh=ErQg79pp3pplN8h3HJROaf+ly9fFVIw9oCOs4TZeyFw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KVHRUj8tRuRxUfeENqY+plgs2675b7CJO9nijMv7g+QdYALTkIS6PFFXGJnH0KvCtOhefRFJSYVxVQoQMLBynns3ap098gdg6V999cmHpF3KihsmtZBhady2gu57vGamZPmGjVts4MHkwj1bpdiFFut3dvQEvhw3pp53Tvj6Rqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ityYgHdy; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7113ac6d4b3so23665257b3.3
        for <stable@vger.kernel.org>; Sat, 21 Jun 2025 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750492229; x=1751097029; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vr7QyiiBJ6zTTuVrh4ftEOpkOvB4rnAOG8zNhC+o+I8=;
        b=ityYgHdyjnfnQupqya8Tx/zVJjasGT+u78H1uGVkEuoyePsDAt5HWwP7+Y+IAaXHuY
         osGKA49QFQR5wm5EKmL4z9VYoN/tK2T9KemPbSawBR5IUGUKnoiCvGqOIHukuJTEenHc
         ODkrE+/aEApjgDDp/UzISwn24EeDoSbqcF6ExMU8IObCCvAHEODWnFr3T2LqJxlJVz9f
         PCmrl0aEyDaIxH3VUACv/nFALpGBT8lROWOvEQf1f9RotrBEHgxuarsODYh8Lvej+6h4
         CPp4Gj/uOFc3AhykNm0+Hmtb30HNAgkFqM/NBmCFbZMRB8up4MCxRYSIugFfHckEiz+g
         9yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750492229; x=1751097029;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr7QyiiBJ6zTTuVrh4ftEOpkOvB4rnAOG8zNhC+o+I8=;
        b=Ly4PsvQ5r70xZelEEpNFLuTxo6HgmthLiIAs8krB4Duau9D0eebPhCIBUjM9aykZA1
         pV+uVlk2Q5H1H2e3jNpILLO/NE7fwYR7MKHBKXL2hMxbL3jagvsIXcMHYkUJDwmPhgRl
         wCiZNK+L054poGIaJNJP5HY6cjmjvlq9Ok6d7pmJNDuOSpS+i5JeRGTbrfjNaNCVsu8P
         V0N18NhB4+z/mSxEBmX7SWM49T+a+Gn+BwhTGSNE0cwjQ6EUo7qXQYkbt1Wos9nSrMQv
         47vOp2nNKCZrqWiB2TJGFIiGoy3ki9gp9LiuQnDFR0nC2EK3eRXMKu0jqJPyXIozDgQF
         WVqg==
X-Forwarded-Encrypted: i=1; AJvYcCUu+ZPRUIi5Pgfiz5ZVPHlyTLzYiY92Zs6LW8C/T+/1TicF4JcsArDyZLdpn9v/o9S7UaoMUic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bbSBYxaBWv6uuDnZGOFK+mIB0dCUNnw7KWp0kFs8q2qQeQxZ
	832Fyk4NwLtLJOZsG7eOjJ6rYc/+1OKY8k9zjhukd6SKUcC49qJ0c071i99Ig5840w==
X-Gm-Gg: ASbGncsxOTLNWzdZLqew4AJ/bCsOKshtz6frfl1iKn0kqaVNtmdjD4BuIS5McdQGNbE
	ifs5SdTV/aR0nk9lUn4R4+AVWINFdln6+bkEbcWlDv2rN5hUCItcDlpGxy2andvv7E6cUfnzghi
	4f8V275O9dbHuOg6HQfO1UBAxgQcGYFNzsiBjh5Px4gnynS8aUEulgfxzjLLGx9mp8x9/FOb/9N
	w3pePMnazZeULdotyEuhF4TibdX/cy5uwBzWS1Our1QBjF93uPOv3fuv3EaxQii9Ps4jQtMJunH
	xOoZnyf5zKNZ+SxyCWUBkbRReJ8QoSwQkA4Y/aV9ep8KKlzbPpG2U/k9aesmYLwQmvF3lgS8zu6
	L1GxizlE/qNuabrytjf6doI+ccIabhAvT1zkdgUyf0Ew3HTU=
X-Google-Smtp-Source: AGHT+IG7LIoVtpQoVqE/TP5gVpF0XfeFqlnT/YNgyl+uU0zuKVeKDB9msGnjI3f6R49FZtbEdrW+0g==
X-Received: by 2002:a05:690c:6b89:b0:70c:8f0c:f923 with SMTP id 00721157ae682-712c651782bmr84530467b3.18.1750492228694;
        Sat, 21 Jun 2025 00:50:28 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aab931esm1120858276.2.2025.06.21.00.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 00:50:27 -0700 (PDT)
Date: Sat, 21 Jun 2025 00:50:25 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Gavin Guo <gavinguo@igalia.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Zi Yan <ziy@nvidia.com>, Gavin Shan <gshan@redhat.com>, 
    Florent Revest <revest@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Miaohe Lin <linmiaohe@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
In-Reply-To: <20250621053951.3648727-1-gavinguo@igalia.com>
Message-ID: <b62029b6-79e9-0209-85b4-95c21887fb86@google.com>
References: <2025051205-work-bronze-e167@gregkh> <20250621053951.3648727-1-gavinguo@igalia.com>
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

Thanks, yes, this new 5.10 version
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e4c690c21fc9..92550e398e5d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2227,7 +2227,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  	VM_BUG_ON(freeze && !page);
>  	if (page) {
>  		VM_WARN_ON_ONCE(!PageLocked(page));
> -		if (page != pmd_page(*pmd))
> +		if (is_pmd_migration_entry(*pmd) || page != pmd_page(*pmd))
>  			goto out;
>  	}
>  
> 
> base-commit: 01e7e36b8606e5d4fddf795938010f7bfa3aa277
> -- 
> 2.43.0

