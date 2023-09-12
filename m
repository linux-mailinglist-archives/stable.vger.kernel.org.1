Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF879B2AC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358244AbjIKWIV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbjIKOYd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:24:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E89DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:24:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CE2C433C7;
        Mon, 11 Sep 2023 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442268;
        bh=U+3OVJbVH3GdJ786cIQeIEKNzyQXcx/Xo9BynLojblg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ix2WF9fwFOGhAARkBW8Bak4aVOd/poFF8875yVe8XVSPjVmrVOqTAUMKebVxIOJNf
         BBtejLgOTBc7MSCSeyTyUD0cONrbbS8R+l3EOHsd9nLFTcGZdgX6JfeOJwtCoMMngc
         V72EDHJohBNnWv2LJRQLhC8AWdOuxyOfqUNZKCnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.5 706/739] x86/MCE: Always save CS register on AMD Zen IF Poison errors
Date:   Mon, 11 Sep 2023 15:48:25 +0200
Message-ID: <20230911134710.806176990@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit 4240e2ebe67941ce2c4f5c866c3af4b5ac7a0c67 upstream.

The Instruction Fetch (IF) units on current AMD Zen-based systems do not
guarantee a synchronous #MC is delivered for poison consumption errors.
Therefore, MCG_STATUS[EIPV|RIPV] will not be set. However, the
microarchitecture does guarantee that the exception is delivered within
the same context. In other words, the exact rIP is not known, but the
context is known to not have changed.

There is no architecturally-defined method to determine this behavior.

The Code Segment (CS) register is always valid on such IF unit poison
errors regardless of the value of MCG_STATUS[EIPV|RIPV].

Add a quirk to save the CS register for poison consumption from the IF
unit banks.

This is needed to properly determine the context of the error.
Otherwise, the severity grading function will assume the context is
IN_KERNEL due to the m->cs value being 0 (the initialized value). This
leads to unnecessary kernel panics on data poison errors due to the
kernel believing the poison consumption occurred in kernel context.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230814200853.29258-1-yazen.ghannam@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mce/core.c     |   26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |    5 ++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -843,6 +843,26 @@ static noinstr bool quirk_skylake_repmov
 }
 
 /*
+ * Some Zen-based Instruction Fetch Units set EIPV=RIPV=0 on poison consumption
+ * errors. This means mce_gather_info() will not save the "ip" and "cs" registers.
+ *
+ * However, the context is still valid, so save the "cs" register for later use.
+ *
+ * The "ip" register is truly unknown, so don't save it or fixup EIPV/RIPV.
+ *
+ * The Instruction Fetch Unit is at MCA bank 1 for all affected systems.
+ */
+static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_regs *regs)
+{
+	if (bank != 1)
+		return;
+	if (!(m->status & MCI_STATUS_POISON))
+		return;
+
+	m->cs = regs->cs;
+}
+
+/*
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
@@ -861,6 +881,9 @@ static __always_inline int mce_no_way_ou
 		if (mce_flags.snb_ifu_quirk)
 			quirk_sandybridge_ifu(i, m, regs);
 
+		if (mce_flags.zen_ifu_quirk)
+			quirk_zen_ifu(i, m, regs);
+
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			mce_read_aux(m, i);
@@ -1842,6 +1865,9 @@ static int __mcheck_cpu_apply_quirks(str
 		if (c->x86 == 0x15 && c->x86_model <= 0xf)
 			mce_flags.overflow_recov = 1;
 
+		if (c->x86 >= 0x17 && c->x86 <= 0x1A)
+			mce_flags.zen_ifu_quirk = 1;
+
 	}
 
 	if (c->x86_vendor == X86_VENDOR_INTEL) {
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -157,6 +157,9 @@ struct mce_vendor_flags {
 	 */
 	smca			: 1,
 
+	/* Zen IFU quirk */
+	zen_ifu_quirk		: 1,
+
 	/* AMD-style error thresholding banks present. */
 	amd_threshold		: 1,
 
@@ -172,7 +175,7 @@ struct mce_vendor_flags {
 	/* Skylake, Cascade Lake, Cooper Lake REP;MOVS* quirk */
 	skx_repmov_quirk	: 1,
 
-	__reserved_0		: 56;
+	__reserved_0		: 55;
 };
 
 extern struct mce_vendor_flags mce_flags;


