Return-Path: <stable+bounces-162884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC03B0604E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984051C23C39
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F92ECE94;
	Tue, 15 Jul 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQ7mvaPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828E2E718E;
	Tue, 15 Jul 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587730; cv=none; b=IYt+8vgH069b7lH3kwAbpK4kZp9l1f6Gs3qaklM/WbrgWBYX3SVWAlCZDvK6Cw8vKLxE9pBn6G91GRNz/z2SmeqkG+gsaLz+EzCslU13LQX9X7hcuxg96H0CpPbIDQlihPWMDnisO1XA6ngGDpoHxub7uiSF9UQNgQnAlzCCiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587730; c=relaxed/simple;
	bh=Xa+q0X7VKh40xjOLnqbXtbuMWOP+VbyRJ//ULQQBCjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlI8DPMZ6TDOnC290I7IivLxrnujy+Vrvjdjm3IMM7GI9JMlEI83FTrH5c4j1KrJMK4MB6nygFYRWHCYMgUUEb4c7yWz3s/p95ghM4TQ+VOUFLFF/nFXsTlf+Z2R2ofYigTfEDhol3IpDtX9ORDYfjEJkwjJ/VF2EP48mNc9z/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UQ7mvaPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA5BC4CEE3;
	Tue, 15 Jul 2025 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587729;
	bh=Xa+q0X7VKh40xjOLnqbXtbuMWOP+VbyRJ//ULQQBCjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQ7mvaPjfmaQVCuuj1ydBdRTRnSJ5GBcWCp8ZtrfMV2WvwlURKE4/Sjy3dp+MafCq
	 3gzd3Oek7pVcZ2nxNuyHh+w7MRhSZ1eedq9Cwncs3o0kVVgpm1U/a8526w5bCqGLN8
	 HwQJWJ1sNHN6Axf028S2y/bUEJJ2rR/uelDZ5VQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Radu Bulie <radu-andrei.bulie@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 121/208] dpaa2-eth: Update SINGLE_STEP register access
Date: Tue, 15 Jul 2025 15:13:50 +0200
Message-ID: <20250715130815.791465892@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radu Bulie <radu-andrei.bulie@nxp.com>

[ Upstream commit c4680c978567328a696fd2400bbf58a36cff95d1 ]

DPAA2 MAC supports 1588 one step timestamping.
If this option is enabled then for each transmitted PTP event packet,
the 1588 SINGLE_STEP register is accessed to modify the following fields:

-offset of the correction field inside the PTP packet
-UDP checksum update bit,  in case the PTP event packet has
 UDP encapsulation

These values can change any time, because there may be multiple
PTP clients connected, that receive various 1588 frame types:
- L2 only frame
- UDP / Ipv4
- UDP / Ipv6
- other

The current implementation uses dpni_set_single_step_cfg to update the
SINLGE_STEP register.
Using an MC command  on the Tx datapath for each transmitted 1588 message
introduces high delays, leading to low throughput and consequently to a
small number of supported PTP clients. Besides these, the nanosecond
correction field from the PTP packet will contain the high delay from the
driver which together with the originTimestamp will render timestamp
values that are unacceptable in a GM clock implementation.

This patch updates the Tx datapath for 1588 messages when single step
timestamp is enabled and provides direct access to SINGLE_STEP register,
eliminating the  overhead caused by the dpni_set_single_step_cfg
MC command. MC version >= 10.32 implements this functionality.
If the MC version does not have support for returning the
single step register base address, the driver will use
dpni_set_single_step_cfg command for updates operations.

All the delay introduced by dpni_set_single_step_cfg
function will be eliminated (if MC version has support for returning the
base address of the single step register), improving the egress driver
performance for PTP packets when single step timestamping is enabled.

Before these changes the maximum throughput for 1588 messages with
single step hardware timestamp enabled was around 2000pps.
After the updates the throughput increased up to 32.82 Mbps / 46631.02 pps.

Signed-off-by: Radu Bulie <radu-andrei.bulie@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 2def09ead4ad ("dpaa2-eth: fix xdp_rxq_info leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 89 +++++++++++++++++--
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.h  | 14 ++-
 2 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index fa799cc044426..ef5356ac604ca 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -34,6 +34,75 @@ MODULE_DESCRIPTION("Freescale DPAA2 Ethernet Driver");
 struct ptp_qoriq *dpaa2_ptp;
 EXPORT_SYMBOL(dpaa2_ptp);
 
+static void dpaa2_eth_detect_features(struct dpaa2_eth_priv *priv)
+{
+	priv->features = 0;
+
+	if (dpaa2_eth_cmp_dpni_ver(priv, DPNI_PTP_ONESTEP_VER_MAJOR,
+				   DPNI_PTP_ONESTEP_VER_MINOR) >= 0)
+		priv->features |= DPAA2_ETH_FEATURE_ONESTEP_CFG_DIRECT;
+}
+
+static void dpaa2_update_ptp_onestep_indirect(struct dpaa2_eth_priv *priv,
+					      u32 offset, u8 udp)
+{
+	struct dpni_single_step_cfg cfg;
+
+	cfg.en = 1;
+	cfg.ch_update = udp;
+	cfg.offset = offset;
+	cfg.peer_delay = 0;
+
+	if (dpni_set_single_step_cfg(priv->mc_io, 0, priv->mc_token, &cfg))
+		WARN_ONCE(1, "Failed to set single step register");
+}
+
+static void dpaa2_update_ptp_onestep_direct(struct dpaa2_eth_priv *priv,
+					    u32 offset, u8 udp)
+{
+	u32 val = 0;
+
+	val = DPAA2_PTP_SINGLE_STEP_ENABLE |
+	       DPAA2_PTP_SINGLE_CORRECTION_OFF(offset);
+
+	if (udp)
+		val |= DPAA2_PTP_SINGLE_STEP_CH;
+
+	if (priv->onestep_reg_base)
+		writel(val, priv->onestep_reg_base);
+}
+
+static void dpaa2_ptp_onestep_reg_update_method(struct dpaa2_eth_priv *priv)
+{
+	struct device *dev = priv->net_dev->dev.parent;
+	struct dpni_single_step_cfg ptp_cfg;
+
+	priv->dpaa2_set_onestep_params_cb = dpaa2_update_ptp_onestep_indirect;
+
+	if (!(priv->features & DPAA2_ETH_FEATURE_ONESTEP_CFG_DIRECT))
+		return;
+
+	if (dpni_get_single_step_cfg(priv->mc_io, 0,
+				     priv->mc_token, &ptp_cfg)) {
+		dev_err(dev, "dpni_get_single_step_cfg cannot retrieve onestep reg, falling back to indirect update\n");
+		return;
+	}
+
+	if (!ptp_cfg.ptp_onestep_reg_base) {
+		dev_err(dev, "1588 onestep reg not available, falling back to indirect update\n");
+		return;
+	}
+
+	priv->onestep_reg_base = ioremap(ptp_cfg.ptp_onestep_reg_base,
+					 sizeof(u32));
+	if (!priv->onestep_reg_base) {
+		dev_err(dev, "1588 onestep reg cannot be mapped, falling back to indirect update\n");
+		return;
+	}
+
+	priv->dpaa2_set_onestep_params_cb = dpaa2_update_ptp_onestep_direct;
+}
+
 static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
 				dma_addr_t iova_addr)
 {
@@ -668,7 +737,6 @@ static void dpaa2_eth_enable_tx_tstamp(struct dpaa2_eth_priv *priv,
 				       struct sk_buff *skb)
 {
 	struct ptp_tstamp origin_timestamp;
-	struct dpni_single_step_cfg cfg;
 	u8 msgtype, twostep, udp;
 	struct dpaa2_faead *faead;
 	struct dpaa2_fas *fas;
@@ -722,14 +790,12 @@ static void dpaa2_eth_enable_tx_tstamp(struct dpaa2_eth_priv *priv,
 			htonl(origin_timestamp.sec_lsb);
 		*(__be32 *)(data + offset2 + 6) = htonl(origin_timestamp.nsec);
 
-		cfg.en = 1;
-		cfg.ch_update = udp;
-		cfg.offset = offset1;
-		cfg.peer_delay = 0;
+		if (priv->ptp_correction_off == offset1)
+			return;
+
+		priv->dpaa2_set_onestep_params_cb(priv, offset1, udp);
+		priv->ptp_correction_off = offset1;
 
-		if (dpni_set_single_step_cfg(priv->mc_io, 0, priv->mc_token,
-					     &cfg))
-			WARN_ONCE(1, "Failed to set single step register");
 	}
 }
 
@@ -2112,6 +2178,9 @@ static int dpaa2_eth_ts_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		config.rx_filter = HWTSTAMP_FILTER_ALL;
 	}
 
+	if (priv->tx_tstamp_type == HWTSTAMP_TX_ONESTEP_SYNC)
+		dpaa2_ptp_onestep_reg_update_method(priv);
+
 	return copy_to_user(rq->ifr_data, &config, sizeof(config)) ?
 			-EFAULT : 0;
 }
@@ -4009,6 +4078,8 @@ static int dpaa2_eth_netdev_init(struct net_device *net_dev)
 		return err;
 	}
 
+	dpaa2_eth_detect_features(priv);
+
 	/* Capabilities listing */
 	supported |= IFF_LIVE_ADDR_CHANGE;
 
@@ -4433,6 +4504,8 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	dpaa2_eth_free_dpbp(priv);
 	dpaa2_eth_free_dpio(priv);
 	dpaa2_eth_free_dpni(priv);
+	if (priv->onestep_reg_base)
+		iounmap(priv->onestep_reg_base);
 
 	fsl_mc_portal_free(priv->mc_io);
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index e143d66ca2474..5934b1b4ee973 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -504,12 +504,15 @@ struct dpaa2_eth_priv {
 	u8 num_channels;
 	struct dpaa2_eth_channel *channel[DPAA2_ETH_MAX_DPCONS];
 	struct dpaa2_eth_sgt_cache __percpu *sgt_cache;
-
+	unsigned long features;
 	struct dpni_attr dpni_attrs;
 	u16 dpni_ver_major;
 	u16 dpni_ver_minor;
 	u16 tx_data_offset;
-
+	void __iomem *onestep_reg_base;
+	u8 ptp_correction_off;
+	void (*dpaa2_set_onestep_params_cb)(struct dpaa2_eth_priv *priv,
+					    u32 offset, u8 udp);
 	struct fsl_mc_device *dpbp_dev;
 	u16 rx_buf_size;
 	u16 bpid;
@@ -647,6 +650,13 @@ enum dpaa2_eth_rx_dist {
 #define DPAA2_ETH_DIST_L4DST		BIT(8)
 #define DPAA2_ETH_DIST_ALL		(~0ULL)
 
+#define DPNI_PTP_ONESTEP_VER_MAJOR 8
+#define DPNI_PTP_ONESTEP_VER_MINOR 2
+#define DPAA2_ETH_FEATURE_ONESTEP_CFG_DIRECT BIT(0)
+#define DPAA2_PTP_SINGLE_STEP_ENABLE	BIT(31)
+#define DPAA2_PTP_SINGLE_STEP_CH	BIT(7)
+#define DPAA2_PTP_SINGLE_CORRECTION_OFF(v) ((v) << 8)
+
 #define DPNI_PAUSE_VER_MAJOR		7
 #define DPNI_PAUSE_VER_MINOR		13
 #define dpaa2_eth_has_pause_support(priv)			\
-- 
2.39.5




