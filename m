Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A1C75CDCD
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjGUQOx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjGUQOf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B84423E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BECB61D1D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D995C433C8;
        Fri, 21 Jul 2023 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956044;
        bh=aVHW2lR+2WGPjExKIjKGIewU87VdW9kaD7rJpRp2IE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrEIgGYAINqft5ye7jwJ6hXMvbt9b+Qi1Bmruos81Awi931Zd5EtfXzioHB2f3631
         s0xSo08Af/BYBqSd4uFXQFa0I20EkmVIdeEMBu6f1YV8K0/LH5A+jNJh2a1Yjw+d+X
         8f1SDxpulRCq4yh+M36fs8+F5fZHpJUeMgEOYmvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 6.4 114/292] kbuild: make modules_install copy modules.builtin(.modinfo)
Date:   Fri, 21 Jul 2023 18:03:43 +0200
Message-ID: <20230721160533.720834632@linuxfoundation.org>
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

From: Masahiro Yamada <masahiroy@kernel.org>

commit 8ae071fc216a25f4f797f33c56857f4dd6b4408e upstream.

Josh Triplett reports that initramfs-tools needs modules.builtin and
modules.builtin.modinfo to create a working initramfs for a non-modular
kernel.

If this is a general tooling issue not limited to Debian, I think it
makes sense to change modules_install.

This commit changes the targets as follows when CONFIG_MODULES=n.

In-tree builds:
  make modules          -> no-op
  make modules_install  -> install modules.builtin(.modinfo)

External module builds:
  make modules          -> show error message like before
  make modules_install  -> show error message like before

Link: https://lore.kernel.org/lkml/36a4014c73a52af27d930d3ca31d362b60f4461c.1686356364.git.josh@joshtriplett.org/
Reported-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nicolas Schier <nicolas@fjasle.eu>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Tested-by: Josh Triplett <josh@joshtriplett.org>
Stable-dep-of: 4243afdb9326 ("kbuild: builddeb: always make modules_install, to install modules.builtin*")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -1561,6 +1561,8 @@ modules_sign_only := y
 endif
 endif
 
+endif # CONFIG_MODULES
+
 modinst_pre :=
 ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
 modinst_pre := __modinst_pre
@@ -1571,18 +1573,18 @@ PHONY += __modinst_pre
 __modinst_pre:
 	@rm -rf $(MODLIB)/kernel
 	@rm -f $(MODLIB)/source
-	@mkdir -p $(MODLIB)/kernel
+	@mkdir -p $(MODLIB)
+ifdef CONFIG_MODULES
 	@ln -s $(abspath $(srctree)) $(MODLIB)/source
 	@if [ ! $(objtree) -ef  $(MODLIB)/build ]; then \
 		rm -f $(MODLIB)/build ; \
 		ln -s $(CURDIR) $(MODLIB)/build ; \
 	fi
 	@sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.order
+endif
 	@cp -f modules.builtin $(MODLIB)/
 	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
 
-endif # CONFIG_MODULES
-
 ###
 # Cleaning is done on three levels.
 # make clean     Delete most generated files
@@ -1924,6 +1926,13 @@ help:
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
 
+__external_modules_error:
+	@echo >&2 '***'
+	@echo >&2 '*** The present kernel disabled CONFIG_MODULES.'
+	@echo >&2 '*** You cannot build or install external modules.'
+	@echo >&2 '***'
+	@false
+
 endif # KBUILD_EXTMOD
 
 # ---------------------------------------------------------------------------
@@ -1960,13 +1969,10 @@ else # CONFIG_MODULES
 # Modules not configured
 # ---------------------------------------------------------------------------
 
-modules modules_install:
-	@echo >&2 '***'
-	@echo >&2 '*** The present kernel configuration has modules disabled.'
-	@echo >&2 '*** To use the module feature, please run "make menuconfig" etc.'
-	@echo >&2 '*** to enable CONFIG_MODULES.'
-	@echo >&2 '***'
-	@exit 1
+PHONY += __external_modules_error
+
+modules modules_install: __external_modules_error
+	@:
 
 KBUILD_MODULES :=
 


