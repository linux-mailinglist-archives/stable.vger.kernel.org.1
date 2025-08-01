Return-Path: <stable+bounces-165746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD276B183AB
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC83E7A8C2E
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2126B756;
	Fri,  1 Aug 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh34V0d6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB322641E3;
	Fri,  1 Aug 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058259; cv=none; b=VTWF/Y4sib2IzG98HYQ+cc+MNpbMogfMjKL0bPpEewUOKBdSgv+/nsDfIjq4qDcoPirgcufA24VmDpyw+HKYf8qVfYrheE4SR0/wu3Zq8K9b2fFZAB8XHbYiBRvQiF5DniZvNBllfxPGbnzrUq3vq1Ct2izMI7wxO1ZQ9JvTi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058259; c=relaxed/simple;
	bh=LdWLM57B/0XA9mDL5JeTNz6Ago8lMwc+LmfdW7VJ9js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXGNOS04as/4OWFUvzid5KFSCv5FGXmPkNjPmfFpzRKeatw/QJHzJP2MLc/Okqg3M7kAhQRBBCb4NBKz5/y2wjqzoQVmKLq+5AZPGB7WZrR6Q4SN6CXAlMNfYw23Qy3w8B8knD29zWBSbvN7LWlU2AnivmjGhLSeB0zHYY7bRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh34V0d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2674C4CEE7;
	Fri,  1 Aug 2025 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754058258;
	bh=LdWLM57B/0XA9mDL5JeTNz6Ago8lMwc+LmfdW7VJ9js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sh34V0d6zMmhqDHGN93E32yJAm0b4ksxVAZI5uPc8t8G02fK26EEihsDOFx5AiZmx
	 84mAo3hiF+tDfLCnX6IRQ4/OEXPUBntA+LiaYtAtfpAG9RT24sMyZj2zFmopZrpmTP
	 N5iFnXhs0W5N9pK/76oI98dfp4Pl6fuVwYEucPR3mGhZjvWw+tAOPovUERPmYdF9cB
	 zHcbXq7sGnX8Uzzj4bVWwm5wtu++jYsYvrhC3hPU8PUY53SR4tViP6sMpjF1VgKQSN
	 WczApY8X+fIkWTQbmFsJZLd2FS4yhDDfZpoTksrGDXvw2eLf0XOrViuKoDWtjVg5Wi
	 1XmbS2jXAVBRQ==
Date: Fri, 1 Aug 2025 10:24:16 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
	aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
Message-ID: <aIzOEJgbmjae7AOS@lappy>
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com>
 <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com>
 <aItjffoR7molh3QF@lappy>
 <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com>
 <aIzAj9xUOPCsmZEG@lappy>
 <593b222e-1a62-475c-9502-76e128d3625d@redhat.com>
 <286466e3-9d1c-40a0-a467-a48cb2b657b4@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <286466e3-9d1c-40a0-a467-a48cb2b657b4@redhat.com>

On Fri, Aug 01, 2025 at 04:13:32PM +0200, David Hildenbrand wrote:
>On 01.08.25 16:06, David Hildenbrand wrote:
>>On 01.08.25 15:26, Sasha Levin wrote:
>>>On Thu, Jul 31, 2025 at 02:56:25PM +0200, David Hildenbrand wrote:
>>>>On 31.07.25 14:37, Sasha Levin wrote:
>>>>>On Tue, Jul 08, 2025 at 05:42:16PM +0200, David Hildenbrand wrote:
>>>>>>On 08.07.25 17:33, Sasha Levin wrote:
>>>>>>>On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
>>>>>>>>On 01.07.25 02:57, Andrew Morton wrote:
>>>>>>>>>On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>>>When handling non-swap entries in move_pages_pte(), the error handling
>>>>>>>>>>for entries that are NOT migration entries fails to unmap the page table
>>>>>>>>>>entries before jumping to the error handling label.
>>>>>>>>>>
>>>>>>>>>>This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
>>>>>>>>>>triggers a WARNING in kunmap_local_indexed() because the kmap stack is
>>>>>>>>>>corrupted.
>>>>>>>>>>
>>>>>>>>>>Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>>>>>>>>>>    WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>>>>>>>>    Call trace:
>>>>>>>>>>      kunmap_local_indexed from move_pages+0x964/0x19f4
>>>>>>>>>>      move_pages from userfaultfd_ioctl+0x129c/0x2144
>>>>>>>>>>      userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>>>>>>>>>>
>>>>>>>>>>The issue was introduced with the UFFDIO_MOVE feature but became more
>>>>>>>>>>frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
>>>>>>>>>>PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
>>>>>>>>>>path more commonly executed during userfaultfd operations.
>>>>>>>>>>
>>>>>>>>>>Fix this by ensuring PTEs are properly unmapped in all non-swap entry
>>>>>>>>>>paths before jumping to the error handling label, not just for migration
>>>>>>>>>>entries.
>>>>>>>>>
>>>>>>>>>I don't get it.
>>>>>>>>>
>>>>>>>>>>--- a/mm/userfaultfd.c
>>>>>>>>>>+++ b/mm/userfaultfd.c
>>>>>>>>>>@@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>>>>>>>   		entry = pte_to_swp_entry(orig_src_pte);
>>>>>>>>>>   		if (non_swap_entry(entry)) {
>>>>>>>>>>+			pte_unmap(src_pte);
>>>>>>>>>>+			pte_unmap(dst_pte);
>>>>>>>>>>+			src_pte = dst_pte = NULL;
>>>>>>>>>>   			if (is_migration_entry(entry)) {
>>>>>>>>>>-				pte_unmap(src_pte);
>>>>>>>>>>-				pte_unmap(dst_pte);
>>>>>>>>>>-				src_pte = dst_pte = NULL;
>>>>>>>>>>   				migration_entry_wait(mm, src_pmd, src_addr);
>>>>>>>>>>   				err = -EAGAIN;
>>>>>>>>>>-			} else
>>>>>>>>>>+			} else {
>>>>>>>>>>   				err = -EFAULT;
>>>>>>>>>>+			}
>>>>>>>>>>   			goto out;
>>>>>>>>>
>>>>>>>>>where we have
>>>>>>>>>
>>>>>>>>>out:
>>>>>>>>>	...
>>>>>>>>>	if (dst_pte)
>>>>>>>>>		pte_unmap(dst_pte);
>>>>>>>>>	if (src_pte)
>>>>>>>>>		pte_unmap(src_pte);
>>>>>>>>
>>>>>>>>AI slop?
>>>>>>>
>>>>>>>Nah, this one is sadly all me :(
>>>>>>
>>>>>>Haha, sorry :P
>>>>>
>>>>>So as I was getting nowhere with this, I asked AI to help me :)
>>>>>
>>>>>If you're not interested in reading LLM generated code, feel free to
>>>>>stop reading now...
>>>>>
>>>>>After it went over the logs, and a few prompts to point it the right
>>>>>way, it ended up generating a patch (below) that made sense, and fixed
>>>>>the warning that LKFT was being able to trigger.
>>>>>
>>>>>If anyone who's more familiar with the code than me (and the AI) agrees
>>>>>with the patch and ways to throw their Reviewed-by, I'll send out the
>>>>>patch.
>>>>
>>>>Seems to check out for me. In particular, out pte_unmap() everywhere
>>>>else in that function (and mremap.c:move_ptes) are ordered properly.
>>>>
>>>>Even if it would not fix the issue, it would be a cleanup :)
>>>>
>>>>Acked-by: David Hildenbrand <david@redhat.com>
>>>
>>>David, I ended up LLM generating a .cocci script to detect this type of
>>>issues, and it ended up detecting a similar issue in
>>>arch/loongarch/mm/init.c.
>>
>>Does loongarch have these kmap_local restrictions?
>
>loongarch doesn't use HIGHMEM, so it probably doesn't matter. Could be 
>considered a cleanup, though.

Yup, it's just a cleanup for loongarch.

It was the only other place besides mm/userfaultfd.c that had that
inversion, so keeping the tree warning clear will make it easier to spot
newly introduced issues in the future.

-- 
Thanks,
Sasha

