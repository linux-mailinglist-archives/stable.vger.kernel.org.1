Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FFA75D2C2
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGUTDT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjGUTDS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF33F2D4A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7506661D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876F5C433C7;
        Fri, 21 Jul 2023 19:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966196;
        bh=1bI9VTkb064C9miAHigDSoX5dmCr6mkoMBRm9f4279A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhAz2m0c1JzLukKKUpZZ8hIKHiQjDmDiut7TJ5oBAX66qXNtVU3usCWFRtu9hrLwJ
         ZTujpNRRtQiju7Ll5WsePTXoKpzke0tN2X9rJrzdBKLQCpEQIPI+OKS2SojEMXzxuJ
         XY2dfs//I2LjjqwZmXlHg/h+5gsbF4LG4oPo1Uq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 230/532] ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard
Date:   Fri, 21 Jul 2023 18:02:14 +0200
Message-ID: <20230721160626.856101563@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 92e2921eeafdfca9acd9b83f07d2b7ca099bac24 ]

ASM_NL is useful not only in *.S files but also in .c files for using
inline assembler in C code.

On ARC, however, ASM_NL is evaluated inconsistently. It is expanded to
a backquote (`) in *.S files, but a semicolon (;) in *.c files because
arch/arc/include/asm/linkage.h defines it inside #ifdef __ASSEMBLY__,
so the definition for C code falls back to the default value defined in
include/linux/linkage.h.

If ASM_NL is used in inline assembler in .c files, it will result in
wrong assembly code because a semicolon is not an instruction separator,
but the start of a comment for ARC.

Move ASM_NL (also __ALIGN and __ALIGN_STR) out of the #ifdef.

Fixes: 9df62f054406 ("arch: use ASM_NL instead of ';' for assembler new line character in the macro")
Fixes: 8d92e992a785 ("ARC: define __ALIGN_STR and __ALIGN symbols for ARC")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/linkage.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index c9434ff3aa4ce..8a3fb71e9cfad 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -8,6 +8,10 @@
 
 #include <asm/dwarf.h>
 
+#define ASM_NL		 `	/* use '`' to mark new line in macro */
+#define __ALIGN		.align 4
+#define __ALIGN_STR	__stringify(__ALIGN)
+
 #ifdef __ASSEMBLY__
 
 .macro ST2 e, o, off
@@ -28,10 +32,6 @@
 #endif
 .endm
 
-#define ASM_NL		 `	/* use '`' to mark new line in macro */
-#define __ALIGN		.align 4
-#define __ALIGN_STR	__stringify(__ALIGN)
-
 /* annotation for data we want in DCCM - if enabled in .config */
 .macro ARCFP_DATA nm
 #ifdef CONFIG_ARC_HAS_DCCM
-- 
2.39.2



