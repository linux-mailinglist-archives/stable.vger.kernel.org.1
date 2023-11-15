Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E897ECC7D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjKOTat (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjKOTar (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:30:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A61AC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:30:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36CDC433C9;
        Wed, 15 Nov 2023 19:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076643;
        bh=/xHdzCFtTQvU02azXj9MCQwveNrrxgDyNfO+eUxgZlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0m7d1vE2+L4m+GdPA2C8t3PCDxFSNPmYruCT26s+i/cQ7HZav6CvlWQF/GbMPDQ/
         ir0cIFphSUk7IqaQI7c4vs1rEFJHk67N5WUndFERpYMnehWOcgn8kOx23esFc7GWxP
         VjTwfVaS69URJ7T4/LVgDCxW1n161o8l7tHDqZx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gou Hao <gouhao@uniontech.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 333/550] ext4: move ix sanity check to corrent position
Date:   Wed, 15 Nov 2023 14:15:17 -0500
Message-ID: <20231115191623.852548259@linuxfoundation.org>
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

From: Gou Hao <gouhao@uniontech.com>

[ Upstream commit af90a8f4a09ec4a3de20142e37f37205d4687f28 ]

Check 'ix' before it is used.

Fixes: 80e675f906db ("ext4: optimize memmmove lengths in extent/index insertions")
Signed-off-by: Gou Hao <gouhao@uniontech.com>
Link: https://lore.kernel.org/r/20230906013341.7199-1-gouhao@uniontech.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e4115d338f101..d97333aa92e99 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1010,6 +1010,11 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		ix = curp->p_idx;
 	}
 
+	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
+		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
+		return -EFSCORRUPTED;
+	}
+
 	len = EXT_LAST_INDEX(curp->p_hdr) - ix + 1;
 	BUG_ON(len < 0);
 	if (len > 0) {
@@ -1019,11 +1024,6 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		memmove(ix + 1, ix, len * sizeof(struct ext4_extent_idx));
 	}
 
-	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
-		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
-		return -EFSCORRUPTED;
-	}
-
 	ix->ei_block = cpu_to_le32(logical);
 	ext4_idx_store_pblock(ix, ptr);
 	le16_add_cpu(&curp->p_hdr->eh_entries, 1);
-- 
2.42.0



