Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304587E23A9
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjKFNNc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjKFNNX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:13:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB907BF
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:13:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBD0C433C8;
        Mon,  6 Nov 2023 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276400;
        bh=NLfr0Z24RYpRYf49x9WP4bcTYxhN0XGCEh41C8lAmc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2xv7H+VOstro7O75HXMdsowOV1J8erMb5y7WGwC/IA12DXBKAHH0lo8glICSbO/q
         7bPKhapqsWhLcYV0tbso0Pb3t9Ibu/P68dX+I6CVXPJrY+OU15Ve/unv9iuz5e+9Lq
         0XUneYS4nS3xtK/am4IMFKgpiAGNPkGX1utbcJAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Tianrui Zhao <zhaotianrui@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 29/62] LoongArch: Export symbol invalid_pud_table for modules building
Date:   Mon,  6 Nov 2023 14:03:35 +0100
Message-ID: <20231106130302.865274219@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 449c2756c2323c9e32b2a2fa9c8b59ce91b5819d ]

Export symbol invalid_pud_table for modules building (such as the KVM
module) if 4-level page tables enabled. Otherwise we get:

ERROR: modpost: "invalid_pud_table" [arch/loongarch/kvm/kvm.ko] undefined!

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index c7e9c96719fa3..c74da7770e39e 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -228,6 +228,7 @@ pgd_t swapper_pg_dir[_PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
 pgd_t invalid_pg_dir[_PTRS_PER_PGD] __page_aligned_bss;
 #ifndef __PAGETABLE_PUD_FOLDED
 pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligned_bss;
+EXPORT_SYMBOL(invalid_pud_table);
 #endif
 #ifndef __PAGETABLE_PMD_FOLDED
 pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
-- 
2.42.0



