Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15787BC187
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjJFVq5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjJFVq4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 17:46:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FC1C5;
        Fri,  6 Oct 2023 14:46:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D25FC433CB;
        Fri,  6 Oct 2023 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696628814;
        bh=L+9UxI2FKJdGXc23wv3KgmrimCfJen5PD9Sbi6dKp48=;
        h=Date:To:From:Subject:From;
        b=fmRalAcLabN3JuFIAYiAWQWl9WcU4uEQz88KciJlvM87JW06tMa0fOesBeICFarXg
         kWoNLR8Saa+Etoi3iu6vKBJHO7d0HS1z18Efzo3jICljhQuEI0nrcpOlZ/VgH7glOb
         ErAdPZiVLcgvjmLCvz03M0XLWj45oRhik2OsRzQo=
Date:   Fri, 06 Oct 2023 14:46:51 -0700
To:     mm-commits@vger.kernel.org, yikebaer61@gmail.com,
        stable@vger.kernel.org, lstoakes@gmail.com,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-mempolicy-fix-set_mempolicy_home_node-previous-vma-pointer.patch removed from -mm tree
Message-Id: <20231006214654.4D25FC433CB@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: mm/mempolicy: fix set_mempolicy_home_node() previous VMA pointer
has been removed from the -mm tree.  Its filename was
     mm-mempolicy-fix-set_mempolicy_home_node-previous-vma-pointer.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: mm/mempolicy: fix set_mempolicy_home_node() previous VMA pointer
Date: Thu, 28 Sep 2023 13:24:32 -0400

The two users of mbind_range() are expecting that mbind_range() will
update the pointer to the previous VMA, or return an error.  However,
set_mempolicy_home_node() does not call mbind_range() if there is no VMA
policy.  The fix is to update the pointer to the previous VMA prior to
continuing iterating the VMAs when there is no policy.

Users may experience a WARN_ON() during VMA policy updates when updating
a range of VMAs on the home node.

Link: https://lkml.kernel.org/r/20230928172432.2246534-1-Liam.Howlett@oracle.com
Link: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
Fixes: f4e9e0e69468 ("mm/mempolicy: fix use-after-free of VMA iterator")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
Closes: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mempolicy.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/mm/mempolicy.c~mm-mempolicy-fix-set_mempolicy_home_node-previous-vma-pointer
+++ a/mm/mempolicy.c
@@ -1543,8 +1543,10 @@ SYSCALL_DEFINE4(set_mempolicy_home_node,
 		 * the home node for vmas we already updated before.
 		 */
 		old = vma_policy(vma);
-		if (!old)
+		if (!old) {
+			prev = vma;
 			continue;
+		}
 		if (old->mode != MPOL_BIND && old->mode != MPOL_PREFERRED_MANY) {
 			err = -EOPNOTSUPP;
 			break;
_

Patches currently in -mm which might be from Liam.Howlett@oracle.com are

mmap-add-clarifying-comment-to-vma_merge-code.patch
radix-tree-test-suite-fix-allocation-calculation-in-kmem_cache_alloc_bulk.patch

