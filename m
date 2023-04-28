Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7A6F159D
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjD1KdC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjD1KdB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 06:33:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6EACD
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:32:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2fa47de5b04so9333244f8f.1
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682677977; x=1685269977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BQndHIB5xvn5zpZGSRRs0cW/8um6zd7o8Gwf2rXrn4=;
        b=NjuC+ZDDrQq1h5mpSo5X2IzDioeUHGkB3m1ahZYV8K8FHT1L6mJsy3soUcQo4CBgoa
         oOspC3xqgA6Ck9eVcWKH0DMBhMaf8+vBH5PsYKhkNhAV70SO+05zZivVLOdevcP2dcbj
         pkZnnDRAV21PhDU7bLVG9QJOPDlPAy/TW/y46uzfbLjZsaHpdrsV81o3s5oIXh4DVST6
         Nz5MLszeYPMKJ21BiKZGkzHKyzDBHvxHlEVrgfapYHAP1gK5OIowy5386RWobcxTphp9
         w+SNYBfJfEMsdfjgc8QrjLHqC5Pu9BnMtFxK01hL55wRNet+57c8/SMhkvSuseHbQTV2
         gQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682677977; x=1685269977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BQndHIB5xvn5zpZGSRRs0cW/8um6zd7o8Gwf2rXrn4=;
        b=YE4KF2DacdkzCSV0B+0IhEl5qxodGtPpQUDfi9ldFRV0Eml/3DZsJFU4+I6ikYruW4
         5Dvk7cWRHHROVWjuB/GV0XayPrRmon8cAgVabSejHy9BFGwZNEZHu1G6f/Hoaj93dahG
         o3YMs12hAKUnm5I/0/lCvyqUrm2Ixqg4Sq4kXsQv02s+nKcZaf6UKjaP3WOR2wO/V73t
         Si06sGK683T2UUJe95cF+MJ7G558SEH5k18g1DJc+unoews1iNF+8Bqzq8YhmTQ/+E4T
         kqUDqrcPB/0IGdObgADZBPUYlbQPGATyVdKcHjz+cAGrKzx9NjR24Jf/leYrhqECxTQ0
         Y5uA==
X-Gm-Message-State: AC+VfDwg+bN/pXjPXT1TutsN3JfXaNEyIf8gmmx+76667o6Eq6DTROwY
        p5GtnTnsXjZVHK+9u7BEogqmSQ==
X-Google-Smtp-Source: ACHHUZ7AUEAVIMZMn9qYUVwKhWYqLzLX2hPQoOGacKozzSl320NT0nvwTxqXxMT3ig6XwpOQKYWshA==
X-Received: by 2002:adf:eb0f:0:b0:2f5:b952:2a53 with SMTP id s15-20020adfeb0f000000b002f5b9522a53mr3086871wrn.25.1682677976950;
        Fri, 28 Apr 2023 03:32:56 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d48ca000000b003047dc162f7sm11467519wrs.67.2023.04.28.03.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:32:56 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.1.24 v2 3/3] riscv: No need to relocate the dtb as it lies in the fixmap region
Date:   Fri, 28 Apr 2023 12:29:28 +0200
Message-Id: <20230428102928.16470-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230428102928.16470-1-alexghiti@rivosinc.com>
References: <20230428102928.16470-1-alexghiti@rivosinc.com>
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
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/init.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5570c52deb0b..6f47ced3175b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -249,25 +249,8 @@ static void __init setup_bootmem(void)
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

