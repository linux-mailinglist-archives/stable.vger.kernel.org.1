Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104F1761319
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjGYLH5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjGYLHY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5A3A84
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79B756166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4A4C433C8;
        Tue, 25 Jul 2023 11:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283163;
        bh=FKZbOhdA7/68DKOEKNohWy4R+kHghKdMXoKva7FA37w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Idd3VxRWF0jAusTmq0HxISIGAMzHAE1hMIbh1WXJaSL/+gZE07LZmr1/oDFJsgTwG
         PwcGllH1uSbNQeKcKr8Ir7q0lXBsDe8TM8iXhBztFCN2p9NoeH36af/DBrk8Sq8R1g
         KWRcK09vZaLwPP5jL5y5co0+eziqLULbDOP42x8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kurt Kanzenbach <kurt@linutronix.de>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 132/183] igc: Avoid transmit queue timeout for XDP
Date:   Tue, 25 Jul 2023 12:46:00 +0200
Message-ID: <20230725104512.690877105@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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
index 273941f90f066..ade4bde47c65a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2402,6 +2402,8 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
 	nq = txring_txq(ring);
 
 	__netif_tx_lock(nq, cpu);
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	txq_trans_cond_update(nq);
 	res = igc_xdp_init_tx_descriptor(ring, xdpf);
 	__netif_tx_unlock(nq);
 	return res;
@@ -2804,6 +2806,9 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 
 	__netif_tx_lock(nq, cpu);
 
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	txq_trans_cond_update(nq);
+
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
@@ -6297,6 +6302,9 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 
 	__netif_tx_lock(nq, cpu);
 
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	txq_trans_cond_update(nq);
+
 	drops = 0;
 	for (i = 0; i < num_frames; i++) {
 		int err;
-- 
2.39.2



