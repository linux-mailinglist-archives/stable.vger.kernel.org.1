Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5BE74C246
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjGILS6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjGILS5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21CDE72
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AD460BCA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C33C433C7;
        Sun,  9 Jul 2023 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901524;
        bh=GepKi8YWqFTFAPDEljNijeMEOsJeeMqPf97Dr+6vUK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IjXuzJdTpA9eb8uLohKvRt4OzBrM53nZRoN7KLYF9qJ2tMe6pRJDmwQ9+tj8wpmAE
         bz9SnCx/Y1bH5jeHJiyg4CzLT/uL9xTTWSsT2ytgh5f3CoG0AdNEh79ZKuIrBTyxRd
         RtBRmXKDOLOVi4AMtMbsNNeWHyxRIw09o20vP0KU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 050/431] ARM: 9303/1: kprobes: avoid missing-declaration warnings
Date:   Sun,  9 Jul 2023 13:09:58 +0200
Message-ID: <20230709111452.284638943@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 1b9c3ddcec6a55e15d3e38e7405e2d078db02020 ]

checker_stack_use_t32strd() and kprobe_handler() can be made static since
they are not used from other files, while coverage_start_registers()
and __kprobes_test_case() are used from assembler code, and just need
a declaration to avoid a warning with the global definition.

arch/arm/probes/kprobes/checkers-common.c:43:18: error: no previous prototype for 'checker_stack_use_t32strd'
arch/arm/probes/kprobes/core.c:236:16: error: no previous prototype for 'kprobe_handler'
arch/arm/probes/kprobes/test-core.c:723:10: error: no previous prototype for 'coverage_start_registers'
arch/arm/probes/kprobes/test-core.c:918:14: error: no previous prototype for '__kprobes_test_case_start'
arch/arm/probes/kprobes/test-core.c:952:14: error: no previous prototype for '__kprobes_test_case_end_16'
arch/arm/probes/kprobes/test-core.c:967:14: error: no previous prototype for '__kprobes_test_case_end_32'

Fixes: 6624cf651f1a ("ARM: kprobes: collects stack consumption for store instructions")
Fixes: 454f3e132d05 ("ARM/kprobes: Remove jprobe arm implementation")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/probes/kprobes/checkers-common.c | 2 +-
 arch/arm/probes/kprobes/core.c            | 2 +-
 arch/arm/probes/kprobes/opt-arm.c         | 2 --
 arch/arm/probes/kprobes/test-core.c       | 2 +-
 arch/arm/probes/kprobes/test-core.h       | 4 ++++
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/probes/kprobes/checkers-common.c b/arch/arm/probes/kprobes/checkers-common.c
index 4d720990cf2a3..eba7ac4725c02 100644
--- a/arch/arm/probes/kprobes/checkers-common.c
+++ b/arch/arm/probes/kprobes/checkers-common.c
@@ -40,7 +40,7 @@ enum probes_insn checker_stack_use_imm_0xx(probes_opcode_t insn,
  * Different from other insn uses imm8, the real addressing offset of
  * STRD in T32 encoding should be imm8 * 4. See ARMARM description.
  */
-enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
+static enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
 		struct arch_probes_insn *asi,
 		const struct decode_header *h)
 {
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 9090c3a74dcce..d8238da095df7 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -233,7 +233,7 @@ singlestep(struct kprobe *p, struct pt_regs *regs, struct kprobe_ctlblk *kcb)
  * kprobe, and that level is reserved for user kprobe handlers, so we can't
  * risk encountering a new kprobe in an interrupt handler.
  */
-void __kprobes kprobe_handler(struct pt_regs *regs)
+static void __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p, *cur;
 	struct kprobe_ctlblk *kcb;
diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index dbef34ed933f2..7f65048380ca5 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -145,8 +145,6 @@ __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
 	}
 }
 
-extern void kprobe_handler(struct pt_regs *regs);
-
 static void
 optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 {
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index c562832b86272..171c7076b89f4 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -720,7 +720,7 @@ static const char coverage_register_lookup[16] = {
 	[REG_TYPE_NOSPPCX]	= COVERAGE_ANY_REG | COVERAGE_SP,
 };
 
-unsigned coverage_start_registers(const struct decode_header *h)
+static unsigned coverage_start_registers(const struct decode_header *h)
 {
 	unsigned regs = 0;
 	int i;
diff --git a/arch/arm/probes/kprobes/test-core.h b/arch/arm/probes/kprobes/test-core.h
index 56ad3c0aaeeac..c7297037c1623 100644
--- a/arch/arm/probes/kprobes/test-core.h
+++ b/arch/arm/probes/kprobes/test-core.h
@@ -454,3 +454,7 @@ void kprobe_thumb32_test_cases(void);
 #else
 void kprobe_arm_test_cases(void);
 #endif
+
+void __kprobes_test_case_start(void);
+void __kprobes_test_case_end_16(void);
+void __kprobes_test_case_end_32(void);
-- 
2.39.2



