Return-Path: <stable+bounces-140379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DFAAA811
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B8717769D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C53464BE;
	Mon,  5 May 2025 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ9E8Udp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A53464AC;
	Mon,  5 May 2025 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484729; cv=none; b=tzbZG7X7wsxcWedT2qHFm9B8qo4jsqVZbOZ90dcmeZ0asNevPKuLeNIQ9C/otE723qBrs7DZcFggIE+uZhxvc6I1UKsSuIFaPIpv98PnX1xFevOLKuAGP28D87hPZ6zJw67OocOF8f0/cLSdWluja1wp92yGBN/LA5Di/Jmvq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484729; c=relaxed/simple;
	bh=CsvS6II9oVJ5boEsLo9m0bMgICzv2jJ+IxHrPSipucg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhFWhKwHxvb43t5dVBAQs4rWxKA9WsWL6tP6qZI4i/QdyOuhM0CDs4nCnPhfvY633PL2ePruiWsH9Ks1qNLzZNi4wFEc5boknO2ynKnMk33F2S5x8VXTzq+gYZrWgwd3nD1keTIF2fx0ivyzlOv14ICKOljHqZQJX/ZEibt+qnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ9E8Udp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C57EC4CEED;
	Mon,  5 May 2025 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484728;
	bh=CsvS6II9oVJ5boEsLo9m0bMgICzv2jJ+IxHrPSipucg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZ9E8UdpLGmLxWchQed0wwZEr4aYzSsM+PgnMD9vTaYHb4sEr5+5X83OfOnNmCuGG
	 41hrDYrqscdY9Ztmr96MGoo69uk+MFb4Tj7rzW/UhA5IwqLLKnX5qLsu5GqCE/7aTi
	 gUIs3Qf2X2ot9UFeNuJeyJj44xQz2y35BegbpVAm/kR26T3Vn2JGbRWvK+tXHlTRBn
	 SmwJ6mqN5pdL+7whQVkEEIjo77rw5oXpLI0WDHYCOztQdLmn639vUrdKkObN2BAeFy
	 AAP5sIsklsKxffrxO3W1873S3bt7UzqvYjlZMUFGKpT4Z+yvhDlYe/LpQSudvHowtn
	 r8+qXZnYWJ0IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Balbir Singh <balbirs@nvidia.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	bhelgaas@google.com,
	kees@kernel.org
Subject: [PATCH AUTOSEL 6.14 630/642] x86/mm/init: Handle the special case of device private pages in add_pages(), to not increase max_pfn and trigger dma_addressing_limited() bounce buffers
Date: Mon,  5 May 2025 18:14:06 -0400
Message-Id: <20250505221419.2672473-630-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Balbir Singh <balbirs@nvidia.com>

[ Upstream commit 7170130e4c72ce0caa0cb42a1627c635cc262821 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/init_64.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df3036..17c89dad4f7ff 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -967,9 +967,18 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
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
-- 
2.39.5


