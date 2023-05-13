Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829C47014A6
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjEMGgR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjEMGgR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872752D5A
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0421560A4C
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D06BC433D2;
        Sat, 13 May 2023 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683959774;
        bh=YNzGNBLUyj6pyVsV8oygumn1aVp/eubGnPKwvphYdUs=;
        h=Subject:To:Cc:From:Date:From;
        b=0DBX2Auf26bzsDjviHUgCRVnx7ZDUEDWQa0ZsnNg76FItoSFA4jyqeDlNGh7cQAmx
         p0ukgOvcCotZdh6Ce9OtqFVp3IyFM7fUduEyymEcfrSUl8V/0TCKcCTsM5QS3pKgEi
         BbpiM2kkxEMvtZcjmXPiwdQtACPEWKRpIKOMDwHY=
Subject: FAILED: patch "[PATCH] inotify: Avoid reporting event with invalid wd" failed to apply to 4.14-stable tree
To:     jack@suse.cz, amir73il@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:35:55 +0900
Message-ID: <2023051355-axis-manly-3a44@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x c915d8f5918bea7c3962b09b8884ca128bfd9b0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051355-axis-manly-3a44@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

c915d8f5918b ("inotify: Avoid reporting event with invalid wd")
ec165450968b ("memcg, fsnotify: no oom-kill for remote memcg charging")
a0a92d261f29 ("fsnotify: move mask out of struct fsnotify_event")
d0a6a87e40da ("fanotify: support reporting thread id instead of process id")
bdd5a46fe306 ("fanotify: add BUILD_BUG_ON() to count the bits of fanotify constants")
23c9deeb3285 ("fanotify: deprecate uapi FAN_ALL_* constants")
a72fd224e37b ("fanotify: simplify handling of FAN_ONDIR")
b723a7911d02 ("fanotify: fix collision of internal and uapi mark flags")
96a71f21ef1f ("fanotify: store fanotify_init() flags in group's fanotify_data")
d54f4fba889b ("fanotify: add API to attach/detach super block mark")
6ada4e282679 ("Merge branch 'akpm' (patches from Andrew)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c915d8f5918bea7c3962b09b8884ca128bfd9b0c Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 24 Apr 2023 18:32:19 +0200
Subject: [PATCH] inotify: Avoid reporting event with invalid wd

When inotify_freeing_mark() races with inotify_handle_inode_event() it
can happen that inotify_handle_inode_event() sees that i_mark->wd got
already reset to -1 and reports this value to userspace which can
confuse the inotify listener. Avoid the problem by validating that wd is
sensible (and pretend the mark got removed before the event got
generated otherwise).

CC: stable@vger.kernel.org
Fixes: 7e790dd5fc93 ("inotify: fix error paths in inotify_update_watch")
Message-Id: <20230424163219.9250-1-jack@suse.cz>
Reported-by: syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 49cfe2ae6d23..993375f0db67 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -65,7 +65,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	struct fsnotify_event *fsn_event;
 	struct fsnotify_group *group = inode_mark->group;
 	int ret;
-	int len = 0;
+	int len = 0, wd;
 	int alloc_len = sizeof(struct inotify_event_info);
 	struct mem_cgroup *old_memcg;
 
@@ -80,6 +80,13 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
 			      fsn_mark);
 
+	/*
+	 * We can be racing with mark being detached. Don't report event with
+	 * invalid wd.
+	 */
+	wd = READ_ONCE(i_mark->wd);
+	if (wd == -1)
+		return 0;
 	/*
 	 * Whoever is interested in the event, pays for the allocation. Do not
 	 * trigger OOM killer in the target monitoring memcg as it may have
@@ -110,7 +117,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	fsn_event = &event->fse;
 	fsnotify_init_event(fsn_event);
 	event->mask = mask;
-	event->wd = i_mark->wd;
+	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)

