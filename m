Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A991F73731F
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 19:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFTRp2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjFTRp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 13:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005421712
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 10:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 897EF61347
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 17:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEA8C433C8;
        Tue, 20 Jun 2023 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687283124;
        bh=s1tq1ZDjdzFB2GkT5pO6cNB1MDeTYdM68tmhr1OE9PQ=;
        h=From:Date:Subject:To:Cc:From;
        b=Bn01cZPlsTPkLSSJI+6+6aZbotW6eFX0AVgIoaXdsZrryG17lqJUyPR0gG8oTTQkf
         fA6itNU9zy8R3YQe93nVawa9N/M9WNXVGcIJ8yiIPH+v32o7zG4nIEOEC/JWFSdIPc
         5Bu9Lx2KdMrO2D5NlyEYt8HD2S7GRMCYdyJuSqyoY/YIystZEx8XmrvagJtfgR4YFr
         bseQxUJxEIurhAFbR274/EgyKVOVghAaM/peJfiVqV4CNE18DPwiOlt6PMJxGCPIcj
         GJmZMIh4YH3QoGhgoBEqauOaBZeCsG+ouHcDXytIgaZvND2+IBL5jZM6lkwunyvuMu
         b/kDaXZWiBXTw==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 20 Jun 2023 17:44:50 +0000
Subject: [PATCH 6.3] riscv: Link with '-z norelro'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-6-3-fix-got-relro-error-lld-v1-1-f3e71ec912d1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJHlkWQC/x3NywqDMBCF4VeRWXdKkoH08iqli0RHDaRJmZEii
 O9u7PLnwHc2UJbECs9uA+Ff0lRLC3vpoJ9DmRjT0BqccWS8M+iRcEwrTnVB4SwVWaQK5jwgPW4
 jWevu3kRoQgzKGCWUfj6NT9CF5Ry+ws34377AXwne+34AtHwpposAAAA=
To:     gregkh@linuxfoundation.org, sashal@kernel.org
Cc:     palmer@dabbelt.com, conor@kernel.org, ndesaulniers@google.com,
        nathan@kernel.org, linux-riscv@lists.infradead.org,
        stable@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=nathan@kernel.org;
 h=from:subject:message-id; bh=s1tq1ZDjdzFB2GkT5pO6cNB1MDeTYdM68tmhr1OE9PQ=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCkTn27JOxd3cO3pT4z33m7YLTUn/NUSca0JUxvTwxvP/
 jrjedn5W0cpC4MYB4OsmCJL9WPV44aGc84y3jg1CWYOKxPIEAYuTgGYiLY5I8O53D8ck/R22ZhP
 TSzvFpoZ5GFtpiw3tUxzv+f2eU2xl9kZGX6+aM2+opszZa+ZUqbTpwonxznXmUqWi4RPf6Am7pF
 4mRMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch fixes a stable only patch, so it has no direct upstream
equivalent.

After a stable only patch to explicitly handle the '.got' section to
handle an orphan section warning from the linker, certain configurations
error when linking with ld.lld, which enables relro by default:

  ld.lld: error: section: .got is not contiguous with other relro sections

This has come up with other architectures before, such as arm and arm64
in commit 0cda9bc15dfc ("ARM: 9038/1: Link with '-z norelro'") and
commit 3b92fa7485eb ("arm64: link with -z norelro regardless of
CONFIG_RELOCATABLE"). Additionally, '-z norelro' is used unconditionally
for RISC-V upstream after commit 26e7aacb83df ("riscv: Allow to
downgrade paging mode from the command line"), which alluded to this
issue for the same reason. Bring 6.3 in line with mainline and link with
'-z norelro', which resolves the above link failure.

Fixes: e6d1562dd4e9 ("riscv: vmlinux.lds.S: Explicitly handle '.got' section")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306192231.DJmWr6BX-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/riscv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index b05e833a022d..d46b6722710f 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -7,7 +7,7 @@
 #
 
 OBJCOPYFLAGS    := -O binary
-LDFLAGS_vmlinux :=
+LDFLAGS_vmlinux := -z norelro
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux := --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY

---
base-commit: f2427f9a3730e9a1a11b69f6b767f7f2fad87523
change-id: 20230620-6-3-fix-got-relro-error-lld-397f3112860b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

