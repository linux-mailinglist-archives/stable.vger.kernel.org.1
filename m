Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4D7937C8
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjIFJKo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 05:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjIFJKn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 05:10:43 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C32FE56
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 02:10:25 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.176])
        by gateway (Coremail) with SMTP id _____8AxZ+gAQvhkU0EgAA--.28770S3;
        Wed, 06 Sep 2023 17:10:24 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.180.13.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF83pQfhkIV1uAA--.100S2;
        Wed, 06 Sep 2023 17:10:23 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     zhanghongchen@loongson.cn
Cc:     stable@vger.kernel.org
Subject: [PATCH v2] LoongArch: add p?d_leaf() definitions
Date:   Wed,  6 Sep 2023 17:09:59 +0800
Message-Id: <20230906090959.4387-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF83pQfhkIV1uAA--.100S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAGB2T3-DUDaQADsz
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr18AF4Dtr1UZFykCrWDWrX_yoW8Gry8pF
        9rCF92gF45GF92k34Dtr1Y9F1DAws7WF42gFyYya18XF13Xws7Z3yxXr45ZFW5XaykXFWI
        gFsxKw1YgF18ZwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
        wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84x
        RDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When I do LTP test, LTP test case ksm06 caused panic at
	break_ksm_pmd_entry
	  -> pmd_leaf (Huge page table but False)
	  -> pte_present (panic)

The reason is pmd_leaf is not defined, So like
commit 501b81046701 ("mips: mm: add p?d_leaf() definitions")
add p?d_leaf() definition for LoongArch.

Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
Cc: stable@vger.kernel.org
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
v3: add Cc: stable@vger.kernel.org in commit message
v2: add Fixes: in commit message.
 arch/loongarch/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 370c6568ceb8..ea54653b7aab 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -243,6 +243,9 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 #define pmd_phys(pmd)		PHYSADDR(pmd_val(pmd))
 
+#define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
+#define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
+
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */

base-commit: a47fc304d2b678db1a5d760a7d644dac9b067752
-- 
2.33.0

