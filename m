Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A347ECCBE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjKOTc1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjKOTcX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:32:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0015D10C6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:32:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C5DC433C8;
        Wed, 15 Nov 2023 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076735;
        bh=5iEaMigpw0dkiAILjKDj+DKRJiWpCIrIgQ06h5x8+Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHUkWSPAbyf8ivzI3EE0VtSEpctamWYOViqAjpPRKgbSS7oPsRg3cf+uto8f0k4Fc
         VjaD47RNp65JyS0G28r6Xpn6k3/GNp6p1nuQiHJIHd9c3N7YjDzxIukRY5w8gYJ2en
         0l+u/oMv15eHaQ3AX886Z5Gsn5vpLNOYbizXKsfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 405/550] f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()
Date:   Wed, 15 Nov 2023 14:16:29 -0500
Message-ID: <20231115191628.835693824@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index ea4a094c518f9..e53a429bd4c4c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3258,6 +3258,7 @@ int f2fs_precache_extents(struct inode *inode)
 		return -EOPNOTSUPP;
 
 	map.m_lblk = 0;
+	map.m_pblk = 0;
 	map.m_next_pgofs = NULL;
 	map.m_next_extent = &m_next_extent;
 	map.m_seg_type = NO_CHECK_TYPE;
-- 
2.42.0



