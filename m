Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7175D312
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGUTGq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjGUTGp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:06:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787F830D7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1355861D90
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B7BC433C8;
        Fri, 21 Jul 2023 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966403;
        bh=IBJfLhpbY5oWgvUV83BonFzR6Szn7t/yWSuUjp0T0f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AGyIRzLOjXNASDNwpManXgskfOlQ9ArjgavGSOrhJ9zBiQlp1n1wyrfbWzzOD0XjQ
         BzWonJERLkgny8Zg8ErXatZZXEMqBgwI3z1Rq53qgj1DAXo2qvcePkMl3ggCULyAt2
         x89FOVYhODTPcE8VTpp8LORNDod8OAYLqC/Yv4h0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Woody Zhang <woodylab@foxmail.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 332/532] riscv: move memblock_allow_resize() after linear mapping is ready
Date:   Fri, 21 Jul 2023 18:03:56 +0200
Message-ID: <20230721160632.429331435@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Woody Zhang <woodylab@foxmail.com>

[ Upstream commit 85fadc0d04119c2fe4a20287767ab904c6d21ba1 ]

The initial memblock metadata is accessed from kernel image mapping. The
regions arrays need to "reallocated" from memblock and accessed through
linear mapping to cover more memblock regions. So the resizing should
not be allowed until linear mapping is ready. Note that there are
memblock allocations when building linear mapping.

This patch is similar to 24cc61d8cb5a ("arm64: memblock: don't permit
memblock resizing until linear mapping is up").

In following log, many memblock regions are reserved before
create_linear_mapping_page_table(). And then it triggered reallocation
of memblock.reserved.regions and memcpy the old array in kernel image
mapping to the new array in linear mapping which caused a page fault.

[    0.000000] memblock_reserve: [0x00000000bf01f000-0x00000000bf01ffff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf021000-0x00000000bf021fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf023000-0x00000000bf023fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf025000-0x00000000bf025fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf027000-0x00000000bf027fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf029000-0x00000000bf029fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf02b000-0x00000000bf02bfff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf02d000-0x00000000bf02dfff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf02f000-0x00000000bf02ffff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf030000-0x00000000bf030fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] OF: reserved mem: 0x0000000080000000..0x000000008007ffff (512 KiB) map non-reusable mmode_resv0@80000000
[    0.000000] memblock_reserve: [0x00000000bf000000-0x00000000bf001fed] paging_init+0x19a/0x5ae
[    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
[    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
[    0.000000] memblock: reserved is doubled to 256 at [0x000000017fffd000-0x000000017fffe7ff]
[    0.000000] Unable to handle kernel paging request at virtual address ff600000ffffd000
[    0.000000] Oops [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc1-00011-g99a670b2069c #66
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] epc : __memcpy+0x60/0xf8
[    0.000000]  ra : memblock_double_array+0x192/0x248
[    0.000000] epc : ffffffff8081d214 ra : ffffffff80a3dfc0 sp : ffffffff81403bd0
[    0.000000]  gp : ffffffff814fbb38 tp : ffffffff8140dac0 t0 : 0000000001600000
[    0.000000]  t1 : 0000000000000000 t2 : 000000008f001000 s0 : ffffffff81403c60
[    0.000000]  s1 : ffffffff80c0bc98 a0 : ff600000ffffd000 a1 : ffffffff80c0bcd8
[    0.000000]  a2 : 0000000000000c00 a3 : ffffffff80c0c8d8 a4 : 0000000080000000
[    0.000000]  a5 : 0000000000080000 a6 : 0000000000000000 a7 : 0000000080200000
[    0.000000]  s2 : ff600000ffffd000 s3 : 0000000000002000 s4 : 0000000000000c00
[    0.000000]  s5 : ffffffff80c0bc60 s6 : ffffffff80c0bcc8 s7 : 0000000000000000
[    0.000000]  s8 : ffffffff814fd0a8 s9 : 000000017fffe7ff s10: 0000000000000000
[    0.000000]  s11: 0000000000001000 t3 : 0000000000001000 t4 : 0000000000000000
[    0.000000]  t5 : 000000008f003000 t6 : ff600000ffffd000
[    0.000000] status: 0000000200000100 badaddr: ff600000ffffd000 cause: 000000000000000f
[    0.000000] [<ffffffff8081d214>] __memcpy+0x60/0xf8
[    0.000000] [<ffffffff80a3e1a2>] memblock_add_range.isra.14+0x12c/0x162
[    0.000000] [<ffffffff80a3e36a>] memblock_reserve+0x6e/0x8c
[    0.000000] [<ffffffff80a123fc>] memblock_alloc_range_nid+0xb8/0x128
[    0.000000] [<ffffffff80a1256a>] memblock_phys_alloc_range+0x5e/0x6a
[    0.000000] [<ffffffff80a04732>] alloc_pmd_fixmap+0x14/0x1c
[    0.000000] [<ffffffff80a0475a>] alloc_p4d_fixmap+0xc/0x14
[    0.000000] [<ffffffff80a04a36>] create_pgd_mapping+0x98/0x17c
[    0.000000] [<ffffffff80a04e9e>] create_linear_mapping_range.constprop.10+0xe4/0x112
[    0.000000] [<ffffffff80a05bb8>] paging_init+0x3ec/0x5ae
[    0.000000] [<ffffffff80a03354>] setup_arch+0xb2/0x576
[    0.000000] [<ffffffff80a00726>] start_kernel+0x72/0x57e
[    0.000000] Code: b303 0285 b383 0305 be03 0385 be83 0405 bf03 0485 (b023) 00ef
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
Signed-off-by: Woody Zhang <woodylab@foxmail.com>
Tested-by: Song Shuai <songshuaishuai@tinylab.org>
Link: https://lore.kernel.org/r/tencent_FBB94CE615C5CCE7701CD39C15CCE0EE9706@qq.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0afcd4ae7eed1..f8bfbe983517c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -235,7 +235,6 @@ static void __init setup_bootmem(void)
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-	memblock_allow_resize();
 }
 
 #ifdef CONFIG_MMU
@@ -868,6 +867,9 @@ void __init paging_init(void)
 {
 	setup_bootmem();
 	setup_vm_final();
+
+	/* Depend on that Linear Mapping is ready */
+	memblock_allow_resize();
 }
 
 void __init misc_mem_init(void)
-- 
2.39.2



