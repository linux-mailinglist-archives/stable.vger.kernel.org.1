Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D17879BFAD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355503AbjIKWAF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbjIKPBM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:01:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCEF1B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:01:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30933C433C8;
        Mon, 11 Sep 2023 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444467;
        bh=v/sBwy1mNa17gIt5A5LGiVy+dHI2zgDJfXb/Z+r8EiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1476ZThvzjl87SObds7MFN18x0L0QIEgnJnhhNnK2AGYC8zRCmH9E3WoSs5Kuh8xJ
         oVimyToXjlJlmSJhtgh7mkET1MKLtjotDGnJhiFwrIprbZM9o4d9pn6mnG3ALdOsvi
         tSSchRUMNl0d8QBQTBqenGVZ+Metb8EvT3wSkBhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 733/737] memfd: improve userspace warnings for missing exec-related flags
Date:   Mon, 11 Sep 2023 15:49:52 +0200
Message-ID: <20230911134710.986885489@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksa Sarai <cyphar@cyphar.com>

[ Upstream commit 434ed3350f57c03a9654fe0619755cc137a58935 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index d65485c762def..aa46521057ab1 100644
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
-- 
2.40.1



