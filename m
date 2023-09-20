Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194117A7B5F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjITLvf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjITLvf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:51:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF888ED
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:51:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BF9C433C9;
        Wed, 20 Sep 2023 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210687;
        bh=cx4cOriP05z38Q+nyPNwui7Et3L4X9mXPddeekFUmJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFtT+zrBYmqTbfNzoKvFvUqo/K+7RXRUUepIFUjvF+5OaBIvz4aYY3zT2x+uF/9iI
         qSF/0q05rTbW3ZvyTPRBLzNyjNbzas2j0iLlAEl0dITOkPYuqBGv2xqjQrsKbZehYu
         LIt9+mwErZbFnM90jfattQZIussewYOMb6itiiZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruiwen Zhao <ruiwen@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 6.5 168/211] ovl: fix failed copyup of fileattr on a symlink
Date:   Wed, 20 Sep 2023 13:30:12 +0200
Message-ID: <20230920112851.098692101@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit ab048302026d7701e7fbd718917e0dbcff0c4223 upstream.

Some local filesystems support setting persistent fileattr flags
(e.g. FS_NOATIME_FL) on directories and regular files via ioctl.
Some of those persistent fileattr flags are reflected to vfs as
in-memory inode flags (e.g. S_NOATIME).

Overlayfs uses the in-memory inode flags (e.g. S_NOATIME) on a lower file
as an indication that a the lower file may have persistent inode fileattr
flags (e.g. FS_NOATIME_FL) that need to be copied to upper file.

However, in some cases, the S_NOATIME in-memory flag could be a false
indication for persistent FS_NOATIME_FL fileattr. For example, with NFS
and FUSE lower fs, as was the case in the two bug reports, the S_NOATIME
flag is set unconditionally for all inodes.

Users cannot set persistent fileattr flags on symlinks and special files,
but in some local fs, such as ext4/btrfs/tmpfs, the FS_NOATIME_FL fileattr
flag are inheritted to symlinks and special files from parent directory.

In both cases described above, when lower symlink has the S_NOATIME flag,
overlayfs will try to copy the symlink's fileattrs and fail with error
ENOXIO, because it could not open the symlink for the ioctl security hook.

To solve this failure, do not attempt to copyup fileattrs for anything
other than directories and regular files.

Reported-by: Ruiwen Zhao <ruiwen@google.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217850
Fixes: 72db82115d2b ("ovl: copy up sync/noatime fileattr flags")
Cc: <stable@vger.kernel.org> # v5.15
Reviewed-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/copy_up.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -617,7 +617,8 @@ static int ovl_copy_up_metadata(struct o
 	if (err)
 		return err;
 
-	if (inode->i_flags & OVL_COPY_I_FLAGS_MASK) {
+	if (inode->i_flags & OVL_COPY_I_FLAGS_MASK &&
+	    (S_ISREG(c->stat.mode) || S_ISDIR(c->stat.mode))) {
 		/*
 		 * Copy the fileattr inode flags that are the source of already
 		 * copied i_flags


