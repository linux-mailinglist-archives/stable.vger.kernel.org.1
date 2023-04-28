Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA726F1545
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbjD1KXI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 06:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345999AbjD1KXH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 06:23:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42371FD4
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:23:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2fa47de5b04so9320658f8f.1
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682677383; x=1685269383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdQQdg0l40IrcuiAHH3VsWznLkACnILUusaFyIPj2No=;
        b=PqRZRBoiHv6BX7zjbSDzreLHzUIjEN3TrI6Uoo6DcnN3Dnu5EedYiMz8DZE7bbI76B
         SMM9YGnjtVAbnjhTPwRCIT6epJsvK24hewgIu37zlDxm4hS2XBSFVexS/i6mrO5SvNon
         YcgPqSkq2EuKbf/83MmvPwSXwaHXmdlviDqitDFtvowiJpovLhnhFmiVCnJhUA+ubAUj
         D7A9GodM1W045qli+iCDQ4infmn4BT1R2WawDk/sm64BvoVuEBT2JFuK/kJk21gJjU1P
         dlqFtAMf3VEOwW55iOoQ40fNqQ0NRIWR9DF8wRIG6zs4GynTXJmEI+CzlrCJrlYDkyt4
         xC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682677383; x=1685269383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdQQdg0l40IrcuiAHH3VsWznLkACnILUusaFyIPj2No=;
        b=L33YhFWwj35qAM5HzyXEOyZqcgj4Dz2e1B813cPF2lxMevhUPIlgmRbkjXDxNXfb88
         tzqUlNo0yQuo4i7LL4SuctfesoSxeJl06MeHVnazoMu7FKoYRVGDLmPaoEqxgHuP8wG0
         bCjQ81UmGzMYXXUGAMGeDoLUhn9K1bAwv8OrCzAtgjB9oSntHI9nwAnezot5E+0vQn1a
         DRjOY+E0k1xRLpavdqLkSRWRcA27UgbMSQ7B0UP/SDV+3kIt2rYUQwTHxPRwWL+ANjuW
         DcKHkVL4M8CfRRtQ7v+/ec26h7a3IKvUW+KfQ3i3+ua3gn2tTLyeWsf1/QrNIhHYKSuP
         gtYg==
X-Gm-Message-State: AC+VfDxPlf2q0/qLB2Qn8HT7BGUcxI58KKi48AdNi/09ZU89rhVOUqw5
        QXYOFtwsii7i8Jm/lB/d7TgNXnR/nAJmbVWFHn4=
X-Google-Smtp-Source: ACHHUZ7XaMFSWazYtOoPVnm2LRdBMHMDU8c2B2BwGgbT38rQlySRIJLQL09KNzNCxLCWkDDcJacU/A==
X-Received: by 2002:a5d:6748:0:b0:2ce:a34b:2b0b with SMTP id l8-20020a5d6748000000b002cea34b2b0bmr3499091wrw.28.1682677383375;
        Fri, 28 Apr 2023 03:23:03 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002fda1b12a0bsm20833273wrx.2.2023.04.28.03.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:23:03 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 5.15.108 v3 2/3] riscv: Do not set initial_boot_params to the linear address of the dtb
Date:   Fri, 28 Apr 2023 12:20:54 +0200
Message-Id: <20230428102055.15920-3-alexghiti@rivosinc.com>
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

commit f1581626071c8e37c58c5e8f0b4126b17172a211 upstream.

early_init_dt_verify() is already called in parse_dtb() and since the dtb
address does not change anymore (it is now in the fixmap region), no need
to reset initial_boot_params by calling early_init_dt_verify() again.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20230329081932.79831-3-alexghiti@rivosinc.com
Cc: stable@vger.kernel.org # 5.15.x
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f874fe07fb78..8cc147491c67 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -286,10 +286,7 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
 #else
-	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
-		unflatten_device_tree();
-	else
-		pr_err("No DTB found in kernel mappings\n");
+	unflatten_device_tree();
 #endif
 	misc_mem_init();
 
-- 
2.37.2

