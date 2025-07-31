Return-Path: <stable+bounces-165660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBDAB1715C
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 14:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C350176BC5
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38CD22A801;
	Thu, 31 Jul 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQwjL0KX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF56208CA;
	Thu, 31 Jul 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965440; cv=none; b=HI2YpLDBUJhlqR0X/ukPTlcp973eXax5U+6RcnFcfn6DQn79/rRJ/qEcPW9woL/IBamvUyPkNIpRAZICK45QtJUeMK+cEj0lFRMjgL8tHBDKZngwZqWOvxBGiHRbCHV7keuV8sISEsewMSIS4sDqiQT1nmr4sg5HkyJw50da4fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965440; c=relaxed/simple;
	bh=x1zdbpjE+cQySjmlF0wAM2xxqmg+a54+zYfqjK8Zpzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L791vcpYLqBg8vAjD2TnuM7WfdliOAAn5DHi4eV6flg3Y6EJR9tl0QXwj5AefCZFTh7iOrI6jccvZq+XhcWFZcf40IYpiixb9tebrWZYW7jxE5cooGvKhOQCqNK5Eww7EXTrRwcwx77BiGDZVkjrdZpAFIXjR6MPuE7jBWb4aWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQwjL0KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71B6C4CEEF;
	Thu, 31 Jul 2025 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753965440;
	bh=x1zdbpjE+cQySjmlF0wAM2xxqmg+a54+zYfqjK8Zpzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQwjL0KXX9GSPLy404TgAv0Qjn5xJ/FZd0z0sd2awLL9rtJ6MpA0rDUw5mOVdzCMq
	 bMpFB8M36c4znUpKP/k50xNWpODaryzeMbshLCpQjMli2PVEe4qOQWgRuJc8rndyXK
	 BH1Z6o0w2ur0cNxQf1PwRaeMdZcj1hdTc2/Y9DttZsTtvvaHmzC3atRN5EtcoDkqBf
	 hfBo67Vr0R3Y0/MbpO0VeNbRNIHvoKW2qw9ht+3NKrG7vkyOnoitqwiCcCc1xmNe5i
	 IATI8gFqfxsQQyklFYF9OEkCf5DIk7ttJepk8TkGFkOLxuhy3ePvyZX2NGm605ONo3
	 WhjTJ5Qx1Bk6w==
Date: Thu, 31 Jul 2025 08:37:17 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
	aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
Message-ID: <aItjffoR7molh3QF@lappy>
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com>
 <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com>

On Tue, Jul 08, 2025 at 05:42:16PM +0200, David Hildenbrand wrote:
>On 08.07.25 17:33, Sasha Levin wrote:
>>On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
>>>On 01.07.25 02:57, Andrew Morton wrote:
>>>>On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>>>
>>>>>When handling non-swap entries in move_pages_pte(), the error handling
>>>>>for entries that are NOT migration entries fails to unmap the page table
>>>>>entries before jumping to the error handling label.
>>>>>
>>>>>This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
>>>>>triggers a WARNING in kunmap_local_indexed() because the kmap stack is
>>>>>corrupted.
>>>>>
>>>>>Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>>>>>   WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>>>   Call trace:
>>>>>     kunmap_local_indexed from move_pages+0x964/0x19f4
>>>>>     move_pages from userfaultfd_ioctl+0x129c/0x2144
>>>>>     userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>>>>>
>>>>>The issue was introduced with the UFFDIO_MOVE feature but became more
>>>>>frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
>>>>>PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
>>>>>path more commonly executed during userfaultfd operations.
>>>>>
>>>>>Fix this by ensuring PTEs are properly unmapped in all non-swap entry
>>>>>paths before jumping to the error handling label, not just for migration
>>>>>entries.
>>>>
>>>>I don't get it.
>>>>
>>>>>--- a/mm/userfaultfd.c
>>>>>+++ b/mm/userfaultfd.c
>>>>>@@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>>  		entry = pte_to_swp_entry(orig_src_pte);
>>>>>  		if (non_swap_entry(entry)) {
>>>>>+			pte_unmap(src_pte);
>>>>>+			pte_unmap(dst_pte);
>>>>>+			src_pte = dst_pte = NULL;
>>>>>  			if (is_migration_entry(entry)) {
>>>>>-				pte_unmap(src_pte);
>>>>>-				pte_unmap(dst_pte);
>>>>>-				src_pte = dst_pte = NULL;
>>>>>  				migration_entry_wait(mm, src_pmd, src_addr);
>>>>>  				err = -EAGAIN;
>>>>>-			} else
>>>>>+			} else {
>>>>>  				err = -EFAULT;
>>>>>+			}
>>>>>  			goto out;
>>>>
>>>>where we have
>>>>
>>>>out:
>>>>	...
>>>>	if (dst_pte)
>>>>		pte_unmap(dst_pte);
>>>>	if (src_pte)
>>>>		pte_unmap(src_pte);
>>>
>>>AI slop?
>>
>>Nah, this one is sadly all me :(
>
>Haha, sorry :P

So as I was getting nowhere with this, I asked AI to help me :)

If you're not interested in reading LLM generated code, feel free to
stop reading now...

After it went over the logs, and a few prompts to point it the right
way, it ended up generating a patch (below) that made sense, and fixed
the warning that LKFT was being able to trigger.

If anyone who's more familiar with the code than me (and the AI) agrees
with the patch and ways to throw their Reviewed-by, I'll send out the
patch.

If the below patch is completely bogus then I'm sorry and I'll buy you a
beer at LPC :)


 From 70f7eae079a5203857b96d6c64bb72b0f566d4de Mon Sep 17 00:00:00 2001
From: Sasha Levin <sashal@kernel.org>
Date: Wed, 30 Jul 2025 20:41:54 -0400
Subject: [PATCH] mm/userfaultfd: fix kmap_local LIFO ordering for
  CONFIG_HIGHPTE

With CONFIG_HIGHPTE on 32-bit ARM, move_pages_pte() maps PTE pages using
kmap_local_page(), which requires unmapping in Last-In-First-Out order.

The current code maps dst_pte first, then src_pte, but unmaps them in
the same order (dst_pte, src_pte), violating the LIFO requirement.
This causes the warning in kunmap_local_indexed():

   WARNING: CPU: 0 PID: 604 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
   addr != __fix_to_virt(FIX_KMAP_BEGIN + idx)

Fix this by reversing the unmap order to respect LIFO ordering.

This issue follows the same pattern as similar fixes:
- commit eca6828403b8 ("crypto: skcipher - fix mismatch between mapping and unmapping order")
- commit 8cf57c6df818 ("nilfs2: eliminate staggered calls to kunmap in nilfs_rename")

Both of which addressed the same fundamental requirement that kmap_local
operations must follow LIFO ordering.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Co-developed-by: Claude claude-opus-4-20250514
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
  mm/userfaultfd.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8253978ee0fb..bf7a57ea71e0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1453,10 +1453,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
  		folio_unlock(src_folio);
  		folio_put(src_folio);
  	}
-	if (dst_pte)
-		pte_unmap(dst_pte);
+	/*
+	 * Unmap in reverse order (LIFO) to maintain proper kmap_local
+	 * index ordering when CONFIG_HIGHPTE is enabled. We mapped dst_pte
+	 * first, then src_pte, so we must unmap src_pte first, then dst_pte.
+	 */
  	if (src_pte)
  		pte_unmap(src_pte);
+	if (dst_pte)
+		pte_unmap(dst_pte);
  	mmu_notifier_invalidate_range_end(&range);
  	if (si)
  		put_swap_device(si);


-- 
Thanks,
Sasha

