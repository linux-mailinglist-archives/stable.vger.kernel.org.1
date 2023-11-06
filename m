Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EC57E2301
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKFNHr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjKFNHr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:07:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC9F1
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:07:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AFBC433C8;
        Mon,  6 Nov 2023 13:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276063;
        bh=3NioW1MZEjnQizBTIwgnVQ6kvPANiG/Mu2YS0xib8RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keirC3f3zaUXI1+tYg9NxaB0QEkwXXL1crbCGE9A7aqRKacUnpxY3GzZMM7bf3w/T
         cdfNSwiVMZlNvAaMvtJorUI8HwcbFuT/j/nuD/tTapoP6l9sxVKAnzFgs8QXcEhLej
         V4nGgS0xT3u+6mKRjNRVjTw3omXYc78izEKrly9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 19/48] nfsd: lock_rename() needs both directories to live on the same fs
Date:   Mon,  6 Nov 2023 14:03:10 +0100
Message-ID: <20231106130258.517026709@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 1aee9158bc978f91701c5992e395efbc6da2de3c upstream.

... checking that after lock_rename() is too late.  Incidentally,
NFSv2 had no nfserr_xdev...

Fixes: aa387d6ce153 "nfsd: fix EXDEV checking in rename"
Cc: stable@vger.kernel.org # v3.9+
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/vfs.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1665,6 +1665,12 @@ nfsd_rename(struct svc_rqst *rqstp, stru
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
+	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
+		goto out;
+	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
+		goto out;
+
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
 		err = nfserrno(host_err);
@@ -1698,12 +1704,6 @@ nfsd_rename(struct svc_rqst *rqstp, stru
 	if (ndentry == trap)
 		goto out_dput_new;
 
-	host_err = -EXDEV;
-	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
-	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
-
 	host_err = vfs_rename(fdir, odentry, tdir, ndentry, NULL, 0);
 	if (!host_err) {
 		host_err = commit_metadata(tfhp);


