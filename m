Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1191779B43B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348499AbjIKV1G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbjIKO0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:26:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2638FDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:26:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675FAC433C9;
        Mon, 11 Sep 2023 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442359;
        bh=U+rdpYITGSATQnSbvs7W8O7fAgVegDAVV8V7I8IEOLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgsDQ8fOHFj+WAK8KdIzeDCGoXPXKDa6fyAcs9u3GaE4Aibx0/KiKRvIYx6CMUpVq
         TOiqRwRzAFKAseRZ1lFTugRB0kc5WLOum0LXbaQJEIbn7qezt8PHDsBpTVFDduD31b
         hCghmgbZksR9cLgy+G7noVJywdxu/m7uaBqYXx/I=
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
Subject: [PATCH 6.5 738/739] revert "memfd: improve userspace warnings for missing exec-related flags".
Date:   Mon, 11 Sep 2023 15:48:57 +0200
Message-ID: <20230911134711.671046183@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
@@ -316,7 +316,7 @@ SYSCALL_DEFINE2(memfd_create,
 		return -EINVAL;
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		pr_info_ratelimited(
+		pr_warn_once(
 			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
 			current->comm, task_pid_nr(current));
 	}


