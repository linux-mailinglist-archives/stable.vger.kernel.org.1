Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A647DD509
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376261AbjJaRqh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376371AbjJaRqf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:46:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FB2A6
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:46:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24DEC433C9;
        Tue, 31 Oct 2023 17:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774392;
        bh=o7VNhG9Mv9712cfsEQbDs1sR3yHbJx+JciECrw8e+Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIMdKLO7lH4yXPJfDZl3tbscjG7/Idk9sMZDskg/OttIlvAcFAL0tSTNNLsQp5TVR
         4qr5WpIK2oDMqfN5M+4BeEZaY6VwBde0ge8YmvTA2998bA2OLq9bYYMsDpJFbAVJqo
         8tHOU4arWYj/QPtOLUXuap7QTp62pvRLkeiNuAHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sebastian Ott <sebott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 023/112] mm: fix vm_brk_flags() to not bail out while holding lock
Date:   Tue, 31 Oct 2023 18:00:24 +0100
Message-ID: <20231031165902.048967020@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Ott <sebott@redhat.com>

commit e0f81ab1e4f42ffece6440dc78f583eb352b9a71 upstream.

Calling vm_brk_flags() with flags set other than VM_EXEC will exit the
function without releasing the mmap_write_lock.

Just do the sanity check before the lock is acquired.  This doesn't fix an
actual issue since no caller sets a flag other than VM_EXEC.

Link: https://lkml.kernel.org/r/20230929171937.work.697-kees@kernel.org
Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3136,13 +3136,13 @@ int vm_brk_flags(unsigned long addr, uns
 	if (!len)
 		return 0;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) != 0)
 		return -EINVAL;
 
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
 	ret = check_brk_limits(addr, len);
 	if (ret)
 		goto limits_failed;


