Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8FC726B02
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjFGUVp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjFGUVh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC0B1FE2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB31064392
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E9FC433D2;
        Wed,  7 Jun 2023 20:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169274;
        bh=RBNaXX8tonXjQ0R73cRRpqWvJyxYNaT+FfaI3gU6k04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c79YLTJp+/zyivjiWq8R+1gW09xRjgw16AsqQBsfZknfw6GozMZdSivSruhX/jmWO
         8T9y7+6FBGHYsB/9ECJW6Z8V3BNZcYuY5PQg9PkXK4V7fc5Eq9otFeTfDJ5jktBcq6
         3Q+Yss3hBmb8MH4ZdALQk6ZU499XgnPNO6HrbTBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 019/286] riscv: Fix unused variable warning when BUILTIN_DTB is set
Date:   Wed,  7 Jun 2023 22:11:58 +0200
Message-ID: <20230607200923.637621712@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 6ebb75a9a6b9f..dc1793bf01796 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -846,9 +846,9 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
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



