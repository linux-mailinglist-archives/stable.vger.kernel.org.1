Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4AB713E64
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjE1TfV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjE1TfU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EC511F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:35:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA9E61DF2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C843C433EF;
        Sun, 28 May 2023 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302504;
        bh=xlj9Beh6OB0dw16yu4Loybvh6lRsj3LLLBEYSJNB8Ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFVRfaAkKVCkZqQaKB5gry6qJUTTdHKIXXAYePqicPr/viLqX3DRVUdFsXza+YotR
         Ua49r37tYaSXkGybyuy0AtlVMyK/3I4u1q1Zl4+ckGGPTbKzwDHRYkAJv98oMnjL7m
         zDXfoyS/f+FPq3lMUrioIWX2SIAcKdwQIm737TrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stan Johnson <userm57@yahoo.com>
Subject: [PATCH 6.1 029/119] m68k: Move signal frame following exception on 68020/030
Date:   Sun, 28 May 2023 20:10:29 +0100
Message-Id: <20230528190836.310666420@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Finn Thain <fthain@linux-m68k.org>

commit b845b574f86dcb6a70dfa698aa87a237b0878d2a upstream.

On 68030/020, an instruction such as, moveml %a2-%a3/%a5,%sp@- may cause
a stack page fault during instruction execution (i.e. not at an
instruction boundary) and produce a format 0xB exception frame.

In this situation, the value of USP will be unreliable.  If a signal is
to be delivered following the exception, this USP value is used to
calculate the location for a signal frame.  This can result in a
corrupted user stack.

The corruption was detected in dash (actually in glibc) where it showed
up as an intermittent "stack smashing detected" message and crash
following signal delivery for SIGCHLD.

It was hard to reproduce that failure because delivery of the signal
raced with the page fault and because the kernel places an unpredictable
gap of up to 7 bytes between the USP and the signal frame.

A format 0xB exception frame can be produced by a bus error or an
address error.  The 68030 Users Manual says that address errors occur
immediately upon detection during instruction prefetch.  The instruction
pipeline allows prefetch to overlap with other instructions, which means
an address error can arise during the execution of a different
instruction.  So it seems likely that this patch may help in the address
error case also.

Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Link: https://lore.kernel.org/all/CAMuHMdW3yD22_ApemzW_6me3adq6A458u1_F0v-1EYwK_62jPA@mail.gmail.com/
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: stable@vger.kernel.org
Co-developed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/9e66262a754fcba50208aa424188896cc52a1dd1.1683365892.git.fthain@linux-m68k.org
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/m68k/kernel/signal.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -858,11 +858,17 @@ static inline int rt_setup_ucontext(stru
 }
 
 static inline void __user *
-get_sigframe(struct ksignal *ksig, size_t frame_size)
+get_sigframe(struct ksignal *ksig, struct pt_regs *tregs, size_t frame_size)
 {
 	unsigned long usp = sigsp(rdusp(), ksig);
+	unsigned long gap = 0;
 
-	return (void __user *)((usp - frame_size) & -8UL);
+	if (CPU_IS_020_OR_030 && tregs->format == 0xb) {
+		/* USP is unreliable so use worst-case value */
+		gap = 256;
+	}
+
+	return (void __user *)((usp - gap - frame_size) & -8UL);
 }
 
 static int setup_frame(struct ksignal *ksig, sigset_t *set,
@@ -880,7 +886,7 @@ static int setup_frame(struct ksignal *k
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame) + fsize);
+	frame = get_sigframe(ksig, tregs, sizeof(*frame) + fsize);
 
 	if (fsize)
 		err |= copy_to_user (frame + 1, regs + 1, fsize);
@@ -952,7 +958,7 @@ static int setup_rt_frame(struct ksignal
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame));
+	frame = get_sigframe(ksig, tregs, sizeof(*frame));
 
 	if (fsize)
 		err |= copy_to_user (&frame->uc.uc_extra, regs + 1, fsize);


