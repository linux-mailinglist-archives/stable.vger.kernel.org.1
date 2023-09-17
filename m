Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1021D7A376B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbjIQTT0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbjIQTSy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:18:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93753119
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:18:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEE6C433C7;
        Sun, 17 Sep 2023 19:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978328;
        bh=LcNdHopO5rhAjPZKKdAJ115Ti78DtoetUDwGcLRPcJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMEAClXZ9vColJp23JfJE20ill6RNEeBtyNM+T13aXJ7A/BRPsLSqllse3BjVxA/f
         5K/ITD72368vhu06CMwPh4UZoGFRKsB/tg68l9O+2T8O4AJ29RyEQVIdW9PtmhUUac
         CAkW4RcAPECE8I1XDBCijOr69p6NFUMdL9LGVBk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Snowberg <eric.snowberg@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 045/406] ovl: Always reevaluate the file signature for IMA
Date:   Sun, 17 Sep 2023 21:08:19 +0200
Message-ID: <20230917191102.331608707@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Snowberg <eric.snowberg@oracle.com>

[ Upstream commit 18b44bc5a67275641fb26f2c54ba7eef80ac5950 ]

Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
partially closed an IMA integrity issue when directly modifying a file
on the lower filesystem.  If the overlay file is first opened by a user
and later the lower backing file is modified by root, but the extended
attribute is NOT updated, the signature validation succeeds with the old
original signature.

Update the super_block s_iflags to SB_I_IMA_UNVERIFIABLE_SIGNATURE to
force signature reevaluation on every file access until a fine grained
solution can be found.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5d7df839902df..e0384095ca960 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2028,7 +2028,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_xattr = ovl_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC;
+	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
-- 
2.40.1



