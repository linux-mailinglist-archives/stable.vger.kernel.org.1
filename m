Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DF7B8721
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243494AbjJDSBx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJDSBx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:01:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1568DA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:01:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AA4C433C7;
        Wed,  4 Oct 2023 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442509;
        bh=2SftrWpqzlOlPpZ/+xSbZS1+eZ5koZ2HDM2FNtbtSF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSrnVfYmUw6cGcd68dp5zM/wSwvaUpsrgRG6khBYCFk52jT/VxpoyKQAP6TEBgWn4
         SAX3W4scRRObF+EYmnL3It/mwQv9BVyXqsVROy1J7H3Y3vNExZ/Hu/XjFLhntU3OU3
         pjOYlGUC6k95t0j7P4OwE5eD1BmkrtCESXDhjqrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 011/183] ext4: scope ret locally in ext4_try_to_trim_range()
Date:   Wed,  4 Oct 2023 19:54:02 +0200
Message-ID: <20231004175204.461111589@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

[ Upstream commit afcc4e32f606dbfb47aa7309172c89174b86e74c ]

As commit 6920b3913235 ("ext4: add new helper interface
ext4_try_to_trim_range()") moves some code into the separate function
ext4_try_to_trim_range(), the use of the variable ret within that
function is more limited and can be adjusted as well.

Scope the use of the variable ret locally and drop dead assignments.

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Link: https://lore.kernel.org/r/20210820120853.23134-1-lukas.bulwahn@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 45e4ab320c9b ("ext4: move setting of trimmed bit into ext4_try_to_trim_range()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7e7153c673c0d..6eb445bbb2be8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6441,7 +6441,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
 	ext4_grpblk_t next, count, free_count;
 	void *bitmap;
-	int ret = 0;
 
 	bitmap = e4b->bd_bitmap;
 	start = (e4b->bd_info->bb_first_free > start) ?
@@ -6456,10 +6455,10 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		next = mb_find_next_bit(bitmap, max + 1, start);
 
 		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start, next - start, e4b);
+			int ret = ext4_trim_extent(sb, start, next - start, e4b);
+
 			if (ret && ret != -EOPNOTSUPP)
 				break;
-			ret = 0;
 			count += next - start;
 		}
 		free_count += next - start;
-- 
2.40.1



