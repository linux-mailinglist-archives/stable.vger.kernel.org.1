Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E697A3D44
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbjIQUkj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbjIQUkc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B4101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CCEC433C7;
        Sun, 17 Sep 2023 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983226;
        bh=JcyYObJsZt/oMTdbKjF6g+xaYPjG+7s2t32q1jQ2TYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAq9E3CeZSJ6PObspRpCv1a/7Ra/UrE9U06kLqCh83YGlqi/dOvyUAP7PiTyaqiMI
         m0i21luIDLj3tgwM9GOVuwUFNF5UQez8dYWxQE9cWOXEWMp85BpR+wIod/CZEoQFBA
         M1GGMPHPvRyV2rpxAFXiuyfDVqVXD6rfZfBPWYfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.15 481/511] MIPS: Fix CONFIG_CPU_DADDI_WORKAROUNDS `modules_install regression
Date:   Sun, 17 Sep 2023 21:15:08 +0200
Message-ID: <20230917191125.355252817@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -279,8 +279,8 @@ ifdef CONFIG_64BIT
     endif
   endif
 
-  ifeq ($(KBUILD_SYM32)$(call cc-option-yn,-msym32), yy)
-    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+  ifeq ($(KBUILD_SYM32), y)
+    cflags-$(KBUILD_SYM32) += -msym32 -DKBUILD_64BIT_SYM32
   else
     ifeq ($(CONFIG_CPU_DADDI_WORKAROUNDS), y)
       $(error CONFIG_CPU_DADDI_WORKAROUNDS unsupported without -msym32)


