Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0327D3566
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjJWLry (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjJWLrw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:47:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1A0D6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:47:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FFCC433C8;
        Mon, 23 Oct 2023 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061669;
        bh=auU4/7WQgUbu2GX7jo28DHl3SbAvoJDkgBaDJ1f9LoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0+dD4tpzeNDFsSZTuqAQHFeNgj7Ms85HPwxcb5Vw/KatE31H9dEP7IjGPBKiow/N
         aRoRs5DCPFBAbUUpG0tGG4VL8cwpeAMfQRqrY4hjNKOmXuQ1tUf6qsRQacTHIqW+mm
         znWI+Kj5U8SOZPlOHMf4BolyXWDsAW97xScftGa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Dohrmann <erbse.13@gmx.de>,
        Joerg Roedel <jroedel@suse.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org
Subject: [PATCH 5.10 098/202] x86/sev: Check IOBM for IOIO exceptions from user-space
Date:   Mon, 23 Oct 2023 12:56:45 +0200
Message-ID: <20231023104829.406503755@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joerg Roedel <jroedel@suse.de>

Upstream commit: b9cb9c45583b911e0db71d09caa6b56469eb2bdf

Check the IO permission bitmap (if present) before emulating IOIO #VC
exceptions for user-space. These permissions are checked by hardware
already before the #VC is raised, but due to the VC-handler decoding
race it needs to be checked again in software.

Fixes: 25189d08e516 ("x86/sev-es: Add support for handling IOIO exceptions")
Reported-by: Tom Dohrmann <erbse.13@gmx.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Dohrmann <erbse.13@gmx.de>
Cc: <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/sev-es.c |    5 +++++
 arch/x86/kernel/sev-es-shared.c   |   22 +++++++++++++++-------
 arch/x86/kernel/sev-es.c          |   27 +++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 7 deletions(-)

--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -106,6 +106,11 @@ static enum es_result vc_read_mem(struct
 	return ES_OK;
 }
 
+static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
+{
+	return ES_OK;
+}
+
 #undef __init
 #undef __pa
 #define __init
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -281,6 +281,9 @@ static enum es_result vc_insn_string_wri
 static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 {
 	struct insn *insn = &ctxt->insn;
+	size_t size;
+	u64 port;
+
 	*exitinfo = 0;
 
 	switch (insn->opcode.bytes[0]) {
@@ -289,7 +292,7 @@ static enum es_result vc_ioio_exitinfo(s
 	case 0x6d:
 		*exitinfo |= IOIO_TYPE_INS;
 		*exitinfo |= IOIO_SEG_ES;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	/* OUTS opcodes */
@@ -297,41 +300,43 @@ static enum es_result vc_ioio_exitinfo(s
 	case 0x6f:
 		*exitinfo |= IOIO_TYPE_OUTS;
 		*exitinfo |= IOIO_SEG_DS;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	/* IN immediate opcodes */
 	case 0xe4:
 	case 0xe5:
 		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (u8)insn->immediate.value << 16;
+		port	   = (u8)insn->immediate.value & 0xffff;
 		break;
 
 	/* OUT immediate opcodes */
 	case 0xe6:
 	case 0xe7:
 		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (u8)insn->immediate.value << 16;
+		port	   = (u8)insn->immediate.value & 0xffff;
 		break;
 
 	/* IN register opcodes */
 	case 0xec:
 	case 0xed:
 		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	/* OUT register opcodes */
 	case 0xee:
 	case 0xef:
 		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	default:
 		return ES_DECODE_FAILED;
 	}
 
+	*exitinfo |= port << 16;
+
 	switch (insn->opcode.bytes[0]) {
 	case 0x6c:
 	case 0x6e:
@@ -341,12 +346,15 @@ static enum es_result vc_ioio_exitinfo(s
 	case 0xee:
 		/* Single byte opcodes */
 		*exitinfo |= IOIO_DATA_8;
+		size       = 1;
 		break;
 	default:
 		/* Length determined by instruction parsing */
 		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
 						     : IOIO_DATA_32;
+		size       = (insn->opnd_bytes == 2) ? 2 : 4;
 	}
+
 	switch (insn->addr_bytes) {
 	case 2:
 		*exitinfo |= IOIO_ADDR_16;
@@ -362,7 +370,7 @@ static enum es_result vc_ioio_exitinfo(s
 	if (insn_has_rep_prefix(insn))
 		*exitinfo |= IOIO_REP;
 
-	return ES_OK;
+	return vc_ioio_check(ctxt, (u16)port, size);
 }
 
 static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -448,6 +448,33 @@ static enum es_result vc_slow_virt_to_ph
 	return ES_OK;
 }
 
+static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
+{
+	BUG_ON(size > 4);
+
+	if (user_mode(ctxt->regs)) {
+		struct thread_struct *t = &current->thread;
+		struct io_bitmap *iobm = t->io_bitmap;
+		size_t idx;
+
+		if (!iobm)
+			goto fault;
+
+		for (idx = port; idx < port + size; ++idx) {
+			if (test_bit(idx, iobm->bitmap))
+				goto fault;
+		}
+	}
+
+	return ES_OK;
+
+fault:
+	ctxt->fi.vector = X86_TRAP_GP;
+	ctxt->fi.error_code = 0;
+
+	return ES_EXCEPTION;
+}
+
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
 


