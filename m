Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8214974C2E7
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjGILZ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjGILZ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1D313D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2FBF60B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A8EC433C8;
        Sun,  9 Jul 2023 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901956;
        bh=xXKNGR0dCRTxWu8UBfQXcmT6tgnXo5eNhTez1gORFKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYprjPHcd1V/GCqhXq0kf6NP7ZPJcGcYY8C2MWKeyS83A0FT+0JKpJP8ZPexs4Lxq
         gxMO/JgTV7ualGnLbOxF4GW7lXs12TWj1HhbMxrSSQ1TChYEi9fEaJojTGCS/aWjyE
         4bPTlXMcxtuLbjNY2ow8/WHC+OIxOaP4TU/rPJy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 204/431] RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid
Date:   Sun,  9 Jul 2023 13:12:32 +0200
Message-ID: <20230709111455.954641263@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit b989f90cef0af48aa5679b6a75476371705ec53c ]

The NULL check inside bnxt_re_update_gid() always return false.  If
sgid_tbl->tbl is not allocated, then dev_init would have failed.

Fixes: 5fac5b1b297f ("RDMA/bnxt_re: Add vlan tag for untagged RoCE traffic when PFC is configured")
Link: https://lore.kernel.org/r/1684478897-12247-5-git-send-email-selvin.xavier@broadcom.com
Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/main.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a9cc65614a9ee..b4edcf12d0d19 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1010,12 +1010,6 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
 	if (!ib_device_try_get(&rdev->ibdev))
 		return 0;
 
-	if (!sgid_tbl) {
-		ibdev_err(&rdev->ibdev, "QPLIB: SGID table not allocated");
-		rc = -EINVAL;
-		goto out;
-	}
-
 	for (index = 0; index < sgid_tbl->active; index++) {
 		gid_idx = sgid_tbl->hw_id[index];
 
@@ -1033,7 +1027,7 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
 		rc = bnxt_qplib_update_sgid(sgid_tbl, &gid, gid_idx,
 					    rdev->qplib_res.netdev->dev_addr);
 	}
-out:
+
 	ib_device_put(&rdev->ibdev);
 	return rc;
 }
-- 
2.39.2



