Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E257A3A2E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbjIQT7d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbjIQT7W (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:59:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684DBF3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:59:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9940DC433C7;
        Sun, 17 Sep 2023 19:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980757;
        bh=psB1KBeQO3ClstUvgpWPqNoPqKEnp0tn8S6EyKYfcdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTFiBSqrCxhZuo1vp+O680QL9PM1Db027+Tf0oeCMHSDc+YHxnn3bPn1D/U6+nPi9
         begPIqzAEDpzEo1YrCwn13FlfjTIrl231SYd5lkCXTvx9xRFAO7IsFxdm9xWZT+qW5
         L/gyDoR2fE1lK0O4CtBYXcMa8NXXKRkkLO11zoU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: [PATCH 6.5 284/285] vm: fix move_vma() memory accounting being off
Date:   Sun, 17 Sep 2023 21:14:44 +0200
Message-ID: <20230917191100.965552467@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 3cec50490969afd4a76ccee441f747d869ccff77 upstream.

Commit 408579cd627a ("mm: Update do_vmi_align_munmap() return
semantics") seems to have updated one of the callers of do_vmi_munmap()
incorrectly: it used to check for the error case (which didn't
change: negative means error).

That commit changed the check to the success case (which did change:
before that commit, 0 was success, and 1 was "success and lock
downgraded".  After the change, it's always 0 for success, and the lock
will have been released if requested).

This didn't change any actual VM behavior _except_ for memory accounting
when 'VM_ACCOUNT' was set on the vma.  Which made the wrong return value
test fairly subtle, since everything continues to work.

Or rather - it continues to work but the "Committed memory" accounting
goes all wonky (Committed_AS value in /proc/meminfo), and depending on
settings that then causes problems much much later as the VM relies on
bogus statistics for its heuristics.

Revert that one line of the change back to the original logic.

Fixes: 408579cd627a ("mm: Update do_vmi_align_munmap() return semantics")
Reported-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Reported-bisected-and-tested-by: Michael Labiuk <michael.labiuk@virtuozzo.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Link: https://lore.kernel.org/all/1694366957@msgid.manchmal.in-ulm.de/
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mremap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -715,7 +715,7 @@ static unsigned long move_vma(struct vm_
 	}
 
 	vma_iter_init(&vmi, mm, old_addr);
-	if (!do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false)) {
+	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);


