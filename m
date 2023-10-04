Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185667B8A57
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244375AbjJDSeb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbjJDSeb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:34:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF35C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:34:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B103C433C8;
        Wed,  4 Oct 2023 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444467;
        bh=jYVPHaBHKAhtJNSmXtfYPhckC5HORPuJPMovxDkdLyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXrzT5lJVznpO5iHAPyVzNSVDtBV+OhHqBsllOVABDReokKlyThd2kHXGALCUeTBM
         rwSUuE0li6hg7F1lynkTwWOQcxtS7/cj9jXQ/iLd7FxkuolXWbt03kVPBocs8mntu8
         33ujoXLCgITCDDImeYWUQyRqjz52VfPVynkVrQ4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.5 260/321] LoongArch: Define relocation types for ABI v2.10
Date:   Wed,  4 Oct 2023 19:56:45 +0200
Message-ID: <20231004175241.307982642@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Tiezhu Yang <yangtiezhu@loongson.cn>

commit 2761498876adebff77a43574639005b29e912c43 upstream.

The relocation types from 101 to 109 are used by GNU binutils >= 2.41,
add their definitions to use them in later patches.

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=include/elf/loongarch.h#l230
Cc: <stable@vger.kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/elf.h |    9 +++++++++
 arch/loongarch/kernel/module.c   |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -111,6 +111,15 @@
 #define R_LARCH_TLS_GD_HI20			98
 #define R_LARCH_32_PCREL			99
 #define R_LARCH_RELAX				100
+#define R_LARCH_DELETE				101
+#define R_LARCH_ALIGN				102
+#define R_LARCH_PCREL20_S2			103
+#define R_LARCH_CFA				104
+#define R_LARCH_ADD6				105
+#define R_LARCH_SUB6				106
+#define R_LARCH_ADD_ULEB128			107
+#define R_LARCH_SUB_ULEB128			108
+#define R_LARCH_64_PCREL			109
 
 #ifndef ELF_ARCH
 
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -382,7 +382,7 @@ typedef int (*reloc_rela_handler)(struct
 
 /* The handlers for known reloc types */
 static reloc_rela_handler reloc_rela_handlers[] = {
-	[R_LARCH_NONE ... R_LARCH_RELAX]		     = apply_r_larch_error,
+	[R_LARCH_NONE ... R_LARCH_64_PCREL]		     = apply_r_larch_error,
 
 	[R_LARCH_NONE]					     = apply_r_larch_none,
 	[R_LARCH_32]					     = apply_r_larch_32,


