Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F957B89C4
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbjJDS3F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbjJDS3F (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:29:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40AABF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:29:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8D9C433C7;
        Wed,  4 Oct 2023 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444140;
        bh=XOklIZq5LB8LR5vhTggytVTp4xqkz63gvVjB/nEubLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFvAFcmV5Z++LgvprDFyHYAs+e6gSndDzwxJJSINrVLt+jym2QMR0/qq7L1nPzOje
         RlJUnpmLF0Mldv8ye8Zx3i/lUTeGiX7dowKpyYSHXW0I8aeUqyFr+JoODdK0ZraMX5
         57sPUuay5hHNMpFHirl/QodNCXTAeqkbhIhtq+GU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joe Lawrence <joe.lawrence@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 144/321] powerpc/stacktrace: Fix arch_stack_walk_reliable()
Date:   Wed,  4 Oct 2023 19:54:49 +0200
Message-ID: <20231004175235.919628542@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit c5cc3ca707bc916a3f326364751a41f25040aef3 ]

The changes to copy_thread() made in commit eed7c420aac7 ("powerpc:
copy_thread differentiate kthreads and user mode threads") inadvertently
broke arch_stack_walk_reliable() because it has knowledge of the stack
layout.

Fix it by changing the condition to match the new logic in
copy_thread(). The changes make the comments about the stack layout
incorrect, rather than rephrasing them just refer the reader to
copy_thread().

Also the comment about the stack backchain is no longer true, since
commit edbd0387f324 ("powerpc: copy_thread add a back chain to the
switch stack frame"), so remove that as well.

Fixes: eed7c420aac7 ("powerpc: copy_thread differentiate kthreads and user mode threads")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230921232441.1181843-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/stacktrace.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index b15f15dcacb5c..e6a958a5da276 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -73,29 +73,12 @@ int __no_sanitize_address arch_stack_walk_reliable(stack_trace_consume_fn consum
 	bool firstframe;
 
 	stack_end = stack_page + THREAD_SIZE;
-	if (!is_idle_task(task)) {
-		/*
-		 * For user tasks, this is the SP value loaded on
-		 * kernel entry, see "PACAKSAVE(r13)" in _switch() and
-		 * system_call_common().
-		 *
-		 * Likewise for non-swapper kernel threads,
-		 * this also happens to be the top of the stack
-		 * as setup by copy_thread().
-		 *
-		 * Note that stack backlinks are not properly setup by
-		 * copy_thread() and thus, a forked task() will have
-		 * an unreliable stack trace until it's been
-		 * _switch()'ed to for the first time.
-		 */
-		stack_end -= STACK_USER_INT_FRAME_SIZE;
-	} else {
-		/*
-		 * idle tasks have a custom stack layout,
-		 * c.f. cpu_idle_thread_init().
-		 */
+
+	// See copy_thread() for details.
+	if (task->flags & PF_KTHREAD)
 		stack_end -= STACK_FRAME_MIN_SIZE;
-	}
+	else
+		stack_end -= STACK_USER_INT_FRAME_SIZE;
 
 	if (task == current)
 		sp = current_stack_frame();
-- 
2.40.1



