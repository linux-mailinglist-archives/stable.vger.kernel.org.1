Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD9789900
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjHZU0O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHZUZ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BF6CF1
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D723360C55
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 20:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CA9C433C8;
        Sat, 26 Aug 2023 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693081555;
        bh=oPSL9L8K0iA4OGbfptsGH/ieFgdIMSqILi79itcrHHw=;
        h=Subject:To:Cc:From:Date:From;
        b=Nb/BArk1ZcE6xVpsYUP5I6kE0AyRSIX4zvBzA3oKXlALUEdLK2KofaXpYJ9wFYnhD
         RqWZ1L2rBJMZqXdtk2QHqHgTkpW4WXHpxIZ2wALyLx8DNjtgYjnU99Q760tqRpziVf
         pEudUB1O4GuJqtiosi8pK3ymQ0iYkiC1GmatwDOc=
Subject: FAILED: patch "[PATCH] maple_tree: disable mas_wr_append() when other readers are" failed to apply to 6.1-stable tree
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 Aug 2023 22:25:44 +0200
Message-ID: <2023082644-dimmed-purse-07c2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x cfeb6ae8bcb96ccf674724f223661bbcef7b0d0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082644-dimmed-purse-07c2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

cfeb6ae8bcb9 ("maple_tree: disable mas_wr_append() when other readers are possible")
2e1da329b424 ("maple_tree: add comments and some minor cleanups to mas_wr_append()")
c6fc9e4a5c50 ("maple_tree: add mas_wr_new_end() to calculate new_end accurately")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cfeb6ae8bcb96ccf674724f223661bbcef7b0d0b Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Fri, 18 Aug 2023 20:43:55 -0400
Subject: [PATCH] maple_tree: disable mas_wr_append() when other readers are
 possible

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

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4dd73cf936a6..f723024e1426 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4265,6 +4265,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
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
@@ -4274,6 +4278,9 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
+	if (mt_in_rcu(mas->tree))
+		return false;
+
 	if (mas->offset != wr_mas->node_end)
 		return false;
 

