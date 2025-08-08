Return-Path: <stable+bounces-166873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74070B1EC90
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 17:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080DC1AA6568
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C38E285CBD;
	Fri,  8 Aug 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIBm+3A0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E1285CB5;
	Fri,  8 Aug 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668552; cv=none; b=YbDyikT5vDfyKz0cQ8UevMivZCj7FaOIFJ6wdxoB7JfOBi9T7dNWm3AvckkQpPk2nMRtH+xyzcrPqHILaH14bg2KqkW430B0fo3rbzeBoxchBy2L6IpEh2sDMM8HFwPxV0qXg5F4kOhr7I2jfWSn5vxYgFqffyItY6710yRjTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668552; c=relaxed/simple;
	bh=OcaDToPvu/EEOBIvyPIc8Gm5Mu+wySbfvpWzqrlXL+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAccqLk2xr++gT+OrXWv5S9Gflr7kKIu7KkxF7EZTCKTyGAVgunju+pB2QNr77lq786zE0Yl3yOgsOAE0g5YxF/gpyOPuDfZvw2K6Se0sXqkSExhiqXgbxXr8HZPceyGq90Lk67gje8RCBpiufjZGxfqpmjO/4D9ly1u1dftlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIBm+3A0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28054C4CEED;
	Fri,  8 Aug 2025 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754668551;
	bh=OcaDToPvu/EEOBIvyPIc8Gm5Mu+wySbfvpWzqrlXL+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIBm+3A0Klj5Sv82WBkHb1TqKpq3M+wIq+lrWhvnofEF4mnMJQK9E1iVE3clQxS0P
	 9vmPwj+SQV7+4YUTsz3LJam4wh9+Vr9X0onjpO5PLxD04uTwL96IfcnRMFD//eYmhO
	 ULtzLOlIDMgFQ0r3M42O8QMHmo4Ed9gZrbIUrqRmhnhafepNQ8IiiQNOb7UunVsTMy
	 fuMi0LAVkhA7/K3iYRtCcdUU4ksvSKq0g0OyoGaqBqgGrEkxR1nD2Mz5l806nENWSp
	 n4Dk98zSKYakyYQsXgclRWUOaznM7r49o6rP32FS04CnknpBSlEZCrV4ez9rX1qjSg
	 TfNj9ppmTL5GQ==
Date: Fri, 8 Aug 2025 11:55:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
	aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
Message-ID: <aJYeBbkHsDECexWN@lappy>
References: <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com>
 <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com>
 <aItjffoR7molh3QF@lappy>
 <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com>
 <aIzAj9xUOPCsmZEG@lappy>
 <593b222e-1a62-475c-9502-76e128d3625d@redhat.com>
 <aIzPPWTaf_88i8-a@lappy>
 <aJUDqqjCycGDn1Wg@lappy>
 <5b9c775c-35a1-4cd6-8387-00198e768b9a@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5b9c775c-35a1-4cd6-8387-00198e768b9a@redhat.com>

On Fri, Aug 08, 2025 at 10:02:08AM +0200, David Hildenbrand wrote:
>On 07.08.25 21:51, Sasha Levin wrote:
>>On Fri, Aug 01, 2025 at 10:29:17AM -0400, Sasha Levin wrote:
>>>On Fri, Aug 01, 2025 at 04:06:14PM +0200, David Hildenbrand wrote:
>>>>Sure, if it's prechecked by you no problem.
>>>
>>>Yup. Though I definitely learned a thing or two about Coccinelle patches
>>>during this experiment.
>>
>>Appologies if it isn't the case, but the two patches were attached to
>>the previous mail and I suspect they might have been missed :)
>
>Whoop's not used to reviewing attachments. I'll focus on the loongarch patch.

Thank you for the review!

>From a547687db03ecfe13ddc74e452357df78f880255 Mon Sep 17 00:00:00 2001
>From: Sasha Levin <sashal@kernel.org>
>Date: Fri, 1 Aug 2025 09:17:04 -0400
>Subject: [PATCH 2/2] LoongArch: fix kmap_local_page() LIFO ordering in
> copy_user_highpage()
>
>The current implementation violates kmap_local_page()'s LIFO ordering
>requirement by unmapping the pages in the same order they were mapped.
>
>This was introduced by commit 477a0ebec101 ("LoongArch: Replace
>kmap_atomic() with kmap_local_page() in copy_user_highpage()") when
>converting from kmap_atomic() to kmap_local_page(). The original code
>correctly unmapped in reverse order, but the conversion swapped the
>mapping order while keeping the unmapping order unchanged, resulting
>in a LIFO violation.
>
>kmap_local_page() requires unmapping to be done in reverse order
>(Last-In-First-Out). Currently we map vfrom and then vto, but unmap
>vfrom and then vto, which is incorrect. This patch corrects it to
>unmap vto first, then vfrom.
>
>This issue was detected by the kmap_local_lifo.cocci semantic patch.
>
>Fixes: 477a0ebec101 ("LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()")
>Co-developed-by: Claude claude-opus-4-20250514
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> arch/loongarch/mm/init.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
>index c3e4586a7975..01c43f455486 100644
>--- a/arch/loongarch/mm/init.c
>+++ b/arch/loongarch/mm/init.c
>@@ -47,8 +47,8 @@ void copy_user_highpage(struct page *to, struct page *from,
> 	vfrom = kmap_local_page(from);
> 	vto = kmap_local_page(to);
> 	copy_page(vto, vfrom);
>-	kunmap_local(vfrom);
> 	kunmap_local(vto);
>+	kunmap_local(vfrom);
> 	/* Make sure this page is cleared on other CPU's too before using it */
> 	smp_wmb();
> }
>-- 
>2.39.5
>
>
>So, loongarch neither supports
>
>a) Highmem
>
>nor
>
>b) ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP, disabling DEBUG_KMAP_LOCAL_FORCE_MAP
>
>Consequently __kmap_local_page_prot() will not do anything:
>
>	if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
>		return page_address(page);
>
>
>So there isn't anything to fix here and the whole patch subject+description should be
>rewritten to focus on this being purely a cleanup -- unless I am missing
>something important.
>
>Also, please reduce the description to the absolute minimum, nobody wants to read the
>same thing 4 times using slightly different words.
>
>"LIFO ordering", "LIFO ordering", "unmapped in reverse order ... LIFO violation" ...
>"reverse order (Last-In-First-Out)"

How about something like:

     LoongArch: cleanup kmap_local_page() usage in copy_user_highpage()
     
     Unmap kmap_local_page() mappings in reverse order to follow the
     function's LIFO specification. While LoongArch doesn't support
     highmem and these operations are no-ops, code should still adhere
     to the API requirements.
     
     Detected by kmap_local_lifo.cocci.
     
     Fixes: 477a0ebec101 ("LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()")
     Signed-off-by: Sasha Levin <sashal@kernel.org>

>More importantly: is the LIFO semantics clearly documented somewhere? I read
>Documentation/mm/highmem.rst
>
>  Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
>  extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
>  because the map implementation is stack based. See kmap_local_page() kdocs
>  (included in the "Functions" section) for details on how to manage nested
>  mappings.
>
>and that kind-of spells that out (strictly order -> stack based). I think one could
>have clarified that a bit further.
>
>Also, I would expect this to be mentioned in the docs of the relevant kmap functions,
>and the pte map / unmap functions.
>
>Did I miss that part or could we extend the function docs to spell that out?

The docs for kmap_local_page() seem to cover it better, and give the
concrete example we're trying to fix here:

  * Requires careful handling when nesting multiple mappings because the map
  * management is stack based. The unmap has to be in the reverse order of
  * the map operation:
  *
  * addr1 = kmap_local_page(page1);
  * addr2 = kmap_local_page(page2);
  * ...
  * kunmap_local(addr2);
  * kunmap_local(addr1);
  *
  * Unmapping addr1 before addr2 is invalid and causes malfunction.

-- 
Thanks,
Sasha

