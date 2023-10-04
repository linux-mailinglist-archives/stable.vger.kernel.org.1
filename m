Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D607B8903
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjJDSVw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbjJDSVw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:21:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF95AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:21:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AACC433C9;
        Wed,  4 Oct 2023 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443707;
        bh=Rccw9v0lL2ypQ4aQIjXfLmmDOjAYtbUdgXaaXI7tJU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKkcs2h+RvkJS43UE2p/VgSAMK7/xv3depi11AwWG1jMu5EMjsH4zHwZ7f39yoeYc
         ENmMGJmuD1ph3pvWLlMNDZEneuchIJF4+jFU2HR+w5Vj3bz+KBAeuaAwXjVAvOvHHS
         vgG+gZkdpx6bnn3ZHo7YdIy/5obz8GmJjWkMtC68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chong Qiao <qiaochong@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1 223/259] LoongArch: numa: Fix high_memory calculation
Date:   Wed,  4 Oct 2023 19:56:36 +0200
Message-ID: <20231004175227.566545277@linuxfoundation.org>
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

commit 1943feecf80e73ecc03ce40271f29c6cea142bac upstream.

For 64bit kernel without HIGHMEM, high_memory is the virtual address of
the highest physical address in the system. But __va(get_num_physpages()
<< PAGE_SHIFT) is not what we want for high_memory because there may be
holes in the physical address space. On the other hand, max_low_pfn is
calculated from memblock_end_of_DRAM(), which is exactly corresponding
to the highest physical address, so use it for high_memory calculation.

Cc: <stable@vger.kernel.org>
Fixes: d4b6f1562a3c3284adce ("LoongArch: Add Non-Uniform Memory Access (NUMA) support")
Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/numa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -453,7 +453,7 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
+	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 	memblock_free_all();
 	setup_zero_pages();	/* This comes from node 0 */
 }


