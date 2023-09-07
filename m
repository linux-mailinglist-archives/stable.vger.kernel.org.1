Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74A7973A7
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbjIGP2y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 11:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjIGPXH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:23:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8651CCA
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:22:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CA2C4AF7D;
        Thu,  7 Sep 2023 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694099077;
        bh=P/gJ2htYj0a1P0CE0q1Fg/2lY3og3ZNxCMrrXSAc/Gk=;
        h=Subject:To:Cc:From:Date:From;
        b=MiDj+UPGpqsAxxOm818JvYpJlCMJi3AifDt/T2fvA0rh3TWPoULETMHhB1oB5veWQ
         3Y8ADJAGU3KId6jQx9TQzeEvHJA3vLKgQ65TZfvWTQN28nnnTns5986KzALbmIklsW
         cDvKGuh0Yaq6uD20eW598V+TNA0HPS9/LZ1zg+Os=
Subject: FAILED: patch "[PATCH] revert "memfd: improve userspace warnings for missing" failed to apply to 6.5-stable tree
To:     akpm@linux-foundation.org, brauner@kernel.org, cyphar@cyphar.com,
        dtometzki@fedoraproject.org, dverkamp@chromium.org,
        jeffxu@google.com, keescook@chromium.org, shuah@kernel.org,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 07 Sep 2023 16:04:34 +0100
Message-ID: <2023090734-sudoku-catalyze-ef01@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 2562d67b1bdf91c7395b0225d60fdeb26b4bc5a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090734-sudoku-catalyze-ef01@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

2562d67b1bdf ("revert "memfd: improve userspace warnings for missing exec-related flags".")
434ed3350f57 ("memfd: improve userspace warnings for missing exec-related flags")
202e14222fad ("memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=2")
badbbcd76545 ("selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED")
72de25913022 ("mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2562d67b1bdf91c7395b0225d60fdeb26b4bc5a0 Mon Sep 17 00:00:00 2001
From: Andrew Morton <akpm@linux-foundation.org>
Date: Sat, 2 Sep 2023 15:59:31 -0700
Subject: [PATCH] revert "memfd: improve userspace warnings for missing
 exec-related flags".

This warning is telling userspace developers to pass MFD_EXEC and
MFD_NOEXEC_SEAL to memfd_create().  Commit 434ed3350f57 ("memfd: improve
userspace warnings for missing exec-related flags") made the warning more
frequent and visible in the hope that this would accelerate the fixing of
errant userspace.

But the overall effect is to generate far too much dmesg noise.

Fixes: 434ed3350f57 ("memfd: improve userspace warnings for missing exec-related flags")
Reported-by: Damian Tometzki <dtometzki@fedoraproject.org>
Closes: https://lkml.kernel.org/r/ZPFzCSIgZ4QuHsSC@fedora.fritz.box
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memfd.c b/mm/memfd.c
index 1cad1904fc26..2dba2cb6f0d0 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -316,7 +316,7 @@ SYSCALL_DEFINE2(memfd_create,
 		return -EINVAL;
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		pr_info_ratelimited(
+		pr_warn_once(
 			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
 			current->comm, task_pid_nr(current));
 	}

