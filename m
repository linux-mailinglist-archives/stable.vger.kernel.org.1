Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5FD7DA4B6
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 03:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjJ1Bul (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 21:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Buk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 21:50:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBB111B
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 18:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aRidRwlryL1qBY2BeDNjS+KPn32zznIvsqQRrFmhpZA=; b=KdxFg3yjPsPxjLI31GGQZ4YfWg
        rvtzQl+EUVOf1DDUQJJ41kr44nVbRXxJhM4CBdKHk6M/AtWusDINm5MLdXobD1SFcYvf9cf9YU7nm
        tHpcN9FADPxyElZ7gD/ISJ7zyviQp7eawrgkd3WEl80I/6eKj0BSNgZOz3Bq7ZFGHVIlrnhK3CDXk
        qVLUuMN5aTvv8nHlW87jKsfLnV4iyl3mOwjMiHStSQpAs/PHow+Zdmceh0lpv65Mo+hQFxjDjp7qe
        69pvkbHJRZsDK8cKG2sYyM/cPQbILbtbOruqq4UleN1wMPMzT0GSdlAwxxeBn8ZONfLdwxzJGyVjk
        wSu3CFxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwYTA-006pbj-0f;
        Sat, 28 Oct 2023 01:50:32 +0000
Date:   Sat, 28 Oct 2023 02:50:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     gregkh@linuxfoundation.org
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] nfsd: lock_rename() needs both
 directories to live on the" failed to apply to 5.4-stable tree
Message-ID: <20231028015032.GO800259@ZenIV>
References: <2023102701-cadet-groovy-9672@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102701-cadet-groovy-9672@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 02:18:01PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Trivial context change in that one, really.  The if (...) following the
second chunk has changed; git cherry-pick is unhappy about it.  See below
for rebased diff (identical to the original except for the post-chunk
context):

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b6f4b552c9af..6aa968bee0ce 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1689,6 +1689,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
@@ -1723,12 +1729,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ndentry == trap)
 		goto out_dput_new;
 
-	host_err = -EXDEV;
-	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
-	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
-
 	if (nfsd_has_cached_files(ndentry)) {
 		has_cached = true;
 		goto out_dput_old;
