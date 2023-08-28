Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02178AA45
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjH1KUj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjH1KUM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E66AB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C476383C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E047EC433C8;
        Mon, 28 Aug 2023 10:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217994;
        bh=REDqSAzp+QlZKIihsjnnhqurPJzy4ml7mwyDIR5j9Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foceYfk2GIkCqolmlg9m9kxawnKOMvkfzZ3ppVK+gs8Eraa7n3q2H3uAKITLt94nB
         UIsVWvV5j5BzcEuSUfB8aAp2wbsCFuryf3sMunBOsH6+mfJrAhskdp+MSAktUfsiRi
         gX8a9fgzHaFnZYmHM0ASIObHJ4Yqfn5t0RiqSHlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alessio Igor Bogani <alessio.bogani@elettra.eu>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH 6.4 039/129] igb: Avoid starting unnecessary workqueues
Date:   Mon, 28 Aug 2023 12:11:58 +0200
Message-ID: <20230828101158.676138547@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alessio Igor Bogani <alessio.bogani@elettra.eu>

[ Upstream commit b888c510f7b3d64ca75fc0f43b4a4bd1a611312f ]

If ptp_clock_register() fails or CONFIG_PTP isn't enabled, avoid starting
PTP related workqueues.

In this way we can fix this:
 BUG: unable to handle page fault for address: ffffc9000440b6f8
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 100000067 P4D 100000067 PUD 1001e0067 PMD 107dc5067 PTE 0
 Oops: 0000 [#1] PREEMPT SMP
 [...]
 Workqueue: events igb_ptp_overflow_check
 RIP: 0010:igb_rd32+0x1f/0x60
 [...]
 Call Trace:
  igb_ptp_read_82580+0x20/0x50
  timecounter_read+0x15/0x60
  igb_ptp_overflow_check+0x1a/0x50
  process_one_work+0x1cb/0x3c0
  worker_thread+0x53/0x3f0
  ? rescuer_thread+0x370/0x370
  kthread+0x142/0x160
  ? kthread_associate_blkcg+0xc0/0xc0
  ret_from_fork+0x1f/0x30

Fixes: 1f6e8178d685 ("igb: Prevent dropped Tx timestamps via work items and interrupts.")
Fixes: d339b1331616 ("igb: add PTP Hardware Clock code")
Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230821171927.2203644-1-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 405886ee52615..319c544b9f04c 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1385,18 +1385,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
-	spin_lock_init(&adapter->tmreg_lock);
-	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
-
-	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
-				  igb_ptp_overflow_check);
-
-	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
-	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-
-	igb_ptp_reset(adapter);
-
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1406,6 +1394,18 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
+
+		spin_lock_init(&adapter->tmreg_lock);
+		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
+
+		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
+					  igb_ptp_overflow_check);
+
+		adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+
+		igb_ptp_reset(adapter);
 	}
 }
 
-- 
2.40.1



