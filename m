Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D160C701538
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 10:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEMISA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 04:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMISA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 04:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D7270E
        for <stable@vger.kernel.org>; Sat, 13 May 2023 01:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D582261032
        for <stable@vger.kernel.org>; Sat, 13 May 2023 08:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC8DC433EF;
        Sat, 13 May 2023 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683965878;
        bh=Z7gtOPLjHOKkSot2CCmeQQfT8ln1TYmmf6CEWXzLGyg=;
        h=Subject:To:Cc:From:Date:From;
        b=j6N8oaVIURydvmEjkNm88yYe8UiQzl1bqHWxi0fWiilnIZh75nchy7Sl6lpK7+2ar
         wwPTrvD1PnangGxr6eOd7G0xSGSbX8w/rC5yDpYi8NsIY8wryQdiYPoxlTy4/d/RO7
         MtRWgSrOukcvtNpAdn0uJyE25xXvxPR8Dmb5gZc4=
Subject: FAILED: patch "[PATCH] x86/retbleed: Fix return thunk alignment" failed to apply to 5.10-stable tree
To:     bp@alien8.de, stable@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 17:17:08 +0900
Message-ID: <2023051308-reflected-pessimism-42d1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9a48d604672220545d209e9996c2a1edbb5637f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051308-reflected-pessimism-42d1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

9a48d6046722 ("x86/retbleed: Fix return thunk alignment")
a149180fbcf3 ("x86: Add magic AMD return-thunk")
d9e9d2300681 ("x86,objtool: Create .return_sites")
15e67227c49a ("x86: Undo return-thunk damage")
0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
369ae6ffc41a ("x86/retpoline: Cleanup some #ifdefery")
a883d624aed4 ("x86/cpufeatures: Move RETPOLINE flags to word 11")
22922deae13f ("Merge tag 'objtool-core-2022-05-23' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a48d604672220545d209e9996c2a1edbb5637f6 Mon Sep 17 00:00:00 2001
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 12 May 2023 23:12:26 +0200
Subject: [PATCH] x86/retbleed: Fix return thunk alignment

SYM_FUNC_START_LOCAL_NOALIGN() adds an endbr leading to this layout
(leaving only the last 2 bytes of the address):

  3bff <zen_untrain_ret>:
  3bff:       f3 0f 1e fa             endbr64
  3c03:       f6                      test   $0xcc,%bl

  3c04 <__x86_return_thunk>:
  3c04:       c3                      ret
  3c05:       cc                      int3
  3c06:       0f ae e8                lfence

However, "the RET at __x86_return_thunk must be on a 64 byte boundary,
for alignment within the BTB."

Use SYM_START instead.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 27ef53fab6bd..b3b1e376dce8 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -144,8 +144,8 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  */
 	.align 64
 	.skip 63, 0xcc
-SYM_FUNC_START_NOALIGN(zen_untrain_ret);
-
+SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	ANNOTATE_NOENDBR
 	/*
 	 * As executed from zen_untrain_ret, this is:
 	 *

