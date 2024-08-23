Return-Path: <stable+bounces-70005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6833A95CF17
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257E4281D9D
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851711991CA;
	Fri, 23 Aug 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCdMj/+d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337D188906;
	Fri, 23 Aug 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421828; cv=none; b=mXuVKq3hzzOJDbtj0EsuKHYsFLDpTwet+gjxxgUTsjUlGQe7HcFRuGv414ACkH1eOZQmuS6HSmdsq7OLbeETQjU3QqKP20iGIfrXN1X55603KSnYtS9UvbeoqJCBXVge670B+bAG0phnYVgYw7GSPdq19+rqEGSQ5GVMfXetpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421828; c=relaxed/simple;
	bh=Pf5doyZj52sYU4ZkPBSvPV+8vO0qg1sLFS+ArTntM9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa5EmKNTZTKOE9O37OBlIpoB/RlNhXuDrD/XtMkST2rV9qbdR2FGRiKPeyWe4ffEoWzqeLRbqIpAVPS5XwCKaaS0cVc4RrmVBZDqQUaMLYv4gbY4jqgK2FG/VuB5yLNtPGWmEScMK6VkF9AW6Gj23YrRzGyloOyYZpckxkC47ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCdMj/+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CB2C4AF09;
	Fri, 23 Aug 2024 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421828;
	bh=Pf5doyZj52sYU4ZkPBSvPV+8vO0qg1sLFS+ArTntM9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCdMj/+dpinNjVQRIjaF8ETG5e28uQsJj1yLZQbZC10aXoBNzKa7Tmji4ayvbiEZn
	 JFwig4yCBefVY4aIhfEgtkTjVxGt0pg3L/kp/RBIWLIbDS8tzhfh0NoqyUuR/ncHbm
	 kge0U6Gd5nsEiGEmjm9ZBWlTzgdEmiyJ55abf14hNCFJR8GS9qdC3c9zP51tkicNKz
	 gAJ4kxpdhJwjpAqQZBqsNcjx/0yCA7M4NXdwtBogudeAxhUUxa8j4yf0II9AlsKb1a
	 TYvnhDO8D3d9CCE86CVU6cPZe1GXxLwgWBID129bFv8rEVz88H//7XBfx15q47L9eb
	 o4zDg4t0+hFGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	hbathini@linux.ibm.com,
	thorsten.blum@toblux.com,
	rostedt@goodmis.org,
	bhe@redhat.com,
	arnd@arndb.de,
	philmd@linaro.org,
	rppt@kernel.org,
	kent.overstreet@linux.dev,
	tzimmermann@suse.de,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 14/20] powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL
Date: Fri, 23 Aug 2024 10:02:28 -0400
Message-ID: <20240823140309.1974696-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
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
index 20f72cd1d8138..03eaad5949f14 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -950,6 +950,7 @@ void __init setup_arch(char **cmdline_p)
 	mem_topology_setup();
 	/* Set max_mapnr before paging_init() */
 	set_max_mapnr(max_pfn);
+	high_memory = (void *)__va(max_low_pfn * PAGE_SIZE);
 
 	/*
 	 * Release secondary cpus out of their spinloops at 0x60 now that
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 07e8f4f1e07f8..9dbef559af4cb 100644
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


