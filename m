Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B348C70C4F0
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjEVSFv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjEVSFu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338DC6
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E8EB62600
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ADDC433EF;
        Mon, 22 May 2023 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778748;
        bh=U886QXtzxZNhS3Kn0xHmRRxjRr+BVVKh0/yLlWsuGlY=;
        h=Subject:To:Cc:From:Date:From;
        b=AMGAtyF8fF8BMvXBQcw92p3TnYC6TTFgBjt6c1Hjrs6Mz447o1lx/FLOqZUr/o1Gi
         rLDQumBkiNgVxPA91kO1aHnKi/ihgowssajYp9DCF76xE68Anv7SmoS03HIApx/lzi
         Vm8NjMMcmuEIssg7faFp82jL8VRTykm01ShyZ20Q=
Subject: FAILED: patch "[PATCH] fprobe: make fprobe_kprobe_handler recursion free" failed to apply to 6.3-stable tree
To:     zegao2021@gmail.com, mhiramat@kernel.org, zegao@tencent.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 19:05:46 +0100
Message-ID: <2023052246-hardness-spoiling-5f03@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 3cc4e2c5fbae84e5033723fb7e350bc6c164e3a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052246-hardness-spoiling-5f03@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

3cc4e2c5fbae ("fprobe: make fprobe_kprobe_handler recursion free")
6049674b5720 ("tracing: fprobe: Initialize ret valiable to fix smatch error")
39d954200bf6 ("fprobe: Skip exit_handler if entry_handler returns !0")
7e7ef1bfe552 ("lib/test_fprobe: Add a test case for nr_maxactive")
34cabf8fd18f ("lib/test_fprobe: Add private entry_data testcases")
76d0de5729c0 ("fprobe: Pass entry_data to handlers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3cc4e2c5fbae84e5033723fb7e350bc6c164e3a2 Mon Sep 17 00:00:00 2001
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 17 May 2023 11:45:07 +0800
Subject: [PATCH] fprobe: make fprobe_kprobe_handler recursion free

Current implementation calls kprobe related functions before doing
ftrace recursion check in fprobe_kprobe_handler, which opens door
to kernel crash due to stack recursion if preempt_count_{add, sub}
is traceable in kprobe_busy_{begin, end}.

Things goes like this without this patch quoted from Steven:
"
fprobe_kprobe_handler() {
   kprobe_busy_begin() {
      preempt_disable() {
         preempt_count_add() {  <-- trace
            fprobe_kprobe_handler() {
		[ wash, rinse, repeat, CRASH!!! ]
"

By refactoring the common part out of fprobe_kprobe_handler and
fprobe_handler and call ftrace recursion detection at the very beginning,
the whole fprobe_kprobe_handler is free from recursion.

[ Fix the indentation of __fprobe_handler() parameters. ]

Link: https://lore.kernel.org/all/20230517034510.15639-3-zegao@tencent.com/

Fixes: ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag for fprobe")
Signed-off-by: Ze Gao <zegao@tencent.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 293184227394..7a692c02f787 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -20,30 +20,22 @@ struct fprobe_rethook_node {
 	char data[];
 };
 
-static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
-			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
+			struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
 	struct fprobe_rethook_node *fpr;
 	struct rethook_node *rh = NULL;
 	struct fprobe *fp;
 	void *entry_data = NULL;
-	int bit, ret = 0;
+	int ret = 0;
 
 	fp = container_of(ops, struct fprobe, ops);
-	if (fprobe_disabled(fp))
-		return;
-
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
-	if (bit < 0) {
-		fp->nmissed++;
-		return;
-	}
 
 	if (fp->exit_handler) {
 		rh = rethook_try_get(fp->rethook);
 		if (!rh) {
 			fp->nmissed++;
-			goto out;
+			return;
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
@@ -61,23 +53,60 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 		else
 			rethook_hook(rh, ftrace_get_regs(fregs), true);
 	}
-out:
+}
+
+static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
+		struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe *fp;
+	int bit;
+
+	fp = container_of(ops, struct fprobe, ops);
+	if (fprobe_disabled(fp))
+		return;
+
+	/* recursion detection has to go before any traceable function and
+	 * all functions before this point should be marked as notrace
+	 */
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+	__fprobe_handler(ip, parent_ip, ops, fregs);
 	ftrace_test_recursion_unlock(bit);
+
 }
 NOKPROBE_SYMBOL(fprobe_handler);
 
 static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	struct fprobe *fp = container_of(ops, struct fprobe, ops);
+	struct fprobe *fp;
+	int bit;
+
+	fp = container_of(ops, struct fprobe, ops);
+	if (fprobe_disabled(fp))
+		return;
+
+	/* recursion detection has to go before any traceable function and
+	 * all functions called before this point should be marked as notrace
+	 */
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
 
 	if (unlikely(kprobe_running())) {
 		fp->nmissed++;
 		return;
 	}
+
 	kprobe_busy_begin();
-	fprobe_handler(ip, parent_ip, ops, fregs);
+	__fprobe_handler(ip, parent_ip, ops, fregs);
 	kprobe_busy_end();
+	ftrace_test_recursion_unlock(bit);
 }
 
 static void fprobe_exit_handler(struct rethook_node *rh, void *data,

