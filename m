Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFD783045
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 20:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjHUScV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 14:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjHUScV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 14:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E492B62;
        Mon, 21 Aug 2023 11:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9471F61499;
        Mon, 21 Aug 2023 18:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E9C433C8;
        Mon, 21 Aug 2023 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692642726;
        bh=Rx6YDTC7jbMH0oll6Z0X5njt0HLW+NfPV8bcHLqKB50=;
        h=Date:To:From:Subject:From;
        b=Ur+F6WuwF0RVUhefnp6snVB6FjuphlRcYeOanz8Whq+GN99tWlx3XcFRW67RY11sx
         dexfOc37gIKw12JNgpzGrRsfqFcH+pcAORB9MrnsdfrUDS0AZzXNiWG2qv1e2LSFmC
         JRQ+58kiP9R9bXUhp+wuO1mUSSKaBn7xefbnbl0E=
Date:   Mon, 21 Aug 2023 11:32:05 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + maple_tree-disable-mas_wr_append-when-other-readers-are-possible.patch added to mm-hotfixes-unstable branch
Message-Id: <20230821183205.DF5E9C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: maple_tree: disable mas_wr_append() when other readers are possible
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     maple_tree-disable-mas_wr_append-when-other-readers-are-possible.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/maple_tree-disable-mas_wr_append-when-other-readers-are-possible.patch

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
Subject: maple_tree: disable mas_wr_append() when other readers are possible
Date: Fri, 18 Aug 2023 20:43:55 -0400

The current implementation of append may cause duplicate data and/or
incorrect ranges to be returned to a reader during an update.  Although
this has not been reported or seen, disable the append write operation
while the tree is in rcu mode out of an abundance of caution.

During the analysis of the mas_next_slot() the following was
artificially created by separating the writer and reader code:

Writer:                                 reader:
mas_wr_append
    set end pivot
    updates end metata
    Detects write to last slot
    last slot write is to start of slot
    store current contents in slot
    overwrite old end pivot
                                        mas_next_slot():
                                                read end metadata
                                                read old end pivot
                                                return with incorrect range
    store new value

Alternatively:

Writer:                                 reader:
mas_wr_append
    set end pivot
    updates end metata
    Detects write to last slot
    last lost write to end of slot
    store value
                                        mas_next_slot():
                                                read end metadata
                                                read old end pivot
                                                read new end pivot
                                                return with incorrect range
    set old end pivot

There may be other accesses that are not safe since we are now updating
both metadata and pointers, so disabling append if there could be rcu
readers is the safest action.

Link: https://lkml.kernel.org/r/20230819004356.1454718-2-Liam.Howlett@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/maple_tree.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/lib/maple_tree.c~maple_tree-disable-mas_wr_append-when-other-readers-are-possible
+++ a/lib/maple_tree.c
@@ -4265,6 +4265,10 @@ static inline unsigned char mas_wr_new_e
  * mas_wr_append: Attempt to append
  * @wr_mas: the maple write state
  *
+ * This is currently unsafe in rcu mode since the end of the node may be cached
+ * by readers while the node contents may be updated which could result in
+ * inaccurate information.
+ *
  * Return: True if appended, false otherwise
  */
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
@@ -4274,6 +4278,9 @@ static inline bool mas_wr_append(struct
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
+	if (mt_in_rcu(mas->tree))
+		return false;
+
 	if (mas->offset != wr_mas->node_end)
 		return false;
 
_

Patches currently in -mm which might be from Liam.Howlett@oracle.com are

maple_tree-disable-mas_wr_append-when-other-readers-are-possible.patch
maple_tree-add-hex-output-to-maple_arange64-dump.patch
maple_tree-reorder-replacement-of-nodes-to-avoid-live-lock.patch
maple_tree-introduce-mas_put_in_tree.patch
maple_tree-introduce-mas_tree_parent-definition.patch
maple_tree-change-mas_adopt_children-parent-usage.patch
maple_tree-replace-data-before-marking-dead-in-split-and-spanning-store.patch

