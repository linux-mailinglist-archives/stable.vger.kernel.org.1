Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841FF75CE3B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjGUQSz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjGUQSg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B530C3ABE
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A67E61D3C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7D8C433CA;
        Fri, 21 Jul 2023 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956238;
        bh=paTdJRJv0QD+pWf6HJKbgBrvmj9Lkcwto9FGPWJHbpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HEHd8G5wtQr0LGWedDe9mrXbd3voNVphGCEujF0yMR9afek2U5Dp4dCSx+OZ5Ojh
         TKNFJWkWTEtD8ROE48KuqWfZEFVvqnQP8q53+b/IzK62GIQj8pZDInJh6FYzU6sHs4
         2mZCieJJsrUwyxY9WRTltguH1nxa6lkdQ1ZZGRWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Feiyang Chen <chenfeiyang@loongson.cn>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.4 148/292] MIPS: Loongson: Fix build error when make modules_install
Date:   Fri, 21 Jul 2023 18:04:17 +0200
Message-ID: <20230721160535.256528861@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

commit 531b3d1195d096f14e030c4b01ec3a53b80276bf upstream.

After commit 0e96ea5c3eb5904e5dc2f ("MIPS: Loongson64: Clean up use of
cc-ifversion") we get a build error when make modules_install:

cc1: error: '-mloongson-mmi' must be used with '-mhard-float'

The reason is when make modules_install, 'call cc-option' doesn't work
in $(KBUILD_CFLAGS) of 'CHECKFLAGS'. Then there is no -mno-loongson-mmi
applied and -march=loongson3a enable MMI instructions.

To be detail, the error message comes from the CHECKFLAGS invocation of
$(CC) but it has no impact on the final result of make modules_install,
it is purely a cosmetic issue. The error occurs because cc-option is
defined in scripts/Makefile.compiler, which is not included in Makefile
when running 'make modules_install', as install targets are not supposed
to require the compiler; see commit 805b2e1d427aab4b ("kbuild: include
Makefile.compiler only when compiler is needed"). As a result, the call
to check for '-mno-loongson-mmi' just never happens.

Fix this by partially reverting to the old logic, use 'call cc-option'
to conditionally apply -march=loongson3a and -march=mips64r2.

By the way, Loongson-2E/2F is also broken in commit 13ceb48bc19c563e05f4
("MIPS: Loongson2ef: Remove unnecessary {as,cc}-option calls") so fix it
together.

Fixes: 13ceb48bc19c563e05f4 ("MIPS: Loongson2ef: Remove unnecessary {as,cc}-option calls")
Fixes: 0e96ea5c3eb5904e5dc2 ("MIPS: Loongson64: Clean up use of cc-ifversion")
Cc: stable@vger.kernel.org
Cc: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/Makefile |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -181,16 +181,12 @@ endif
 cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
 cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
 
-cflags-$(CONFIG_CPU_LOONGSON2E) += -march=loongson2e -Wa,--trap
-cflags-$(CONFIG_CPU_LOONGSON2F) += -march=loongson2f -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON2E) += $(call cc-option,-march=loongson2e) -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON2F) += $(call cc-option,-march=loongson2f) -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON64) += $(call cc-option,-march=loongson3a,-march=mips64r2) -Wa,--trap
 # Some -march= flags enable MMI instructions, and GCC complains about that
 # support being enabled alongside -msoft-float. Thus explicitly disable MMI.
 cflags-$(CONFIG_CPU_LOONGSON2EF) += $(call cc-option,-mno-loongson-mmi)
-ifdef CONFIG_CPU_LOONGSON64
-cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap
-cflags-$(CONFIG_CC_IS_GCC) += -march=loongson3a
-cflags-$(CONFIG_CC_IS_CLANG) += -march=mips64r2
-endif
 cflags-$(CONFIG_CPU_LOONGSON64) += $(call cc-option,-mno-loongson-mmi)
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)


