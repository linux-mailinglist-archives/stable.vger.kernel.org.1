Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8E78DB76
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbjH3SjR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244508AbjH3NPm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 09:15:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0803FCD6
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 06:15:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf55a81eeaso29975755ad.0
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693401337; x=1694006137; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58JmpBMuut0U4rrpw0CXIuY7q7ojOIFJjIbB/139BI0=;
        b=JCfWGFKyJV9N+qOgd2ElNqvENwjFHCCxaSER4TS5syWPZCqcR1QixR9LJGdGWFej8N
         ALl90jo0+bvhJy6Wd9vcGLb8K2DZEvU3bA6SdYsP9qvJQAECnASzinZdG/EfZ+8dTsmg
         Zk39gYK7y28D4YCqCdGJv+z1MktptJIeSYiRCt4qMgh8rMfBHRdZfjAVzSgz5nEUJO95
         q/nNQ0o4/RTHYIXcYMNeXqc4xG/5LMei10sgVdwRxBmjrmJgqXNgcylbcG9+7HDWgzxz
         GV6zIiMmC2dc6TVBJT1qNRQfW5/vAahtT8h29F069qPUuClmxSuQ39y8mRBi7BV4/eQF
         vf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401337; x=1694006137;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58JmpBMuut0U4rrpw0CXIuY7q7ojOIFJjIbB/139BI0=;
        b=Xrd718449o8d1j2qOMwz6+8HuoHdbCfKuAJwF1hCxAfUzs61/1XQDGQd4InXn4fYen
         ENjb9j6CH9qLfaab/Zo6nGinlq49uZHFJUY1Q936Mp35OfSxiSZRRGqEeDFcuaS1tGkL
         n5+RdRQUUyS8Qhf+Hprr0hiK52LehTVQJ1ZTEDUCM+cDc0xIBebgrPlQYfSXuvzmaSg5
         eqh80p4kAZZ2H5u7PAdKukUb/J4rD0urQJrMT6qRh++60qxbP9Tamca9DE1gBSh+Plpt
         QdyRYoNjSY3GEAai5pRIbBXXgJ93s/q2Jkd9Tt+EUoUSk9MKlww4Xh+3swvHkMB0vkEE
         4QQg==
X-Gm-Message-State: AOJu0YxOtf6le4Au81GVVVR+XLOL9PGIfpPSSsR8nTF6/UQ+I0ZWg0ZH
        OHv2jdml28LmQ29HfCtA3zGU5Q==
X-Google-Smtp-Source: AGHT+IECpbqH/UrkxB1+1DlNKmoHKvp+r/ynwupNT9KnTwQXvzoUtZlWI5HNytgqOrLW6uFMy/+qpw==
X-Received: by 2002:a17:902:720a:b0:1c1:f3f8:3949 with SMTP id ba10-20020a170902720a00b001c1f3f83949mr1656776plb.1.1693401337465;
        Wed, 30 Aug 2023 06:15:37 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001bc445e249asm11306143pln.124.2023.08.30.06.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:15:37 -0700 (PDT)
Subject: [PATCH v2 2/2] riscv: correct pt_level name via pgtable_l5/4_enabled
Date:   Tue, 29 Aug 2023 21:39:20 -0700
Message-ID: <20230830044129.11481-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830044129.11481-1-palmer@rivosinc.com>
References: <20230830044129.11481-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>, stable@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, suagrfillet@gmail.com
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
2.41.0

