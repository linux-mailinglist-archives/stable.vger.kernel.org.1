Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB217799F57
	for <lists+stable@lfdr.de>; Sun, 10 Sep 2023 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjIJSa5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 10 Sep 2023 14:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjIJSa5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 10 Sep 2023 14:30:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC6ACC5
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 11:30:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD0CC433C7;
        Sun, 10 Sep 2023 18:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694370649;
        bh=uxbnUkw5Kg9gM2lPWmlcFPf7+jTzF3WYHDN2VW5475k=;
        h=Subject:To:Cc:From:Date:From;
        b=CAUPlgee1zG5PCv70YOjvAe4w9OwCgXieT06pKsciYkcNJcj81zHqEs9eoSnItCMn
         iekpiMbJKsDbCPyW9wxIErJJht0h45WbwwlKdbMqGpxHh2WIU62B9iQ9mSxmhjk8Ei
         3N30neVRJYfw1upPoXJr29gWKC9dKXuXIGoCoPJs=
Subject: FAILED: patch "[PATCH] x86/build: Fix linker fill bytes quirk/incompatibility for" failed to apply to 5.10-stable tree
To:     song@kernel.org, keescook@chromium.org, mingo@kernel.org,
        peterz@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 10 Sep 2023 19:30:34 +0100
Message-ID: <2023091034-applaud-urologist-8167@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 65e710899fd19f435f40268f3a92dfaa11f14470
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091034-applaud-urologist-8167@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65e710899fd19f435f40268f3a92dfaa11f14470 Mon Sep 17 00:00:00 2001
From: Song Liu <song@kernel.org>
Date: Wed, 6 Sep 2023 10:52:15 -0700
Subject: [PATCH] x86/build: Fix linker fill bytes quirk/incompatibility for
 ld.lld

With ":text =0xcccc", ld.lld fills unused text area with 0xcccc0000.
Example objdump -D output:

	ffffffff82b04203:       00 00                   add    %al,(%rax)
	ffffffff82b04205:       cc                      int3
	ffffffff82b04206:       cc                      int3
	ffffffff82b04207:       00 00                   add    %al,(%rax)
	ffffffff82b04209:       cc                      int3
	ffffffff82b0420a:       cc                      int3

Replace it with ":text =0xcccccccc", so we get the following instead:

	ffffffff82b04203:       cc                      int3
	ffffffff82b04204:       cc                      int3
	ffffffff82b04205:       cc                      int3
	ffffffff82b04206:       cc                      int3
	ffffffff82b04207:       cc                      int3
	ffffffff82b04208:       cc                      int3

gcc/ld doesn't seem to have the same issue. The generated code stays the
same for gcc/ld.

Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP for linker fill bytes")
Link: https://lore.kernel.org/r/20230906175215.2236033-1-song@kernel.org

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 83d41c2601d7..f15fb71f280e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -156,7 +156,7 @@ SECTIONS
 		ALIGN_ENTRY_TEXT_END
 		*(.gnu.warning)
 
-	} :text =0xcccc
+	} :text = 0xcccccccc
 
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;

