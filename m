Return-Path: <stable+bounces-153922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E734EADD739
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64F819E4D1D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705B82ED17C;
	Tue, 17 Jun 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="viLgV+/b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FC2EA14E;
	Tue, 17 Jun 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177533; cv=none; b=A/6p3j+I+MHxOo4GK/AnEMrq5XQaPlJ2mYudDf8TDCMHLpW8ggzh483NMgkIbtpUtHiXC1OftI1pz9siI9Dcy9pvifj0WIs/DQvnsg94+RjuteelgwEEO0T0g7bnHBnyvtKbvLc1SHsOzlqu52qTtRE1PaRY/kF08DonAnVELz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177533; c=relaxed/simple;
	bh=DyW9BBjbKPVrY0e8EquHMaPj4C5cfHuvHuYDMo79i5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UibYTP/vbDbKcEG0oDXhYHDl4pR3BxZo/AtcOVSuFsaky8oe5TN2oOnNHxfTUjQPoOdLPzBfmZF9EWOk2Hac35otAAO060Gj0/3mPetoKJyefAoTP8GskpAEreOJE3pbR76pg4bxqmPcs4GIU8V+I6cWtpywvkO19hlvk5kop8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=viLgV+/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE97C4CEE3;
	Tue, 17 Jun 2025 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177533;
	bh=DyW9BBjbKPVrY0e8EquHMaPj4C5cfHuvHuYDMo79i5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=viLgV+/b1U8n6ZhTlnI2VCyZk366uZ2D0xY8P4p7hlVBOnM2/Rwi7qNGaMb4MRV+G
	 umDkftiJ2enaul4j2YywIMBSSCUh/XwSPsYYIeIivpAnr9YeKhKlz+N6uf3sb8Oc8C
	 Kd+IRrdjf/cCMo4wm9EWbzpmZW5rH5OV6eDKu6WI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 320/780] net: lan966x: Fix 1-step timestamping over ipv4 or ipv6
Date: Tue, 17 Jun 2025 17:20:28 +0200
Message-ID: <20250617152504.485425077@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit 57ee9584fd8606deef66d7b65fa4dcf94f6843aa ]

When enabling 1-step timestamping for ptp frames that are over udpv4 or
udpv6 then the inserted timestamp is added at the wrong offset in the
frame, meaning that will modify the frame at the wrong place, so the
frame will be malformed.
To fix this, the HW needs to know which kind of frame it is to know
where to insert the timestamp. For that there is a field in the IFH that
says the PDU_TYPE, which can be NONE  which is the default value,
IPV4 or IPV6. Therefore make sure to set the PDU_TYPE so the HW knows
where to insert the timestamp.
Like I mention before the issue is not seen with L2 frames because by
default the PDU_TYPE has a value of 0, which represents the L2 frames.

Fixes: 77eecf25bd9d2f ("net: lan966x: Update extraction/injection for timestamping")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Link: https://patch.msgid.link/20250521124159.2713525-1-horatiu.vultur@microchip.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/microchip/lan966x/lan966x_main.c |  6 +++
 .../ethernet/microchip/lan966x/lan966x_main.h |  5 ++
 .../ethernet/microchip/lan966x/lan966x_ptp.c  | 49 ++++++++++++++-----
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 0af143ec0f869..427bdc0e4908c 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -353,6 +353,11 @@ static void lan966x_ifh_set_rew_op(void *ifh, u64 rew_op)
 	lan966x_ifh_set(ifh, rew_op, IFH_POS_REW_CMD, IFH_WID_REW_CMD);
 }
 
+static void lan966x_ifh_set_oam_type(void *ifh, u64 oam_type)
+{
+	lan966x_ifh_set(ifh, oam_type, IFH_POS_PDU_TYPE, IFH_WID_PDU_TYPE);
+}
+
 static void lan966x_ifh_set_timestamp(void *ifh, u64 timestamp)
 {
 	lan966x_ifh_set(ifh, timestamp, IFH_POS_TIMESTAMP, IFH_WID_TIMESTAMP);
@@ -380,6 +385,7 @@ static netdev_tx_t lan966x_port_xmit(struct sk_buff *skb,
 			return err;
 
 		lan966x_ifh_set_rew_op(ifh, LAN966X_SKB_CB(skb)->rew_op);
+		lan966x_ifh_set_oam_type(ifh, LAN966X_SKB_CB(skb)->pdu_type);
 		lan966x_ifh_set_timestamp(ifh, LAN966X_SKB_CB(skb)->ts_id);
 	}
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 1efa584e71077..1f9df67f05044 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -75,6 +75,10 @@
 #define IFH_REW_OP_ONE_STEP_PTP		0x3
 #define IFH_REW_OP_TWO_STEP_PTP		0x4
 
+#define IFH_PDU_TYPE_NONE		0
+#define IFH_PDU_TYPE_IPV4		7
+#define IFH_PDU_TYPE_IPV6		8
+
 #define FDMA_RX_DCB_MAX_DBS		1
 #define FDMA_TX_DCB_MAX_DBS		1
 
@@ -254,6 +258,7 @@ struct lan966x_phc {
 
 struct lan966x_skb_cb {
 	u8 rew_op;
+	u8 pdu_type;
 	u16 ts_id;
 	unsigned long jiffies;
 };
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 63905bb5a63a8..87e5e81d40dc6 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -322,34 +322,55 @@ void lan966x_ptp_hwtstamp_get(struct lan966x_port *port,
 	*cfg = phc->hwtstamp_config;
 }
 
-static int lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb)
+static void lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb,
+				 u8 *rew_op, u8 *pdu_type)
 {
 	struct ptp_header *header;
 	u8 msgtype;
 	int type;
 
-	if (port->ptp_tx_cmd == IFH_REW_OP_NOOP)
-		return IFH_REW_OP_NOOP;
+	if (port->ptp_tx_cmd == IFH_REW_OP_NOOP) {
+		*rew_op = IFH_REW_OP_NOOP;
+		*pdu_type = IFH_PDU_TYPE_NONE;
+		return;
+	}
 
 	type = ptp_classify_raw(skb);
-	if (type == PTP_CLASS_NONE)
-		return IFH_REW_OP_NOOP;
+	if (type == PTP_CLASS_NONE) {
+		*rew_op = IFH_REW_OP_NOOP;
+		*pdu_type = IFH_PDU_TYPE_NONE;
+		return;
+	}
 
 	header = ptp_parse_header(skb, type);
-	if (!header)
-		return IFH_REW_OP_NOOP;
+	if (!header) {
+		*rew_op = IFH_REW_OP_NOOP;
+		*pdu_type = IFH_PDU_TYPE_NONE;
+		return;
+	}
 
-	if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP)
-		return IFH_REW_OP_TWO_STEP_PTP;
+	if (type & PTP_CLASS_L2)
+		*pdu_type = IFH_PDU_TYPE_NONE;
+	if (type & PTP_CLASS_IPV4)
+		*pdu_type = IFH_PDU_TYPE_IPV4;
+	if (type & PTP_CLASS_IPV6)
+		*pdu_type = IFH_PDU_TYPE_IPV6;
+
+	if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP) {
+		*rew_op = IFH_REW_OP_TWO_STEP_PTP;
+		return;
+	}
 
 	/* If it is sync and run 1 step then set the correct operation,
 	 * otherwise run as 2 step
 	 */
 	msgtype = ptp_get_msgtype(header, type);
-	if ((msgtype & 0xf) == 0)
-		return IFH_REW_OP_ONE_STEP_PTP;
+	if ((msgtype & 0xf) == 0) {
+		*rew_op = IFH_REW_OP_ONE_STEP_PTP;
+		return;
+	}
 
-	return IFH_REW_OP_TWO_STEP_PTP;
+	*rew_op = IFH_REW_OP_TWO_STEP_PTP;
 }
 
 static void lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
@@ -374,10 +395,12 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
 {
 	struct lan966x *lan966x = port->lan966x;
 	unsigned long flags;
+	u8 pdu_type;
 	u8 rew_op;
 
-	rew_op = lan966x_ptp_classify(port, skb);
+	lan966x_ptp_classify(port, skb, &rew_op, &pdu_type);
 	LAN966X_SKB_CB(skb)->rew_op = rew_op;
+	LAN966X_SKB_CB(skb)->pdu_type = pdu_type;
 
 	if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
 		return 0;
-- 
2.39.5




