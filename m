Return-Path: <stable+bounces-143945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE46AB42E6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DF31886EFD
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A6B299A95;
	Mon, 12 May 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uo/Y33Yy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C92512F1;
	Mon, 12 May 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073375; cv=none; b=IKFAQcWZ1L5vOhVQFv3scnyPqkCHSc6dvaWXj2Q267VphxDuKWlAB0pOrk6beS6R/LerHZLKndfphEJ/gY9ae1mBc5GuKsE/Uup4TKZwr18RCI2q6EfgQhSRsATGh5kGp4SZAHWfvsdljMQHaaUv4E1pUneHAhoAGxEV9Xuj9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073375; c=relaxed/simple;
	bh=/VLt3X2mDyxfFZ65Xb1OxN31ygsDtFMwOsPVUuaggRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO3TN+2Cg81NkRh5RYKMuIeTCtIcp9BlEfn7diFFk8rIc0WGYjuZjapIoo2+Pdazw+Y3ZM503BkGXyKvD11b8pPwJoOMW7fPM483eChURE5DZuMxGx3y74Bn4qn05Y/J+ozWoJlJqYhW9QtCm0PPTcfddGA/cWqsNH1ZafHz4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uo/Y33Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF857C4CEE7;
	Mon, 12 May 2025 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073375;
	bh=/VLt3X2mDyxfFZ65Xb1OxN31ygsDtFMwOsPVUuaggRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uo/Y33YyVgQFaaqQ2OcQvBQy72xwjxdLtWZmjbo8rmZ8A75u3tHzqiBuCMFBENTCR
	 VHTijUdZPPbsnnnVEgOPu5U2HtuPh9/HtaibedbFKv3541n1OsgZJ/Vrf4QzJOA/Uh
	 lHv14xY7J0s63XU5yg6g32y5dhPF9Qx8QqQnSIAQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kelsey Maes <kelsey@vpprocess.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 015/113] can: mcp251xfd: fix TDC setting for low data bit rates
Date: Mon, 12 May 2025 19:45:04 +0200
Message-ID: <20250512172028.311682736@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
References: <20250512172027.691520737@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kelsey Maes <kelsey@vpprocess.com>

[ Upstream commit 5e1663810e11c64956aa7e280cf74b2f3284d816 ]

The TDC is currently hardcoded enabled. This means that even for lower
CAN-FD data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC
is configured. This leads to a bus-off condition.

ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC)
is only applicable if DBRP is 1 or 2.

To fix the problem, switch the driver to use the TDC calculation
provided by the CAN driver framework (which respects ISO 11898-1
section 11.3.3). This has the positive side effect that userspace can
control TDC as needed.

Demonstration of the feature in action:
| $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
| $ ip -details link show can0
| 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
|     link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
|     can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
| 	  bitrate 125000 sample-point 0.875
| 	  tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
| 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
| 	  dbitrate 500000 dsample-point 0.875
| 	  dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
| 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
| 	  tdcv 0..63 tdco 0..63
| 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
| $ ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd on
| $ ip -details link show can0
| 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
|     link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
|     can <FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
| 	  bitrate 1000000 sample-point 0.750
| 	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 5 brp 1
| 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
| 	  dbitrate 4000000 dsample-point 0.700
| 	  dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
| 	  tdco 7
| 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
| 	  tdcv 0..63 tdco 0..63
| 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0

There has been some confusion about the MCP2518FD using a relative or
absolute TDCO due to the datasheet specifying a range of [-64,63]. I
have a custom board with a 40 MHz clock and an estimated loop delay of
100 to 216 ns. During testing at a data bit rate of 4 Mbit/s I found
that using can_get_relative_tdco() resulted in bus-off errors. The
final TDCO value was 1 which corresponds to a 10% SSP in an absolute
configuration. This behavior is expected if the TDCO value is really
absolute and not relative. Using priv->can.tdc.tdco instead results in
a final TDCO of 8, setting the SSP at exactly 80%. This configuration
works.

The automatic, manual, and off TDC modes were tested at speeds up to,
and including, 8 Mbit/s on real hardware and behave as expected.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Reported-by: Kelsey Maes <kelsey@vpprocess.com>
Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vpprocess.com
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>
Link: https://patch.msgid.link/20250430161501.79370-1-kelsey@vpprocess.com
[mkl: add comment]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 40 +++++++++++++++----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index a48996265172f..21ae3a89924e9 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -75,6 +75,24 @@ static const struct can_bittiming_const mcp251xfd_data_bittiming_const = {
 	.brp_inc = 1,
 };
 
+/* The datasheet of the mcp2518fd (DS20006027B) specifies a range of
+ * [-64,63] for TDCO, indicating a relative TDCO.
+ *
+ * Manual tests have shown, that using a relative TDCO configuration
+ * results in bus off, while an absolute configuration works.
+ *
+ * For TDCO use the max value (63) from the data sheet, but 0 as the
+ * minimum.
+ */
+static const struct can_tdc_const mcp251xfd_tdc_const = {
+	.tdcv_min = 0,
+	.tdcv_max = 63,
+	.tdco_min = 0,
+	.tdco_max = 63,
+	.tdcf_min = 0,
+	.tdcf_max = 0,
+};
+
 static const char *__mcp251xfd_get_model_str(enum mcp251xfd_model model)
 {
 	switch (model) {
@@ -510,8 +528,7 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 {
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
-	u32 val = 0;
-	s8 tdco;
+	u32 tdcmod, val = 0;
 	int err;
 
 	/* CAN Control Register
@@ -575,11 +592,16 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 		return err;
 
 	/* Transmitter Delay Compensation */
-	tdco = clamp_t(int, dbt->brp * (dbt->prop_seg + dbt->phase_seg1),
-		       -64, 63);
-	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
-			 MCP251XFD_REG_TDC_TDCMOD_AUTO) |
-		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO)
+		tdcmod = MCP251XFD_REG_TDC_TDCMOD_AUTO;
+	else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
+		tdcmod = MCP251XFD_REG_TDC_TDCMOD_MANUAL;
+	else
+		tdcmod = MCP251XFD_REG_TDC_TDCMOD_DISABLED;
+
+	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK, tdcmod) |
+		FIELD_PREP(MCP251XFD_REG_TDC_TDCV_MASK, priv->can.tdc.tdcv) |
+		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
 
 	return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
 }
@@ -2083,10 +2105,12 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
 	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
+	priv->can.tdc_const = &mcp251xfd_tdc_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
 		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
-		CAN_CTRLMODE_CC_LEN8_DLC;
+		CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO |
+		CAN_CTRLMODE_TDC_MANUAL;
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	priv->ndev = ndev;
 	priv->spi = spi;
-- 
2.39.5




