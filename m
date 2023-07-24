Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0E075FC07
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGXQ1K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjGXQ1J (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 12:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C15B1BC;
        Mon, 24 Jul 2023 09:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F3366126B;
        Mon, 24 Jul 2023 16:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E340C433C7;
        Mon, 24 Jul 2023 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690216020;
        bh=2nirOMCPqTa3XQnumUz/H3AXphuRwUYczlTpTHNPR2Y=;
        h=Date:To:From:Subject:From;
        b=v4/uW+fwWewB7ngyGFXK+DFv56ZznMiHix/ZWj88RbGgg2VRLbGw5gp6nPTRwnIC7
         0pUICKIulY9KcV2+IUC5fpaoQP4WxNdHfJxQTrLHZPzZYiih/DK1spkbrmyCnGI1xG
         A59A9fJJcg5fuNDvvk7lXxUXjjpQ9zgcIlwSWk8Y=
Date:   Mon, 24 Jul 2023 09:26:59 -0700
To:     mm-commits@vger.kernel.org, yang.guang5@zte.com.cn,
        stable@vger.kernel.org, richard@nod.at, lkp@intel.com,
        linux@rasmusvillemoes.dk, johannes@sipsolutions.net,
        Jason@zx2c4.com, herve.codina@bootlin.com,
        anton.ivanov@cambridgegreys.com, andriy.shevchenko@linux.intel.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + revert-um-use-swap-to-make-code-cleaner.patch added to mm-hotfixes-unstable branch
Message-Id: <20230724162700.7E340C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: Revert "um: Use swap() to make code cleaner"
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     revert-um-use-swap-to-make-code-cleaner.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/revert-um-use-swap-to-make-code-cleaner.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Revert "um: Use swap() to make code cleaner"
Date: Mon, 24 Jul 2023 17:31:31 +0300

This reverts commit 9b0da3f22307af693be80f5d3a89dc4c7f360a85.

The sigio.c is clearly user space code which is handled by
arch/um/scripts/Makefile.rules (see USER_OBJS rule).

The above mentioned commit simply broke this agreement,
we may not use Linux kernel internal headers in them without
thorough thinking.

Hence, revert the wrong commit.

Link: https://lkml.kernel.org/r/20230724143131.30090-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307212304.cH79zJp1-lkp@intel.com/
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Richard Weinberger <richard@nod.at>
Cc: Yang Guang <yang.guang5@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/um/os-Linux/sigio.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/um/os-Linux/sigio.c~revert-um-use-swap-to-make-code-cleaner
+++ a/arch/um/os-Linux/sigio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2002 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
-#include <linux/minmax.h>
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -51,7 +50,7 @@ static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
-	struct pollfds *fds;
+	struct pollfds *fds, tmp;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
@@ -78,7 +77,9 @@ static int write_sigio_thread(void *unus
 					       "write_sigio_thread : "
 					       "read on socket failed, "
 					       "err = %d\n", errno);
-				swap(current_poll, next_poll);
+				tmp = current_poll;
+				current_poll = next_poll;
+				next_poll = tmp;
 				respond_fd = sigio_private[1];
 			}
 			else {
_

Patches currently in -mm which might be from andriy.shevchenko@linux.intel.com are

revert-um-use-swap-to-make-code-cleaner.patch
kernelh-split-out-count_args-and-concatenate-to-argsh.patch
x86-asm-replace-custom-count_args-concatenate-implementations.patch
arm64-smccc-replace-custom-count_args-concatenate-implementations.patch
genetlink-replace-custom-concatenate-implementation.patch

