Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA8379B6B0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353808AbjIKVuc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbjIKOvk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:51:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA5118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:51:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3060DC433C8;
        Mon, 11 Sep 2023 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443895;
        bh=1PAQIBARMv7nPzOLjHZfngvUJdA2DYFCon6J3zj4R7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHW99zxvRO7RMNxC7zO41HhnOyGSWQBbsF+suVtFVYD1I5xl4Le5mxsy+jdPFvAS3
         zSggTuFPKow/h3XYHhcRuU6hIEaGsX3ToNfCdFrNCofewcHnA4MBMbuOCl2P/GXuk4
         Wn09x0oiB2lz6AwCz/WE24QTmbYh5iHLEjPR7RMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 538/737] RDMA/bnxt_re: Remove a redundant flag
Date:   Mon, 11 Sep 2023 15:46:37 +0200
Message-ID: <20230911134705.592594450@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit fd28c8a8c7a10e7b53851129c6d8dc5945108fe9 ]

After the cited commit, BNXT_RE_FLAG_GOT_MSIX is redundant.
Remove it.

Fixes: 303432211324 ("bnxt_en: Remove runtime interrupt vector allocation")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1691052326-32143-3-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h | 1 -
 drivers/infiniband/hw/bnxt_re/main.c    | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index eef3ef3fabb42..bacb1b6723ef8 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -116,7 +116,6 @@ struct bnxt_re_dev {
 	struct list_head		list;
 	unsigned long			flags;
 #define BNXT_RE_FLAG_NETDEV_REGISTERED		0
-#define BNXT_RE_FLAG_GOT_MSIX			2
 #define BNXT_RE_FLAG_HAVE_L2_REF		3
 #define BNXT_RE_FLAG_RCFW_CHANNEL_EN		4
 #define BNXT_RE_FLAG_QOS_WORK_REG		5
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4f00fb7869f8e..bfab2c83faf92 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1113,8 +1113,8 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
 		bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 	}
-	if (test_and_clear_bit(BNXT_RE_FLAG_GOT_MSIX, &rdev->flags))
-		rdev->num_msix = 0;
+
+	rdev->num_msix = 0;
 
 	bnxt_re_destroy_chip_ctx(rdev);
 	if (test_and_clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
@@ -1170,7 +1170,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
 		  rdev->en_dev->ulp_tbl->msix_requested);
 	rdev->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
-	set_bit(BNXT_RE_FLAG_GOT_MSIX, &rdev->flags);
 
 	bnxt_re_query_hwrm_intf_version(rdev);
 
-- 
2.40.1



