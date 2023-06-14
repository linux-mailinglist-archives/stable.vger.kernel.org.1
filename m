Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBBF726F49
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjFGU5J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjFGU5E (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB091BC2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5453361E93
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6475CC433EF;
        Wed,  7 Jun 2023 20:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171421;
        bh=/840ehDzQSLi86VHWNeeUFZTr0TQbQP5QqZdVg4nCYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+fKVclXxXYgqIc1eF/zXd+poT7slv6ID8h8dH3Uvh9y8MjattQuRDl84of+aoYw8
         Edj1nyAyfe0jKV+f9hqiM5UGVewgOyuDZhFZrW1ySFMIrNQn0rWwZM4zw1qK1KMYQx
         +4hAU1L7P6w8I9nBCDIKz1u3iDAim4HrwA+wO8c4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 012/159] riscv: Fix unused variable warning when BUILTIN_DTB is set
Date:   Wed,  7 Jun 2023 22:15:15 +0200
Message-ID: <20230607200904.074279546@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit 33d418da6f476b15e4510e0a590062583f63cd36 ]

commit ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap
region") wrongly moved the #ifndef CONFIG_BUILTIN_DTB surrounding the pa
variable definition in create_fdt_early_page_table(), so move it back to
its right place to quiet the following warning:

../arch/riscv/mm/init.c: In function ‘create_fdt_early_page_table’:
../arch/riscv/mm/init.c:925:12: warning: unused variable ‘pa’ [-Wunused-variable]
  925 |  uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);

Fixes: ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap region")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230519131311.391960-1-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d8f37034c092d..0afcd4ae7eed1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -572,9 +572,9 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
 static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 					       uintptr_t dtb_pa)
 {
+#ifndef CONFIG_BUILTIN_DTB
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
 
-#ifndef CONFIG_BUILTIN_DTB
 	/* Make sure the fdt fixmap address is always aligned on PMD size */
 	BUILD_BUG_ON(FIX_FDT % (PMD_SIZE / PAGE_SIZE));
 
-- 
2.39.2



