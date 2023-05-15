Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA1703796
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbjEORXD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbjEORWr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69168DD91
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F65162C12
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7161FC433D2;
        Mon, 15 May 2023 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171248;
        bh=ecRzZTC14Y082V1XWJK204NohrP7IYeyAEnOOPYXe8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQIWge3EzHHcBK4iZULrGBfUsYHfXXm6zYDEW3zKC5nmzWce7cz8br9IVDU+4ALIE
         iQR6lXhm/Z7VhHP6n0TXe+bNnyNLuFItO09/e+C4rt9TgHmuuzkeQE+6CAfL//Czsd
         v11VVGGCK1eS1Pqp6Gu0XxzQWRnlEeWm2ecEp7WA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6.2 149/242] inotify: Avoid reporting event with invalid wd
Date:   Mon, 15 May 2023 18:27:55 +0200
Message-Id: <20230515161726.363428783@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit c915d8f5918bea7c3962b09b8884ca128bfd9b0c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/inotify/inotify_fsnotify.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -65,7 +65,7 @@ int inotify_handle_inode_event(struct fs
 	struct fsnotify_event *fsn_event;
 	struct fsnotify_group *group = inode_mark->group;
 	int ret;
-	int len = 0;
+	int len = 0, wd;
 	int alloc_len = sizeof(struct inotify_event_info);
 	struct mem_cgroup *old_memcg;
 
@@ -81,6 +81,13 @@ int inotify_handle_inode_event(struct fs
 			      fsn_mark);
 
 	/*
+	 * We can be racing with mark being detached. Don't report event with
+	 * invalid wd.
+	 */
+	wd = READ_ONCE(i_mark->wd);
+	if (wd == -1)
+		return 0;
+	/*
 	 * Whoever is interested in the event, pays for the allocation. Do not
 	 * trigger OOM killer in the target monitoring memcg as it may have
 	 * security repercussion.
@@ -110,7 +117,7 @@ int inotify_handle_inode_event(struct fs
 	fsn_event = &event->fse;
 	fsnotify_init_event(fsn_event);
 	event->mask = mask;
-	event->wd = i_mark->wd;
+	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)


