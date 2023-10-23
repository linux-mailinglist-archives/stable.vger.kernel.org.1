Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802777D328A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjJWLVR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjJWLVQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:21:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06004A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDBDC433C9;
        Mon, 23 Oct 2023 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060074;
        bh=hGWOSTisAnz8j4qni8enfO4/84hXI9YoKv4/985TxW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6PEsE4ETk5CluVf/S4ebJQ4TuW3I/1DfZbScZ3Qsf32yDUwxx6w73+0+mnVFDyuB
         Km8oON6M66sRblsWqjERPbsHwnlFPma6g33cl3wj29a8y5z/14Gu25Z9H3HaX24dEB
         xtp5ISKQwdcgaipjb0IVo024I5QvRPSSYzsEGRx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Dohrmann <erbse.13@gmx.de>,
        Joerg Roedel <jroedel@suse.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org
Subject: [PATCH 6.1 023/196] x86/sev: Check for user-space IOIO pointing to kernel space
Date:   Mon, 23 Oct 2023 12:54:48 +0200
Message-ID: <20231023104829.140101144@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joerg Roedel <jroedel@suse.de>

Upstream commit: 63e44bc52047f182601e7817da969a105aa1f721

Check the memory operand of INS/OUTS before emulating the instruction.
The #VC exception can get raised from user-space, but the memory operand
can be manipulated to access kernel memory before the emulation actually
begins and after the exception handler has run.

  [ bp: Massage commit message. ]

Fixes: 597cfe48212a ("x86/boot/compressed/64: Setup a GHCB-based VC Exception handler")
Reported-by: Tom Dohrmann <erbse.13@gmx.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/sev.c |    5 +++++
 arch/x86/kernel/sev-shared.c   |   31 +++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -108,6 +108,11 @@ static enum es_result vc_ioio_check(stru
 	return ES_OK;
 }
 
+static bool fault_in_kernel_space(unsigned long address)
+{
+	return false;
+}
+
 #undef __init
 #undef __pa
 #define __init
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -629,6 +629,23 @@ fail:
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
+static enum es_result vc_insn_string_check(struct es_em_ctxt *ctxt,
+					   unsigned long address,
+					   bool write)
+{
+	if (user_mode(ctxt->regs) && fault_in_kernel_space(address)) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_USER;
+		ctxt->fi.cr2        = address;
+		if (write)
+			ctxt->fi.error_code |= X86_PF_WRITE;
+
+		return ES_EXCEPTION;
+	}
+
+	return ES_OK;
+}
+
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
 					  void *src, char *buf,
 					  unsigned int data_size,
@@ -636,7 +653,12 @@ static enum es_result vc_insn_string_rea
 					  bool backwards)
 {
 	int i, b = backwards ? -1 : 1;
-	enum es_result ret = ES_OK;
+	unsigned long address = (unsigned long)src;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, false);
+	if (ret != ES_OK)
+		return ret;
 
 	for (i = 0; i < count; i++) {
 		void *s = src + (i * data_size * b);
@@ -657,7 +679,12 @@ static enum es_result vc_insn_string_wri
 					   bool backwards)
 {
 	int i, s = backwards ? -1 : 1;
-	enum es_result ret = ES_OK;
+	unsigned long address = (unsigned long)dst;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, true);
+	if (ret != ES_OK)
+		return ret;
 
 	for (i = 0; i < count; i++) {
 		void *d = dst + (i * data_size * s);


