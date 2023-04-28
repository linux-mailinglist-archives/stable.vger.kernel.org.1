Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5842C6F1597
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 12:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345490AbjD1KcQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345825AbjD1KcP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 06:32:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3C448C
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:31:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso46263845e9.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682677916; x=1685269916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BY5R8qq0NGAMsPEpDeA48bljiW9HzuHUvPQ5uqKST9Q=;
        b=0UlH8XoxwWphzSOsrXBRg/d4t6xvPXeaDVGF3cWiVGSZjEiikvjCoyfa90t7eZozj+
         YBGzrdThj4KlSKyewFBz5zWSyS/FgJov7xDCYACQK/VoBBQ2CUc7GoVrvNVLhGCXAeMO
         ImXRfZZ1r4XNLABpy6qkb2F75Kjlec6syMlqmElcMvrETMkimfT4+KN5yi1ISC8sOor0
         rlMQoFLM0zlpDm+z10qqS9/IW7Tro0P1G8gOAzeodfhrUpeWi3gTfseP9/sl+4emPD4S
         mKH4YNPxa8i9M/Q7FIpCP+micPfWD1l7h3US1fdWctzGp1giooKfdjTwyRZ45d6L71gQ
         rkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682677916; x=1685269916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BY5R8qq0NGAMsPEpDeA48bljiW9HzuHUvPQ5uqKST9Q=;
        b=TiBSNIwXmr0fseTHLGnU743Bw81LskcUfmeH/WPpzfjiDX49Zgd9U2oGgLv92wUn5Y
         UMY9fKBWcgWYou2AwobxNrRkqcmRsGyNtXiGWw+3KMq/g/C7j/swWGVbQ+iEfcXgwCk4
         J4Q8YnVNYha67E3RXUShNdYoBx7RicVD1IqYA8zsrPCh9IzNRwfz41y3bfWAATxnEovr
         +SXfffmdVZtondQ9RbQNam605MBuon5tW3BhSomKgGmDbJqBC3a9oVe/gFjyZnxifn9s
         RqzPZQ9bUCG/96PDkTIJp1yoVSWN4Uw5MYmBU628KpH/FatjiU0UgLzgwWU5Xrj7hb6h
         19Jg==
X-Gm-Message-State: AC+VfDybU4Su1QtpcueXXR2x8DNB9zcqv2rx4AVzuY8ZajU0VKjg+X2N
        rKysdlljM3mO2w9rrdAibe0zWA==
X-Google-Smtp-Source: ACHHUZ7mK1G9vh8P5Rz+9g98ICHy2SlU5Y8pQLvfFyK3R98bHKYZkgB57NXwtVn8letR3pTLAnrheA==
X-Received: by 2002:a5d:4111:0:b0:2cf:e0bc:9639 with SMTP id l17-20020a5d4111000000b002cfe0bc9639mr3128614wrp.37.1682677916137;
        Fri, 28 Apr 2023 03:31:56 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id j14-20020adfea4e000000b002fc3d8c134bsm20837468wrn.74.2023.04.28.03.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:31:55 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.1.24 v2 2/3] riscv: Do not set initial_boot_params to the linear address of the dtb
Date:   Fri, 28 Apr 2023 12:29:27 +0200
Message-Id: <20230428102928.16470-3-alexghiti@rivosinc.com>
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

commit f1581626071c8e37c58c5e8f0b4126b17172a211 upstream.

early_init_dt_verify() is already called in parse_dtb() and since the dtb
address does not change anymore (it is now in the fixmap region), no need
to reset initial_boot_params by calling early_init_dt_verify() again.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20230329081932.79831-3-alexghiti@rivosinc.com
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ef98db2826fc..2acf51c23567 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -278,10 +278,7 @@ void __init setup_arch(char **cmdline_p)
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

