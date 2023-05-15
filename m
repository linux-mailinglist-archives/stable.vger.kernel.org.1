Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2617703725
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbjEORRO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243872AbjEORQz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608D3E73D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE4162BDD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC054C433D2;
        Mon, 15 May 2023 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170937;
        bh=bSM9H6d6VLR85AnQQULNxHo4PgK4wgYUqBTMVrC7dew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMMTAclGG36BXt68H5o5Ftsbe81iGiixcqQ4DK4oGtVkWYO3/aA5gW5IoASkeB/+2
         +aCVPkVMbskbLhHsgWSsXykzWsR8Biupm3fuVqYShZMEeHipaUPk6rn66O/EqzgpV8
         a9EYyGcm40VTQJjbjH0kg0eRJOKN38EG1w/5ca74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Maxim Korotkov <korotkov.maxim.s@gmail.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 049/242] writeback: fix call of incorrect macro
Date:   Mon, 15 May 2023 18:26:15 +0200
Message-Id: <20230515161723.384948580@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Maxim Korotkov <korotkov.maxim.s@gmail.com>

[ Upstream commit 3e46c89c74f2c38e5337d2cf44b0b551adff1cb4 ]

 the variable 'history' is of type u16, it may be an error
 that the hweight32 macro was used for it
 I guess macro hweight16 should be used

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2a81490811d0 ("writeback: implement foreign cgroup inode detection")
Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230119104443.3002-1-korotkov.maxim.s@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 713e2d97935ff..909150a57aebb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -829,7 +829,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 		 * is okay.  The main goal is avoiding keeping an inode on
 		 * the wrong wb for an extended period of time.
 		 */
-		if (hweight32(history) > WB_FRN_HIST_THR_SLOTS)
+		if (hweight16(history) > WB_FRN_HIST_THR_SLOTS)
 			inode_switch_wbs(inode, max_id);
 	}
 
-- 
2.39.2



