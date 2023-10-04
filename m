Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE087B889E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbjJDSR4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbjJDSR4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:17:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9F1C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:17:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C35C433C7;
        Wed,  4 Oct 2023 18:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443472;
        bh=noCEahlCuQdE46oCy/jwi5CS9pdId4l8S+yt3xxMGSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHNB0QV1JJtG/irmoA2gYD/CkC0KjkgziBWfkgEspBZqfiIqLBtu7Nzi76PGXw9dn
         GgkyKL+tKsQ9EWqDP9e/susulH7MYtrPDhhjYAmpA58zBSsyaex9Wjb7UvqK2w2uQ3
         Ijmb3XWZ+gMxrFXGq0nJB0w9NvqZNCyHQOTbOLC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Icenowy Zheng <uwu@icenowy.me>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 169/259] riscv: errata: fix T-Head dcache.cva encoding
Date:   Wed,  4 Oct 2023 19:55:42 +0200
Message-ID: <20231004175225.035925326@linuxfoundation.org>
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

From: Icenowy Zheng <uwu@icenowy.me>

[ Upstream commit 8eb8fe67e2c84324398f5983c41b4f831d0705b3 ]

The dcache.cva encoding shown in the comments are wrong, it's for
dcache.cval1 (which is restricted to L1) instead.

Fix this in the comment and in the hardcoded instruction.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Guo Ren <guoren@kernel.org>
Tested-by: Drew Fustini <dfustini@baylibre.com>
Link: https://lore.kernel.org/r/20230912072410.2481-1-jszhang@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/errata_list.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 19a771085781a..7d2675bb71611 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -100,7 +100,7 @@ asm volatile(ALTERNATIVE(						\
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
  *   0000001    01001      rs1       000      00000  0001011
  * dcache.cva rs1 (clean, virtual address)
- *   0000001    00100      rs1       000      00000  0001011
+ *   0000001    00101      rs1       000      00000  0001011
  *
  * dcache.cipa rs1 (clean then invalidate, physical address)
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
@@ -113,7 +113,7 @@ asm volatile(ALTERNATIVE(						\
  *   0000000    11001     00000      000      00000  0001011
  */
 #define THEAD_inval_A0	".long 0x0265000b"
-#define THEAD_clean_A0	".long 0x0245000b"
+#define THEAD_clean_A0	".long 0x0255000b"
 #define THEAD_flush_A0	".long 0x0275000b"
 #define THEAD_SYNC_S	".long 0x0190000b"
 
-- 
2.40.1



