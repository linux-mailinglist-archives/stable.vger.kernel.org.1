Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B447A7C44
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjITMAH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjITL7m (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:59:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E795AD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:59:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C27C433C7;
        Wed, 20 Sep 2023 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211176;
        bh=sH0hZ4uGl2Z6xXFMq9+rwqBZd/gqSlXZ4vy1msZoUN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H07bIYDn7IrrjMoB6JCdpDOIfdtcaBtbgUahs5W216aYP/4FCz0JkjUkeN2ZbpGZl
         fRofvYKMV38b7zlidtkhNhZxWKNXGu5WR9e+SbqFDr8WQmXbOeHBFlDmbwHpYBdsMa
         iDj+W/KhNUHbKJEwmi5Vgx+UKmZXDVL9CpoXI/zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruiwen Zhao <ruiwen@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 6.1 111/139] ovl: fix failed copyup of fileattr on a symlink
Date:   Wed, 20 Sep 2023 13:30:45 +0200
Message-ID: <20230920112839.699136233@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -580,7 +580,8 @@ static int ovl_copy_up_metadata(struct o
 	if (err)
 		return err;
 
-	if (inode->i_flags & OVL_COPY_I_FLAGS_MASK) {
+	if (inode->i_flags & OVL_COPY_I_FLAGS_MASK &&
+	    (S_ISREG(c->stat.mode) || S_ISDIR(c->stat.mode))) {
 		/*
 		 * Copy the fileattr inode flags that are the source of already
 		 * copied i_flags


