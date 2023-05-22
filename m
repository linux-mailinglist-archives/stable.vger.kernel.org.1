Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6170CA08
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjEVTyO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjEVTyN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE099
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD13862B66
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA776C433EF;
        Mon, 22 May 2023 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785251;
        bh=K8dOeuEo5kaVY4e4GU7nvlb5l2ckeWZF5afWSK/GFkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FneK2B5tygKatAb31rnwv5rTAC+m+2gsGSCcdP7AVlJWRrX5ggtOH9yt9WRYTGLIM
         Kf+NtC5Goo9R2XaIkFE7UXy2bcHmTC3aFabJZEN23p+Csl1/+RiKsvzeSfAASgWyCV
         tHfV8sv3YKu7DUIb0IoDvgEQ7HtZ1UiFnOQQYNuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ardb@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 361/364] ARM: 9297/1: vfp: avoid unbalanced stack on success return path
Date:   Mon, 22 May 2023 20:11:06 +0100
Message-Id: <20230522190421.798440267@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 2b951b0efbaa6c805854b60c11f08811054d50cd ]

Commit c76c6c4ecbec0deb5 ("ARM: 9294/2: vfp: Fix broken softirq handling
with instrumentation enabled") updated the VFP exception entry logic to
go via a C function, so that we get the compiler's version of
local_bh_disable(), which may be instrumented, and isn't generally
callable from assembler.

However, this assumes that passing an alternative 'success' return
address works in C as it does in asm, and this is only the case if the C
calls in question are tail calls, as otherwise, the stack will need some
unwinding as well.

I have already sent patches to the list that replace most of the asm
logic with C code, and so it is preferable to have a minimal fix that
addresses the issue and can be backported along with the commit that it

fixes to v6.3 from v6.4. Hopefully, we can land the C conversion for v6.5.

So instead of passing the 'success' return address as a function
argument, pass the stack address from where to pop it so that both LR
and SP have the expected value.

Fixes: c76c6c4ecbec0deb5 ("ARM: 9294/2: vfp: Fix broken softirq handling with ...")
Reported-by: syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com
Tested-by: syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/vfp/entry.S | 7 +++++--
 arch/arm/vfp/vfphw.S | 6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 7483ef8bccda3..62206ef250371 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -23,6 +23,9 @@
 @
 ENTRY(do_vfp)
 	mov	r1, r10
-	mov	r3, r9
-	b	vfp_entry
+	str	lr, [sp, #-8]!
+	add	r3, sp, #4
+	str	r9, [r3]
+	bl	vfp_entry
+	ldr	pc, [sp], #8
 ENDPROC(do_vfp)
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 4d8478264d82b..a4610d0f32152 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -172,13 +172,14 @@ vfp_hw_state_valid:
 					@ out before setting an FPEXC that
 					@ stops us reading stuff
 	VFPFMXR	FPEXC, r1		@ Restore FPEXC last
+	mov	sp, r3			@ we think we have handled things
+	pop	{lr}
 	sub	r2, r2, #4		@ Retry current instruction - if Thumb
 	str	r2, [sp, #S_PC]		@ mode it's two 16-bit instructions,
 					@ else it's one 32-bit instruction, so
 					@ always subtract 4 from the following
 					@ instruction address.
 
-	mov	lr, r3			@ we think we have handled things
 local_bh_enable_and_ret:
 	adr	r0, .
 	mov	r1, #SOFTIRQ_DISABLE_OFFSET
@@ -209,8 +210,9 @@ skip:
 
 process_exception:
 	DBGSTR	"bounce"
+	mov	sp, r3			@ setup for a return to the user code.
+	pop	{lr}
 	mov	r2, sp			@ nothing stacked - regdump is at TOS
-	mov	lr, r3			@ setup for a return to the user code.
 
 	@ Now call the C code to package up the bounce to the support code
 	@   r0 holds the trigger instruction
-- 
2.39.2



