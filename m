Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5317C7462E9
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGCSzt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGCSzr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D02E7C
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83E7960FFA
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F851C433C7;
        Mon,  3 Jul 2023 18:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410542;
        bh=qgzvZu13hNX2J+CNO5nJBOls9U92Y9tmRI4PsdQ8R18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTO3abg8NZJPR30h6XH4tbftXPJisfKbu5jz8ZgW3ex8ujr3jhVSLrOdi1AMbK9wa
         6vKH9t27vf/gn8K2XdAjuA5NJFJJiYk2C7K4VscDT5lBtYs39f+IEpBUoH9ZU/lQji
         Lwp0fMy1L6DLwazgtGAILyIycYbPyRakaTfF6kxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John David Anglin <dave.anglin@bell.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.4 05/13] execve: always mark stack as growing down during early stack setup
Date:   Mon,  3 Jul 2023 20:54:06 +0200
Message-ID: <20230703184519.428932956@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.261119397@linuxfoundation.org>
References: <20230703184519.261119397@linuxfoundation.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

commit f66066bc5136f25e36a2daff4896c768f18c211e upstream.

While our user stacks can grow either down (all common architectures) or
up (parisc and the ia64 register stack), the initial stack setup when we
copy the argument and environment strings to the new stack at execve()
time is always done by extending the stack downwards.

But it turns out that in commit 8d7071af8907 ("mm: always expand the
stack with the mmap write lock held"), as part of making the stack
growing code more robust, 'expand_downwards()' was now made to actually
check the vma flags:

	if (!(vma->vm_flags & VM_GROWSDOWN))
		return -EFAULT;

and that meant that this execve-time stack expansion started failing on
parisc, because on that architecture, the stack flags do not contain the
VM_GROWSDOWN bit.

At the same time the new check in expand_downwards() is clearly correct,
and simplified the callers, so let's not remove it.

The solution is instead to just codify the fact that yes, during
execve(), the stack grows down.  This not only matches reality, it ends
up being particularly simple: we already have special execve-time flags
for the stack (VM_STACK_INCOMPLETE_SETUP) and use those flags to avoid
page migration during this setup time (see vma_is_temporary_stack() and
invalid_migration_vma()).

So just add VM_GROWSDOWN to that set of temporary flags, and now our
stack flags automatically match reality, and the parisc stack expansion
works again.

Note that the VM_STACK_INCOMPLETE_SETUP bits will be cleared when the
stack is finalized, so we only add the extra VM_GROWSDOWN bit on
CONFIG_STACK_GROWSUP architectures (ie parisc) rather than adding it in
general.

Link: https://lore.kernel.org/all/612eaa53-6904-6e16-67fc-394f4faa0e16@bell.net/
Link: https://lore.kernel.org/all/5fd98a09-4792-1433-752d-029ae3545168@gmx.de/
Fixes: 8d7071af8907 ("mm: always expand the stack with the mmap write lock held")
Reported-by: John David Anglin <dave.anglin@bell.net>
Reported-and-tested-by: Helge Deller <deller@gmx.de>
Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -377,7 +377,7 @@ extern unsigned int kobjsize(const void
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 
 /* Bits set in the VMA until the stack is in its final location */
-#define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
+#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
 
 #define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
 
@@ -399,8 +399,10 @@ extern unsigned int kobjsize(const void
 
 #ifdef CONFIG_STACK_GROWSUP
 #define VM_STACK	VM_GROWSUP
+#define VM_STACK_EARLY	VM_GROWSDOWN
 #else
 #define VM_STACK	VM_GROWSDOWN
+#define VM_STACK_EARLY	0
 #endif
 
 #define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)


