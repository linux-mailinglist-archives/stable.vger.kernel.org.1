Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685D77ED0E9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbjKOT6W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbjKOT6V (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C0C2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA45C433C7;
        Wed, 15 Nov 2023 19:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078297;
        bh=AXhQD0BeR2e7frkBzwmH1qR+O5mS9NvsQm7zBLo12jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6PfsIl8jNffZYhUDQ4fYC+DDT05f+xZPQ+TNz9+k9ptB6Du+Sy6oGzW1NhMjVyZH
         uKAtxlVGyO219kMZKr3n7VUx23CLswpCnDW49wNcl/E12JWzus+0MpAhMkF+fkbo17
         jXclQr4wGIxKxuxLYwj/zzaq73r6ew3kFvFvz6Bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengchang Tang <tangchengchang@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 218/379] RDMA/hns: Fix printing level of asynchronous events
Date:   Wed, 15 Nov 2023 14:24:53 -0500
Message-ID: <20231115192658.016742606@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit 9faef73ef4f6666b97e04d99734ac09251098185 ]

The current driver will print all asynchronous events. Some of the
print levels are set improperly, e.g. SRQ limit reach and SRQ last
wqe reach, which may also occur during normal operation of the software.
Currently, the information of these event is printed as a warning,
which causes a large amount of printing even during normal use of the
application. As a result, the service performance deteriorates.

This patch fixes the printing storms by modifying the print level.

Fixes: b00a92c8f2ca ("RDMA/hns: Move all prints out of irq handle")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20231017125239.164455-2-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 33980485ef5ba..db21d6f2d59ff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5961,7 +5961,7 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 	case HNS_ROCE_EVENT_TYPE_COMM_EST:
 		break;
 	case HNS_ROCE_EVENT_TYPE_SQ_DRAINED:
-		ibdev_warn(ibdev, "send queue drained.\n");
+		ibdev_dbg(ibdev, "send queue drained.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR:
 		ibdev_err(ibdev, "local work queue 0x%x catast error, sub_event type is: %d\n",
@@ -5976,10 +5976,10 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 			  irq_work->queue_num, irq_work->sub_type);
 		break;
 	case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
-		ibdev_warn(ibdev, "SRQ limit reach.\n");
+		ibdev_dbg(ibdev, "SRQ limit reach.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_SRQ_LAST_WQE_REACH:
-		ibdev_warn(ibdev, "SRQ last wqe reach.\n");
+		ibdev_dbg(ibdev, "SRQ last wqe reach.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_SRQ_CATAS_ERROR:
 		ibdev_err(ibdev, "SRQ catas error.\n");
-- 
2.42.0



