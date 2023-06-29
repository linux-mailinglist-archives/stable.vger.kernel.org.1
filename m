Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4FE742C64
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjF2SsP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjF2SsO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CC82D62
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C29A61575
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAB4C433C0;
        Thu, 29 Jun 2023 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064492;
        bh=bI9D4P6dLTHH8C5rIBuO9SDUUcKuewKVbiECUG34xBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISGT5KloQ1twPsxrWSeBWj97Vxjp2MkL30D5pvRuGyxo8Z9zErww6VTvN3NlbIjU0
         HctJcx2JfAkLCE36qBHh5TlqkmvXWLQJKN1sl2FTN/ftE+N3rNNEC5ZPcER/g93F1u
         2UW3e3NwMHdxrAvKXgZhdn2FIJ/v5BIz0GyhvfE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 20/28] execve: expand new process stack manually ahead of time
Date:   Thu, 29 Jun 2023 20:44:08 +0200
Message-ID: <20230629184152.699200577@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
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

commit f313c51d26aa87e69633c9b46efb37a930faca71 upstream.

This is a small step towards a model where GUP itself would not expand
the stack, and any user that needs GUP to not look up existing mappings,
but actually expand on them, would have to do so manually before-hand,
and with the mm lock held for writing.

It turns out that execve() already did almost exactly that, except it
didn't take the mm lock at all (it's single-threaded so no locking
technically needed, but it could cause lockdep errors).  And it only did
it for the CONFIG_STACK_GROWSUP case, since in that case GUP has
obviously never expanded the stack downwards.

So just make that CONFIG_STACK_GROWSUP case do the right thing with
locking, and enable it generally.  This will eventually help GUP, and in
the meantime avoids a special case and the lockdep issue.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exec.c |   37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -200,34 +200,39 @@ static struct page *get_arg_page(struct
 		int write)
 {
 	struct page *page;
+	struct vm_area_struct *vma = bprm->vma;
+	struct mm_struct *mm = bprm->mm;
 	int ret;
-	unsigned int gup_flags = 0;
 
-#ifdef CONFIG_STACK_GROWSUP
-	if (write) {
-		/* We claim to hold the lock - nobody to race with */
-		ret = expand_downwards(bprm->vma, pos, true);
-		if (ret < 0)
+	/*
+	 * Avoid relying on expanding the stack down in GUP (which
+	 * does not work for STACK_GROWSUP anyway), and just do it
+	 * by hand ahead of time.
+	 */
+	if (write && pos < vma->vm_start) {
+		mmap_write_lock(mm);
+		ret = expand_downwards(vma, pos, true);
+		if (unlikely(ret < 0)) {
+			mmap_write_unlock(mm);
 			return NULL;
-	}
-#endif
-
-	if (write)
-		gup_flags |= FOLL_WRITE;
+		}
+		mmap_write_downgrade(mm);
+	} else
+		mmap_read_lock(mm);
 
 	/*
 	 * We are doing an exec().  'current' is the process
-	 * doing the exec and bprm->mm is the new process's mm.
+	 * doing the exec and 'mm' is the new process's mm.
 	 */
-	mmap_read_lock(bprm->mm);
-	ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
+	ret = get_user_pages_remote(mm, pos, 1,
+			write ? FOLL_WRITE : 0,
 			&page, NULL, NULL);
-	mmap_read_unlock(bprm->mm);
+	mmap_read_unlock(mm);
 	if (ret <= 0)
 		return NULL;
 
 	if (write)
-		acct_arg_size(bprm, vma_pages(bprm->vma));
+		acct_arg_size(bprm, vma_pages(vma));
 
 	return page;
 }


