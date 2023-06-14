Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15787306B6
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjFNSFX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjFNSEo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 14:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69447212A
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 11:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7360644B1
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 18:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4F6C43215;
        Wed, 14 Jun 2023 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686765882;
        bh=QXteBoKroNwGlgDrV2V5DRgZPfbgnC7cCmb4aJ2ndqQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IV4CvOPZaapehND8A6x6RFlEsOvy+sqz58j07JWmbSfdAcSeJ3j7u6x6LjM05UbWW
         IRTV7/w6EPEpNy/edxdY37Dt1FeEX0QOg0DUksgWVBAchPbvq0BUIPtroVYkpOtYJS
         TZrsKpTOo7d7AM8iuk0Q3UsTJN4wkbLXbzU4pSVYNbdbWfBMLzYAzQEqSYqlyZgZC5
         8e3hLKXNUoj9p6BUeEpdopIrAdMDUactzKsBH7xUMYX/r975Hu9IlMe8DEkUidv/lf
         yprTyl/lppTasJmF5Jh4wK3E74q204rUwXhZPpdkbRp0BNJl88l8FBgqEvOdS5Tqbp
         2qJMeIAHv/CpA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 14 Jun 2023 11:04:37 -0700
Subject: [PATCH 6.1 3/4] MIPS: Prefer cc-option for additions to cflags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230612-6-1-asssembler-target-llvm-17-v1-3-75605d553401@kernel.org>
References: <20230612-6-1-asssembler-target-llvm-17-v1-0-75605d553401@kernel.org>
In-Reply-To: <20230612-6-1-asssembler-target-llvm-17-v1-0-75605d553401@kernel.org>
To:     gregkh@linuxfoundation.org, sashal@kernel.org,
        ndesaulniers@google.com
Cc:     naresh.kamboju@linaro.org, stable@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=nathan@kernel.org;
 h=from:subject:message-id; bh=QXteBoKroNwGlgDrV2V5DRgZPfbgnC7cCmb4aJ2ndqQ=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCldjGZa2ee/RGwrl/1d98/Jv80oScJxR/iDq4s8LB9Ne
 L7mxneTjlIWBjEOBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjARGQOG/0UzZgq/n5sxweBA
 9i/3zZ/nssrv1OI+HDbLbOd3kzI/+z5Ghi28MbGTpn/Z8MQ4n1008eLELbaRfBvivM4p/vnR9Pb
 LcR4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 337ff6bb8960fdc128cabd264aaea3d42ca27a32 upstream.

A future change will switch as-option to use KBUILD_AFLAGS instead of
KBUILD_CFLAGS to allow clang to drop -Qunused-arguments, which may cause
issues if the flag being tested requires a flag previously added to
KBUILD_CFLAGS but not KBUILD_AFLAGS. Use cc-option for cflags additions
so that the flags are tested properly.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/mips/Makefile             | 2 +-
 arch/mips/loongson2ef/Platform | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index de8d508f27af..85d3c3b4b7bd 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -152,7 +152,7 @@ cflags-y += -fno-stack-check
 #
 # Avoid this by explicitly disabling that assembler behaviour.
 #
-cflags-y += $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
+cflags-y += $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 
 #
 # CPU-dependent compiler/assembler options for optimization.
diff --git a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform
index eebabf9df6ac..c6f7a4b95997 100644
--- a/arch/mips/loongson2ef/Platform
+++ b/arch/mips/loongson2ef/Platform
@@ -25,7 +25,7 @@ cflags-$(CONFIG_CPU_LOONGSON2F) += -march=loongson2f
 # binutils does not merge support for the flag then we can revisit & remove
 # this later - for now it ensures vendor toolchains don't cause problems.
 #
-cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
+cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 
 # Enable the workarounds for Loongson2f
 ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS

-- 
2.41.0

