Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465A735341
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFSKni (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjFSKnU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:43:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6A1735
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C863460B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB0BC433C9;
        Mon, 19 Jun 2023 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171376;
        bh=X77fEewRRbsc242A1IvEOhtkWHLN2cEUzLtxn19E3S8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkhQv2ivVZbz9nmknTviHUrTAjPfLFQUHUgrPIzqfyTJMLC4LHnMCsCM50l9Yl1Wf
         WpckGwPpcr03ACwqkST+uDCVZfseJvMageDmFv2DGzFc+RAIhtqfBK1HSdBbfL3vw2
         FV7ZHJjnk+0e4wKwFDy51H3rfuFv3dZ+KpAggujE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 001/166] x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed
Date:   Mon, 19 Jun 2023 12:27:58 +0200
Message-ID: <20230619102154.662888016@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

From: Tom Lendacky <thomas.lendacky@amd.com>

[ Upstream commit a37f2699c36a7f6606ba3300f243227856c5ad6b ]

The call to startup_64_setup_env() will install a new GDT but does not
actually switch to using the KERNEL_CS entry until returning from the
function call.

Commit bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in
boot") moved the call to sme_enable() earlier in the boot process and in
between the call to startup_64_setup_env() and the switch to KERNEL_CS.
An SEV-ES or an SEV-SNP guest will trigger #VC exceptions during the call
to sme_enable() and if the CS pushed on the stack as part of the exception
and used by IRETQ is not mapped by the new GDT, then problems occur.
Today, the current CS when entering startup_64 is the kernel CS value
because it was set up by the decompressor code, so no issue is seen.

However, a recent patchset that looked to avoid using the legacy
decompressor during an EFI boot exposed this bug. At entry to startup_64,
the CS value is that of EFI and is not mapped in the new kernel GDT. So
when a #VC exception occurs, the CS value used by IRETQ is not valid and
the guest boot crashes.

Fix this issue by moving the block that switches to the KERNEL_CS value to
be done immediately after returning from startup_64_setup_env().

Fixes: bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in boot")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/all/6ff1f28af2829cc9aea357ebee285825f90a431f.1684340801.git.thomas.lendacky%40amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/head_64.S | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d860d437631b6..998cdb112b725 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -85,6 +85,15 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	startup_64_setup_env
 	popq	%rsi
 
+	/* Now switch to __KERNEL_CS so IRET works reliably */
+	pushq	$__KERNEL_CS
+	leaq	.Lon_kernel_cs(%rip), %rax
+	pushq	%rax
+	lretq
+
+.Lon_kernel_cs:
+	UNWIND_HINT_EMPTY
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
 	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
@@ -98,15 +107,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	popq	%rsi
 #endif
 
-	/* Now switch to __KERNEL_CS so IRET works reliably */
-	pushq	$__KERNEL_CS
-	leaq	.Lon_kernel_cs(%rip), %rax
-	pushq	%rax
-	lretq
-
-.Lon_kernel_cs:
-	UNWIND_HINT_EMPTY
-
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
-- 
2.39.2



