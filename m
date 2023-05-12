Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611EC700200
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbjELH7F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbjELH7D (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 03:59:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAA41BCA
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683878342; x=1715414342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XcHkppjRb567AP25f3S4tAxeu5i3rfXpZrV5mp/W3oQ=;
  b=SoD3xY4xWMfGc1/ZYeuQAV8lBQxNzARi0otCpchk9C9qo6GcHg4szFoe
   FeqjHyQXKrdSQ7Rkd7F58Tc6S7UCJYlm/2OS6zxViWeNKDQK63KcRkMQZ
   4fONUUo0MolmfSlvNs/XKagSpLNqv9W+/FGSXCzlOKHofoEj9ckD7ajCD
   55QxE7GBF9x0wmKLSsWmUE0z6QuHSjVTFQNWICcnPseTp4PVaE8EUgjAm
   jtQM1lS0YXdXVNRN9J37bqndnz8ZufSZHCRb9lxX7jFu89bgubETCS7xz
   GvvGI5LhjJFzcpU/106AgYOCp1avAIyXs4rHoKeCfLUwKtrIm3JJQHwQV
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="scan'208";a="225016219"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 00:59:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 00:59:01 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 00:58:59 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <stable@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        <sasha@kernel.org>, <palmer@dabbelt.com>, <linux@roeck-us.net>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.1 v2 1/2] RISC-V: take text_mutex during alternative patching
Date:   Fri, 12 May 2023 08:58:18 +0100
Message-ID: <20230512-pointy-schilling-feddb54b08a8@wendy>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512-unbroken-preppy-8d726731e8e7@wendy>
References: <20230512-unbroken-preppy-8d726731e8e7@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5080; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=XcHkppjRb567AP25f3S4tAxeu5i3rfXpZrV5mp/W3oQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmxH2fV+qnlszf0pIc+ftv4Tkz38tb7J+rkPD46up5KyZrE kfu4o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNx+c/wT+1LefwT78DL4ZLvmO/On3 8sMuTDeucy6S32yrHbvlibHWT4wyfIuV5yuda1VxM4GYUfHTWwSmpcpTL9Z5UAz9/1PKs8WAE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 9493e6f3ce02f44c21aa19f3cbf3b9aa05479d06 upstream.

Guenter reported a splat during boot, that Samuel pointed out was the
lockdep assertion failing in patch_insn_write():

WARNING: CPU: 0 PID: 0 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x222/0x2f6
epc : patch_insn_write+0x222/0x2f6
 ra : patch_insn_write+0x21e/0x2f6
epc : ffffffff800068c6 ra : ffffffff800068c2 sp : ffffffff81803df0
 gp : ffffffff81a1ab78 tp : ffffffff81814f80 t0 : ffffffffffffe000
 t1 : 0000000000000001 t2 : 4c45203a76637369 s0 : ffffffff81803e40
 s1 : 0000000000000004 a0 : 0000000000000000 a1 : ffffffffffffffff
 a2 : 0000000000000004 a3 : 0000000000000000 a4 : 0000000000000001
 a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000052464e43
 s2 : ffffffff80b4889c s3 : 000000000000082c s4 : ffffffff80b48828
 s5 : 0000000000000828 s6 : ffffffff8131a0a0 s7 : 0000000000000fff
 s8 : 0000000008000200 s9 : ffffffff8131a520 s10: 0000000000000018
 s11: 000000000000000b t3 : 0000000000000001 t4 : 000000000000000d
 t5 : ffffffffd8180000 t6 : ffffffff81803bc8
status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
[<ffffffff800068c6>] patch_insn_write+0x222/0x2f6
[<ffffffff80006a36>] patch_text_nosync+0xc/0x2a
[<ffffffff80003b86>] riscv_cpufeature_patch_func+0x52/0x98
[<ffffffff80003348>] _apply_alternatives+0x46/0x86
[<ffffffff80c02d36>] apply_boot_alternatives+0x3c/0xfa
[<ffffffff80c03ad8>] setup_arch+0x584/0x5b8
[<ffffffff80c0075a>] start_kernel+0xa2/0x8f8

This issue was exposed by 702e64550b12 ("riscv: fpu: switch has_fpu() to
riscv_has_extension_likely()"), as it is the patching in has_fpu() that
triggers the splats in Guenter's report.

Take the text_mutex before doing any code patching to satisfy lockdep.

Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
Fixes: 1a0e5dbd3723 ("riscv: sifive: Add SiFive alternative ports")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/20230212154333.GA3760469@roeck-us.net/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230212194735.491785-1-conor@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/errata/sifive/errata.c | 3 +++
 arch/riscv/errata/thead/errata.c  | 8 ++++++--
 arch/riscv/kernel/cpufeature.c    | 6 +++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 1031038423e7..5b77d7310e39 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/bug.h>
@@ -107,7 +108,9 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
 
 		tmp = (1U << alt->errata_id);
 		if (cpu_req_errata & tmp) {
+			mutex_lock(&text_mutex);
 			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+			mutex_lock(&text_mutex);
 			cpu_apply_errata |= tmp;
 		}
 	}
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 21546937db39..32a34ed73509 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -5,6 +5,7 @@
 
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
@@ -78,11 +79,14 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
 		tmp = (1U << alt->errata_id);
 		if (cpu_req_errata & tmp) {
 			/* On vm-alternatives, the mmu isn't running yet */
-			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
+			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT) {
 				memcpy((void *)__pa_symbol(alt->old_ptr),
 				       (void *)__pa_symbol(alt->alt_ptr), alt->alt_len);
-			else
+			} else {
+				mutex_lock(&text_mutex);
 				patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+				mutex_unlock(&text_mutex);
+			}
 		}
 	}
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 694267d1fe81..fd1238df6149 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
+#include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <asm/alternative.h>
@@ -316,8 +317,11 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 		}
 
 		tmp = (1U << alt->errata_id);
-		if (cpu_req_feature & tmp)
+		if (cpu_req_feature & tmp) {
+			mutex_lock(&text_mutex);
 			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+			mutex_unlock(&text_mutex);
+		}
 	}
 }
 #endif
-- 
2.39.2

