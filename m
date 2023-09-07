Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EDC7973B2
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbjIGP3A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjIGPW5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:22:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138B184
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:22:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43155C4AF7C;
        Thu,  7 Sep 2023 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694099088;
        bh=z4J613rWdKVM3SJ40UJe+I+Q7Z44WoXTXDd09h57S3Y=;
        h=Subject:To:Cc:From:Date:From;
        b=IVZGQGuPAPbaoMgDUUIGmO1L/YtllnUraQIDfmEfIxWJnVjQEcMujV4QNTEc/d07u
         mxRnbxf+NmUjXkHHtxTvjDc03Z1FdctjbVADPtp5guTDmcUmHejf/UJnftHq4POLp8
         MTFOwCD6KACTSQXZIwoGNOOO0XcAftH7zmTP1/yw=
Subject: FAILED: patch "[PATCH] memfd: improve userspace warnings for missing exec-related" failed to apply to 6.4-stable tree
To:     cyphar@cyphar.com, akpm@linux-foundation.org,
        asmadeus@codewreck.org, brauner@kernel.org, dverkamp@chromium.org,
        keescook@chromium.org, shuah@kernel.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 07 Sep 2023 16:04:42 +0100
Message-ID: <2023090742-velocity-perjury-fa80@gregkh>
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 434ed3350f57c03a9654fe0619755cc137a58935
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090742-velocity-perjury-fa80@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:

434ed3350f57 ("memfd: improve userspace warnings for missing exec-related flags")
202e14222fad ("memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=2")
badbbcd76545 ("selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED")
72de25913022 ("mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 434ed3350f57c03a9654fe0619755cc137a58935 Mon Sep 17 00:00:00 2001
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 14 Aug 2023 18:40:59 +1000
Subject: [PATCH] memfd: improve userspace warnings for missing exec-related
 flags

In order to incentivise userspace to switch to passing MFD_EXEC and
MFD_NOEXEC_SEAL, we need to provide a warning on each attempt to call
memfd_create() without the new flags.  pr_warn_once() is not useful
because on most systems the one warning is burned up during the boot
process (on my system, systemd does this within the first second of boot)
and thus userspace will in practice never see the warnings to push them to
switch to the new flags.

The original patchset[1] used pr_warn_ratelimited(), however there were
concerns about the degree of spam in the kernel log[2,3].  The resulting
inability to detect every case was flagged as an issue at the time[4].

While we could come up with an alternative rate-limiting scheme such as
only outputting the message if vm.memfd_noexec has been modified, or only
outputting the message once for a given task, these alternatives have
downsides that don't make sense given how low-stakes a single kernel
warning message is.  Switching to pr_info_ratelimited() instead should be
fine -- it's possible some monitoring tool will be unhappy with a stream
of warning-level messages but there's already plenty of info-level message
spam in dmesg.

[1]: https://lore.kernel.org/20221215001205.51969-4-jeffxu@google.com/
[2]: https://lore.kernel.org/202212161233.85C9783FB@keescook/
[3]: https://lore.kernel.org/Y5yS8wCnuYGLHMj4@x1n/
[4]: https://lore.kernel.org/f185bb42-b29c-977e-312e-3349eea15383@linuxfoundation.org/

Link: https://lkml.kernel.org/r/20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com
Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memfd.c b/mm/memfd.c
index d65485c762de..aa46521057ab 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -315,7 +315,7 @@ SYSCALL_DEFINE2(memfd_create,
 		return -EINVAL;
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		pr_warn_once(
+		pr_info_ratelimited(
 			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
 			current->comm, task_pid_nr(current));
 	}

