Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005257D3313
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjJWL0a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjJWL03 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:26:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9092
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:26:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA77EC433C9;
        Mon, 23 Oct 2023 11:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060386;
        bh=OMxN+MAuJTEM3cNtG/ORCZ5nABEUjPPn8G/dSlpQF58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yaTbZoFEiSvUdZ21eTceYYOKMqWSM7A9v2+lRjjQM3ERY0jckalqo+vOGpZLu4T23
         45J/hy0zyu5x2PEVIoJqQT9dyevbGqOCOQ12va7VJIN2uzhmQ8s987xnJav7xmSzpN
         csVDJD80yWqFx5dWhekk/KwF5/uRC56My9XkUZKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 6.1 155/196] pNFS/flexfiles: Check the layout validity in ff_layout_mirror_prepare_stats
Date:   Mon, 23 Oct 2023 12:57:00 +0200
Message-ID: <20231023104832.846229351@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit e1c6cfbb3bd1377e2ddcbe06cf8fb1ec323ea7d3 upstream.

Ensure that we check the layout pointer and validity after dereferencing
it in ff_layout_mirror_prepare_stats.

Fixes: 08e2e5bc6c9a ("pNFS/flexfiles: Clean up layoutstats")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2520,9 +2520,9 @@ ff_layout_mirror_prepare_stats(struct pn
 	return i;
 }
 
-static int
-ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
+static int ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
 {
+	struct pnfs_layout_hdr *lo;
 	struct nfs4_flexfile_layout *ff_layout;
 	const int dev_count = PNFS_LAYOUTSTATS_MAXDEV;
 
@@ -2533,11 +2533,14 @@ ff_layout_prepare_layoutstats(struct nfs
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


