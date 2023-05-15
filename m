Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFBD703BEF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbjEOSIc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244957AbjEOSH7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C37619BFE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D16DE630A4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E7FC433EF;
        Mon, 15 May 2023 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173903;
        bh=8owA7c1r4tUFh9YUgeL0r3Cazrnf8zHs8wRdQkoz69E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4AUtwmsES5EsiDfhUFkRrwfGvDessbJgv2APK0lqX4boTpk1BzyV0c/nGGCeL/De
         wp8yTDP3hYASedaZsx6kRIT2BDjFspgke0cdORcbFfUAa/g73kSrS015NHsGGxu/W1
         Af56gnc+O3vwKNkjI6iEXRxsDRocw3psNcFVrxFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5.4 244/282] inotify: Avoid reporting event with invalid wd
Date:   Mon, 15 May 2023 18:30:22 +0200
Message-Id: <20230515161729.570992200@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -66,7 +66,7 @@ int inotify_handle_event(struct fsnotify
 	struct inotify_event_info *event;
 	struct fsnotify_event *fsn_event;
 	int ret;
-	int len = 0;
+	int len = 0, wd;
 	int alloc_len = sizeof(struct inotify_event_info);
 
 	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
@@ -91,6 +91,13 @@ int inotify_handle_event(struct fsnotify
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
@@ -120,7 +127,7 @@ int inotify_handle_event(struct fsnotify
 	fsn_event = &event->fse;
 	fsnotify_init_event(fsn_event, (unsigned long)inode);
 	event->mask = mask;
-	event->wd = i_mark->wd;
+	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)


