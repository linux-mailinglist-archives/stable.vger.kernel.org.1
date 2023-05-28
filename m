Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D0E713F03
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjE1TlF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjE1TlE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A500BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E3061ECB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B47C433D2;
        Sun, 28 May 2023 19:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302860;
        bh=w9VxPysiKMrYdqxAYVz6j4YUhLGK9dxWfb0tP/gY1rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2dlZXsxsGrfU8wX+29i+WeQo10lI60Sj0s59XtNOyS9mKSGQTYZT6RoxK8vLCucx
         qcF7tFKhW85oJny7y/AxycRGzUNdcGAvY6xkOSTkD10tZywJlw4u9bzaGxLfW/nuVQ
         gaLiYETzgq7myuVWexI4lT5SwyLC8U/dCoVh8EzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 028/211] ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
Date:   Sun, 28 May 2023 20:09:09 +0100
Message-Id: <20230528190844.218933536@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index aa51d1b837274..84d74ba02b378 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1864,7 +1864,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct ext4_free_extent ex;
 
-	if (!(ac->ac_flags & EXT4_MB_HINT_TRY_GOAL))
+	if (!(ac->ac_flags & (EXT4_MB_HINT_TRY_GOAL | EXT4_MB_HINT_GOAL_ONLY)))
 		return 0;
 	if (grp->bb_free == 0)
 		return 0;
-- 
2.39.2



