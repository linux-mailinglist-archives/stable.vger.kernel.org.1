Return-Path: <stable+bounces-83559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0796999B3F3
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C1DB217D8
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD271D1F60;
	Sat, 12 Oct 2024 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGpBLTAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3D155330;
	Sat, 12 Oct 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732521; cv=none; b=c8FZBy9ilUCNNUKDoggB1lkSd7DU3uvVg7w9KzW8Ek7yVvRlQEmw6MYCiCtxSHMY7yQUdmM2WNZAubCLX+LSK/GC/wGaRZNa+teH0f5zW0qNVpB2Lf8fjjO9Of/LtZFMkdpNq+slxHBt77bHfmrxh39oYWfC9mgrccRxSVKBthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732521; c=relaxed/simple;
	bh=ZTPbxuQvV6jqCBSrT0OYW3+1G2s/lDk827YHZs04KpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1CxgAnqK3KD2KGztU59tBKXjdUS3Jjw2HI1eJ2yGjVkM9zoWqMfnL74Tb+T1BTkmtzzcwyzR8v4yb5oZBsll709XMJrYUyCphfgUvPdqimKZ+iEEwdaSwlcHYgifOhqH5x4z0qnFwC+aQcoutUzexgdl8O4vcQRbB5RuCG5/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGpBLTAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF4CC4CECE;
	Sat, 12 Oct 2024 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732521;
	bh=ZTPbxuQvV6jqCBSrT0OYW3+1G2s/lDk827YHZs04KpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGpBLTAdroY5rs/G2aI15Hjc/NgEopx27oLLoah/GawY/vyTJcCkZJ7duWn7DMgYk
	 AcBh/pgwmtLZtb80jvas3WilVemopqBNQ9rung3gCyowBwKbv5MsduJbV9zcadi8ni
	 sriBiE0E7hNdnpE+ePXjDv6qmWlJicAwz4SIb2AgxnO2O3q4OX2yi2WR7KwQ5zcGyw
	 LZrRfu8Dxu8AxyMW1NnLtOn7oAYVROjtjkS5WcsK5GM2HqV7449/WqgKwygvimgx73
	 p9Njye5IFdNEodtnoa795k6lXZuhRvbIhg8YIxn1Wkw0aNME3GS4e+o5evtSxK4eHA
	 ZGbN03/keiTeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	hbathini@linux.ibm.com,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	bhe@redhat.com,
	arnd@arndb.de,
	willy@infradead.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	tzimmermann@suse.de,
	kent.overstreet@linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.1 09/13] powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL
Date: Sat, 12 Oct 2024 07:27:58 -0400
Message-ID: <20241012112818.1763719-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112818.1763719-1-sashal@kernel.org>
References: <20241012112818.1763719-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit e7e846dc6c73fbc94ae8b4ec20d05627646416f2 ]

Booting with CONFIG_DEBUG_VIRTUAL leads to following warning when
passing hugepage reservation on command line:

  Kernel command line: hugepagesz=1g hugepages=1 hugepagesz=64m hugepages=1 hugepagesz=256m hugepages=1 noreboot
  HugeTLB: allocating 1 of page size 1.00 GiB failed.  Only allocated 0 hugepages.
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at arch/powerpc/include/asm/io.h:948 __alloc_bootmem_huge_page+0xd4/0x284
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0-rc6-00396-g6b0e82791bd0-dirty #936
  Hardware name: MPC8544DS e500v2 0x80210030 MPC8544 DS
  NIP:  c1020240 LR: c10201d0 CTR: 00000000
  REGS: c13fdd30 TRAP: 0700   Not tainted  (6.10.0-rc6-00396-g6b0e82791bd0-dirty)
  MSR:  00021000 <CE,ME>  CR: 44084288  XER: 20000000

  GPR00: c10201d0 c13fde20 c130b560 e8000000 e8001000 00000000 00000000 c1420000
  GPR08: 00000000 00028001 00000000 00000004 44084282 01066ac0 c0eb7c9c efffe149
  GPR16: c0fc4228 0000005f ffffffff c0eb7d0c c0eb7cc0 c0eb7ce0 ffffffff 00000000
  GPR24: c1441cec efffe153 e8001000 c14240c0 00000000 c1441d64 00000000 e8000000
  NIP [c1020240] __alloc_bootmem_huge_page+0xd4/0x284
  LR [c10201d0] __alloc_bootmem_huge_page+0x64/0x284
  Call Trace:
  [c13fde20] [c10201d0] __alloc_bootmem_huge_page+0x64/0x284 (unreliable)
  [c13fde50] [c10207b8] hugetlb_hstate_alloc_pages+0x8c/0x3e8
  [c13fdeb0] [c1021384] hugepages_setup+0x240/0x2cc
  [c13fdef0] [c1000574] unknown_bootoption+0xfc/0x280
  [c13fdf30] [c0078904] parse_args+0x200/0x4c4
  [c13fdfa0] [c1000d9c] start_kernel+0x238/0x7d0
  [c13fdff0] [c0000434] set_ivor+0x12c/0x168
  Code: 554aa33e 7c042840 3ce0c142 80a7427c 5109a016 50caa016 7c9a2378 7fdcf378 4180000c 7c052040 41810160 7c095040 <0fe00000> 38c00000 40800108 3c60c0eb
  ---[ end trace 0000000000000000 ]---

This is due to virt_addr_valid() using high_memory before it is set.

high_memory is set in mem_init() using max_low_pfn, but max_low_pfn
is available long before, it is set in mem_topology_setup(). So just
like commit daa9ada2093e ("powerpc/mm: Fix boot crash with FLATMEM")
moved the setting of max_mapnr immediately after the call to
mem_topology_setup(), the same can be done for high_memory.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/62b69c4baad067093f39e7e60df0fe27a86b8d2a.1723100702.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/setup-common.c | 1 +
 arch/powerpc/mm/mem.c              | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 59b4ac57bfaf7..56f6b958926d7 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -948,6 +948,7 @@ void __init setup_arch(char **cmdline_p)
 	mem_topology_setup();
 	/* Set max_mapnr before paging_init() */
 	set_max_mapnr(max_pfn);
+	high_memory = (void *)__va(max_low_pfn * PAGE_SIZE);
 
 	/*
 	 * Release secondary cpus out of their spinloops at 0x60 now that
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c7599b1737099..40f4a31f001c2 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -287,8 +287,6 @@ void __init mem_init(void)
 	swiotlb_init(ppc_swiotlb_enable, ppc_swiotlb_flags);
 #endif
 
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-
 	kasan_late_init();
 
 	memblock_free_all();
-- 
2.43.0


