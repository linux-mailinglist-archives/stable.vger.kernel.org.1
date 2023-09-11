Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8190B79BEBE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbjIKVLi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbjIKOPP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:15:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6689DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:15:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA9CC433C7;
        Mon, 11 Sep 2023 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441711;
        bh=RgZvhWmK0NnEGqV9vMA9lC8R2E0ef3gUlfW8BtUPtkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1aS3B2b6UDpEmPBPxURk2CDzpgByKUyuEP2EQkycjzCs6kYYptWMX2gXGPD0eZAfW
         HAtrQjcUlnwxmuCYoP7BetxXD/nYK+DiEQgxu93oLKcaDJX+qh9J3ic9ZdLbCHr9lK
         y5oO/lXXiEWcYuVxvyYDcMwdRBXPoNXcHcdDknIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Chan <michael.chan@broadcom.com>,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 510/739] bnxt_en: Share the bar0 address with the RoCE driver
Date:   Mon, 11 Sep 2023 15:45:09 +0200
Message-ID: <20230911134705.372887360@linuxfoundation.org>
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

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

[ Upstream commit 61220e098e858951f1926d66c1490a96351e1c85 ]

Add a parameter in the bnxt_en_dev structure to share the bar0 address
with RoCE driver.

Link: https://lore.kernel.org/r/1689742977-9128-3-git-send-email-selvin.xavier@broadcom.com
CC: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: f19fba1f79dc ("RDMA/bnxt_re: Fix max_qp count for virtual functions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 852eb449ccae2..6ba2b93986333 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -345,7 +345,7 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 	edev->hw_ring_stats_size = bp->hw_ring_stats_size;
 	edev->pf_port_id = bp->pf.port_id;
 	edev->en_state = bp->state;
-
+	edev->bar0 = bp->bar0;
 	edev->ulp_tbl->msix_requested = bnxt_get_ulp_msix_num(bp);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 80cbc4b6130aa..6ff77f082e6c7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -81,6 +81,7 @@ struct bnxt_en_dev {
 							 * mode only. Will be
 							 * updated in resume.
 							 */
+	void __iomem                    *bar0;
 };
 
 static inline bool bnxt_ulp_registered(struct bnxt_en_dev *edev)
-- 
2.40.1



