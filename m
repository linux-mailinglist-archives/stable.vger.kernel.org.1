Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F047DA4B7
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 03:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJ1Bxq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 21:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Bxp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 21:53:45 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7ED11B
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 18:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ACtA88MMaslKsHbhFDrGAzp/DXJ+AFtLGQVX87BCDE=; b=TAqAiwC6SrN4vU4L25Ncjh9Kix
        m6/9/qmYeUqSv+S92eB01f8UY9nQYN2UbNcPTQ6mD2J0bFVDTqe7rISdVeWePq4yCJtczsuvOm4yB
        LMsz1fHpgM/qKshWaTjlDzDw8MvzE8iccngzUw7vJIna7IwexuiakRV+F690LBrfq6ZFkKL+6midd
        Ur6lYeI+OrG4SXfyglKQJikA9KnjiInUE16RMwoZcKKIvjOEn/EoDpWNcfAJxRWV4VfIGM39CTQI9
        cvTks9f5HqASAHVZEFhL2lYAyDv81CHLqfm/hTQ7SqFUI+BmzCJELyb1BHskFNz89ysCU+vkaj+ZQ
        NR/+Lpzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwYW9-006pgv-2O;
        Sat, 28 Oct 2023 01:53:37 +0000
Date:   Sat, 28 Oct 2023 02:53:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     gregkh@linuxfoundation.org
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] nfsd: lock_rename() needs both
 directories to live on the" failed to apply to 4.19-stable tree
Message-ID: <20231028015337.GP800259@ZenIV>
References: <2023102702-equation-convene-7bce@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102702-equation-convene-7bce@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 02:18:02PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Same story - trivial context changes; see rebased diff below:

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 28e7f86c8c94..a7231d17e359 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1691,6 +1691,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
@@ -1724,12 +1730,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
