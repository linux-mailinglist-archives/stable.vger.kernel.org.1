Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492847D30D6
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjJWLCq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjJWLCp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:02:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635A7D6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:02:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A372AC433C7;
        Mon, 23 Oct 2023 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058963;
        bh=D9QssG/CS5IhMaJ6uutUwDip0Dg+pQSpEBmRaMYrrwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WspYihl0Dp8GTqCsA7/l/NhLBsVB5f1grIif4k2SGUiciidg1RAlb/K7GFcQcr8WQ
         rLNI8/ZXJAY43RrLhAfuKOtQRD//fK00u7gxCxJaZZOwulezXQTLK6ie58V/s06r5/
         W8KezpRyxO0/9bqY6oixmWcp75ZTNHJzWuejO5kw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Dohrmann <erbse.13@gmx.de>,
        Joerg Roedel <jroedel@suse.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org
Subject: [PATCH 6.5 018/241] x86/sev: Check for user-space IOIO pointing to kernel space
Date:   Mon, 23 Oct 2023 12:53:24 +0200
Message-ID: <20231023104834.370004141@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
 #define __init
 
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -632,6 +632,23 @@ fail:
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
@@ -639,7 +656,12 @@ static enum es_result vc_insn_string_rea
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
@@ -660,7 +682,12 @@ static enum es_result vc_insn_string_wri
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


