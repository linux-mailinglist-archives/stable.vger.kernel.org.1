Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1275875C9EB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGUOZW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGUOZV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003412D50
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86BAC61CEB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945CBC433C7;
        Fri, 21 Jul 2023 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689949515;
        bh=9pNVz2TfnFWDuoN6IthU7Q6dUZEYvqTT7k8OhS/TL4o=;
        h=Subject:To:Cc:From:Date:From;
        b=jKCxI4eTaPNIdsk5UithQVskbgJb/cjHqglY0ca21st2ZY+XbmOUry2NxGIgI7mDg
         jZ6q3J8HGDXvIBG25A3ws3QuN2cfJy7DcA32nTo8cEZQUwDdeBWp0Q1hHzzyxJ1tw8
         Swx5ogK1Qc2Fd8hbOqK5pHa52sPcI3IkEJP/fHOU=
Subject: FAILED: patch "[PATCH] cifs: if deferred close is disabled then close files" failed to apply to 5.4-stable tree
To:     bharathsm@microsoft.com, sprasad@microsoft.com,
        stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:25:07 +0200
Message-ID: <2023072107-facsimile-recolor-8439@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x df9d70c18616760c6504b97fec66b6379c172dbb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072107-facsimile-recolor-8439@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

df9d70c18616 ("cifs: if deferred close is disabled then close files immediately")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df9d70c18616760c6504b97fec66b6379c172dbb Mon Sep 17 00:00:00 2001
From: Bharath SM <bharathsm@microsoft.com>
Date: Fri, 7 Jul 2023 15:29:01 +0000
Subject: [PATCH] cifs: if deferred close is disabled then close files
 immediately

If defer close timeout value is set to 0, then there is no
need to include files in the deferred close list and utilize
the delayed worker for closing. Instead, we can close them
immediately.

Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 879bc8e6555c..fc5acc95cd13 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1080,8 +1080,8 @@ int cifs_close(struct inode *inode, struct file *file)
 		cfile = file->private_data;
 		file->private_data = NULL;
 		dclose = kmalloc(sizeof(struct cifs_deferred_close), GFP_KERNEL);
-		if ((cinode->oplock == CIFS_CACHE_RHW_FLG) &&
-		    cinode->lease_granted &&
+		if ((cifs_sb->ctx->closetimeo && cinode->oplock == CIFS_CACHE_RHW_FLG)
+		    && cinode->lease_granted &&
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
 		    dclose) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {

