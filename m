Return-Path: <stable+bounces-146709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB34AC5444
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260DA1BA4094
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8042327E1CA;
	Tue, 27 May 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TPMokfb8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C9194A67
	for <stable@vger.kernel.org>; Tue, 27 May 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365064; cv=none; b=DWvsUXQQUaYtSKf9eQCK70M8y5wRn0jEdGmg55HQ/X01YrKG0voZ95UBixd1ycLtCot18XK2i0P2rkRc4ifuHaUBGbSDlyjDfKTD+ejkDDx9juLzEwR1L+OBlwDHj+FvcaJNNyhmDL+OhgNlD+qtodiFORuj7Bh1ys+6Q+fvIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365064; c=relaxed/simple;
	bh=R5hLVj+JmJT6JvPi1+0u3PsooaMXKEKlGdOSpfYpReQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LwZyQlBAof2KtoqqGxwwGz5kIUASJbmZLeh8feZD77/gS40OjwvN7Dfvrhfy+FtgV7IM0vKEf5qxe9ybSPAefzY6Qbqj4/RDJx826ER0GaNkuu0cFt+126aSSFQKSVLpQL+Kp65MpXVtlywz5z6T1aH+9kcGyMJDGisv6CQWLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TPMokfb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DA1C4CEE9;
	Tue, 27 May 2025 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365064;
	bh=R5hLVj+JmJT6JvPi1+0u3PsooaMXKEKlGdOSpfYpReQ=;
	h=Subject:To:Cc:From:Date:From;
	b=TPMokfb8mLmq9sRit8rhZgGuWlV6XZeNNt4X0lM8U1qwzpr3Mfpwh0//j0zsDNRcq
	 jeDf/Q8kro16BKz3mWWnja1Mp/ow1BjKnZkD7WfMDS6UifrWTpH+XJ4cOitB10VRJc
	 9HRFzJdT9fuZIwUBdB60defu0OKRxHRMJLG8rjvU=
Subject: FAILED: patch "[PATCH] x86/mm/init: Handle the special case of device private pages" failed to apply to 5.15-stable tree
To: balbirs@nvidia.com,airlied@gmail.com,akpm@linux-foundation.org,alexander.deucher@amd.com,brgerst@gmail.com,christian.koenig@amd.com,hch@lst.de,hpa@zytor.com,jgross@suse.com,mingo@kernel.org,pierre-eric.pelloux-prayer@amd.com,simona@ffwll.ch,spasswolf@web.de,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 May 2025 18:55:50 +0200
Message-ID: <2025052750-fondness-revocable-a23b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052750-fondness-revocable-a23b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7170130e4c72ce0caa0cb42a1627c635cc262821 Mon Sep 17 00:00:00 2001
From: Balbir Singh <balbirs@nvidia.com>
Date: Tue, 1 Apr 2025 11:07:52 +1100
Subject: [PATCH] x86/mm/init: Handle the special case of device private pages
 in add_pages(), to not increase max_pfn and trigger dma_addressing_limited()
 bounce buffers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As Bert Karwatzki reported, the following recent commit causes a
performance regression on AMD iGPU and dGPU systems:

  7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")

It exposed a bug with nokaslr and zone device interaction.

The root cause of the bug is that, the GPU driver registers a zone
device private memory region. When KASLR is disabled or the above commit
is applied, the direct_map_physmem_end is set to much higher than 10 TiB
typically to the 64TiB address. When zone device private memory is added
to the system via add_pages(), it bumps up the max_pfn to the same
value. This causes dma_addressing_limited() to return true, since the
device cannot address memory all the way up to max_pfn.

This caused a regression for games played on the iGPU, as it resulted in
the DMA32 zone being used for GPU allocations.

Fix this by not bumping up max_pfn on x86 systems, when pgmap is passed
into add_pages(). The presence of pgmap is used to determine if device
private memory is being added via add_pages().

More details:

devm_request_mem_region() and request_free_mem_region() request for
device private memory. iomem_resource is passed as the base resource
with start and end parameters. iomem_resource's end depends on several
factors, including the platform and virtualization. On x86 for example
on bare metal, this value is set to boot_cpu_data.x86_phys_bits.
boot_cpu_data.x86_phys_bits can change depending on support for MKTME.
By default it is set to the same as log2(direct_map_physmem_end) which
is 46 to 52 bits depending on the number of levels in the page table.
The allocation routines used iomem_resource's end and
direct_map_physmem_end to figure out where to allocate the region.

[ arch/powerpc is also impacted by this problem, but this patch does not fix
  the issue for PowerPC. ]

Testing:

 1. Tested on a virtual machine with test_hmm for zone device inseration

 2. A previous version of this patch was tested by Bert, please see:
    https://lore.kernel.org/lkml/d87680bab997fdc9fb4e638983132af235d9a03a.camel@web.de/

[ mingo: Clarified the comments and the changelog. ]

Reported-by: Bert Karwatzki <spasswolf@web.de>
Tested-by: Bert Karwatzki <spasswolf@web.de>
Fixes: 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
Signed-off-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Link: https://lore.kernel.org/r/20250401000752.249348-1-balbirs@nvidia.com

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 519aa53114fa..821a0b53b21c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -959,9 +959,18 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	ret = __add_pages(nid, start_pfn, nr_pages, params);
 	WARN_ON_ONCE(ret);
 
-	/* update max_pfn, max_low_pfn and high_memory */
-	update_end_of_memory_vars(start_pfn << PAGE_SHIFT,
-				  nr_pages << PAGE_SHIFT);
+	/*
+	 * Special case: add_pages() is called by memremap_pages() for adding device
+	 * private pages. Do not bump up max_pfn in the device private path,
+	 * because max_pfn changes affect dma_addressing_limited().
+	 *
+	 * dma_addressing_limited() returning true when max_pfn is the device's
+	 * addressable memory can force device drivers to use bounce buffers
+	 * and impact their performance negatively:
+	 */
+	if (!params->pgmap)
+		/* update max_pfn, max_low_pfn and high_memory */
+		update_end_of_memory_vars(start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
 
 	return ret;
 }


