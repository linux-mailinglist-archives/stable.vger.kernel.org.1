Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794F973522C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjFSKcL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjFSKby (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:31:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D362218C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62F8D60B5E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E6C433C0;
        Mon, 19 Jun 2023 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170712;
        bh=/I/C8cIaL5gPR9Fb6/NVrBtqeUweLiRSbCmm5pXEwRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZoTqalVW29sDym9fufp8QqwgRp1jRxbE4wq1BcXQcH/91X4sQjr6s0RNkjCkcFV9
         q8EAq3kbEvVUaYwePh1fUdvDKeq6871nmxUv936mDZcbmHRAaMBrz8aiquzh6RlAgq
         FrEpRsydPzfIChB2PFKkXnG9yJpN9DEft3Gz3l4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 001/187] x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed
Date:   Mon, 19 Jun 2023 12:26:59 +0200
Message-ID: <20230619102157.683564289@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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
index 222efd4a09bc8..f047723c6ca5d 100644
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



