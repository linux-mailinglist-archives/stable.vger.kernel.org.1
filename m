Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B97BDFE2
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377160AbjJINfJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377156AbjJINfI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:35:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161F9C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:35:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2209EC433C8;
        Mon,  9 Oct 2023 13:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858506;
        bh=voLaP+EWwDCmzwHXKCV8+2TbDDQu1sUgZzujU9OX1k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbyXRAJeMdk02U9zl82RMwiSAJT//UM5Ilbcjhkly/UIcnCVc4l1XhmSCwNMiEsFN
         YKcoZlierKaAo6kgi0WsIMGCmalK5omIzzWSS3PIVdi+qDVGcPLNomw+aOX/pqGkHK
         Zr3MQ38h4yVLfZEBUCDF6FS4plkQsec78weYGCvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 012/226] ext4: replace the traditional ternary conditional operator with with max()/min()
Date:   Mon,  9 Oct 2023 14:59:33 +0200
Message-ID: <20231009130127.046528306@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit de8bf0e5ee7482585450357c6d4eddec8efc5cb7 ]

Replace the traditional ternary conditional operator with with max()/min()

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20230801143204.2284343-7-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 45e4ab320c9b ("ext4: move setting of trimmed bit into ext4_try_to_trim_range()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5c650e28dcb6b..c06f304f38edf 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5902,8 +5902,7 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 	void *bitmap;
 
 	bitmap = e4b->bd_bitmap;
-	start = (e4b->bd_info->bb_first_free > start) ?
-		e4b->bd_info->bb_first_free : start;
+	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
 
@@ -6125,8 +6124,7 @@ ext4_mballoc_query_range(
 
 	ext4_lock_group(sb, group);
 
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
+	start = max(e4b.bd_info->bb_first_free, start);
 	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
 		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
-- 
2.40.1



