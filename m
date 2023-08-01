Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F002C76AF11
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjHAJo6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjHAJom (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF34229
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBB956151B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05B8C433C7;
        Tue,  1 Aug 2023 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882922;
        bh=wL+wgLn/14c9wzN4T+XJzRRYNdXulAknWX6ly04tDh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBSlARprNp85GXaDD6cMX0A22MQqlB6x0HAPkG0kO8c5Q7Iu+ZxdSvJnml6i2DpiD
         B4nIKlPjn1zp04PCwaDmpsHZIpsMUfEipte+H7es/n5pl9DF2jvD8xCiJqwfv0zqNa
         PYCXI3ephs5EkC46FwRWIAspfwtpatWTCzGayjM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 050/239] ext4: mballoc: Remove useless setting of ac_criteria
Date:   Tue,  1 Aug 2023 11:18:34 +0200
Message-ID: <20230801091927.355459866@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ritesh Harjani <ritesh.list@gmail.com>

[ Upstream commit 569f196f1e7a14472f21734170411f75a3179db0 ]

There will be changes coming in future patches which will introduce a new
criteria for block allocation. This removes the useless setting of ac_criteria.
AFAIU, this might be only used to differentiate between whether a preallocated
blocks was allocated or was regular allocator called for allocating blocks.
Hence this also adds the debug prints to identify what type of block allocation
was done in ext4_mb_show_ac().

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/1dbae05617519cb6202f1b299c9d1be3e7cda763.1685449706.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 9d3de7ee192a ("ext4: fix rbtree traversal bug in ext4_mb_use_preallocated")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1f4d00a4308dc..d49d1a7af22db 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4614,7 +4614,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 			atomic_inc(&tmp_pa->pa_count);
 			ext4_mb_use_inode_pa(ac, tmp_pa);
 			spin_unlock(&tmp_pa->pa_lock);
-			ac->ac_criteria = 10;
 			read_unlock(&ei->i_prealloc_lock);
 			return true;
 		}
@@ -4657,7 +4656,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	}
 	if (cpa) {
 		ext4_mb_use_group_pa(ac, cpa);
-		ac->ac_criteria = 20;
 		return true;
 	}
 	return false;
@@ -5431,6 +5429,10 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 			(unsigned long)ac->ac_b_ex.fe_logical,
 			(int)ac->ac_criteria);
 	mb_debug(sb, "%u found", ac->ac_found);
+	mb_debug(sb, "used pa: %s, ", ac->ac_pa ? "yes" : "no");
+	if (ac->ac_pa)
+		mb_debug(sb, "pa_type %s\n", ac->ac_pa->pa_type == MB_GROUP_PA ?
+			 "group pa" : "inode pa");
 	ext4_mb_show_pa(sb);
 }
 #else
-- 
2.39.2



