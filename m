Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07108761683
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjGYLj4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjGYLj4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629F19C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0BC061698
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF50CC433C8;
        Tue, 25 Jul 2023 11:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285194;
        bh=cXxs9X5aAf/rmF+ly0QpUKlbokW/7PVGhV9U9w9jKeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRQMLMraOeYHJloNaGRTARsyZb84cUPfij/LrCyFXzMUyWnodVdyGTRCEf55ykr5u
         yADRP8NUsgzkSnPJnXb4Oze1KRPs1n7mezJsNN8qIZ90EYDcHwkxKLANmzLEDheg5Y
         FRreXChfzkUHs8tZPg1MraFKoHQtgIXOjdezpzes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 117/313] ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard
Date:   Tue, 25 Jul 2023 12:44:30 +0200
Message-ID: <20230725104526.071530303@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index fe19f1d412e71..284fd513d7c67 100644
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



