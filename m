Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37DC7ADB50
	for <lists+stable@lfdr.de>; Mon, 25 Sep 2023 17:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjIYPYs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 25 Sep 2023 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjIYPYo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 25 Sep 2023 11:24:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DE3109
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 08:24:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c47309a8ccso56356685ad.1
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695655477; x=1696260277; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ie0I8vPiPu7fWmL9QMaLa54dXoB+86VLEOUcIFiG3I=;
        b=Li+S4XaBncLdaQYh+HwyjR8uK2MEiSlPCqYXqJ7gXyXGdMkx1L645I+GWImMn3F4Zo
         f9P/vt6THzbjUFgP6XHhBssAxmTogIbPDMbP6tKx4drE9fzek8MxqxljYLGRBYj78XJh
         FmI3WzgpNOnMt0JJSOB6oZYfxfuFHJBfJBKzFe4vIi9V2lgcf0CASzZpBIvu9zAU6X3d
         O5+NVcbbLAVe9+QteZ7dx8xi/LYEGud+e1t/57ggSjdMNOv/c4tXfaiQ6xBTPiKqnsha
         2qDaobeezoPkc8WBCeK06IJyxk4U+Om0C9rCoSZHDaJzxhg1jH0/N0FKKEFyas2TYXc1
         dTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655477; x=1696260277;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ie0I8vPiPu7fWmL9QMaLa54dXoB+86VLEOUcIFiG3I=;
        b=anfxDuad8erwKqr/9KNZfgkRV+oyYpn/Hk8cxxqYl0Gq4c8Qr2TLS/K9rnlSmNlPoM
         EnYvK9/LXue3S/d+KtLhznTNUysd9zRCJcueWUSc25NSqactksnKTfWEDfcpkdJTVPAr
         Y12aqIpYJc7l/OQ6+7ouhBK3Rug9B1/Stzqp/FWRlqNtlertMJQ0i+JVF0LeCDoFnYp+
         VMl29k+xQpD38PkiqSPiiFBoROKNlvqLfVLhcszYT44QQikLm2DVbdImuM+4CrY5UAWm
         BVou02wXBMfT8ajmECXuBsLTVJDD83YRjUbUQ4RC3T+imdYcs9YoaINFvlH+nGFDmYPj
         C41A==
X-Gm-Message-State: AOJu0YwWGoTWn5WFPBpeZzZG3WDXLD7pPXiZw7jITsZ4KSz8S9xd2507
        7FJISdDaFpWBiGw666VuvGhoGA==
X-Google-Smtp-Source: AGHT+IGz114UixM1Ve8x2nN4BzbRTk8luqnv0RrFRU+P4huuqBhX2kxEzLfCN/zc/Jbs/bAy4mFJQQ==
X-Received: by 2002:a17:902:ab1a:b0:1c6:d0a:cf01 with SMTP id ik26-20020a170902ab1a00b001c60d0acf01mr5791024plb.11.1695655477424;
        Mon, 25 Sep 2023 08:24:37 -0700 (PDT)
Received: from localhost ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902b69800b001bb1f0605b2sm8940905pls.214.2023.09.25.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:24:36 -0700 (PDT)
Subject: [PATCH v3 2/2] riscv: correct pt_level name via pgtable_l5/4_enabled
Date:   Mon, 25 Sep 2023 08:22:20 -0700
Message-ID: <20230925152409.29057-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925152409.29057-1-palmer@rivosinc.com>
References: <20230925152409.29057-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Song Shuai <suagrfillet@gmail.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        stable@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Song Shuai <suagrfillet@gmail.com>

The pt_level uses CONFIG_PGTABLE_LEVELS to display page table names.
But if page mode is downgraded from kernel cmdline or restricted by
the hardware in 64BIT, it will give a wrong name.

Like, using no4lvl for sv39, ptdump named the 1G-mapping as "PUD"
that should be "PGD":

0xffffffd840000000-0xffffffd900000000    0x00000000c0000000         3G PUD     D A G . . W R V

So select "P4D/PUD" or "PGD" via pgtable_l5/4_enabled to correct it.

Fixes: e8a62cc26ddf ("riscv: Implement sv48 support")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Link: https://lore.kernel.org/r/20230712115740.943324-1-suagrfillet@gmail.com
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230830044129.11481-3-palmer@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/ptdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 20a9f991a6d7..e9090b38f811 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -384,6 +384,9 @@ static int __init ptdump_init(void)
 
 	kernel_ptd_info.base_addr = KERN_VIRT_START;
 
+	pg_level[1].name = pgtable_l5_enabled ? "P4D" : "PGD";
+	pg_level[2].name = pgtable_l4_enabled ? "PUD" : "PGD";
+
 	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
 		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
 			pg_level[i].mask |= pte_bits[j].mask;
-- 
2.42.0

