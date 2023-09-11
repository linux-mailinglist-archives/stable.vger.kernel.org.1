Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1158079AD92
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbjIKVQb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbjIKOPc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:15:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF9DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:15:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039F0C433C9;
        Mon, 11 Sep 2023 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441728;
        bh=RdG5XIvh+6/6ZEYTjkUtDVH4G+rUgnAIYEzI7xBv4L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1f9vMRjjxYXH2AsBBoBBsOk3X/SaBcXPGHhu9YBcK8wXLPrbHJfrBvgs2D8l77+Te
         MUA29dCKie2AdT59Hl+KMGHxGE1EYDuno+S0hR87KjBmG+heRibGTShJ+tdvkj53ov
         OC0pMz45p804s7StAUOWRm3mTTrEJnRWrvs3ybm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 515/739] RDMA/hns: Fix incorrect post-send with direct wqe of wr-list
Date:   Mon, 11 Sep 2023 15:45:14 +0200
Message-ID: <20230911134705.504450951@linuxfoundation.org>
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

From: Junxian Huang <huangjunxian6@hisilicon.com>

[ Upstream commit 706efac4477cdb8be857f6322457de524acc02ff ]

Currently, direct wqe is not supported for wr-list. RoCE driver excludes
direct wqe for wr-list by judging whether the number of wr is 1.

For a wr-list where the second wr is a length-error atomic wr, the
post-send driver handles the first wr and adds 1 to the wr number counter
firstly. While handling the second wr, the driver finds out a length error
and terminates the wr handle process, remaining the counter at 1. This
causes the driver mistakenly judges there is only 1 wr and thus enters
the direct wqe process, carrying the current length-error atomic wqe.

This patch fixes the error by adding a judgement whether the current wr
is a bad wr. If so, use the normal doorbell process but not direct wqe
despite the wr number is 1.

Fixes: 01584a5edcc4 ("RDMA/hns: Add support of direct wqe")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20230804012711.808069-3-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8f7eb11066b43..f95551b6d4072 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -750,7 +750,8 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		qp->sq.head += nreq;
 		qp->next_sge = sge_idx;
 
-		if (nreq == 1 && (qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE))
+		if (nreq == 1 && !ret &&
+		    (qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE))
 			write_dwqe(hr_dev, qp, wqe);
 		else
 			update_sq_db(hr_dev, qp);
-- 
2.40.1



