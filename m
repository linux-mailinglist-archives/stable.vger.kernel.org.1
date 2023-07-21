Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918F575D4FA
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGUT1I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGUT1H (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A633A82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CADD61D5C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0000C433C9;
        Fri, 21 Jul 2023 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967609;
        bh=yCtRCcKJvemSyJ7Qpgn3h+W1BSH1bLS7t//DEQ3eAmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBvFsCsZ34HS+D9KMDmthRPCtkpRRBLk6DSd87iNZdD5Mvg7PLLvwHEL3Pp3+MUBZ
         w0CoiDzF08qQjDedXDFqs9GzGBAU4P7mEqcmh5Z0KnNNa8t/dyP4bUH4pa0gcdJajz
         cZX4r2Hqp9CjLW+aW2a4qMdHCjD+QgdKS1FvZbC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Subject: [PATCH 6.1 222/223] swiotlb: mark swiotlb_memblock_alloc() as __init
Date:   Fri, 21 Jul 2023 18:07:55 +0200
Message-ID: <20230721160530.333242277@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

commit 9b07d27d0fbb7f7441aa986859a0f53ec93a0335 upstream.

swiotlb_memblock_alloc() calls memblock_alloc(), which calls
(__init) memblock_alloc_try_nid(). However, swiotlb_membloc_alloc()
can be marked as __init since it is only called by swiotlb_init_remap(),
which is already marked as __init. This prevents a modpost build
warning/error:

WARNING: modpost: vmlinux.o: section mismatch in reference: swiotlb_memblock_alloc (section: .text) -> memblock_alloc_try_nid (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: swiotlb_memblock_alloc (section: .text) -> memblock_alloc_try_nid (section: .init.text)

This fixes the build warning/error seen on ARM64, PPC64, S390, i386,
and x86_64.

Fixes: 8d58aa484920 ("swiotlb: reduce the swiotlb buffer size on allocation failure")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/dma/swiotlb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -324,7 +324,8 @@ static void swiotlb_init_io_tlb_mem(stru
 	return;
 }
 
-static void *swiotlb_memblock_alloc(unsigned long nslabs, unsigned int flags,
+static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
+		unsigned int flags,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
 	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);


