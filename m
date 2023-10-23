Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A007D3317
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjJWL0l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjJWL0k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:26:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2C100
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:26:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B676C433C8;
        Mon, 23 Oct 2023 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060397;
        bh=SV6BtxR0oVGgdR2P71txoRQvZJO3vGRjQ4IRH1Oruxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0k6rj9+IS5V/f75mVZW9eEJAZNxPFpJfiKqZEE0ZNt0LF/ljKzgutK9O90IRhZJx
         NoixMPlUHhG0dWMu7GV12sIaz0mm295ZbXYyxFEV/dvYK2PPrh/2Z/ERUTZ5LrOinl
         0ohnla7K47PsSy3Ox6gys/pZZB/A+W+Gqqkg3Kc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Trond Myklebust <trondmy@hammerspace.com>,
        Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 6.1 158/196] nfs42: client needs to strip file modes suid/sgid bit after ALLOCATE op
Date:   Mon, 23 Oct 2023 12:57:03 +0200
Message-ID: <20231023104832.922771366@linuxfoundation.org>
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

From: Dai Ngo <dai.ngo@oracle.com>

commit f588d72bd95f748849685412b1f0c7959ca228cf upstream.

The Linux NFS server strips the SUID and SGID from the file mode
on ALLOCATE op.

Modify _nfs42_proc_fallocate to add NFS_INO_REVAL_FORCED to
nfs_set_cache_invalid's argument to force update of the file
mode suid/sgid bit.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs42proc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -81,7 +81,8 @@ static int _nfs42_proc_fallocate(struct
 	if (status == 0) {
 		if (nfs_should_remove_suid(inode)) {
 			spin_lock(&inode->i_lock);
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+			nfs_set_cache_invalid(inode,
+				NFS_INO_REVAL_FORCED | NFS_INO_INVALID_MODE);
 			spin_unlock(&inode->i_lock);
 		}
 		status = nfs_post_op_update_inode_force_wcc(inode,


