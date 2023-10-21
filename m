Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7BC7D1BE6
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJUJGm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJUJGl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 05:06:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01ADD
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 02:06:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5A2C433C9;
        Sat, 21 Oct 2023 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697879196;
        bh=KaXph4s95eEz94/9GVmxEj0p83ZcCc3IGwH1M2MBWmQ=;
        h=Subject:To:Cc:From:Date:From;
        b=EMW4l42xCOWlALgl+VZPKQhw57/CP5OxJBCBiGbL+k6kt3gSMnweUnG6iYfCMQqxG
         femrm5kCSIhmOry+D+ZC46hQe8PSYimrbu3s1UujgfjdIIzd5Emmq2Le2yj2pXlKb2
         DWWaLkC7h2AtHTEvDMH94RBSODvo84DEpXluGov0=
Subject: FAILED: patch "[PATCH] pNFS/flexfiles: Check the layout validity in" failed to apply to 5.4-stable tree
To:     trond.myklebust@hammerspace.com, Anna.Schumaker@Netapp.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 11:06:28 +0200
Message-ID: <2023102128-paralysis-unwary-3d2b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x e1c6cfbb3bd1377e2ddcbe06cf8fb1ec323ea7d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102128-paralysis-unwary-3d2b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1c6cfbb3bd1377e2ddcbe06cf8fb1ec323ea7d3 Mon Sep 17 00:00:00 2001
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Sun, 8 Oct 2023 14:28:46 -0400
Subject: [PATCH] pNFS/flexfiles: Check the layout validity in
 ff_layout_mirror_prepare_stats

Ensure that we check the layout pointer and validity after dereferencing
it in ff_layout_mirror_prepare_stats.

Fixes: 08e2e5bc6c9a ("pNFS/flexfiles: Clean up layoutstats")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a1dc33864906..ef817a0475ff 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2520,9 +2520,9 @@ ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
 	return i;
 }
 
-static int
-ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
+static int ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
 {
+	struct pnfs_layout_hdr *lo;
 	struct nfs4_flexfile_layout *ff_layout;
 	const int dev_count = PNFS_LAYOUTSTATS_MAXDEV;
 
@@ -2533,11 +2533,14 @@ ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
 		return -ENOMEM;
 
 	spin_lock(&args->inode->i_lock);
-	ff_layout = FF_LAYOUT_FROM_HDR(NFS_I(args->inode)->layout);
-	args->num_dev = ff_layout_mirror_prepare_stats(&ff_layout->generic_hdr,
-						       &args->devinfo[0],
-						       dev_count,
-						       NFS4_FF_OP_LAYOUTSTATS);
+	lo = NFS_I(args->inode)->layout;
+	if (lo && pnfs_layout_is_valid(lo)) {
+		ff_layout = FF_LAYOUT_FROM_HDR(lo);
+		args->num_dev = ff_layout_mirror_prepare_stats(
+			&ff_layout->generic_hdr, &args->devinfo[0], dev_count,
+			NFS4_FF_OP_LAYOUTSTATS);
+	} else
+		args->num_dev = 0;
 	spin_unlock(&args->inode->i_lock);
 	if (!args->num_dev) {
 		kfree(args->devinfo);

