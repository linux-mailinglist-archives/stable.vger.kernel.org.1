Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813577A3AD9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbjIQUJj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbjIQUJU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:09:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B997
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:09:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBE2C433C8;
        Sun, 17 Sep 2023 20:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981354;
        bh=ay5vsD8GvCtGfclQ7xDBVWJF0N3TrITOeO5uaPvsvfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0yAQ064Agt//SnVN0+D8poyrveGtEg+Rrb67tFLC754hrXLBucRxxxA/H1SwguaEN
         oqLGnEkNDZekcJwd8hTA54CAPrKqiS4S5uhUcBrrheiGr8WdNMfcyavNbFOhThfHcE
         fDwRJqxq2hNQLgqWrKDEUGoyZ8cdC3qluzEkn8j8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        David Christensen <drc@linux.vnet.ibm.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 042/511] bnx2x: fix page fault following EEH recovery
Date:   Sun, 17 Sep 2023 21:07:49 +0200
Message-ID: <20230917191114.877187948@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Christensen <drc@linux.vnet.ibm.com>

[ Upstream commit 7ebe4eda4265642859507d1b3ca330d8c196cfe5 ]

In the last step of the EEH recovery process, the EEH driver calls into
bnx2x_io_resume() to re-initialize the NIC hardware via the function
bnx2x_nic_load().  If an error occurs during bnx2x_nic_load(), OS and
hardware resources are released and an error code is returned to the
caller.  When called from bnx2x_io_resume(), the return code is ignored
and the network interface is brought up unconditionally.  Later attempts
to send a packet via this interface result in a page fault due to a null
pointer reference.

This patch checks the return code of bnx2x_nic_load(), prints an error
message if necessary, and does not enable the interface.

Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 553f3de939574..9c26c46771f5e 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14317,11 +14317,16 @@ static void bnx2x_io_resume(struct pci_dev *pdev)
 	bp->fw_seq = SHMEM_RD(bp, func_mb[BP_FW_MB_IDX(bp)].drv_mb_header) &
 							DRV_MSG_SEQ_NUMBER_MASK;
 
-	if (netif_running(dev))
-		bnx2x_nic_load(bp, LOAD_NORMAL);
+	if (netif_running(dev)) {
+		if (bnx2x_nic_load(bp, LOAD_NORMAL)) {
+			netdev_err(bp->dev, "Error during driver initialization, try unloading/reloading the driver\n");
+			goto done;
+		}
+	}
 
 	netif_device_attach(dev);
 
+done:
 	rtnl_unlock();
 }
 
-- 
2.40.1



