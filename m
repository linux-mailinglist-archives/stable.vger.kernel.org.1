Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E396FC713
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjEIMv5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 08:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjEIMv4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 08:51:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898552D59
        for <stable@vger.kernel.org>; Tue,  9 May 2023 05:51:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso3180294f8f.0
        for <stable@vger.kernel.org>; Tue, 09 May 2023 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683636710; x=1686228710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fIRJ3tMbu1kEKHicGn7aNqHPuLMGYkIYm5dUP4PgE7E=;
        b=yPjLeVDCgLXB3qhHZo7tFpYH3aJE6pz3KGf2TkDACAHQvFX5Eo3IEtaPgPj9EP90cD
         LrMVAPn54Duu7Mc2pukHlShMIcJE6OH6huUwbcrlX/839YsVHckOTA6Ldwj6nltGZOHm
         MtgahIoVAJQquOwWSfLs9gCcC57lfgv468nMG753UCZcJoBjOYYWSiXNWZvUEtuYoj7e
         Z49PDGEwWlre6RmaafE8nuezMhGLTUWUeAKUzNaphY+RGy/Hu998TKwQDnzo5MZVMEjl
         7mKE2FkISYuDCeVo/v8sLqu8pFRuXI90xcgz0KwBPSHiYH1GDHmOMzzl1+bpkgvwMpMF
         Ynxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683636710; x=1686228710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIRJ3tMbu1kEKHicGn7aNqHPuLMGYkIYm5dUP4PgE7E=;
        b=B4AFeYZeMJL4Bb+grkA8S9H1j3KAhq1vDfOXZpWNtKxcwTVy1u4Mh5/Jm6Q7t/jH7V
         353JmzkyUF+NyLWyPlFrGEY4UEr59TFbCRReuz7r4kb+fj76ObQ90h/2iv7F9M9Dreub
         C/A+KTEh1CcukFxq4hVBUB7Q6s5f44UpN5vpS+1QpsDD3XOPcTCkvfLIc1am2gGK/Z+Y
         3wf1MRBVPDkI3ESv6281BzJVkCaTXqU4UZHFmeTWWeaqC10rmEZZXtKs+DZONXpQIxdZ
         aH7TFtZPDMoZ9EWIi84mX4DIMDf1gw4OlU8GYZ62BkKemfnbYK+HmJe6AS2QLYSfKyd0
         j/bA==
X-Gm-Message-State: AC+VfDywodxVhTV6x2qVSrM0ArHhQ6uc+iSN2mnzNXdHZZWcqsRihOKG
        bQ1e1NARUMjJq8DXObp6DwJ8YyqbJeCs6qcqJFg=
X-Google-Smtp-Source: ACHHUZ4j9+YZEOybBKRrGkxJd3xOcGyAokDMpAbrHKlVbbT89qoBbzZ5yexf0f2MtUWaNojUjOL7yg==
X-Received: by 2002:a5d:6b41:0:b0:307:14a6:ef97 with SMTP id x1-20020a5d6b41000000b0030714a6ef97mr9905270wrw.67.1683636709795;
        Tue, 09 May 2023 05:51:49 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id s6-20020adff806000000b003068f5cca8csm14131733wrp.94.2023.05.09.05.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 05:51:49 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        kernel test robot <lkp@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 5.15.110 v2] RISC-V: Fix up a cherry-pick warning in setup_vm_final()
Date:   Tue,  9 May 2023 14:51:41 +0200
Message-Id: <20230509125141.95587-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This triggers a -Wdeclaration-after-statement as the code has changed a
bit since upstream.  It might be better to hoist the whole block up, but
this is a smaller change so I went with it.

arch/riscv/mm/init.c:755:16: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
             unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
                           ^
     1 warning generated.

Fixes: bbf94b042155 ("riscv: Move early dtb mapping into the fixmap region")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304300429.SXZOA5up-lkp@intel.com/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

v2:
- Fix rv64 warning introduced by the v1
- Add Fixes tag

 arch/riscv/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e800d7981e99..a382623e91cf 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -716,6 +716,7 @@ static void __init setup_vm_final(void)
 {
 	uintptr_t va, map_size;
 	phys_addr_t pa, start, end;
+	unsigned long idx __maybe_unused;
 	u64 i;
 
 	/**
@@ -735,7 +736,7 @@ static void __init setup_vm_final(void)
 	 * directly in swapper_pg_dir in addition to the pgd entry that points
 	 * to fixmap_pte.
 	 */
-	unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
+	idx = pgd_index(__fix_to_virt(FIX_FDT));
 
 	set_pgd(&swapper_pg_dir[idx], early_pg_dir[idx]);
 #endif
-- 
2.37.2

