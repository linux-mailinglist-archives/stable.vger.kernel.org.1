Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D8470C605
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjEVTOU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjEVTOQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F591FE
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EB462723
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C49C433EF;
        Mon, 22 May 2023 19:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782849;
        bh=efN6Hw7VJoZ/WQ/XBtfUpRMqnFA7puMMmxVS+Zt4b2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFiaMHrMOGsz7ulQtnU6fZuzuB1+RITH4ssZiCjlca448IEby5TQE36P4mcF48aBv
         MyVpanqEGHdZK7uMDaAVZiRRgJ5mKNCSVd3/XQfMyTIfkNvKOwTkAO+az8n/+nH52v
         qcfjvJVxWGEF5kbhaZmEr0tlyBRFs4ZzEsRm4Hdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 028/203] ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
Date:   Mon, 22 May 2023 20:07:32 +0100
Message-Id: <20230522190355.743724519@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit 01e4ca29451760b9ac10b4cdc231c52150842643 ]

If EXT4_MB_HINT_GOAL_ONLY is set, ext4_mb_regular_allocator will only
allocate blocks from ext4_mb_find_by_goal. Allow to find by goal in
ext4_mb_find_by_goal if EXT4_MB_HINT_GOAL_ONLY is set or allocation
with EXT4_MB_HINT_GOAL_ONLY set will always fail.

EXT4_MB_HINT_GOAL_ONLY is not used at all, so the problem is not
found for now.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20230303172120.3800725-3-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 5354b2af3406 ("ext4: allow ext4_get_group_info() to fail")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0e0226b30db6a..820804a7afe6e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2206,7 +2206,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct ext4_free_extent ex;
 
-	if (!(ac->ac_flags & EXT4_MB_HINT_TRY_GOAL))
+	if (!(ac->ac_flags & (EXT4_MB_HINT_TRY_GOAL | EXT4_MB_HINT_GOAL_ONLY)))
 		return 0;
 	if (grp->bb_free == 0)
 		return 0;
-- 
2.39.2



