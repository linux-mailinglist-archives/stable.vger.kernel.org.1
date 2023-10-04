Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227587B88C3
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjJDSTP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjJDSTO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:19:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9363EA7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:19:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC8BC433C7;
        Wed,  4 Oct 2023 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443551;
        bh=XrFUUMWbdS+18imRo1gtru9y2aqOXzy+pkt1+Qr5H3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xen0Y6qlFp89J51UV9MfBjfJZ2ouoeqUlExIvXhX1EsurfxU7U8HWxZwhgRGny2Ki
         IX3MvpRQSgxCPWUxDWmE1FKzwS9wOdHWHn/W/r9xhOqopT3D1XKpr9k4YK34t38NLq
         vq61GFQlGkyoRqr68rKrSZI+Mp72Ewyb9o5zw1us=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, WANG Xuerui <git@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 197/259] LoongArch: Set all reserved memblocks on Node#0 at initialization
Date:   Wed,  4 Oct 2023 19:56:10 +0200
Message-ID: <20231004175226.316681096@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit b795fb9f5861ee256070d59e33130980a01fadd7 ]

After commit 61167ad5fecdea ("mm: pass nid to reserve_bootmem_region()")
we get a panic if DEFERRED_STRUCT_PAGE_INIT is enabled:

[    0.000000] CPU 0 Unable to handle kernel paging request at virtual address 0000000000002b82, era == 90000000040e3f28, ra == 90000000040e3f18
[    0.000000] Oops[#1]:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0+ #733
[    0.000000] pc 90000000040e3f28 ra 90000000040e3f18 tp 90000000046f4000 sp 90000000046f7c90
[    0.000000] a0 0000000000000001 a1 0000000000200000 a2 0000000000000040 a3 90000000046f7ca0
[    0.000000] a4 90000000046f7ca4 a5 0000000000000000 a6 90000000046f7c38 a7 0000000000000000
[    0.000000] t0 0000000000000002 t1 9000000004b00ac8 t2 90000000040e3f18 t3 90000000040f0800
[    0.000000] t4 00000000000f0000 t5 80000000ffffe07e t6 0000000000000003 t7 900000047fff5e20
[    0.000000] t8 aaaaaaaaaaaaaaab u0 0000000000000018 s9 0000000000000000 s0 fffffefffe000000
[    0.000000] s1 0000000000000000 s2 0000000000000080 s3 0000000000000040 s4 0000000000000000
[    0.000000] s5 0000000000000000 s6 fffffefffe000000 s7 900000000470b740 s8 9000000004ad4000
[    0.000000]    ra: 90000000040e3f18 reserve_bootmem_region+0xec/0x21c
[    0.000000]   ERA: 90000000040e3f28 reserve_bootmem_region+0xfc/0x21c
[    0.000000]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[    0.000000]  PRMD: 00000000 (PPLV0 -PIE -PWE)
[    0.000000]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[    0.000000]  ECFG: 00070800 (LIE=11 VS=7)
[    0.000000] ESTAT: 00010800 [PIL] (IS=11 ECode=1 EsubCode=0)
[    0.000000]  BADV: 0000000000002b82
[    0.000000]  PRID: 0014d000 (Loongson-64bit, Loongson-3A6000)
[    0.000000] Modules linked in:
[    0.000000] Process swapper (pid: 0, threadinfo=(____ptrval____), task=(____ptrval____))
[    0.000000] Stack : 0000000000000000 9000000002eb5430 0000003a00000020 90000000045ccd00
[    0.000000]         900000000470e000 90000000002c1918 0000000000000000 9000000004110780
[    0.000000]         00000000fe6c0000 0000000480000000 9000000004b4e368 9000000004110748
[    0.000000]         0000000000000000 900000000421ca84 9000000004620000 9000000004564970
[    0.000000]         90000000046f7d78 9000000002cc9f70 90000000002c1918 900000000470e000
[    0.000000]         9000000004564970 90000000040bc0e0 90000000046f7d78 0000000000000000
[    0.000000]         0000000000004000 90000000045ccd00 0000000000000000 90000000002c1918
[    0.000000]         90000000002c1900 900000000470b700 9000000004b4df78 9000000004620000
[    0.000000]         90000000046200a8 90000000046200a8 0000000000000000 9000000004218b2c
[    0.000000]         9000000004270008 0000000000000001 0000000000000000 90000000045ccd00
[    0.000000]         ...
[    0.000000] Call Trace:
[    0.000000] [<90000000040e3f28>] reserve_bootmem_region+0xfc/0x21c
[    0.000000] [<900000000421ca84>] memblock_free_all+0x114/0x350
[    0.000000] [<9000000004218b2c>] mm_core_init+0x138/0x3cc
[    0.000000] [<9000000004200e38>] start_kernel+0x488/0x7a4
[    0.000000] [<90000000040df0d8>] kernel_entry+0xd8/0xdc
[    0.000000]
[    0.000000] Code: 02eb21ad  00410f4c  380c31ac <262b818d> 6800b70d  02c1c196  0015001c  57fe4bb1  260002cd

The reason is early memblock_reserve() in memblock_init() set node id to
MAX_NUMNODES, making NODE_DATA(nid) a NULL dereference in the call chain
reserve_bootmem_region() -> init_reserved_page(). After memblock_init(),
those late calls of memblock_reserve() operate on subregions of memblock
.memory regions. As a result, these reserved regions will be set to the
correct node at the first iteration of memmap_init_reserved_pages().

So set all reserved memblocks on Node#0 at initialization can avoid this
panic.

Reported-by: WANG Xuerui <git@xen0n.name>
Tested-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: WANG Xuerui <git@xen0n.name>  # with nits addressed
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/mem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
index 4a4107a6a9651..aed901c57fb43 100644
--- a/arch/loongarch/kernel/mem.c
+++ b/arch/loongarch/kernel/mem.c
@@ -50,7 +50,6 @@ void __init memblock_init(void)
 	}
 
 	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
-	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
 
 	/* Reserve the first 2MB */
 	memblock_reserve(PHYS_OFFSET, 0x200000);
@@ -58,4 +57,7 @@ void __init memblock_init(void)
 	/* Reserve the kernel text/data/bss */
 	memblock_reserve(__pa_symbol(&_text),
 			 __pa_symbol(&_end) - __pa_symbol(&_text));
+
+	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
+	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.reserved, 0);
 }
-- 
2.40.1



