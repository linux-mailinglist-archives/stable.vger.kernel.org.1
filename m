Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D676FA961
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjEHKuY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjEHKty (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D2D2A9D7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C1662916
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AE7C4339B;
        Mon,  8 May 2023 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542973;
        bh=z68mJqRInk+pcesD3Pww50pW2B9wZJjCKfYA9GNFuts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQZrdJJFDfp8pYR6S6rZc0I+GBMfnxIzSGgOTVMCsTDrUQeJl504ObzgnKr+Xob3b
         YsLzPH4hq/N3KOXlUvNsRTlJRyMco0xz7LdZA7gNUwl3GXryshoKsjojZ/J3GvWogs
         jk48zv8xHBOeSFKUR/PE1FTrNi1hiMec3S2T6NUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 609/663] afs: Fix getattr to report server i_size on dirs, not local size
Date:   Mon,  8 May 2023 11:47:15 +0200
Message-Id: <20230508094449.409584684@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 45f66fa03ba9943cca5af88d691399332b8bde08 ]

Fix afs_getattr() to report the server's idea of the file size of a
directory rather than the local size.  The local size may differ as we edit
the local copy to avoid having to redownload it and we may end up with a
differently structured blob of a different size.

However, if the directory is discarded from the pagecache we then download
it again and the user may see the directory file size apparently change.

Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/unlink/...")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 52d040ffde35f..5921dd3687e39 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -450,7 +450,7 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 				    0 : FSCACHE_ADV_SINGLE_CHUNK,
 				    &key, sizeof(key),
 				    &aux, sizeof(aux),
-				    vnode->status.size));
+				    i_size_read(&vnode->netfs.inode)));
 #endif
 }
 
@@ -766,6 +766,13 @@ int afs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		if (test_bit(AFS_VNODE_SILLY_DELETED, &vnode->flags) &&
 		    stat->nlink > 0)
 			stat->nlink -= 1;
+
+		/* Lie about the size of directories.  We maintain a locally
+		 * edited copy and may make different allocation decisions on
+		 * it, but we need to give userspace the server's size.
+		 */
+		if (S_ISDIR(inode->i_mode))
+			stat->size = vnode->netfs.remote_i_size;
 	} while (need_seqretry(&vnode->cb_lock, seq));
 
 	done_seqretry(&vnode->cb_lock, seq);
-- 
2.39.2



