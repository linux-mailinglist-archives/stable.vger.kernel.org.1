Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943CD6F2709
	for <lists+stable@lfdr.de>; Sun, 30 Apr 2023 00:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjD2Wpw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 29 Apr 2023 18:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2Wpv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 29 Apr 2023 18:45:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F96E7C
        for <stable@vger.kernel.org>; Sat, 29 Apr 2023 15:45:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a6670671e3so10416345ad.0
        for <stable@vger.kernel.org>; Sat, 29 Apr 2023 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682808350; x=1685400350;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=eGCdcEw4y5HNnkhElsF0KTMoRMbJurRvg+ykIaF0fnM=;
        b=z5L4bEHAGNgH118ITQtSKmlKGvPaxpoArwxZzsTi+6vozFKhBltOSkrtKNavulM3s4
         FFwp7u/TiLcPp+8NPx1JKuey3EeNh2sB8iRu973EDEirpGzTWoF7eotxboovKQ2IuPhh
         26/s4mmZX6xCahlQ/9oJbD9apM5Tq2foOw1MWkWeqtPoY9yZexXpQgJ3YlXL9pJXrAWp
         ZeVJUuMI+ArGIVLT1Y8E68UEqX5Dz3WyUkW+HqMCleHqwwnKx6fpP1FMybGiDeTmebk3
         qhmOGfg7KsROEThc/axQT+67ZrULBVTtLVvvep8LBNlzHBwcW4hPl0YS1S7W2Q97skB3
         FgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682808350; x=1685400350;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGCdcEw4y5HNnkhElsF0KTMoRMbJurRvg+ykIaF0fnM=;
        b=d85kEbRH25GN+aurTSGjME9gC29nrXkhqs0a6AmGID4Jo/nm1FmmQgO3B8L7fslb6G
         zox9wE/QchkOTIYGnNaJbOs/MY92TtyksKXJeorx48aF8BMfRmNdu6/t04vWo+xVmci+
         oJL7jiTbd4HsdSOMM4v6lcJAd2v+VqDUXcQ5pCOJ7ccxvBmOXgIHMhME9Y2tj7jQUB+J
         xtaHj38m61me7lN0JQwVNN7wumUnAWhxuxns/JJ+0F5ZhH8zp8pfVYMgswDKL7tCCXzS
         GQVuW1oixTPMskeVHeNVktWF+TedJLcc4e7LrskKkO1wcAS9N/hVjhFEtPRotDwKCSSB
         SCNQ==
X-Gm-Message-State: AC+VfDwI5hXwKIviiiB/ZUsKxZuOpnAY/mNU0mgJrce8KUihPMJmlJZ4
        wdxtetDzpBoSvENwzLYUlZiPURmkfOPDTXyfrv0=
X-Google-Smtp-Source: ACHHUZ60tTYPb8KYCToDDbrlNHJSlUBu3Y7sAxneHBQsOxvIRhiOi13UkEb+U0wzsaE9np4L9rZPcQ==
X-Received: by 2002:a17:902:f649:b0:1a6:67e1:4d2c with SMTP id m9-20020a170902f64900b001a667e14d2cmr9185757plg.6.1682808350025;
        Sat, 29 Apr 2023 15:45:50 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902788b00b001a943c41c37sm13899975pll.7.2023.04.29.15.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 15:45:49 -0700 (PDT)
Subject: [PATCH linux-5.15.y] RISC-V: Fix up a cherry-pick warning in setup_vm_final()
Date:   Sat, 29 Apr 2023 15:43:31 -0700
Message-Id: <20230429224330.18699-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        stable@vger.kernel.org, linux-riscv@lists.infradead.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
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

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304300429.SXZOA5up-lkp@intel.com/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I haven't even build tested this one, but it looks simple enough that I figured
I'd just send it.  Be warned, though: I broke glibc and missed a merged
conflict yesterday...
---
 arch/riscv/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e800d7981e99..8d67f43f1865 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -717,6 +717,7 @@ static void __init setup_vm_final(void)
 	uintptr_t va, map_size;
 	phys_addr_t pa, start, end;
 	u64 i;
+	unsigned long idx;
 
 	/**
 	 * MMU is enabled at this point. But page table setup is not complete yet.
@@ -735,7 +736,7 @@ static void __init setup_vm_final(void)
 	 * directly in swapper_pg_dir in addition to the pgd entry that points
 	 * to fixmap_pte.
 	 */
-	unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
+	idx = pgd_index(__fix_to_virt(FIX_FDT));
 
 	set_pgd(&swapper_pg_dir[idx], early_pg_dir[idx]);
 #endif
-- 
2.40.0

