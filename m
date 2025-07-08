Return-Path: <stable+bounces-160516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0AEAFCF4D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285527A80AF
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1987A1C8632;
	Tue,  8 Jul 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZihqUqDZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8780231824;
	Tue,  8 Jul 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988805; cv=none; b=W/EbN/fGFH+OCe/2gupP1XaNnBh+g+IwyNw9g9OGgq/XRF1anrgrLSJtQoIFlZdTforSOnpd+lN/AJtKurki2WFRtzbJ4pvTnI0WEH+pQKjPxzMm4rNTP8mOB+aGnNoaKP0EcNkt2dhGe8wkeVH4B0P4ynStRfco0ILOiIzLMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988805; c=relaxed/simple;
	bh=gwGumTC/MUdoi0zvgWSQcU5vXJTTpO8IuLWj2o/iaKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeUjzInKLKxyNnQW+PVlQ0Wn173loTXGCOknSBHK/60fD2UMpVe0cWAGxk1hzA7k8yDqRnuIxudO/BYhkezLOjh+AikzrpU89IUHvILmOXGh3VUajGFbNTxZUROfznaR0tH6uup2SMMfZxhZrb3vf1yB3kRQzCcJDxfouupdxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZihqUqDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FCDC4CEED;
	Tue,  8 Jul 2025 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751988805;
	bh=gwGumTC/MUdoi0zvgWSQcU5vXJTTpO8IuLWj2o/iaKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZihqUqDZ21/bJmp92jGOEjOW9+ObwGzlwxGM6p1YOobHpqpKcvkOP5THwVG0wQhAx
	 +oKkB50gUJrcou5+jvBHnG70R/ViVqTBEgR3KUxc/JFnlVoe7nX/tXChchlHBfemqO
	 lRBp6Kmil3nStFCkazz3aJHbbCw8u/3YgPR1/buSwOu9BIDODJ6Si1Pya6mBBATvsN
	 G7TY6q1yRwHlx5DnXiVDHp3RMSji8oSaouoOWf9iI4CpWLOAlzIfTq22iqQ6Miil2R
	 V6wem4Sea1hduI98t2brAI2hGIOeCzAdgAKKZKtoAYdNquppWOVsZfe+Z4XE3VfuLj
	 QVFpYaQUYDb2w==
Date: Tue, 8 Jul 2025 11:33:20 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
	aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
Message-ID: <aG06QBVeBJgluSqP@lappy>
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com>

On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
>On 01.07.25 02:57, Andrew Morton wrote:
>>On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>
>>>When handling non-swap entries in move_pages_pte(), the error handling
>>>for entries that are NOT migration entries fails to unmap the page table
>>>entries before jumping to the error handling label.
>>>
>>>This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
>>>triggers a WARNING in kunmap_local_indexed() because the kmap stack is
>>>corrupted.
>>>
>>>Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>>>   WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>   Call trace:
>>>     kunmap_local_indexed from move_pages+0x964/0x19f4
>>>     move_pages from userfaultfd_ioctl+0x129c/0x2144
>>>     userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>>>
>>>The issue was introduced with the UFFDIO_MOVE feature but became more
>>>frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
>>>PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
>>>path more commonly executed during userfaultfd operations.
>>>
>>>Fix this by ensuring PTEs are properly unmapped in all non-swap entry
>>>paths before jumping to the error handling label, not just for migration
>>>entries.
>>
>>I don't get it.
>>
>>>--- a/mm/userfaultfd.c
>>>+++ b/mm/userfaultfd.c
>>>@@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>>>  		entry = pte_to_swp_entry(orig_src_pte);
>>>  		if (non_swap_entry(entry)) {
>>>+			pte_unmap(src_pte);
>>>+			pte_unmap(dst_pte);
>>>+			src_pte = dst_pte = NULL;
>>>  			if (is_migration_entry(entry)) {
>>>-				pte_unmap(src_pte);
>>>-				pte_unmap(dst_pte);
>>>-				src_pte = dst_pte = NULL;
>>>  				migration_entry_wait(mm, src_pmd, src_addr);
>>>  				err = -EAGAIN;
>>>-			} else
>>>+			} else {
>>>  				err = -EFAULT;
>>>+			}
>>>  			goto out;
>>
>>where we have
>>
>>out:
>>	...
>>	if (dst_pte)
>>		pte_unmap(dst_pte);
>>	if (src_pte)
>>		pte_unmap(src_pte);
>
>AI slop?

Nah, this one is sadly all me :(

I was trying to resolve some of the issues found with linus-next on
LKFT, and misunderstood the code. Funny enough, I thought that the
change above "fixed" it by making the warnings go away, but clearly is
the wrong thing to do so I went back to the drawing table...

If you're curious, here's the issue: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-43418-g558c6dd4d863/testrun/29030370/suite/log-parser-test/test/exception-warning-cpu-pid-at-mmhighmem-kunmap_local_indexed/details/

-- 
Thanks,
Sasha

