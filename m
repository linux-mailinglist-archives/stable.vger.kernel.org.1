Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411DC6FAE7D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbjEHLpN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbjEHLo4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BBC10A2F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06C4C636B7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A17AC433D2;
        Mon,  8 May 2023 11:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546263;
        bh=a1p2JFjsy9Q8gp8Xwp81ybireaYgdH/l1XtI3Wd9Ap0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5yIeKs12A9UycqvmvwNdcrVWDV+HknScNbZKTgeVESo/dLS9OBGdkTPkpO5qpU5a
         7dy/1o8Z9pPoEtnKC6tx8f4F/NLCwlz4L/AV7sfN87aFyBkputnVNT+r8IWbIaW93G
         ct1W6CMCjd/bY4nWLekAh6pAbToGHJqLQuDsA1dM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 310/371] RDMA/srpt: Add a check for valid mad_agent pointer
Date:   Mon,  8 May 2023 11:48:31 +0200
Message-Id: <20230508094824.360854539@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

[ Upstream commit eca5cd9474cd26d62f9756f536e2e656d3f62f3a ]

When unregistering MAD agent, srpt module has a non-null check
for 'mad_agent' pointer before invoking ib_unregister_mad_agent().
This check can pass if 'mad_agent' variable holds an error value.
The 'mad_agent' can have an error value for a short window when
srpt_add_one() and srpt_remove_one() is executed simultaneously.

In srpt module, added a valid pointer check for 'sport->mad_agent'
before unregistering MAD agent.

This issue can hit when RoCE driver unregisters ib_device

Stack Trace:
------------
BUG: kernel NULL pointer dereference, address: 000000000000004d
PGD 145003067 P4D 145003067 PUD 2324fe067 PMD 0
Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 10 PID: 4459 Comm: kworker/u80:0 Kdump: loaded Tainted: P
Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.5.4 01/13/2020
Workqueue: bnxt_re bnxt_re_task [bnxt_re]
RIP: 0010:_raw_spin_lock_irqsave+0x19/0x40
Call Trace:
  ib_unregister_mad_agent+0x46/0x2f0 [ib_core]
  IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
  ? __schedule+0x20b/0x560
  srpt_unregister_mad_agent+0x93/0xd0 [ib_srpt]
  srpt_remove_one+0x20/0x150 [ib_srpt]
  remove_client_context+0x88/0xd0 [ib_core]
  bond0: (slave p2p1): link status definitely up, 100000 Mbps full duplex
  disable_device+0x8a/0x160 [ib_core]
  bond0: active interface up!
  ? kernfs_name_hash+0x12/0x80
 (NULL device *): Bonding Info Received: rdev: 000000006c0b8247
  __ib_unregister_device+0x42/0xb0 [ib_core]
 (NULL device *):         Master: mode: 4 num_slaves:2
  ib_unregister_device+0x22/0x30 [ib_core]
 (NULL device *):         Slave: id: 105069936 name:p2p1 link:0 state:0
  bnxt_re_stopqps_and_ib_uninit+0x83/0x90 [bnxt_re]
  bnxt_re_alloc_lag+0x12e/0x4e0 [bnxt_re]

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Link: https://lore.kernel.org/r/20230406042549.507328-1-saravanan.vajravel@broadcom.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 7b69b0c9e48d9..38494943bd748 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -549,6 +549,7 @@ static int srpt_format_guid(char *buf, unsigned int size, const __be64 *guid)
  */
 static int srpt_refresh_port(struct srpt_port *sport)
 {
+	struct ib_mad_agent *mad_agent;
 	struct ib_mad_reg_req reg_req;
 	struct ib_port_modify port_modify;
 	struct ib_port_attr port_attr;
@@ -593,24 +594,26 @@ static int srpt_refresh_port(struct srpt_port *sport)
 		set_bit(IB_MGMT_METHOD_GET, reg_req.method_mask);
 		set_bit(IB_MGMT_METHOD_SET, reg_req.method_mask);
 
-		sport->mad_agent = ib_register_mad_agent(sport->sdev->device,
-							 sport->port,
-							 IB_QPT_GSI,
-							 &reg_req, 0,
-							 srpt_mad_send_handler,
-							 srpt_mad_recv_handler,
-							 sport, 0);
-		if (IS_ERR(sport->mad_agent)) {
+		mad_agent = ib_register_mad_agent(sport->sdev->device,
+						  sport->port,
+						  IB_QPT_GSI,
+						  &reg_req, 0,
+						  srpt_mad_send_handler,
+						  srpt_mad_recv_handler,
+						  sport, 0);
+		if (IS_ERR(mad_agent)) {
 			pr_err("%s-%d: MAD agent registration failed (%ld). Note: this is expected if SR-IOV is enabled.\n",
 			       dev_name(&sport->sdev->device->dev), sport->port,
-			       PTR_ERR(sport->mad_agent));
+			       PTR_ERR(mad_agent));
 			sport->mad_agent = NULL;
 			memset(&port_modify, 0, sizeof(port_modify));
 			port_modify.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
 			ib_modify_port(sport->sdev->device, sport->port, 0,
 				       &port_modify);
-
+			return 0;
 		}
+
+		sport->mad_agent = mad_agent;
 	}
 
 	return 0;
-- 
2.39.2



