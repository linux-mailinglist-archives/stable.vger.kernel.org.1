Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C6579AD5A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355438AbjIKV7e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbjIKPBP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:01:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ED4125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:01:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15789C433C8;
        Mon, 11 Sep 2023 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444470;
        bh=KBMnE5gJ/iYzShpyuMHPlSsWdEoOimTwsBy0LS90T6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcEggvVTiys53RzUB1jzxecFv0wDihPTJs111JCAbZlYlP56QLw8YS2/2A8m8wAeB
         jFDBApWJKoWWGt5WS/HI2m5ZzGahg5an7B7VvJlI0tNBLK7fjfFWLLLM4yk06F7nMe
         vIsHDvpMdRV8T5O/N+MGL0nIYyp8aYW0hTXLukVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Damian Tometzki <dtometzki@fedoraproject.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 734/737] revert "memfd: improve userspace warnings for missing exec-related flags".
Date:   Mon, 11 Sep 2023 15:49:53 +0200
Message-ID: <20230911134711.014652360@linuxfoundation.org>
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

From: Andrew Morton <akpm@linux-foundation.org>

commit 2562d67b1bdf91c7395b0225d60fdeb26b4bc5a0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memfd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -315,7 +315,7 @@ SYSCALL_DEFINE2(memfd_create,
 		return -EINVAL;
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		pr_info_ratelimited(
+		pr_warn_once(
 			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
 			current->comm, task_pid_nr(current));
 	}


