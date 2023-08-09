Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB97877574E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHIKod (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHIKob (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:44:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C4F1702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8AC6311F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9F4C433CA;
        Wed,  9 Aug 2023 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577869;
        bh=5ED8FF5WWz6g2COwBH30fekqIPsl5L9cjALjcG+GOdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FvYSP2o2kJXfbTa86jFhXB8Mb+ddzAziTrLRGgg7guEd0awk/rswDhMPmD/IZKlV
         EQWplSoO0M4wi7/CTUIYTkbmjnkq7sqxYdhaR9dMgFV49fVxfxiyuWsG+CjUytSxil
         bb+n0rKsBHUoIb25H7PSmWZbJOpWn9SlLzhFfdyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 023/165] s390/vmem: split pages when debug pagealloc is enabled
Date:   Wed,  9 Aug 2023 12:39:14 +0200
Message-ID: <20230809103643.564517762@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit edc1e4b6e26536868ef819a735e04a5b32c10589 ]

Since commit bb1520d581a3 ("s390/mm: start kernel with DAT enabled")
the kernel crashes early during boot when debug pagealloc is enabled:

mem auto-init: stack:off, heap alloc:off, heap free:off
addressing exception: 0005 ilc:2 [#1] SMP DEBUG_PAGEALLOC
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0-rc3-09759-gc5666c912155 #630
[..]
Krnl Code: 00000000001325f6: ec5600248064 cgrj %r5,%r6,8,000000000013263e
           00000000001325fc: eb880002000c srlg %r8,%r8,2
          #0000000000132602: b2210051     ipte %r5,%r1,%r0,0
          >0000000000132606: b90400d1     lgr %r13,%r1
           000000000013260a: 41605008     la %r6,8(%r5)
           000000000013260e: a7db1000     aghi %r13,4096
           0000000000132612: b221006d     ipte %r6,%r13,%r0,0
           0000000000132616: e3d0d0000171 lay %r13,4096(%r13)

Call Trace:
 __kernel_map_pages+0x14e/0x320
 __free_pages_ok+0x23a/0x5a8)
 free_low_memory_core_early+0x214/0x2c8
 memblock_free_all+0x28/0x58
 mem_init+0xb6/0x228
 mm_core_init+0xb6/0x3b0
 start_kernel+0x1d2/0x5a8
 startup_continue+0x36/0x40
Kernel panic - not syncing: Fatal exception: panic_on_oops

This is caused by using large mappings on machines with EDAT1/EDAT2. Add
the code to split the mappings into 4k pages if debug pagealloc is enabled
by CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT or the debug_pagealloc kernel
command line option.

Fixes: bb1520d581a3 ("s390/mm: start kernel with DAT enabled")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/vmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b9dcb4ae6c59a..05f4912380fac 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -761,6 +761,8 @@ void __init vmem_map_init(void)
 	if (static_key_enabled(&cpu_has_bear))
 		set_memory_nx(0, 1);
 	set_memory_nx(PAGE_SIZE, 1);
+	if (debug_pagealloc_enabled())
+		set_memory_4k(0, ident_map_size >> PAGE_SHIFT);
 
 	pr_info("Write protected kernel read-only data: %luk\n",
 		(unsigned long)(__end_rodata - _stext) >> 10);
-- 
2.40.1



