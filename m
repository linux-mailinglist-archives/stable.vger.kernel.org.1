Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E2073540A
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjFSKvX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjFSKvA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:51:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF2610C6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B86C36068B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF528C433C8;
        Mon, 19 Jun 2023 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171831;
        bh=8WLuV1rTsZ9DAOfWrtAyWuTgOuwrXTm9cHeQai6aEns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkFQXh2rqrsHItVjrVVv17ES2aD3sjMRTVImvidcbmxr0Qwfxpk4aFnFs42wxGaoF
         IuxHQ3sClDZpxwPcgS9r8DHf+00cMcI31NECBIi9iSg0tIRlK62C1vdnRZRNLKPOJC
         FYsBfSdjInH4AWcTBeBW7LXkfJuVcRQmUvLdG1is=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.1 165/166] MIPS: Prefer cc-option for additions to cflags
Date:   Mon, 19 Jun 2023 12:30:42 +0200
Message-ID: <20230619102202.675798857@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/Makefile             |    2 +-
 arch/mips/loongson2ef/Platform |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
--- a/arch/mips/loongson2ef/Platform
+++ b/arch/mips/loongson2ef/Platform
@@ -25,7 +25,7 @@ cflags-$(CONFIG_CPU_LOONGSON2F) += -marc
 # binutils does not merge support for the flag then we can revisit & remove
 # this later - for now it ensures vendor toolchains don't cause problems.
 #
-cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
+cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 
 # Enable the workarounds for Loongson2f
 ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS


