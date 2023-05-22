Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF070C897
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjEVTkL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjEVTkF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6937B129
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD1D6629F4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44B8C433D2;
        Mon, 22 May 2023 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784400;
        bh=7rcd30mQmCELrnheZDdwktUQc2t9ZfeJhhf8hY+89KM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6eG4335eiUhM+w28/RCUGU8kL2Y9lqlP22nY2rxt4VkEqbVS1j6ElcZNYbeNG2TK
         E+YM0RpcNQi1naeFJL1/11QOZSKv5MQiHsdFJxGIExMivf5g4EMg8T1qeWVdNOMnMn
         g1/zWK6UOyvwDoaSmaixIaupx+kCQ8PaQOLkfYc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 038/364] ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
Date:   Mon, 22 May 2023 20:05:43 +0100
Message-Id: <20230522190413.786866487@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 5639a4cf7ff98..343cb38ea3653 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2162,7 +2162,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct ext4_free_extent ex;
 
-	if (!(ac->ac_flags & EXT4_MB_HINT_TRY_GOAL))
+	if (!(ac->ac_flags & (EXT4_MB_HINT_TRY_GOAL | EXT4_MB_HINT_GOAL_ONLY)))
 		return 0;
 	if (grp->bb_free == 0)
 		return 0;
-- 
2.39.2



