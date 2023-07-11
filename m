Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F16074F848
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 21:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGKTOD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGKTOC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 15:14:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBCBEA;
        Tue, 11 Jul 2023 12:14:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA211615CB;
        Tue, 11 Jul 2023 19:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A677C433C7;
        Tue, 11 Jul 2023 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689102840;
        bh=in1L7IMW8F7JyRCe3Dk7+LzGFF/1xMYSy8aD5F4pZTI=;
        h=Date:To:From:Subject:From;
        b=TwFGm8kMUUUcc9/ZPjKgn0JCcde8H9iHB9ao7cuY5KrovRJdpoSZ+GPBvQIgH4MbZ
         zXVVtN2Pa7RLrWrw8JCpBdOmivwj+PV5HH9XSLNnrbvEDICztsq0+TAax9rXQ28NLF
         z+l6Lev1UqwtnuSvsJy5GBkAHot0NVdOboZIS1Qg=
Date:   Tue, 11 Jul 2023 12:13:59 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        Liam.Howlett@oracle.com, geert@linux-m68k.org,
        zhangpeng.00@bytedance.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + maple_tree-set-the-node-limit-when-creating-a-new-root-node.patch added to mm-hotfixes-unstable branch
Message-Id: <20230711191400.3A677C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: maple_tree: set the node limit when creating a new root node
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     maple_tree-set-the-node-limit-when-creating-a-new-root-node.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/maple_tree-set-the-node-limit-when-creating-a-new-root-node.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Peng Zhang <zhangpeng.00@bytedance.com>
Subject: maple_tree: set the node limit when creating a new root node
Date: Tue, 11 Jul 2023 11:54:37 +0800

Set the node limit of the root node so that the last pivot of all nodes is
the node limit (if the node is not full).

This patch also fixes a bug in mas_rev_awalk().  Effectively, always
setting a maximum makes mas_logical_pivot() behave as mas_safe_pivot(). 
Without this fix, it is possible that very small tasks would fail to find
the correct gap.  Although this has not been observed with real tasks, it
has been reported to happen in m68k nommu running the maple tree tests.

Link: https://lkml.kernel.org/r/20230711035444.526-1-zhangpeng.00@bytedance.com
Link: https://lore.kernel.org/linux-mm/CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com/
Link: https://lkml.kernel.org/r/20230711035444.526-2-zhangpeng.00@bytedance.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/maple_tree.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/lib/maple_tree.c~maple_tree-set-the-node-limit-when-creating-a-new-root-node
+++ a/lib/maple_tree.c
@@ -3692,7 +3692,8 @@ static inline int mas_root_expand(struct
 	mas->offset = slot;
 	pivots[slot] = mas->last;
 	if (mas->last != ULONG_MAX)
-		slot++;
+		pivots[++slot] = ULONG_MAX;
+
 	mas->depth = 1;
 	mas_set_height(mas);
 	ma_set_meta(node, maple_leaf_64, 0, slot);
_

Patches currently in -mm which might be from zhangpeng.00@bytedance.com are

maple_tree-set-the-node-limit-when-creating-a-new-root-node.patch
maple_tree-add-test-for-mas_wr_modify-fast-path.patch
maple_tree-add-test-for-expanding-range-in-rcu-mode.patch
maple_tree-optimize-mas_wr_append-also-improve-duplicating-vmas.patch
maple_tree-add-a-fast-path-case-in-mas_wr_slot_store.patch
maple_tree-dont-use-maple_arange64_meta_max-to-indicate-no-gap.patch
maple_tree-make-mas_validate_gaps-to-check-metadata.patch
maple_tree-fix-mas_validate_child_slot-to-check-last-missed-slot.patch
maple_tree-make-mas_validate_limits-check-root-node-and-node-limit.patch
maple_tree-update-mt_validate.patch
maple_tree-replace-mas_logical_pivot-with-mas_safe_pivot.patch
maple_tree-drop-mas_first_entry.patch

