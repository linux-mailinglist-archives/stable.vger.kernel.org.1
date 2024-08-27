Return-Path: <stable+bounces-71071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA896961182
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478721F23126
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E835E1C8FDF;
	Tue, 27 Aug 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ccImz1Yz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580A17C96;
	Tue, 27 Aug 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772003; cv=none; b=cRz7nb3KWi9cg+H6/qpnnxKaz3kQnGzC9ohqCC1iU0RkGyzv7HUP0qU+vv6r0Tc2DAF8C+HWRa0N8tW+FR7JdbiJvuUC/YUalK/Jhw1fpEL+uKuypPgGGKZR/DmxKMKY5NovsfHdRmi53FAg+mDPMm1dxZjpjYyDWrEmDGP6dK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772003; c=relaxed/simple;
	bh=1HnkLzhQTV7EPYjh5V/azVJD3ODXv5Q3w2NY3vYywVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxilBshAdeKB1QtXauRcdO7Z4d5H/mSln3KgIFEJ4TlODRTVrjT++46Lff262+09qgogxBpMElWzF/uPOvuKeSHLCz31pIloeY+lX7c2GhU6Va/0SDPCH2dbE3QlzGFC0ClwNYWnY0Oq0nFxYusngRueDv/KT/wwNRgg/phkPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ccImz1Yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128AEC4DDE5;
	Tue, 27 Aug 2024 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772003;
	bh=1HnkLzhQTV7EPYjh5V/azVJD3ODXv5Q3w2NY3vYywVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccImz1YzqHIiBKATcrCHHYD+lju6gPFCpfqTh3tgmcfbLGhGeBedYY7iMruPspbUV
	 Kzk3q26ssv57AN1TUK1aE19z1A0vS2Gp97gyat9rMbDCkZMLMY3Q9FfwDdepvmOjdA
	 UOi+a3TN3mXBVn2eM+UgfLHhTVtiHi3mMVMpQZaI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 084/321] igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer
Date: Tue, 27 Aug 2024 16:36:32 +0200
Message-ID: <20240827143841.438058254@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

[ Upstream commit e037a26ead187901f83cad9c503ccece5ff6817a ]

Testing uncovered that even when the taprio gate is closed, some packets
still transmit.

According to i225/6 hardware errata [1], traffic might overflow the
planned QBV window. This happens because MAC maintains an internal buffer,
primarily for supporting half duplex retries. Therefore, even when the
gate closes, residual MAC data in the buffer may still transmit.

To mitigate this for i226, reduce the MAC's internal buffer from 192 bytes
to the recommended 88 bytes by modifying the RETX_CTL register value.

This follows guidelines from:
[1] Ethernet Controller I225/I22 Spec Update Rev 2.1 Errata Item 9:
    TSN: Packet Transmission Might Cross Qbv Window
[2] I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control

Note that the RETX_CTL register can't be used in TSN mode because half
duplex feature cannot coexist with TSN.

Test Steps:
1.  Send taprio cmd to board A:
    tc qdisc replace dev enp1s0 parent root handle 100 taprio \
    num_tc 4 \
    map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
    queues 1@0 1@1 1@2 1@3 \
    base-time 0 \
    sched-entry S 0x07 500000 \
    sched-entry S 0x0f 500000 \
    flags 0x2 \
    txtime-delay 0

    Note that for TC3, gate should open for 500us and close for another
    500us.

3.  Take tcpdump log on Board B.

4.  Send udp packets via UDP tai app from Board A to Board B.

5.  Analyze tcpdump log via wireshark log on Board B. Ensure that the
    total time from the first to the last packet received during one cycle
    for TC3 does not exceed 500us.

Fixes: 43546211738e ("igc: Add new device ID's")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  6 ++++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 34 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 63fa7608861b2..8187a658dcbd5 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -402,6 +402,12 @@
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
 
+/* Retry Buffer Control */
+#define IGC_RETX_CTL			0x041C
+#define IGC_RETX_CTL_WATERMARK_MASK	0xF
+#define IGC_RETX_CTL_QBVFULLTH_SHIFT	8 /* QBV Retry Buffer Full Threshold */
+#define IGC_RETX_CTL_QBVFULLEN	0x1000 /* Enable QBV Retry Buffer Full Threshold */
+
 /* Transmit Scheduling Latency */
 /* Latency between transmission scheduling (LaunchTime) and the time
  * the packet is transmitted to the network in nanosecond.
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 83f02b00735d3..abdaaf7db4125 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -78,6 +78,15 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
 	wr32(IGC_GTXOFFSET, txoffset);
 }
 
+static void igc_tsn_restore_retx_default(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 retxctl;
+
+	retxctl = rd32(IGC_RETX_CTL) & IGC_RETX_CTL_WATERMARK_MASK;
+	wr32(IGC_RETX_CTL, retxctl);
+}
+
 /* Returns the TSN specific registers to their default values after
  * the adapter is reset.
  */
@@ -91,6 +100,9 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
 
+	if (igc_is_device_id_i226(hw))
+		igc_tsn_restore_retx_default(adapter);
+
 	tqavctrl = rd32(IGC_TQAVCTRL);
 	tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
 		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS);
@@ -111,6 +123,25 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	return 0;
 }
 
+/* To partially fix i226 HW errata, reduce MAC internal buffering from 192 Bytes
+ * to 88 Bytes by setting RETX_CTL register using the recommendation from:
+ * a) Ethernet Controller I225/I226 Specification Update Rev 2.1
+ *    Item 9: TSN: Packet Transmission Might Cross the Qbv Window
+ * b) I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control
+ */
+static void igc_tsn_set_retx_qbvfullthreshold(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 retxctl, watermark;
+
+	retxctl = rd32(IGC_RETX_CTL);
+	watermark = retxctl & IGC_RETX_CTL_WATERMARK_MASK;
+	/* Set QBVFULLTH value using watermark and set QBVFULLEN */
+	retxctl |= (watermark << IGC_RETX_CTL_QBVFULLTH_SHIFT) |
+		   IGC_RETX_CTL_QBVFULLEN;
+	wr32(IGC_RETX_CTL, retxctl);
+}
+
 static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -124,6 +155,9 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
 
+	if (igc_is_device_id_i226(hw))
+		igc_tsn_set_retx_qbvfullthreshold(adapter);
+
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
 		u32 txqctl = 0;
-- 
2.43.0




