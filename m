Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9FA7352A8
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFSKhL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFSKgp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BABD7
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046F460B0D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18028C433C0;
        Mon, 19 Jun 2023 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171002;
        bh=Q1AYwVEsQ32ySrhgP68VmhIAVqnCzNDoNOsuF4LW8M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLKvS1tNMnIRpn7ipglX4M1N8B/2F4n3WleEGRUT2CkPOkAMDa466loGy2LLBGhzp
         1C0e1W/cW8LPKcuRaS6MpHiHszYfiJUteW7gIJF1e8M/hpluK0MDPfh7Or/pQnjALT
         zHPpOTpdaze//pSa+5gfsQtXIltX6hUWRoaGKZoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kamal Heib <kheib@redhat.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 112/187] RDMA/bnxt_re: Fix reporting active_{speed,width} attributes
Date:   Mon, 19 Jun 2023 12:28:50 +0200
Message-ID: <20230619102202.999055014@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Kamal Heib <kheib@redhat.com>

[ Upstream commit 18e7e3e4217083a682e2c7282011c70c8a1ba070 ]

After commit 6d758147c7b8 ("RDMA/bnxt_re: Use auxiliary driver interface")
the active_{speed, width} attributes are reported incorrectly, This is
happening because ib_get_eth_speed() is called only once from
bnxt_re_ib_init() - Fix this issue by calling ib_get_eth_speed() from
bnxt_re_query_port().

Fixes: 6d758147c7b8 ("RDMA/bnxt_re: Use auxiliary driver interface")
Link: https://lore.kernel.org/r/20230529153525.87254-1-kheib@redhat.com
Signed-off-by: Kamal Heib <kheib@redhat.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 2 --
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 ++++---
 drivers/infiniband/hw/bnxt_re/main.c     | 2 --
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 5a2baf49ecaa4..2c95e6f3d47ac 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -135,8 +135,6 @@ struct bnxt_re_dev {
 
 	struct delayed_work		worker;
 	u8				cur_prio_map;
-	u16				active_speed;
-	u8				active_width;
 
 	/* FP Notification Queue (CQ & SRQ) */
 	struct tasklet_struct		nq_task;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 94222de1d3719..584d6e64ca708 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -199,6 +199,7 @@ int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	int rc;
 
 	memset(port_attr, 0, sizeof(*port_attr));
 
@@ -228,10 +229,10 @@ int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 	port_attr->sm_sl = 0;
 	port_attr->subnet_timeout = 0;
 	port_attr->init_type_reply = 0;
-	port_attr->active_speed = rdev->active_speed;
-	port_attr->active_width = rdev->active_width;
+	rc = ib_get_eth_speed(&rdev->ibdev, port_num, &port_attr->active_speed,
+			      &port_attr->active_width);
 
-	return 0;
+	return rc;
 }
 
 int bnxt_re_get_port_immutable(struct ib_device *ibdev, u32 port_num,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c5867e78f2319..85e36c9f8e797 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1152,8 +1152,6 @@ static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 		return rc;
 	}
 	dev_info(rdev_to_dev(rdev), "Device registered with IB successfully");
-	ib_get_eth_speed(&rdev->ibdev, 1, &rdev->active_speed,
-			 &rdev->active_width);
 	set_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS, &rdev->flags);
 
 	event = netif_running(rdev->netdev) && netif_carrier_ok(rdev->netdev) ?
-- 
2.39.2



