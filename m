Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222CD6F15DE
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjD1Kk4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 06:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1Kkw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 06:40:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBE211D
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:40:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f40b891420so9346299f8f.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682678450; x=1685270450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2bxheMtOKIVxmwYWY1BfXs6E5uot4EJGKHpFHrv5Y4=;
        b=O2bqX1qYLGuo7QgPMdxxfSgDiW6cgm0t8c+hqqYoGQeSOfWApqI9smFaTOTUspzKMM
         CvOIhOKte9othc3YqOkdqYFNGfJBKxXM3P31QPj6V87LWzykLDYZyELv68yh1gQGTJTF
         GwsjaPgX70GUz6kHkIy/rLxLNljwPOFdAAO9OxxNJ6iLqN7aTxnRgACpnwc2EQ/6HjIk
         Gi4njOquOdU9Zta9PNZb0lMMGMmfHJuqDdYUqykN96wRGbsR0agfs8UokrVPsufq3RO7
         OZJy0IFSHCAwC5gnc2F59HIA8sAMlrv3IFlWydleSox6ZUCyXRA7xT9s1p62C4od635Q
         uOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682678450; x=1685270450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2bxheMtOKIVxmwYWY1BfXs6E5uot4EJGKHpFHrv5Y4=;
        b=iPEoS1El3Ixpx3mrNlgGstrPKWjmN33pgVG0VxFMei9r+vm1x6uCZgGnJ4RZkOqy7r
         OH0rOMh4e9eEq4btpPXU9XF7W0BGIgvDUv6EeNAcHtIuEhdWttYOABhYc/uYyITsTPJ0
         LuWuHYhKmwywPa3N/7xFiWb3hbuhvXZ9UU5r7QldpoXL3f3NdH7oMS7NLYIxLB6h8sAY
         73RNFkHKDOevxpuikMmhn7nf+RW7U+4FtddxA0RT6e0pelAm3TMN5u0CB9zlWKfm1hkv
         bgcEUXjVfqFp67RB/3VLS3MlYS5qztv4fX91dg87WgdGXHSOnHCqG+VG8FFb8wtleqLI
         O1tA==
X-Gm-Message-State: AC+VfDyc+2vk+VfWjSAHlCorBXaBhKsyq4sfLAlv6YPuJr2GzA1qxeG+
        CiCNr55p6Jx26YBXwL7ziSi/Iw==
X-Google-Smtp-Source: ACHHUZ7saZjcp03BWRII9I4mTJhlV1zzDpTk5vEuSVx2DblcF714JD8rRPAkKssEnsK5ElBe0c2UqA==
X-Received: by 2002:a5d:42c6:0:b0:2f2:7a0e:5cc9 with SMTP id t6-20020a5d42c6000000b002f27a0e5cc9mr3316036wrr.19.1682678449892;
        Fri, 28 Apr 2023 03:40:49 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d45c1000000b002fdeafcb132sm20729160wrs.107.2023.04.28.03.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:40:49 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.2.11 v2 3/3] riscv: No need to relocate the dtb as it lies in the fixmap region
Date:   Fri, 28 Apr 2023 12:37:45 +0200
Message-Id: <20230428103745.16979-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230428103745.16979-1-alexghiti@rivosinc.com>
References: <20230428103745.16979-1-alexghiti@rivosinc.com>
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
Cc: stable@vger.kernel.org # 6.2.x
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/init.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fb78d6bbabae..0f14f4a8d179 100644
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

