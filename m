Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F4E7A2FEF
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbjIPMQV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbjIPMQH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:16:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B3CF2
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:16:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C90C433C8;
        Sat, 16 Sep 2023 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694866561;
        bh=u3/YcQgzSQGYOwb8IIK21hnpK/+Fdu8T1ER1u110bXY=;
        h=Subject:To:Cc:From:Date:From;
        b=yMFPE1Vq+u9TahhlPNh8zX6DntXiw6WtOdON8Y23b7z1sFeDP82BWMAnZyMjJAaVu
         xwHhJqR8IILt4g8xE3VpZVWI58Vc35vty/ral4KgDKMvRQbdBEcK7YxKYEqi2M+YRr
         esTgsYvlaBp2NH4abSkhVEj8bDGQ3+vnBvKzVOCc=
Subject: FAILED: patch "[PATCH] ext4: don't use CR_BEST_AVAIL_LEN for non-regular files" failed to apply to 6.5-stable tree
To:     ritesh.list@gmail.com, enwlinux@gmail.com, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:15:49 +0200
Message-ID: <2023091649-ember-remindful-28e0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 772c9f691dcf3a487f29ddb90a5a15c78d7328e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091649-ember-remindful-28e0@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

772c9f691dcf ("ext4: don't use CR_BEST_AVAIL_LEN for non-regular files")
b50675a4a6a6 ("ext4: return found group directly in ext4_mb_choose_next_group_goal_fast")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 772c9f691dcf3a487f29ddb90a5a15c78d7328e1 Mon Sep 17 00:00:00 2001
From: Ritesh Harjani <ritesh.list@gmail.com>
Date: Sun, 16 Jul 2023 19:33:34 +0530
Subject: [PATCH] ext4: don't use CR_BEST_AVAIL_LEN for non-regular files

Using CR_BEST_AVAIL_LEN only make sense for regular files, as for
non-regular files we never normalize the allocation request length i.e.
goal len is same as original length (ac_g_ex.fe_len == ac_o_ex.fe_len).

Hence there is no scope of trimming the goal length to make it
satisfy original request len. Thus this patch avoids using
CR_BEST_AVAIL_LEN criteria for non-regular files request.

Cc: stable@kernel.org
Fixes: 33122aa930f1 ("ext4: Add allocation criteria 1.5 (CR1_5)")
Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Tested-by: Eric Whitney <enwlinux@gmail.com>
Link: https://lore.kernel.org/r/2a694c748ff8b8c4b416995a24f06f07b55047a8.1689516047.git.ritesh.list@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b89b5f0816e7..3d5b0b71d7f5 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -966,7 +966,18 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
 		}
 	}
 
-	*new_cr = CR_BEST_AVAIL_LEN;
+	/*
+	 * CR_BEST_AVAIL_LEN works based on the concept that we have
+	 * a larger normalized goal len request which can be trimmed to
+	 * a smaller goal len such that it can still satisfy original
+	 * request len. However, allocation request for non-regular
+	 * files never gets normalized.
+	 * See function ext4_mb_normalize_request() (EXT4_MB_HINT_DATA).
+	 */
+	if (ac->ac_flags & EXT4_MB_HINT_DATA)
+		*new_cr = CR_BEST_AVAIL_LEN;
+	else
+		*new_cr = CR_GOAL_LEN_SLOW;
 }
 
 /*

