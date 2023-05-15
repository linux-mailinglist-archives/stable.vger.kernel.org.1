Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74E7038B5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244328AbjEOReQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244323AbjEOReB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:34:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB93DC77;
        Mon, 15 May 2023 10:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EDB362D4A;
        Mon, 15 May 2023 17:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0665C4339C;
        Mon, 15 May 2023 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171909;
        bh=h5mK51aebmM7frvlZj9/VAIXXGKmEyWTQHFtggW+AO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6hP1pGKwOoTGYu+wNfRzOGkYOuEH7gmpcexEAwSn9J+9/bPtqhMycaZLaW8jrMQf
         oiEUI7ipyg1YdVkHwOQvU7D5K8qEvS4JEvAzYxs3GqF9dPiMXirjhSi96YCEFviK1v
         W4PEtfTk6xFt0xGIVf5cUav0g14fsHH3zwt7gHi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Subject: [PATCH 5.15 077/134] sh: init: use OF_EARLY_FLATTREE for early init
Date:   Mon, 15 May 2023 18:29:14 +0200
Message-Id: <20230515161705.748158315@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

commit 6cba655543c7959f8a6d2979b9d40a6a66b7ed4f upstream.

When CONFIG_OF_EARLY_FLATTREE and CONFIG_SH_DEVICE_TREE are not set,
SH3 build fails with a call to early_init_dt_scan(), so in
arch/sh/kernel/setup.c and arch/sh/kernel/head_32.S, use
CONFIG_OF_EARLY_FLATTREE instead of CONFIG_OF_FLATTREE.

Fixes this build error:
../arch/sh/kernel/setup.c: In function 'sh_fdt_init':
../arch/sh/kernel/setup.c:262:26: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]
  262 |         if (!dt_virt || !early_init_dt_scan(dt_virt)) {

Fixes: 03767daa1387 ("sh: fix build regression with CONFIG_OF && !CONFIG_OF_FLATTREE")
Fixes: eb6b6930a70f ("sh: fix memory corruption of unflattened device tree")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: stable@vger.kernel.org
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/20230306040037.20350-4-rdunlap@infradead.org
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/kernel/head_32.S |    6 +++---
 arch/sh/kernel/setup.c   |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -64,7 +64,7 @@ ENTRY(_stext)
 	ldc	r0, r6_bank
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov	r4, r12		! Store device tree blob pointer in r12
 #endif
 	
@@ -315,7 +315,7 @@ ENTRY(_stext)
 10:		
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov.l	8f, r0		! Make flat device tree available early.
 	jsr	@r0
 	 mov	r12, r4
@@ -346,7 +346,7 @@ ENTRY(stack_start)
 5:	.long	start_kernel
 6:	.long	cpu_init
 7:	.long	init_thread_union
-#if defined(CONFIG_OF_FLATTREE)
+#if defined(CONFIG_OF_EARLY_FLATTREE)
 8:	.long	sh_fdt_init
 #endif
 
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -244,7 +244,7 @@ void __init __weak plat_early_device_set
 {
 }
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
@@ -326,7 +326,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
 #else


