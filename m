Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4AD7827D6
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjHULZb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 07:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjHULZb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 07:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEFEE1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 04:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E521C61812
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 11:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB04C433C8;
        Mon, 21 Aug 2023 11:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692617128;
        bh=1PAap1kchWQmBzLWfFyKy9+jZJ02RwGF7tdIWBKg2Ng=;
        h=Subject:To:Cc:From:Date:From;
        b=hL2JT+CCYWQftika4pevqG4K4BHkDaCZlRvMpbhgkjKwOzVKGlqvTb93xamYEUPvc
         0lbggO3QWFXEqgijHAZpV8q/E8dU96Mlghphxdp7gQbhjNwswMl4zGdUpjBzi1S01q
         2TIjimr8JKLd8McaCdPZ+mAp/9sE+UMR9HiG1LPg=
Subject: FAILED: patch "[PATCH] riscv: Handle zicsr/zifencei issue between gcc and binutils" failed to apply to 5.10-stable tree
To:     xingmingzheng@iscas.ac.cn, conor.dooley@microchip.com,
        guoren@kernel.org, palmer@rivosinc.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 13:25:23 +0200
Message-ID: <2023082123-arson-ventricle-83cf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ca09f772cccaeec4cd05a21528c37a260aa2dd2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082123-arson-ventricle-83cf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

ca09f772ccca ("riscv: Handle zicsr/zifencei issue between gcc and binutils")
e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang and binutils")
aae538cd03bc ("riscv: fix detection of toolchain Zihintpause support")
8eb060e10185 ("arch/riscv: add Zihintpause support")
1631ba1259d6 ("riscv: Add support for non-coherent devices using zicbom extension")
73448ae6204f ("RISC-V: Some Svpbmt fixes and cleanups")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca09f772cccaeec4cd05a21528c37a260aa2dd2c Mon Sep 17 00:00:00 2001
From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Date: Thu, 10 Aug 2023 00:56:48 +0800
Subject: [PATCH] riscv: Handle zicsr/zifencei issue between gcc and binutils

Binutils-2.38 and GCC-12.1.0 bumped[0][1] the default ISA spec to the newer
20191213 version which moves some instructions from the I extension to the
Zicsr and Zifencei extensions. So if one of the binutils and GCC exceeds
that version, we should explicitly specifying Zicsr and Zifencei via -march
to cope with the new changes. but this only occurs when binutils >= 2.36
and GCC >= 11.1.0. It's a different story when binutils < 2.36.

binutils-2.36 supports the Zifencei extension[2] and splits Zifencei and
Zicsr from I[3]. GCC-11.1.0 is particular[4] because it add support Zicsr
and Zifencei extension for -march. binutils-2.35 does not support the
Zifencei extension, and does not need to specify Zicsr and Zifencei when
working with GCC >= 12.1.0.

To make our lives easier, let's relax the check to binutils >= 2.36 in
CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. For the other two cases,
where clang < 17 or GCC < 11.1.0, we will deal with them in
CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.

For more information, please refer to:
commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang and binutils")

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc [0]
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd [1]
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=5a1b31e1e1cee6e9f1c92abff59cdcfff0dddf30 [2]
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=729a53530e86972d1143553a415db34e6e01d5d2 [3]
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49 [4]
Link: https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.org
Link: https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Guo Ren <guoren@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20230809165648.21071-1-xingmingzheng@iscas.ac.cn
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..10e7a7ad175a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -570,24 +570,30 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
 config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	def_bool y
 	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
-	depends on AS_IS_GNU && AS_VERSION >= 23800
+	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
+	depends on AS_IS_GNU && AS_VERSION >= 23600
 	help
-	  Newer binutils versions default to ISA spec version 20191213 which
-	  moves some instructions from the I extension to the Zicsr and Zifencei
-	  extensions.
+	  Binutils-2.38 and GCC-12.1.0 bumped the default ISA spec to the newer
+	  20191213 version, which moves some instructions from the I extension to
+	  the Zicsr and Zifencei extensions. This requires explicitly specifying
+	  Zicsr and Zifencei when binutils >= 2.38 or GCC >= 12.1.0. Zicsr
+	  and Zifencei are supported in binutils from version 2.36 onwards.
+	  To make life easier, and avoid forcing toolchains that default to a
+	  newer ISA spec to version 2.2, relax the check to binutils >= 2.36.
+	  For clang < 17 or GCC < 11.1.0, for which this is not possible, this is
+	  dealt with in CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
 
 config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 	def_bool y
 	depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	# https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943c0c0d4498694e15bf8a16
-	depends on CC_IS_CLANG && CLANG_VERSION < 170000
+	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49
+	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION < 110100)
 	help
-	  Certain versions of clang do not support zicsr and zifencei via -march
-	  but newer versions of binutils require it for the reasons noted in the
-	  help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. This
-	  option causes an older ISA spec compatible with these older versions
-	  of clang to be passed to GAS, which has the same result as passing zicsr
-	  and zifencei to -march.
+	  Certain versions of clang and GCC do not support zicsr and zifencei via
+	  -march. This option causes an older ISA spec compatible with these older
+	  versions of clang and GCC to be passed to GAS, which has the same result
+	  as passing zicsr and zifencei to -march.
 
 config FPU
 	bool "FPU support"
diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
index 189345773e7e..b86e5e2c3aea 100644
--- a/arch/riscv/kernel/compat_vdso/Makefile
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -11,7 +11,13 @@ compat_vdso-syms += flush_icache
 COMPAT_CC := $(CC)
 COMPAT_LD := $(LD)
 
-COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
+# binutils 2.35 does not support the zifencei extension, but in the ISA
+# spec 20191213, G stands for IMAFD_ZICSR_ZIFENCEI.
+ifdef CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
+	COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
+else
+	COMPAT_CC_FLAGS := -march=rv32imafd -mabi=ilp32
+endif
 COMPAT_LD_FLAGS := -melf32lriscv
 
 # Disable attributes, as they're useless and break the build.

