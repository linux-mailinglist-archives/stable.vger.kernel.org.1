Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC37F7ED4EB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbjKOU7g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbjKOU6J (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:58:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784D71FD5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF90C32787;
        Wed, 15 Nov 2023 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081841;
        bh=RZoFvYBIoi3oWaTSCAK7fu6Df5l4ULCoshICXAWtab0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFHy0vYrDmiIXE4xvzurLJLZxqlEAcPBY9ZuIxN0V5tOkA0skp3RHEst0RqBIBu0W
         RKG/8rVzxa4aMZAgSSOGNMZjtk0t4bYPziWhbceH5FDqRRlJzo/vYEuBPbYTyv0gAR
         uf7HTxMWin5RGIOJN8/8HJfMjzXQ0rYaZeLoDLo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 135/191] f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()
Date:   Wed, 15 Nov 2023 15:46:50 -0500
Message-ID: <20231115204652.626544460@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit 8b07c1fb0f1ad139373c8253f2fad8bc43fab07d ]

Otherwise, it may print random physical block address in tracepoint
of f2fs_map_blocks() as below:

f2fs_map_blocks: dev = (253,16), ino = 2297, file offset = 0, start blkaddr = 0xa356c421, len = 0x0, flags = 0

Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6e91be5b8c30f..4e6b93f167589 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3315,6 +3315,7 @@ int f2fs_precache_extents(struct inode *inode)
 		return -EOPNOTSUPP;
 
 	map.m_lblk = 0;
+	map.m_pblk = 0;
 	map.m_next_pgofs = NULL;
 	map.m_next_extent = &m_next_extent;
 	map.m_seg_type = NO_CHECK_TYPE;
-- 
2.42.0



