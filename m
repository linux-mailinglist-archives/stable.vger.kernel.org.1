Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB03B75CD95
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGUQNJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjGUQMs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A454234
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB65761D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8CEC433C7;
        Fri, 21 Jul 2023 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955895;
        bh=7qtWjDWk0gFeEToDQMXuWmhw6EeQpWK3JNzLJqGufdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kt5x9JQAUkmBKknZm863YOP4QjkIEX22ZFkQGg/3b2ATf/gi1CFS4imy+s3iBp/ge
         KOYH5Qm51jsaarpB0KO/prpaOiw25zpN5avublpABDSb8/F+zp4H6jbyYe1w4UP7Ft
         khxR50cwvgVO3cNoUK4xyX2Wx4PizdS1IpguDYdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 067/292] x86/fineibt: Poison ENDBR at +0
Date:   Fri, 21 Jul 2023 18:02:56 +0200
Message-ID: <20230721160531.667102163@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 04505bbbbb15da950ea0239e328a76a3ad2376e0 ]

Alyssa noticed that when building the kernel with CFI_CLANG+IBT and
booting on IBT enabled hardware to obtain FineIBT, the indirect
functions look like:

  __cfi_foo:
	endbr64
	subl	$hash, %r10d
	jz	1f
	ud2
	nop
  1:
  foo:
	endbr64

This is because the compiler generates code for kCFI+IBT. In that case
the caller does the hash check and will jump to +0, so there must be
an ENDBR there. The compiler doesn't know about FineIBT at all; also
it is possible to actually use kCFI+IBT when booting with 'cfi=kcfi'
on IBT enabled hardware.

Having this second ENDBR however makes it possible to elide the CFI
check. Therefore, we should poison this second ENDBR when switching to
FineIBT mode.

Fixes: 931ab63664f0 ("x86/ibt: Implement FineIBT")
Reported-by: "Milburn, Alyssa" <alyssa.milburn@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20230615193722.194131053@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/alternative.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f615e0cb6d932..4e2c70f88e05b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -940,6 +940,17 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 	return 0;
 }
 
+static void cfi_rewrite_endbr(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+
+		poison_endbr(addr+16, false);
+	}
+}
+
 /* .retpoline_sites */
 static int cfi_rand_callers(s32 *start, s32 *end)
 {
@@ -1034,14 +1045,19 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		return;
 
 	case CFI_FINEIBT:
+		/* place the FineIBT preamble at func()-16 */
 		ret = cfi_rewrite_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
 
+		/* rewrite the callers to target func()-16 */
 		ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
 
+		/* now that nobody targets func()+0, remove ENDBR there */
+		cfi_rewrite_endbr(start_cfi, end_cfi);
+
 		if (builtin)
 			pr_info("Using FineIBT CFI\n");
 		return;
-- 
2.39.2



