Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80007A9A6E
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjIUSjf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjIUSjU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 14:39:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19063D3171;
        Thu, 21 Sep 2023 11:23:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1159C433C8;
        Thu, 21 Sep 2023 18:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695320632;
        bh=9HLQKTZgsHyWBlJ5DLMy9KuI2CVbUlewE8E590u6dTE=;
        h=Date:To:From:Subject:From;
        b=Tl0w5pOd6dkLd+UuYo8Qcg0X3R601WTa3qojhT22b7Xu2tVEyfMjEr9m2I+gn6YMF
         /lyKha8/z3jFXxZY52mHzBIN9hdtHFyHOkSvk3pHTUbnJPADNiU5NgX2ji9KMcvU3b
         r7Vd7mzEWT+FOfcN/6UubB6+tsDvw31QjUzljPks=
Date:   Thu, 21 Sep 2023 11:23:51 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        pedro.falcato@gmail.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + maple_tree-add-mas_active-to-detect-in-tree-walks.patch added to mm-hotfixes-unstable branch
Message-Id: <20230921182352.A1159C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: maple_tree: add mas_is_active() to detect in-tree walks
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     maple_tree-add-mas_active-to-detect-in-tree-walks.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/maple_tree-add-mas_active-to-detect-in-tree-walks.patch

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
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: maple_tree: add mas_is_active() to detect in-tree walks
Date: Thu, 21 Sep 2023 14:12:35 -0400

Patch series "maple_tree: Fix mas_prev() state regression".

Pedro Falcato contacted me on IRC with an mprotect regression which was
bisected back to the iterator changes for maple tree.  Root cause analysis
showed the mas_prev() running off the end of the VMA space (previous from
0) followed by mas_find(), would skip the first value.

This patchset introduces maple state underflow/overflow so the sequence of
calls on the maple state will return what the user expects.


This patch (of 2):

Instead of constantly checking each possibility of the maple state,
create a fast path that will skip over checking unlikely states.

Link: https://lkml.kernel.org/r/20230921181236.509072-1-Liam.Howlett@oracle.com
Link: https://lkml.kernel.org/r/20230921181236.509072-2-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/maple_tree.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/include/linux/maple_tree.h~maple_tree-add-mas_active-to-detect-in-tree-walks
+++ a/include/linux/maple_tree.h
@@ -511,6 +511,15 @@ static inline bool mas_is_paused(const s
 	return mas->node == MAS_PAUSE;
 }
 
+/* Check if the mas is pointing to a node or not */
+static inline bool mas_is_active(struct ma_state *mas)
+{
+	if ((unsigned long)mas->node >= MAPLE_RESERVED_RANGE)
+		return true;
+
+	return false;
+}
+
 /**
  * mas_reset() - Reset a Maple Tree operation state.
  * @mas: Maple Tree operation state.
_

Patches currently in -mm which might be from Liam.Howlett@oracle.com are

maple_tree-add-mas_active-to-detect-in-tree-walks.patch
maple_tree-add-mas_underflow-and-mas_overflow-states.patch

