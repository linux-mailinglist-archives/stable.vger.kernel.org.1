Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5426D755403
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjGPUZh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjGPUZf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E0B9F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:25:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FD7660E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A575C433C8;
        Sun, 16 Jul 2023 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539134;
        bh=mWKdnO/QJ1Uq7M8Rqm/vcIRRjkWy4orWnr1qf1BYuJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wU270ZECPygsgbDQ5k65VNVVtVRnFPJVWGXH+jBSbElIlXoEpQyBu/iqJSVGgB0aW
         kYGVqmXqv+T86REyCNwUGyb5mAHhExMESAEiKJT0Y6qLido6TP8+RFPT/kR9Usz1R4
         rV9CB18sH1RgQeE6Lx9ZBQ7xkj3xd4szSVdG3Mt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 700/800] fanotify: disallow mount/sb marks on kernel internal pseudo fs
Date:   Sun, 16 Jul 2023 21:49:13 +0200
Message-ID: <20230716195005.379660550@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 69562eb0bd3e6bb8e522a7b254334e0fb30dff0c ]

Hopefully, nobody is trying to abuse mount/sb marks for watching all
anonymous pipes/inodes.

I cannot think of a good reason to allow this - it looks like an
oversight that dated back to the original fanotify API.

Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mczxv2pm@quack3/
Fixes: 0ff21db9fcc3 ("fanotify: hooks the fanotify_mark syscall to the vfsmount code")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230629042044.25723-1-amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 22fb1cf7e1fc5..f7e11ac763907 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1623,6 +1623,20 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
 		return -EINVAL;
 
+	/*
+	 * mount and sb marks are not allowed on kernel internal pseudo fs,
+	 * like pipe_mnt, because that would subscribe to events on all the
+	 * anonynous pipes in the system.
+	 *
+	 * SB_NOUSER covers all of the internal pseudo fs whose objects are not
+	 * exposed to user's mount namespace, but there are other SB_KERNMOUNT
+	 * fs, like nsfs, debugfs, for which the value of allowing sb and mount
+	 * mark is questionable. For now we leave them alone.
+	 */
+	if (mark_type != FAN_MARK_INODE &&
+	    path->mnt->mnt_sb->s_flags & SB_NOUSER)
+		return -EINVAL;
+
 	/*
 	 * We shouldn't have allowed setting dirent events and the directory
 	 * flags FAN_ONDIR and FAN_EVENT_ON_CHILD in mask of non-dir inode,
-- 
2.39.2



