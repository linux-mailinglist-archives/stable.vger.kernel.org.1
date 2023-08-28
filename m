Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D72E78ABDF
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjH1KfC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjH1Ked (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:34:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8C130
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 016AC63E2F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138E4C433C8;
        Mon, 28 Aug 2023 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218869;
        bh=+cEY45jTJYBgTamOX3tAy1Rjl8wzJXU0Lyk8XAX7jSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQgimn5ZFu1vbFEinuS8pqGqtHaCCiQZ1oTwOYZlS5MMS1ZTPYYZH2c3RRQkZ4IYv
         aAhLeXzUee5hTLWWMp615jXK8Wicb2/xgHVFeBQ5n2iBkjkgTRP+vLzOJ6lENtlYAX
         JCZP8LQc5NlWaNgvTx4gFDGlMbA1cESUBVNOw5XY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>,
        Mingzheng Xing <xingmingzheng@iscas.ac.cn>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.1 085/122] riscv: Fix build errors using binutils2.37 toolchains
Date:   Mon, 28 Aug 2023 12:13:20 +0200
Message-ID: <20230828101159.238248712@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>

commit ef21fa7c198e04f3d3053b1c5b5f2b4b225c3350 upstream.

When building the kernel with binutils 2.37 and GCC-11.1.0/GCC-11.2.0,
the following error occurs:

  Assembler messages:
  Error: cannot find default versions of the ISA extension `zicsr'
  Error: cannot find default versions of the ISA extension `zifencei'

The above error originated from this commit of binutils[0], which has been
resolved and backported by GCC-12.1.0[1] and GCC-11.3.0[2].

So fix this by change the GCC version in
CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC to GCC-11.3.0.

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f0bae2552db1dd4f1995608fbf6648fcee4e9e0c [0]
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ca2bbb88f999f4d3cc40e89bc1aba712505dd598 [1]
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d29f5d6ab513c52fd872f532c492e35ae9fd6671 [2]
Fixes: ca09f772ccca ("riscv: Handle zicsr/zifencei issue between gcc and binutils")
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20230824190852.45470-1-xingmingzheng@iscas.ac.cn
Closes: https://lore.kernel.org/all/20230823-captive-abdomen-befd942a4a73@wendy/
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -457,15 +457,15 @@ config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZI
 	  and Zifencei are supported in binutils from version 2.36 onwards.
 	  To make life easier, and avoid forcing toolchains that default to a
 	  newer ISA spec to version 2.2, relax the check to binutils >= 2.36.
-	  For clang < 17 or GCC < 11.1.0, for which this is not possible, this is
-	  dealt with in CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
+	  For clang < 17 or GCC < 11.3.0, for which this is not possible or need
+	  special treatment, this is dealt with in TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
 
 config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 	def_bool y
 	depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	# https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943c0c0d4498694e15bf8a16
-	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49
-	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION < 110100)
+	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d29f5d6ab513c52fd872f532c492e35ae9fd6671
+	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION < 110300)
 	help
 	  Certain versions of clang and GCC do not support zicsr and zifencei via
 	  -march. This option causes an older ISA spec compatible with these older


