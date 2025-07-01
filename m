Return-Path: <stable+bounces-159092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47699AEEB7F
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 02:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B421BC5058
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 00:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F515A87C;
	Tue,  1 Jul 2025 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ta2oT7cF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD231547E7;
	Tue,  1 Jul 2025 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331467; cv=none; b=n0tiSf3cwX13jN0X5IktDxytJTiekT1CzTOWp0VYuPwWIaVyEOtoDnVfkUPhJjO7hgJo85ILqVN4jeF6NpW4kagQouFFYvav2lxRsvsO0FtkuZIqFyBARncwOCdXIPi+GIpJSSeB+T759eDPyJLTGiNILjjaXSHCvyJU1nwy1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331467; c=relaxed/simple;
	bh=0KXdqPxnq8u5m3JaoBAj3LQJmLTeItSenCMiTod8nuU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AiUXu+7c6AGhsAO4ennjPR1O6nPtooWPhI2bqwydRNrm/F+6ixwwzpBSejpetzliZJGaITIkzY3Jbs9f2ipnCzdEgGTHMbIgxyeksB1afuMGgNn7tno9aqQNvYVpquZylFcx+QwcvdxMiET3f7GVwDGkCJTBaepU3ppESFq8jOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ta2oT7cF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C118EC4CEF0;
	Tue,  1 Jul 2025 00:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751331467;
	bh=0KXdqPxnq8u5m3JaoBAj3LQJmLTeItSenCMiTod8nuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ta2oT7cFvsUGw9C9vm+YGKQtvnu3ivF2IZMKNpHx9yTkkBBYM6pH6fR+spvbLNyET
	 lx/uBU5qSYdMjTK+I8sE1E5enbYZPdo1CGyOjfnu16+0MD647OdkcTDupzwFgwydyF
	 xsUSP7uCnt9+w4tVj8KIp3fN90GFHulzlpUk/QRs=
Date: Mon, 30 Jun 2025 17:57:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: peterx@redhat.com, aarcange@redhat.com, surenb@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
Message-Id: <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
In-Reply-To: <20250630031958.1225651-1-sashal@kernel.org>
References: <20250630031958.1225651-1-sashal@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:

> When handling non-swap entries in move_pages_pte(), the error handling
> for entries that are NOT migration entries fails to unmap the page table
> entries before jumping to the error handling label.
> 
> This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
> triggers a WARNING in kunmap_local_indexed() because the kmap stack is
> corrupted.
> 
> Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>   WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>   Call trace:
>     kunmap_local_indexed from move_pages+0x964/0x19f4
>     move_pages from userfaultfd_ioctl+0x129c/0x2144
>     userfaultfd_ioctl from sys_ioctl+0x558/0xd24
> 
> The issue was introduced with the UFFDIO_MOVE feature but became more
> frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
> PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
> path more commonly executed during userfaultfd operations.
> 
> Fix this by ensuring PTEs are properly unmapped in all non-swap entry
> paths before jumping to the error handling label, not just for migration
> entries.

I don't get it.

> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  
>  		entry = pte_to_swp_entry(orig_src_pte);
>  		if (non_swap_entry(entry)) {
> +			pte_unmap(src_pte);
> +			pte_unmap(dst_pte);
> +			src_pte = dst_pte = NULL;
>  			if (is_migration_entry(entry)) {
> -				pte_unmap(src_pte);
> -				pte_unmap(dst_pte);
> -				src_pte = dst_pte = NULL;
>  				migration_entry_wait(mm, src_pmd, src_addr);
>  				err = -EAGAIN;
> -			} else
> +			} else {
>  				err = -EFAULT;
> +			}
>  			goto out;

where we have

out:
	...
	if (dst_pte)
		pte_unmap(dst_pte);
	if (src_pte)
		pte_unmap(src_pte);




