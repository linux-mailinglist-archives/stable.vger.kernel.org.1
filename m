Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD27DA4B8
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 03:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjJ1Byu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 21:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Byu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 21:54:50 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A5121
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 18:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N92n0SN1wV7kOOL+lwzPpT65WYyGtBwMXYAyrGySmls=; b=QorP5KbI78q/pb9KLdmfMF5stx
        Z9RzEuaghv+gZ/BvKEE1XvQ3GKTDuaZVJpDhpZLY+z0uF63wX3Zb1ecwuON8FpdJrMhB2wf1uY73J
        xHqpMuWUjFC6VYtdOo9C6Iyqfarh/NNoJvC/nl8w6HUTIjC9h9WYJCV1fxX+ADSEZ1K66g9K42WRa
        mshrN1K3wo8b+NfSenAhqI6qP3CTkf3XG/sP+uJH7LejWpaf00ALLH/sXRXdBmgHMIM+4E4dy6gXB
        eo2iczXiPxxzGIu96rdmMzt9niFW9iqQv4GU3g3+9XxO9Zn0qLF8Wn14SZ1HLeLnkM2ruZviTWUFI
        Oq/LphMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwYXC-006piI-25;
        Sat, 28 Oct 2023 01:54:42 +0000
Date:   Sat, 28 Oct 2023 02:54:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     gregkh@linuxfoundation.org
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] nfsd: lock_rename() needs both
 directories to live on the" failed to apply to 4.14-stable tree
Message-ID: <20231028015442.GQ800259@ZenIV>
References: <2023102703-naming-synthetic-7515@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102703-naming-synthetic-7515@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 02:18:03PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 4.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Identical to 4.19 - same rebase applies:

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
