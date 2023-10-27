Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B477D97A5
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjJ0MSP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjJ0MSP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:18:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0480B10A
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:18:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42043C433C8;
        Fri, 27 Oct 2023 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698409092;
        bh=umd2QG/cKeQM7ea6XTXIBdld7X7C7WNaIVGJVq8fl9E=;
        h=Subject:To:Cc:From:Date:From;
        b=tS376RYE1tK6s1NPQqZdtw4NAV8OOMaRmVHBFAY21dIYBsS+bV7+Bdor81MHPx77E
         9dZNOxbMF5FuBFyLFCBUGlHWkektcxIS+Oa8NegzR0F8JVUMVUJ1H8ZdICsRuKY+Ge
         Q9IZv+vtLNwmFmPYvnek93BZuIPDlviQapon2iyA=
Subject: FAILED: patch "[PATCH] nfsd: lock_rename() needs both directories to live on the" failed to apply to 5.4-stable tree
To:     viro@zeniv.linux.org.uk, chuck.lever@oracle.com, jlayton@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:18:01 +0200
Message-ID: <2023102701-cadet-groovy-9672@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 1aee9158bc978f91701c5992e395efbc6da2de3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102701-cadet-groovy-9672@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1aee9158bc978f91701c5992e395efbc6da2de3c Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 14 Oct 2023 21:34:40 -0400
Subject: [PATCH] nfsd: lock_rename() needs both directories to live on the
 same fs

... checking that after lock_rename() is too late.  Incidentally,
NFSv2 had no nfserr_xdev...

Fixes: aa387d6ce153 "nfsd: fix EXDEV checking in rename"
Cc: stable@vger.kernel.org # v3.9+
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 48260cf68fde..02f5fcaad03f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1788,6 +1788,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
+	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
+		goto out;
+	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
+		goto out;
+
 retry:
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
@@ -1823,12 +1829,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ndentry == trap)
 		goto out_dput_new;
 
-	host_err = -EXDEV;
-	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
-	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
-
 	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
 	    nfsd_has_cached_files(ndentry)) {
 		close_cached = true;

