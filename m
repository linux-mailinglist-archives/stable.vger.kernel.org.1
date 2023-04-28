Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CF6F1549
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345847AbjD1KYH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 06:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbjD1KYH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 06:24:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9048C1735
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:24:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f192c23fffso55687455e9.3
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682677444; x=1685269444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBDQghTEOGSvTIwt77jCRHyJCm2Vt6oOZBOLMRWGagc=;
        b=cjzTw2wuGVWM0D1ibnHwmIfBRMuI9cASUu7cEIxahA+15ebM90huIj8PuqiKCMlQmY
         8IJPUk22q/He1qTNE+1qFUBM1dkVIbd32LnJn2eXMZ5384otFzyto5Ckbc18FWk+g+Ng
         UBMhbijkrZwcex3pU5715nysu+Zppxj6J2A8QDu3wktGYR9UeJvmPlBoGabEshNR6dyB
         vk9Pk1pb26lWeBoxvp5KfGoEyBWV72JraKYlRcbKdmrUTIdVIb36E7eXThilrFuq+Ivn
         UKhgyqjXDidNResccKznEmmluqnDxP96BlENL2VqLxGdw0Yo05sQQni/VaIe/KEOMzRK
         EodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682677444; x=1685269444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBDQghTEOGSvTIwt77jCRHyJCm2Vt6oOZBOLMRWGagc=;
        b=bNGcPygXQGJ0xaDopqY2+yoZFxSXGqpbG5IB2V9w4dPJHwmbiUetDjLqgoofbtBaoT
         +GGIIyy0v0JT+kBPBftQAJvnmZLEuY+yrH/D0KcZgWWehVUuVLeKQXrSAEzeGYcm4v4h
         SCZ3SymUjxta91a5K1Uu/l7A1udrHLpwIBU4Jw3DtfiT+O1nySge3oUC/BfegY2VDuG1
         O9/3KHrVoy5juhTXGoRE7DKo6EhDdzWrj2mhD/JqSM5EdEQ5bCZHv3ACjZotR46ZZ61i
         uLxVQOILbqhLbQ/Hf7ZYvUJFcD+7X/fLAV9xC+jmR/XMITAABEQUtZEpMyAbhJmW4hoQ
         OcTA==
X-Gm-Message-State: AC+VfDwhbW5Mv+JZKNDGX2w7TBhuVRIs/hdBKkwPI6/adm0dMrivQPyl
        Y3PK/qnn9GoOWV36eo2qKR6ZyxvNo6/B5pPI6eY=
X-Google-Smtp-Source: ACHHUZ5QDrlibK5fBbL8SNWitGMGoUqeZEnyLPn6H8lW+IXHqNkt0n1YL94vjmI4SL4gu1xOmBmu4w==
X-Received: by 2002:a7b:cd18:0:b0:3f1:6fe2:c4b2 with SMTP id f24-20020a7bcd18000000b003f16fe2c4b2mr3586936wmj.23.1682677444043;
        Fri, 28 Apr 2023 03:24:04 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q16-20020a7bce90000000b003f09d7b6e20sm24011066wmj.2.2023.04.28.03.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:24:03 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 5.15.108 v3 3/3] riscv: No need to relocate the dtb as it lies in the fixmap region
Date:   Fri, 28 Apr 2023 12:20:55 +0200
Message-Id: <20230428102055.15920-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230428102055.15920-1-alexghiti@rivosinc.com>
References: <20230428102055.15920-1-alexghiti@rivosinc.com>
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

commit 1b50f956c8fe9082bdee4a9cfd798149c52f7043 upstream.

We used to access the dtb via its linear mapping address but now that the
dtb early mapping was moved in the fixmap region, we can keep using this
address since it is present in swapper_pg_dir, and remove the dtb
relocation.

Note that the relocation was wrong anyway since early_memremap() is
restricted to 256K whereas the maximum fdt size is 2MB.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230329081932.79831-4-alexghiti@rivosinc.com
Cc: stable@vger.kernel.org # 5.15.x
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/init.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3f62ff02efc4..e800d7981e99 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -229,25 +229,8 @@ static void __init setup_bootmem(void)
 	 * early_init_fdt_reserve_self() since __pa() does
 	 * not work for DTB pointers that are fixmap addresses
 	 */
-	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
-		/*
-		 * In case the DTB is not located in a memory region we won't
-		 * be able to locate it later on via the linear mapping and
-		 * get a segfault when accessing it via __va(dtb_early_pa).
-		 * To avoid this situation copy DTB to a memory region.
-		 * Note that memblock_phys_alloc will also reserve DTB region.
-		 */
-		if (!memblock_is_memory(dtb_early_pa)) {
-			size_t fdt_size = fdt_totalsize(dtb_early_va);
-			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
-			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
-
-			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
-			early_memunmap(new_dtb_early_va, fdt_size);
-			_dtb_early_pa = new_dtb_early_pa;
-		} else
-			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
-	}
+	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
+		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
 
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
-- 
2.37.2

