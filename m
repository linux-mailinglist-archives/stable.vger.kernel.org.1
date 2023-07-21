Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D95A75CD86
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjGUQMb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjGUQML (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400A93599
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 202C861D3B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FEDC433C7;
        Fri, 21 Jul 2023 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955906;
        bh=1k1rj6ao/M0yfx+MSZqarVW7yMSM0G+uXm51tSCCIMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyNgWKGb1/ThHKSeR+nqmiQ4oeFEWm4GcHlRfIlQVSOE+hueQAm8k+rJ7iiemaZwg
         9jQwI9MsYSFnElJO04wZHztF8BF6uqFfY6QpVvbKZOnG0zNdCqfsWUqAQtz/miMB4R
         QTMem17z+5JWt8V4RlO7tn2AS4SD95hEcVXPgJnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Florian Kauer <florian.kauer@linutronix.de>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 071/292] igc: Do not enable taprio offload for invalid arguments
Date:   Fri, 21 Jul 2023 18:03:00 +0200
Message-ID: <20230721160531.851379818@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Kauer <florian.kauer@linutronix.de>

[ Upstream commit 82ff5f29b7377d614f0c01fd74b5d0cb225f0adc ]

Only set adapter->taprio_offload_enable after validating the arguments.
Otherwise, it stays set even if the offload was not enabled.
Since the subsequent code does not get executed in case of invalid
arguments, it will not be read at first.
However, by activating and then deactivating another offload
(e.g. ETF/TX launchtime offload), taprio_offload_enable is read
and erroneously keeps the offload feature of the NIC enabled.

This can be reproduced as follows:

    # TAPRIO offload (flags == 0x2) and negative base-time leading to expected -ERANGE
    sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
	    num_tc 1 \
	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
	    queues 1@0 \
	    base-time -1000 \
	    sched-entry S 01 300000 \
	    flags 0x2

    # IGC_TQAVCTRL is 0x0 as expected (iomem=relaxed for reading register)
    sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1

    # Activate ETF offload
    sudo tc qdisc replace dev enp1s0 parent root handle 6666 mqprio \
	    num_tc 3 \
	    map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
	    queues 1@0 1@1 2@2 \
	    hw 0
    sudo tc qdisc add dev enp1s0 parent 6666:1 etf \
	    clockid CLOCK_TAI \
	    delta 500000 \
	    offload

    # IGC_TQAVCTRL is 0x9 as expected
    sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1

    # Deactivate ETF offload again
    sudo tc qdisc delete dev enp1s0 parent 6666:1

    # IGC_TQAVCTRL should now be 0x0 again, but is observed as 0x9
    sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1

Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6bed12224120f..f051ca733af1b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6090,6 +6090,7 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 
 	adapter->base_time = 0;
 	adapter->cycle_time = NSEC_PER_SEC;
+	adapter->taprio_offload_enable = false;
 	adapter->qbv_config_change_errors = 0;
 	adapter->qbv_transition = false;
 	adapter->qbv_count = 0;
@@ -6117,20 +6118,12 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	size_t n;
 	int i;
 
-	switch (qopt->cmd) {
-	case TAPRIO_CMD_REPLACE:
-		adapter->taprio_offload_enable = true;
-		break;
-	case TAPRIO_CMD_DESTROY:
-		adapter->taprio_offload_enable = false;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	if (!adapter->taprio_offload_enable)
+	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		return igc_tsn_clear_schedule(adapter);
 
+	if (qopt->cmd != TAPRIO_CMD_REPLACE)
+		return -EOPNOTSUPP;
+
 	if (qopt->base_time < 0)
 		return -ERANGE;
 
@@ -6142,6 +6135,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 
 	adapter->cycle_time = qopt->cycle_time;
 	adapter->base_time = qopt->base_time;
+	adapter->taprio_offload_enable = true;
 
 	igc_ptp_read(adapter, &now);
 
-- 
2.39.2



