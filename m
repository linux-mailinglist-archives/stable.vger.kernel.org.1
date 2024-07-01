Return-Path: <stable+bounces-56204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A19B91DC04
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9C91C22A22
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87F12C491;
	Mon,  1 Jul 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGITFEOq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2612BF30;
	Mon,  1 Jul 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828201; cv=none; b=SWpFByyzpduKCCL8nuKmSKpRUuECYCxm9HYMF7hCyEzbL184slsxy01NdYPXdIFUqJTxDwYtKd77bfSb2K5E1Pxkn5cuCyCffnbfEWVokOM561+LMUK+MykPl7VeoLmqW+qr4qvYrzBn2r77Meclo2Q1yubKuQ2ITAuAClldEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828201; c=relaxed/simple;
	bh=IHzImYBvS+r2Fb9vRJHdboMmTujqYSOlMOmKDtVxjSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NamhzAbIYcGh7AQthBMxsbWt7rTItNq+w1SgCNccOTGrspCVbdBYRuZ36nA2guQ3/ASrqijAxaj4UAnGkYp4EnumP4kjW5a/4cF+17ZOe2Q9wE49YfGKi1hglo8eTvoeCWd/QEU/c3HwaRMWB6kLdtz/6K/NzDZMKGw9haSBDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGITFEOq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719828200; x=1751364200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IHzImYBvS+r2Fb9vRJHdboMmTujqYSOlMOmKDtVxjSE=;
  b=ZGITFEOqTMge5BJjpGpnqykS3XJZTGp4Flrp3ROP5drMFANMgddwx4YW
   aKe0twN7q+waFEbq6xmZ+6nMo0lrzZ1+HwzMpy5Nogz8oICMgVbBsm8Em
   5ntzAAENdn0eH55RhkiXdd9f+vBPg84Tv8wG/XzP8+vdoSkfWIrOKUBL+
   qZ8y78F+1+Thlhevjx/YJaobpgINUkP9ylPjUJM6RDxW/zOIBobojxjKI
   dzamS61VSO46FJ28ge4CnzgbwSuY0oDv3E3Kl7NpgDwnLKRCYp++nmCTV
   jlaXTBRzB9XZ6WuwwjT5Ze5ovIbJ0iJNTaFPCo/q5JHmS4TIBY7xeqt+b
   g==;
X-CSE-ConnectionGUID: tLtvLf/YT2WxkYYqLWGdbw==
X-CSE-MsgGUID: 6swt6iXURZaRg1CavVdUFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="16783848"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="16783848"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 03:03:19 -0700
X-CSE-ConnectionGUID: Anw2rhvOSD6NgytuqK2ETQ==
X-CSE-MsgGUID: e35sdeIxRzmdQoUVKrLERw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="68696797"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 03:03:18 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id D0DA720B5702;
	Mon,  1 Jul 2024 03:03:14 -0700 (PDT)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v1 1/1] igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer
Date: Mon,  1 Jul 2024 06:00:58 -0400
Message-Id: <20240701100058.3301229-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AVNU testing uncovered that even when the taprio gate is closed,
some packets still transmit.

A known i225/6 hardware errata states traffic might overflow the planned
QBV window. This happens because MAC maintains an internal buffer,
primarily for supporting half duplex retries. Therefore, when
the gate closes, residual MAC data in the buffer may still transmit.

To mitigate this for i226, reduce the MAC's internal buffer from
192 bytes to 88 bytes by modifying the RETX_CTL register value.
This follows guidelines from:

a) Ethernet Controller I225/I22 Spec Update Rev 2.1 Errata Item 9:
   TSN: Packet Transmission Might Cross Qbv Window
b) I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control

Test Steps:
1. Send taprio cmd to board A
tc qdisc replace dev enp1s0 parent root handle 100 taprio \
num_tc 4 \
map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
queues 1@0 1@1 1@2 1@3 \
base-time 0 \
sched-entry S 0x07 500000 \
sched-entry S 0x0f 500000 \
flags 0x2 \
txtime-delay 0

- Note that for TC3, gate opens for 500us and close for another 500us

3. Take tcpdump log on Board B

4. Send udp packets via UDP tai app from Board A to Board B

5. Analyze tcpdump log via wireshark log on Board B
- Observed that the total time from the first to the last packet
received during one cycle for TC3 does not exceed 500us

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  6 ++++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 34 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 5f92b3c7c3d4..511384f3ec5c 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -404,6 +404,12 @@
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
index 22cefb1eeedf..c97d908cecc5 100644
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
+ * a) Ethernet Controller I225/I22 Specification Update Rev 2.1
+ *    Item 9: TSN: Packet Transmission Might Cross the Qbv Window
+ * b) I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control
+ */
+static void igc_tsn_set_retx_qbvfullth(struct igc_adapter *adapter)
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
@@ -123,6 +154,9 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
 
+	if (igc_is_device_id_i226(hw))
+		igc_tsn_set_retx_qbvfullth(adapter);
+
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
 		u32 txqctl = 0;
-- 
2.25.1


