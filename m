Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA937D9779
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345810AbjJ0MOJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjJ0MOJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:14:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53218C0
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:14:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9707EC433C7;
        Fri, 27 Oct 2023 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698408847;
        bh=T/1XZ7yFe3lRx4//S7bL+4gmQ9Sg9MH8rVCFHr38JHc=;
        h=Subject:To:Cc:From:Date:From;
        b=d2roq0dv3DXx6LqoOdm5ZafB1DZSd0PlZguD1H5KdyNnoNx2jBWPzgCEkYVDCRnBI
         ERz116hjShfgwjCD4RTDyo7vufrg1isuYOw94ang78ngPuLodqgOVZ3M+cZ73fm7ew
         4+yR9O28WJMV6QB1byjrqxnZNZqE6fUDSw4fBbEs=
Subject: FAILED: patch "[PATCH] mm/mempolicy: fix set_mempolicy_home_node() previous VMA" failed to apply to 6.1-stable tree
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        lstoakes@gmail.com, stable@vger.kernel.org, yikebaer61@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:14:04 +0200
Message-ID: <2023102704-surrogate-dole-2888@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 51f625377561e5b167da2db5aafb7ee268f691c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102704-surrogate-dole-2888@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51f625377561e5b167da2db5aafb7ee268f691c5 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Thu, 28 Sep 2023 13:24:32 -0400
Subject: [PATCH] mm/mempolicy: fix set_mempolicy_home_node() previous VMA
 pointer

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

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f1b00d6ac7ee..29ebf1e7898c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1543,8 +1543,10 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
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

