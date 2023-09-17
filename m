Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359F67A3A10
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbjIQT6Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbjIQT5w (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:57:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4651101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:57:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF41C433C8;
        Sun, 17 Sep 2023 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980666;
        bh=qCq6k/gQNnloDQHJnIcmU4nphPxyqxkn4XUygxtuXxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdk0J6mLxu2fLzj2b5T/AcYB84kH+AgDN7LZlfmYsFfm5yHH8HjfxdP5TJy/O5IIu
         AT5Lg54FeCljfp12ZPKVhwWpf0hkJNGgmwRxTyhz19YcfBT4And2XCohsyI13iLe5B
         ninz7f2n8ufipJ2TEXkH8tO4uKhDBIG6vlSJkYRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.5 231/285] MIPS: Fix CONFIG_CPU_DADDI_WORKAROUNDS `modules_install regression
Date:   Sun, 17 Sep 2023 21:13:51 +0200
Message-ID: <20230917191059.432804909@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@orcam.me.uk>

commit a79a404e6c2241ebc528b9ebf4c0832457b498c3 upstream.

Remove a build-time check for the presence of the GCC `-msym32' option.
This option has been there since GCC 4.1.0, which is below the minimum
required as at commit 805b2e1d427a ("kbuild: include Makefile.compiler
only when compiler is needed"), when an error message:

arch/mips/Makefile:306: *** CONFIG_CPU_DADDI_WORKAROUNDS unsupported without -msym32.  Stop.

started to trigger for the `modules_install' target with configurations
such as `decstation_64_defconfig' that set CONFIG_CPU_DADDI_WORKAROUNDS,
because said commit has made `cc-option-yn' an undefined function for
non-build targets.

Reported-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 805b2e1d427a ("kbuild: include Makefile.compiler only when compiler is needed")
Cc: stable@vger.kernel.org # v5.13+
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -299,8 +299,8 @@ ifdef CONFIG_64BIT
     endif
   endif
 
-  ifeq ($(KBUILD_SYM32)$(call cc-option-yn,-msym32), yy)
-    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+  ifeq ($(KBUILD_SYM32), y)
+    cflags-$(KBUILD_SYM32) += -msym32 -DKBUILD_64BIT_SYM32
   else
     ifeq ($(CONFIG_CPU_DADDI_WORKAROUNDS), y)
       $(error CONFIG_CPU_DADDI_WORKAROUNDS unsupported without -msym32)


