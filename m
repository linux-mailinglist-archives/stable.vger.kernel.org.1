Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270E75BDC9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 07:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGUFgj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 01:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGUFgi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 01:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934031719
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 22:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A566B61083
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601C7C433C8;
        Fri, 21 Jul 2023 05:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689917794;
        bh=/ay/yn1ukt8dSbBlM3m/9caIy6ww4xCLkLDyNuQswis=;
        h=Subject:To:Cc:From:Date:From;
        b=uRJA9WvRIb4HaFpsfwvOc49guve0Dtc6hFvdwpXXFsk9FcGh/oA1xHuEzZBjjJRDB
         VZYxzsLaWdprKjsk4/ASvzeZzw1ud2qB5e4fpRC9H9BHi+4PfgTRrY5Hj5E+XAtCXm
         OeJUlPcFt7xcRZS6r07SEhG7R/7lSomE4O/YDXh8=
Subject: FAILED: patch "[PATCH] MIPS: Loongson: Fix build error when make modules_install" failed to apply to 6.1-stable tree
To:     chenhuacai@kernel.org, chenfeiyang@loongson.cn,
        chenhuacai@loongson.cn, nathan@kernel.org, ndesaulniers@google.com,
        tsbogend@alpha.franken.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 07:36:31 +0200
Message-ID: <2023072131-hydrant-clatter-4b9f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 531b3d1195d096f14e030c4b01ec3a53b80276bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072131-hydrant-clatter-4b9f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

531b3d1195d0 ("MIPS: Loongson: Fix build error when make modules_install")
194a83521052 ("MIPS: Loongson: Move arch cflags to MIPS top level Makefile")
337ff6bb8960 ("MIPS: Prefer cc-option for additions to cflags")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 531b3d1195d096f14e030c4b01ec3a53b80276bf Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 28 Jun 2023 19:08:47 +0800
Subject: [PATCH] MIPS: Loongson: Fix build error when make modules_install

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

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a7a4ee66a9d3..35a1b9b34734 100644
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

