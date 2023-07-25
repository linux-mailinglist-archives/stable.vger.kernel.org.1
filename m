Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA4761227
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGYK7x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjGYK73 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFE1FF0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D054F6166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC63C433C8;
        Tue, 25 Jul 2023 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282589;
        bh=82eKH/QmvDoL2Z8HW+/MK/ahA2tZvCxLUILutelxuYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEKCRD6tBa68qefbO4mvYVQN3SoGqyBFUKWEEiTZTaUT09vQadwAr1cWUzby67c7N
         n9wtcihU8fOVujdlcaIocEuIjIb2QoRpIytTK+JDxio25cZ72RWiJlmyJs7pHCNr2O
         y4Bn+tLOSGqSMtH5SK08/PwI1ir6VDkQk+YPasGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kurt Kanzenbach <kurt@linutronix.de>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 183/227] igc: Avoid transmit queue timeout for XDP
Date:   Tue, 25 Jul 2023 12:45:50 +0200
Message-ID: <20230725104522.398282544@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kurt Kanzenbach <kurt@linutronix.de>

[ Upstream commit 95b681485563c64585de78662ee52d06b7fa47d9 ]

High XDP load triggers the netdev watchdog:

|NETDEV WATCHDOG: enp3s0 (igc): transmit queue 2 timed out

The reason is the Tx queue transmission start (txq->trans_start) is not updated
in XDP code path. Therefore, add it for all XDP transmission functions.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: 78adb4bcf99e ("igc: Prevent garbled TX queue with XDP ZEROCOPY")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 44aa4342cbbb5..ef4ea46442f21 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2417,6 +2417,8 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
 	nq = txring_txq(ring);
 
 	__netif_tx_lock(nq, cpu);
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	txq_trans_cond_update(nq);
 	res = igc_xdp_init_tx_descriptor(ring, xdpf);
 	__netif_tx_unlock(nq);
 	return res;
@@ -2833,6 +2835,9 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 
 	__netif_tx_lock(nq, cpu);
 
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	txq_trans_cond_update(nq);
+
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
@@ -6385,6 +6390,9 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 
 	__netif_tx_lock(nq, cpu);
 
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	txq_trans_cond_update(nq);
+
 	drops = 0;
 	for (i = 0; i < num_frames; i++) {
 		int err;
-- 
2.39.2



