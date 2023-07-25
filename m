Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411AE76122D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjGYK74 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjGYK7d (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0A5269F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAF746166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BFFC433C7;
        Tue, 25 Jul 2023 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282600;
        bh=fa7szucgl5x1HD3Q2nSa4kq1A2L5bT4gcrpJYGlFFUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqlvFr/eCtZjzegpkHelmZq6Y+hQVQ1rvS/DNXpF0xutQLun6Y22K7gIE4H/G9r/g
         hHAK+7hgcmqv+vYSTnRpv+MqXthBufG2YCEZH58OEbUN5wCsFc6h2A786sX9criwiX
         N8VCGsw0dBo5fO0DZODtxr3SiivsEW1zIiSCuFDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.4 160/227] ice: prevent NULL pointer deref during reload
Date:   Tue, 25 Jul 2023 12:45:27 +0200
Message-ID: <20230725104521.557046648@linuxfoundation.org>
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

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[ Upstream commit b3e7b3a6ee92ab927f750a6b19615ce88ece808f ]

Calling ethtool during reload can lead to call trace, because VSI isn't
configured for some time, but netdev is alive.

To fix it add rtnl lock for VSI deconfig and config. Set ::num_q_vectors
to 0 after freeing and add a check for ::tx/rx_rings in ring related
ethtool ops.

Add proper unroll of filters in ice_start_eth().

Reproduction:
$watch -n 0.1 -d 'ethtool -g enp24s0f0np0'
$devlink dev reload pci/0000:18:00.0 action driver_reinit

Call trace before fix:
[66303.926205] BUG: kernel NULL pointer dereference, address: 0000000000000000
[66303.926259] #PF: supervisor read access in kernel mode
[66303.926286] #PF: error_code(0x0000) - not-present page
[66303.926311] PGD 0 P4D 0
[66303.926332] Oops: 0000 [#1] PREEMPT SMP PTI
[66303.926358] CPU: 4 PID: 933821 Comm: ethtool Kdump: loaded Tainted: G           OE      6.4.0-rc5+ #1
[66303.926400] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.00.01.0014.070920180847 07/09/2018
[66303.926446] RIP: 0010:ice_get_ringparam+0x22/0x50 [ice]
[66303.926649] Code: 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 87 c0 09 00 00 c7 46 04 e0 1f 00 00 c7 46 10 e0 1f 00 00 48 8b 50 20 <48> 8b 12 0f b7 52 3a 89 56 14 48 8b 40 28 48 8b 00 0f b7 40 58 48
[66303.926722] RSP: 0018:ffffad40472f39c8 EFLAGS: 00010246
[66303.926749] RAX: ffff98a8ada05828 RBX: ffff98a8c46dd060 RCX: ffffad40472f3b48
[66303.926781] RDX: 0000000000000000 RSI: ffff98a8c46dd068 RDI: ffff98a8b23c4000
[66303.926811] RBP: ffffad40472f3b48 R08: 00000000000337b0 R09: 0000000000000000
[66303.926843] R10: 0000000000000001 R11: 0000000000000100 R12: ffff98a8b23c4000
[66303.926874] R13: ffff98a8c46dd060 R14: 000000000000000f R15: ffffad40472f3a50
[66303.926906] FS:  00007f6397966740(0000) GS:ffff98b390900000(0000) knlGS:0000000000000000
[66303.926941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[66303.926967] CR2: 0000000000000000 CR3: 000000011ac20002 CR4: 00000000007706e0
[66303.926999] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[66303.927029] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[66303.927060] PKRU: 55555554
[66303.927075] Call Trace:
[66303.927094]  <TASK>
[66303.927111]  ? __die+0x23/0x70
[66303.927140]  ? page_fault_oops+0x171/0x4e0
[66303.927176]  ? exc_page_fault+0x7f/0x180
[66303.927209]  ? asm_exc_page_fault+0x26/0x30
[66303.927244]  ? ice_get_ringparam+0x22/0x50 [ice]
[66303.927433]  rings_prepare_data+0x62/0x80
[66303.927469]  ethnl_default_doit+0xe2/0x350
[66303.927501]  genl_family_rcv_msg_doit.isra.0+0xe3/0x140
[66303.927538]  genl_rcv_msg+0x1b1/0x2c0
[66303.927561]  ? __pfx_ethnl_default_doit+0x10/0x10
[66303.927590]  ? __pfx_genl_rcv_msg+0x10/0x10
[66303.927615]  netlink_rcv_skb+0x58/0x110
[66303.927644]  genl_rcv+0x28/0x40
[66303.927665]  netlink_unicast+0x19e/0x290
[66303.927691]  netlink_sendmsg+0x254/0x4d0
[66303.927717]  sock_sendmsg+0x93/0xa0
[66303.927743]  __sys_sendto+0x126/0x170
[66303.927780]  __x64_sys_sendto+0x24/0x30
[66303.928593]  do_syscall_64+0x5d/0x90
[66303.929370]  ? __count_memcg_events+0x60/0xa0
[66303.930146]  ? count_memcg_events.constprop.0+0x1a/0x30
[66303.930920]  ? handle_mm_fault+0x9e/0x350
[66303.931688]  ? do_user_addr_fault+0x258/0x740
[66303.932452]  ? exc_page_fault+0x7f/0x180
[66303.933193]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_base.c    |  2 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 13 +++++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c    | 10 ++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1911d644dfa8d..619cb07a40691 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -758,6 +758,8 @@ void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
 
 	ice_for_each_q_vector(vsi, v_idx)
 		ice_free_q_vector(vsi, v_idx);
+
+	vsi->num_q_vectors = 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index f86e814354a31..ec4138e684bd2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2920,8 +2920,13 @@ ice_get_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 
 	ring->rx_max_pending = ICE_MAX_NUM_DESC;
 	ring->tx_max_pending = ICE_MAX_NUM_DESC;
-	ring->rx_pending = vsi->rx_rings[0]->count;
-	ring->tx_pending = vsi->tx_rings[0]->count;
+	if (vsi->tx_rings && vsi->rx_rings) {
+		ring->rx_pending = vsi->rx_rings[0]->count;
+		ring->tx_pending = vsi->tx_rings[0]->count;
+	} else {
+		ring->rx_pending = 0;
+		ring->tx_pending = 0;
+	}
 
 	/* Rx mini and jumbo rings are not supported */
 	ring->rx_mini_max_pending = 0;
@@ -2955,6 +2960,10 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		return -EINVAL;
 	}
 
+	/* Return if there is no rings (device is reloading) */
+	if (!vsi->tx_rings || !vsi->rx_rings)
+		return -EBUSY;
+
 	new_tx_cnt = ALIGN(ring->tx_pending, ICE_REQ_DESC_MULTIPLE);
 	if (new_tx_cnt != ring->tx_pending)
 		netdev_info(netdev, "Requested Tx descriptor count rounded up to %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1277e0a044ee4..fbe70458fda27 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4655,9 +4655,9 @@ static int ice_start_eth(struct ice_vsi *vsi)
 	if (err)
 		return err;
 
-	rtnl_lock();
 	err = ice_vsi_open(vsi);
-	rtnl_unlock();
+	if (err)
+		ice_fltr_remove_all(vsi);
 
 	return err;
 }
@@ -5120,6 +5120,7 @@ int ice_load(struct ice_pf *pf)
 	params = ice_vsi_to_params(vsi);
 	params.flags = ICE_VSI_FLAG_INIT;
 
+	rtnl_lock();
 	err = ice_vsi_cfg(vsi, &params);
 	if (err)
 		goto err_vsi_cfg;
@@ -5127,6 +5128,7 @@ int ice_load(struct ice_pf *pf)
 	err = ice_start_eth(ice_get_main_vsi(pf));
 	if (err)
 		goto err_start_eth;
+	rtnl_unlock();
 
 	err = ice_init_rdma(pf);
 	if (err)
@@ -5141,9 +5143,11 @@ int ice_load(struct ice_pf *pf)
 
 err_init_rdma:
 	ice_vsi_close(ice_get_main_vsi(pf));
+	rtnl_lock();
 err_start_eth:
 	ice_vsi_decfg(ice_get_main_vsi(pf));
 err_vsi_cfg:
+	rtnl_unlock();
 	ice_deinit_dev(pf);
 	return err;
 }
@@ -5156,8 +5160,10 @@ void ice_unload(struct ice_pf *pf)
 {
 	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	rtnl_lock();
 	ice_stop_eth(ice_get_main_vsi(pf));
 	ice_vsi_decfg(ice_get_main_vsi(pf));
+	rtnl_unlock();
 	ice_deinit_dev(pf);
 }
 
-- 
2.39.2



