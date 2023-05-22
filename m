Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1170C4EE
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjEVSEr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjEVSEo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B20119
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16FBA62438
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F036FC433EF;
        Mon, 22 May 2023 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778678;
        bh=hgqzr6BJdHpdGo4lkntsbjVZaZwGcjqoWzS8+PDD6E0=;
        h=Subject:To:Cc:From:Date:From;
        b=w98NcqHeIjoZBpL0/mdSsIRqu6VndGICg4nd+OYQbUI0fzHIn5PPrYiYg8l0Gj5hD
         lgRyqOaId3KPDttrfDxcf/QmcHCi+9VAZkNqxowxCPsJoFB7CKicDOKiUJZo9NayM/
         quqwF8g/zdBjBi+guHKSsI28nIm4UflKHnQHS25U=
Subject: FAILED: patch "[PATCH] arm64: Also reset KASAN tag if page is not PG_mte_tagged" failed to apply to 6.1-stable tree
To:     pcc@google.com, catalin.marinas@arm.com, stable@vger.kernel.org,
        will@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 19:04:35 +0100
Message-ID: <2023052235-cut-gulp-ad69@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2efbafb91e12ff5a16cbafb0085e4c10c3fca493
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052235-cut-gulp-ad69@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

2efbafb91e12 ("arm64: Also reset KASAN tag if page is not PG_mte_tagged")
e74a68468062 ("arm64: Reset KASAN tag in copy_highpage with HW tags only")
d77e59a8fccd ("arm64: mte: Lock a page for MTE tag initialisation")
e059853d14ca ("arm64: mte: Fix/clarify the PG_mte_tagged semantics")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2efbafb91e12ff5a16cbafb0085e4c10c3fca493 Mon Sep 17 00:00:00 2001
From: Peter Collingbourne <pcc@google.com>
Date: Thu, 20 Apr 2023 14:09:45 -0700
Subject: [PATCH] arm64: Also reset KASAN tag if page is not PG_mte_tagged

Consider the following sequence of events:

1) A page in a PROT_READ|PROT_WRITE VMA is faulted.
2) Page migration allocates a page with the KASAN allocator,
   causing it to receive a non-match-all tag, and uses it
   to replace the page faulted in 1.
3) The program uses mprotect() to enable PROT_MTE on the page faulted in 1.

As a result of step 3, we are left with a non-match-all tag for a page
with tags accessible to userspace, which can lead to the same kind of
tag check faults that commit e74a68468062 ("arm64: Reset KASAN tag in
copy_highpage with HW tags only") intended to fix.

The general invariant that we have for pages in a VMA with VM_MTE_ALLOWED
is that they cannot have a non-match-all tag. As a result of step 2, the
invariant is broken. This means that the fix in the referenced commit
was incomplete and we also need to reset the tag for pages without
PG_mte_tagged.

Fixes: e5b8d9218951 ("arm64: mte: reset the page tag in page->flags")
Cc: <stable@vger.kernel.org> # 5.15
Link: https://linux-review.googlesource.com/id/I7409cdd41acbcb215c2a7417c1e50d37b875beff
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20230420210945.2313627-1-pcc@google.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 4aadcfb01754..a7bb20055ce0 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -21,9 +21,10 @@ void copy_highpage(struct page *to, struct page *from)
 
 	copy_page(kto, kfrom);
 
+	if (kasan_hw_tags_enabled())
+		page_kasan_tag_reset(to);
+
 	if (system_supports_mte() && page_mte_tagged(from)) {
-		if (kasan_hw_tags_enabled())
-			page_kasan_tag_reset(to);
 		/* It's a new page, shouldn't have been tagged yet */
 		WARN_ON_ONCE(!try_page_mte_tagging(to));
 		mte_copy_page_tags(kto, kfrom);

