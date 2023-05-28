Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE7713F11
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjE1TmE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjE1TmD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8211BC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D4A761EDE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA197C4339B;
        Sun, 28 May 2023 19:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302899;
        bh=2VFGY4HvW2OUGZk0bl99gzoUPjHwc42VfKnYTyrV3dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqzCbXW6gFQuferIp+LkV+uz3ngZPpHggmFxd1RQRSiDndSkpKkfzi8G4oqZuUjDW
         5f1VEO45DKJTyDHN1+Xq48cElFJ0a3uO2VZUGiwxhuFmLza2/UMv8mNvOgybHo48BZ
         xDqFefldhOQJdN7aQ7XnyLo3ufczG5UKOEEwUhxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 054/211] gfs2: Fix inode height consistency check
Date:   Sun, 28 May 2023 20:09:35 +0100
Message-Id: <20230528190844.935919986@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit cfcdb5bad34f600aed7613c3c1a5e618111f77b7 ]

The maximum allowed height of an inode's metadata tree depends on the
filesystem block size; it is lower for bigger-block filesystems.  When
reading in an inode, make sure that the height doesn't exceed the
maximum allowed height.

Arrays like sd_heightsize are sized to be big enough for any filesystem
block size; they will often be slightly bigger than what's needed for a
specific filesystem.

Reported-by: syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index db28c240dae35..87f8110884663 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -405,6 +405,7 @@ static int inode_go_demote_ok(const struct gfs2_glock *gl)
 
 static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	const struct gfs2_dinode *str = buf;
 	struct timespec64 atime;
 	u16 height, depth;
@@ -444,7 +445,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	/* i_diskflags and i_eattr must be set before gfs2_set_inode_flags() */
 	gfs2_set_inode_flags(&ip->i_inode);
 	height = be16_to_cpu(str->di_height);
-	if (unlikely(height > GFS2_MAX_META_HEIGHT))
+	if (unlikely(height > sdp->sd_max_height))
 		goto corrupt;
 	ip->i_height = (u8)height;
 
-- 
2.39.2



