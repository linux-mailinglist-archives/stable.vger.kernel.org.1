Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191C4713A98
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjE1Qhf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE1Qhe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2862A7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DAB160ECA
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A51DC433D2;
        Sun, 28 May 2023 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685291852;
        bh=IB3z7UqTfyQkJIWAZuXBFgii2ORsuBDwFA0+Qjr23kw=;
        h=Subject:To:Cc:From:Date:From;
        b=mT81WHstm+/EZ/Gl0JlY3wudpioJ5C6Fca0r1YhGIwIn1q3P/CJ2JSgOpaWkeAiRA
         qZLINwlbo0uW84XbNUpCwTDmSBIL2NJGqza64g4BzA0/18r6DgWj795qvgU/O0TJ13
         cpRwGRbTImF2wyF9eQFzLBkUyyZdf57pOERMUOT4=
Subject: FAILED: patch "[PATCH] bpf: Fix mask generation for 32-bit narrow loads of 64-bit" failed to apply to 4.14-stable tree
To:     will@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, krzesimir@kinvolk.io, rdna@fb.com,
        yhs@fb.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:37:30 +0100
Message-ID: <2023052830-mothproof-folic-5a0f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 0613d8ca9ab382caabe9ed2dceb429e9781e443f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052830-mothproof-folic-5a0f@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

0613d8ca9ab3 ("bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields")
e2f7fc0ac695 ("bpf: fix undefined behavior in narrow load handling")
46f53a65d2de ("bpf: Allow narrow loads with offset > 0")
bc23105ca0ab ("bpf: fix context access in tracing progs on 32 bit archs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0613d8ca9ab382caabe9ed2dceb429e9781e443f Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Thu, 18 May 2023 11:25:28 +0100
Subject: [PATCH] bpf: Fix mask generation for 32-bit narrow loads of 64-bit
 fields

A narrow load from a 64-bit context field results in a 64-bit load
followed potentially by a 64-bit right-shift and then a bitwise AND
operation to extract the relevant data.

In the case of a 32-bit access, an immediate mask of 0xffffffff is used
to construct a 64-bit BPP_AND operation which then sign-extends the mask
value and effectively acts as a glorified no-op. For example:

0:	61 10 00 00 00 00 00 00	r0 = *(u32 *)(r1 + 0)

results in the following code generation for a 64-bit field:

	ldr	x7, [x7]	// 64-bit load
	mov	x10, #0xffffffffffffffff
	and	x7, x7, x10

Fix the mask generation so that narrow loads always perform a 32-bit AND
operation:

	ldr	x7, [x7]	// 64-bit load
	mov	w10, #0xffffffff
	and	w7, w7, w10

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Krzesimir Nowak <krzesimir@kinvolk.io>
Cc: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Fixes: 31fd85816dbe ("bpf: permits narrower load from bpf program context fields")
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20230518102528.1341-1-will@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fbcf5a4e2fcd..5871aa78d01a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17033,7 +17033,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
 									insn->dst_reg,
 									shift);
-				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
+				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
 								(1ULL << size * 8) - 1);
 			}
 		}

