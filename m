Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B74679B6E7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbjIKU4V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbjIKOGK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:06:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C99120
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:06:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD494C433C8;
        Mon, 11 Sep 2023 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441166;
        bh=3hLdzSWNGWwKR23/RE1aeiTVUg5sg5KTBWmFh5VlR20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIll2SoALNk21/ABYkLVJR2cokvtJWCARP8V7fUB4BETwoahzRQssF/ugnq70BZC+
         mgbyVOC9hVDk0cTWMSSGCzP2QDpIWkxNX2ywx+ee79Knga7Xa02inr6s5lGCG1oHes
         ezI/+urcZeaX3ZVigoefJl7MsxZCc8vJjHYlS8Ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Ryan McCann <quic_rmccann@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 290/739] drm/msm: Update dev core dump to not print backwards
Date:   Mon, 11 Sep 2023 15:41:29 +0200
Message-ID: <20230911134659.237440674@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan McCann <quic_rmccann@quicinc.com>

[ Upstream commit 903705111d863ed8ccf73465da77d232fc422ec1 ]

Device core dump add block method adds hardware blocks to dumping queue
with stack behavior which causes the hardware blocks to be printed in
reverse order. Change the addition to dumping queue data structure
from "list_add" to "list_add_tail" for FIFO queue behavior.

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/546200/
Link: https://lore.kernel.org/r/20230622-devcoredump_patch-v5-1-67e8b66c4723@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index acfe1b31e0792..add72bbc28b17 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -192,5 +192,5 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
 	new_blk->base_addr = base_addr;
 
 	msm_disp_state_dump_regs(&new_blk->state, new_blk->size, base_addr);
-	list_add(&new_blk->node, &disp_state->blocks);
+	list_add_tail(&new_blk->node, &disp_state->blocks);
 }
-- 
2.40.1



