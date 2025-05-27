Return-Path: <stable+bounces-147617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A92AC586F
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410968A71FD
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F6E27E7CF;
	Tue, 27 May 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="scoDF+bl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671E2750E8;
	Tue, 27 May 2025 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367899; cv=none; b=NIwUWEdPEYLJvBW/BrJFycpTpviiEPV64k/xZFZhYfJ5gmFw5EzA7uTGH8vY5SlY1n5TBhGhODnceK7C37axVybPvhnkhpzmmuMTMmrpG1b3OpLihjR0ZUCi7AMDu5+sC66rfbo0AXrS7ulG/T9baeU4OaH0u1Qcj6gmtqOPW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367899; c=relaxed/simple;
	bh=wy8aCc6A/l6W1Lwpb1xXLTr6Nr0fejzmwplKn75qtMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpZYdsBkcL2uPNFjIo4q35h6DBYpHt+JSHyPH42ORVuZbp1CzqHvuMr5M/gZ4s5PlbTsr6t+NOWjHhjQ0I63KIsE+aUceMh9xvHUVRedf/UydPanIz89MOUzHCrFTuZvHp00tnhgIjDgMrIJx5AI8EqXRZCBK2SD/oYzuYcG+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=scoDF+bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E44AC4CEE9;
	Tue, 27 May 2025 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367899;
	bh=wy8aCc6A/l6W1Lwpb1xXLTr6Nr0fejzmwplKn75qtMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scoDF+blKXGPzrLlWDB0yqTFHZAeUG6+EBUir2mprJaXU94Ba/x0nwKrW3NiGp65g
	 lA2QyKntOOEiDwvY8XSukmunJZchv9u+LNu3zL84YBwocfcwROiGxcKCUyx/6fvHII
	 4tE+WQymDWfvStisku7bTs3bEiGR4jBrO7PPVjSo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 534/783] igc: Avoid unnecessary link down event in XDP_SETUP_PROG process
Date: Tue, 27 May 2025 18:25:31 +0200
Message-ID: <20250527162534.898223987@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Yoong Siang <yoong.siang.song@intel.com>

[ Upstream commit be324b790368c1522f07c6bb5654122e07b5e588 ]

The igc_close()/igc_open() functions are too drastic for installing a new
XDP prog because they cause undesirable link down event and device reset.

To avoid delays in Ethernet traffic, improve the XDP_SETUP_PROG process by
using the same sequence as igc_xdp_setup_pool(), which performs only the
necessary steps, as follows:
 1. stop the traffic and clean buffer
 2. stop NAPI
 3. install the XDP program
 4. resume NAPI
 5. allocate buffer and resume the traffic

This patch has been tested using the 'ip link set xdpdrv' command to attach
a simple XDP prog that always returns XDP_PASS.

Before this patch, attaching xdp program will cause ptp4l to lose sync for
few seconds, as shown in ptp4l log below:
  ptp4l[198.082]: rms    4 max    8 freq   +906 +/-   2 delay    12 +/-   0
  ptp4l[199.082]: rms    3 max    4 freq   +906 +/-   3 delay    12 +/-   0
  ptp4l[199.536]: port 1 (enp2s0): link down
  ptp4l[199.536]: port 1 (enp2s0): SLAVE to FAULTY on FAULT_DETECTED (FT_UNSPECIFIED)
  ptp4l[199.600]: selected local clock 22abbc.fffe.bb1234 as best master
  ptp4l[199.600]: port 1 (enp2s0): assuming the grand master role
  ptp4l[199.600]: port 1 (enp2s0): master state recommended in slave only mode
  ptp4l[199.600]: port 1 (enp2s0): defaultDS.priority1 probably misconfigured
  ptp4l[202.266]: port 1 (enp2s0): link up
  ptp4l[202.300]: port 1 (enp2s0): FAULTY to LISTENING on INIT_COMPLETE
  ptp4l[205.558]: port 1 (enp2s0): new foreign master 44abbc.fffe.bb2144-1
  ptp4l[207.558]: selected best master clock 44abbc.fffe.bb2144
  ptp4l[207.559]: port 1 (enp2s0): LISTENING to UNCALIBRATED on RS_SLAVE
  ptp4l[208.308]: port 1 (enp2s0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
  ptp4l[208.933]: rms  742 max 1303 freq   -195 +/- 682 delay    12 +/-   0
  ptp4l[209.933]: rms  178 max  274 freq   +387 +/- 243 delay    12 +/-   0

After this patch, attaching xdp program no longer cause ptp4l to lose sync,
as shown in ptp4l log below:
  ptp4l[201.183]: rms    1 max    3 freq   +959 +/-   1 delay     8 +/-   0
  ptp4l[202.183]: rms    1 max    3 freq   +961 +/-   2 delay     8 +/-   0
  ptp4l[203.183]: rms    2 max    3 freq   +958 +/-   2 delay     8 +/-   0
  ptp4l[204.183]: rms    3 max    5 freq   +961 +/-   3 delay     8 +/-   0
  ptp4l[205.183]: rms    2 max    4 freq   +964 +/-   3 delay     8 +/-   0

Besides, before this patch, attaching xdp program will causes flood ping to
lose 10 packets, as shown in ping statistics below:
  --- 169.254.1.2 ping statistics ---
  100000 packets transmitted, 99990 received, +6 errors, 0.01% packet loss, time 34001ms
  rtt min/avg/max/mdev = 0.028/0.301/3104.360/13.838 ms, pipe 10, ipg/ewma 0.340/0.243 ms

After this patch, attaching xdp program no longer cause flood ping to loss
any packets, as shown in ping statistics below:
  --- 169.254.1.2 ping statistics ---
  100000 packets transmitted, 100000 received, 0% packet loss, time 32326ms
  rtt min/avg/max/mdev = 0.027/0.231/19.589/0.155 ms, pipe 2, ipg/ewma 0.323/0.322 ms

On the other hand, this patch has been tested with tools/testing/selftests/
bpf/xdp_hw_metadata app to make sure AF_XDP zero-copy is working fine with
XDP Tx and Rx metadata. Below is the result of last packet after received
10000 UDP packets with interval 1 ms:
  poll: 1 (0) skip=0 fail=0 redir=10000
  xsk_ring_cons__peek: 1
  0x55881c7ef7a8: rx_desc[9999]->addr=8f110 addr=8f110 comp_addr=8f110 EoP
  rx_hash: 0xFB9BB6A3 with RSS type:0x1
  HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (43.280 usec)
  XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (31.664 usec)
  No rx_vlan_tci or rx_vlan_proto, err=-95
  0x55881c7ef7a8: ping-pong with csum=ab19 (want 315b) csum_start=34 csum_offset=6
  0x55881c7ef7a8: complete tx idx=9999 addr=f010
  HW TX-complete-time:   1733923136269591637 (sec:1733923136.2696) delta to User TX-complete-time sec:0.0001 (108.571 usec)
  XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User TX-complete-time sec:0.0002 (217.726 usec)
  HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to HW TX-complete-time sec:0.0001 (120.771 usec)
  0x55881c7ef7a8: complete rx idx=10127 addr=8f110

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_xdp.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 869815f48ac1d..9eb47b4beb062 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -14,6 +14,7 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	bool if_running = netif_running(dev);
 	struct bpf_prog *old_prog;
 	bool need_update;
+	unsigned int i;
 
 	if (dev->mtu > ETH_DATA_LEN) {
 		/* For now, the driver doesn't support XDP functionality with
@@ -24,8 +25,13 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	}
 
 	need_update = !!adapter->xdp_prog != !!prog;
-	if (if_running && need_update)
-		igc_close(dev);
+	if (if_running && need_update) {
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			igc_disable_rx_ring(adapter->rx_ring[i]);
+			igc_disable_tx_ring(adapter->tx_ring[i]);
+			napi_disable(&adapter->rx_ring[i]->q_vector->napi);
+		}
+	}
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
 	if (old_prog)
@@ -36,8 +42,13 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	else
 		xdp_features_clear_redirect_target(dev);
 
-	if (if_running && need_update)
-		igc_open(dev);
+	if (if_running && need_update) {
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			napi_enable(&adapter->rx_ring[i]->q_vector->napi);
+			igc_enable_tx_ring(adapter->tx_ring[i]);
+			igc_enable_rx_ring(adapter->rx_ring[i]);
+		}
+	}
 
 	return 0;
 }
-- 
2.39.5




