Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5666F15DA
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbjD1Kk1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 06:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbjD1KkJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 06:40:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A607CE76
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:39:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f939bea9ebso8836953f8f.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682678389; x=1685270389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8e0GYPkckOu1axICSuJczoScMdcQC4wr7b5pjuftCk=;
        b=Sv2Hc7LUnW9j8vDRueO483ME9nDEk2NBsupCik5TOORmo2KuJJ9M4ef8zre/VnKUej
         5c7vCcfkBPIfV/sjgf08Dvnn3DNcbq+TkdSYXQv0xBBAFoScW1Ri7T/2PnjOoDAwoamK
         C8kZpCof1iR0xhNk9sC8eQ3Qrf42Sj1mgAUZ+v2My8IkcaeTY1mGTWJTrr83bOc5QlCP
         MbAyIQw3vrY3Q7LS/TACR4Ys6QSv78Y6MMFRqGjxwKnif1jwIjG+rH4ZkN6c6lrVIh32
         g7KXYTI5zvpFUAOyTnl32Rmt3ciHj5bMHfsQXCt0vaFBWpq7cCDJrtZRd9t8s63Bq73L
         NEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682678389; x=1685270389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8e0GYPkckOu1axICSuJczoScMdcQC4wr7b5pjuftCk=;
        b=g8CT3kiAYdu58WfwTAyG+eSUML+ffBNjyOJcHWMhU1mXjBAzN8aW3JOVRDZEzt1k9c
         n5nUowjOPV1dcmgbV87NPtJzu6X2F8jL7d03YqRtVVbt1w/dEOqYph1dX8CWi4JyYMcF
         KbXEKrGHitU6itrKB3XYheMyDnL+oq8ITnFHHUw/Tb5HW6pnUrXU+H5nNq4c6HEhsqoP
         eSaR9n6jZcQJh7WSyDm4gqk8KqPSv8SiHop75CfUZm0E0ZYffmOs9J6KoI3o0TOFM54M
         WMlhsXhrdf5L5eQsrrGQV8fqg/TytABwr3vOk6FfIFutA5+F7Z2ZZSW9o0auxYVjVmj+
         AXlg==
X-Gm-Message-State: AC+VfDwOgkIe1XQvV+0PcewMeMB27Oj6idZpsWKEdLwlzHPh5uSDdqMB
        9Lw9E22gWhzmnYwNyYdt/VaFcw==
X-Google-Smtp-Source: ACHHUZ6SSuaZu2mmYau/Q+KbBW/GIy6p7phOamVElJHeDQe2JSJNhEoA63au/Q1oPQPiETrIlhHaHQ==
X-Received: by 2002:adf:f204:0:b0:2f4:de63:a0b4 with SMTP id p4-20020adff204000000b002f4de63a0b4mr3586326wro.64.1682678389118;
        Fri, 28 Apr 2023 03:39:49 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d688f000000b003046c216c18sm15372727wru.30.2023.04.28.03.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:39:48 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.2.11 v2 2/3] riscv: Do not set initial_boot_params to the linear address of the dtb
Date:   Fri, 28 Apr 2023 12:37:44 +0200
Message-Id: <20230428103745.16979-3-alexghiti@rivosinc.com>
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

commit f1581626071c8e37c58c5e8f0b4126b17172a211 upstream.

early_init_dt_verify() is already called in parse_dtb() and since the dtb
address does not change anymore (it is now in the fixmap region), no need
to reset initial_boot_params by calling early_init_dt_verify() again.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20230329081932.79831-3-alexghiti@rivosinc.com
Cc: stable@vger.kernel.org # 6.2.x
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

