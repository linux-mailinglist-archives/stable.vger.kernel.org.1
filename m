Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA81713FDB
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjE1Ttt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjE1Tts (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA93F9C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 521D962023
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E33C433EF;
        Sun, 28 May 2023 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303386;
        bh=Ima5WBTGAQip3VNZZXYRFN57qAXgEIT9Tl8MIGXwSL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWQytnvEN3bQBQQycRweuTBucROQKc2Tkd8JrYhMlKCVMerJVHN2nHbGdRS2egfRI
         vLLRnXgic/v54C0LL7TqILqCh72XhbDnM6BsYl8XXgiXWG2Sha3dVdKX1DhWf+SkU9
         XLhY28Rx3XK9ZCY6WRsXJlx+PKWM1F7R3TlGIj4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vernon Lovejoy <vlovejoy@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.15 55/69] x86/show_trace_log_lvl: Ensure stack pointer is aligned, again
Date:   Sun, 28 May 2023 20:12:15 +0100
Message-Id: <20230528190830.426912582@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Vernon Lovejoy <vlovejoy@redhat.com>

commit 2e4be0d011f21593c6b316806779ba1eba2cd7e0 upstream.

The commit e335bb51cc15 ("x86/unwind: Ensure stack pointer is aligned")
tried to align the stack pointer in show_trace_log_lvl(), otherwise the
"stack < stack_info.end" check can't guarantee that the last read does
not go past the end of the stack.

However, we have the same problem with the initial value of the stack
pointer, it can also be unaligned. So without this patch this trivial
kernel module

	#include <linux/module.h>

	static int init(void)
	{
		asm volatile("sub    $0x4,%rsp");
		dump_stack();
		asm volatile("add    $0x4,%rsp");

		return -EAGAIN;
	}

	module_init(init);
	MODULE_LICENSE("GPL");

crashes the kernel.

Fixes: e335bb51cc15 ("x86/unwind: Ensure stack pointer is aligned")
Signed-off-by: Vernon Lovejoy <vlovejoy@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20230512104232.GA10227@redhat.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/dumpstack.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,7 +195,6 @@ static void show_trace_log_lvl(struct ta
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
-	stack = stack ? : get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -214,9 +213,13 @@ static void show_trace_log_lvl(struct ta
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+	for (stack = stack ?: get_stack_pointer(task, regs);
+	     stack;
+	     stack = stack_info.next_sp) {
 		const char *stack_name;
 
+		stack = PTR_ALIGN(stack, sizeof(long));
+
 		if (get_stack_info(stack, task, &stack_info, &visit_mask)) {
 			/*
 			 * We weren't on a valid stack.  It's possible that


