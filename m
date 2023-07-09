Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FB374C3B4
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjGILfW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjGILfV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722B95
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98D1B60BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93ADC433C8;
        Sun,  9 Jul 2023 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902520;
        bh=1bI9VTkb064C9miAHigDSoX5dmCr6mkoMBRm9f4279A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKZV1laTD8+AxnknB/hE2V4jGN118Lb5aCaaJ4pI+8GlszPU7G2TD0/77LQsXGfti
         kw1OoRtLSEBq3Qkm/wVh0ac6pG4nbZmssvemfR2ZoG+svZMtBBWQ9eCuAtHLVZ5nZI
         3U6eb5j3fZKOvs8IlJBvVrUZShCLFPSHWNO/ZdIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 406/431] ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard
Date:   Sun,  9 Jul 2023 13:15:54 +0200
Message-ID: <20230709111500.702639961@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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



