Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD70D76150B
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjGYLZF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjGYLZE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A0D97
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56EC61600
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B25C433C8;
        Tue, 25 Jul 2023 11:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284302;
        bh=JJxJF42IJ8HH2dOOiJwY3UBKSEctPM+1Xq1ASdfXO00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0KGJoojwoubRkrUELbfbDGfYkKqEIZd+BVKG8c39emk8LzaUdQZls4pGnJTVG0JW
         87THy9bT2d2zHYmwQCQIFpuY1VI94mlJ38mqX2q2k/GruFu4aIdjIXDYRaLn6Z9E3z
         /s6FThnLVBA/ojEF5zUDfhhvYv4Ely0xHscezojY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5.10 307/509] fanotify: disallow mount/sb marks on kernel internal pseudo fs
Date:   Tue, 25 Jul 2023 12:44:06 +0200
Message-ID: <20230725104607.794023737@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

commit 69562eb0bd3e6bb8e522a7b254334e0fb30dff0c upstream.

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
[backport to 5.x.y]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/fanotify/fanotify_user.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1090,8 +1090,11 @@ static int fanotify_test_fid(struct path
 	return 0;
 }
 
-static int fanotify_events_supported(struct path *path, __u64 mask)
+static int fanotify_events_supported(struct path *path, __u64 mask,
+				     unsigned int flags)
 {
+	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
 	 * files. For them fanotify permission events have high chances of
@@ -1103,6 +1106,21 @@ static int fanotify_events_supported(str
 	if (mask & FANOTIFY_PERM_EVENTS &&
 	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
 		return -EINVAL;
+
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
 	return 0;
 }
 
@@ -1218,7 +1236,7 @@ static int do_fanotify_mark(int fanotify
 		goto fput_and_out;
 
 	if (flags & FAN_MARK_ADD) {
-		ret = fanotify_events_supported(&path, mask);
+		ret = fanotify_events_supported(&path, mask, flags);
 		if (ret)
 			goto path_put_and_out;
 	}


