Return-Path: <stable+bounces-173697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68DAB35E61
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96426561114
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC94F2FF64C;
	Tue, 26 Aug 2025 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xR5vi6cm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A12C08BD;
	Tue, 26 Aug 2025 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208921; cv=none; b=JILinZWPi09XyROvfWLo2ln1iFASo6IfZ7VkkyBJCAockVQnhfpAt/mndk7ITqfLmdust2KkQIq6Enoo/oIq1vu392FPvJ8Iq/pyrZzwanuaKO32m+QAGVP6OS3SRYMw/2ZJ0tZ/X5dF9Lk700/MjvPm4XUot5boU/qn9tBAOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208921; c=relaxed/simple;
	bh=B2WtjEb9L3nbRe32lDtUsnLgibTE9/suj7Z2pbqNvxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EesjhjfeJF3MvHLsIbW+maIYReRVkP4KFLKssCgrgs4T8tsvqPkLWd77CWqM5DMFQSmQzFYaArDtBtYSuXDgXb/UtE/aKDEWnvjmfnDWV2wVjHztNSQoJ9Ex5DORrqaxWpuktXUGbASgK5D0VZriKdyaq1uLqvvbDoOgMV4pTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xR5vi6cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7FAC4CEF1;
	Tue, 26 Aug 2025 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208921;
	bh=B2WtjEb9L3nbRe32lDtUsnLgibTE9/suj7Z2pbqNvxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xR5vi6cmDteOgnYWnIxVOzKyKOLh3Prk5eSE0VgphMPqaUnzTr1aLsf2y7StSQNQx
	 JcpYy6gBLFOSBM+K4ltGlkIESl4cSHEvhJER7cNJJkntaUzQWcbnYKCpTwR4lWTFew
	 dV4/EOwGk2hhLXVvB5p4NDF11AMSICmcntwHD3tQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 296/322] phy: mscc: Fix timestamping for vsc8584
Date: Tue, 26 Aug 2025 13:11:51 +0200
Message-ID: <20250826110923.209443538@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit bc1a59cff9f797bfbf8f3104507584d89e9ecf2e ]

There was a problem when we received frames and the frames were
timestamped. The driver is configured to store the nanosecond part of
the timestmap in the ptp reserved bits and it would take the second part
by reading the LTC. The problem is that when reading the LTC we are in
atomic context and to read the second part will go over mdio bus which
might sleep, so we get an error.
The fix consists in actually put all the frames in a queue and start the
aux work and in that work to read the LTC and then calculate the full
received time.

Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250818081029.1300780-1-horatiu.vultur@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc/mscc.h      | 12 ++++++++
 drivers/net/phy/mscc/mscc_main.c | 12 ++++++++
 drivers/net/phy/mscc/mscc_ptp.c  | 49 ++++++++++++++++++++++++--------
 3 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 6a3d8a754eb8..58c6d47fbe04 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -362,6 +362,13 @@ struct vsc85xx_hw_stat {
 	u16 mask;
 };
 
+struct vsc8531_skb_cb {
+	u32 ns;
+};
+
+#define VSC8531_SKB_CB(skb) \
+	((struct vsc8531_skb_cb *)((skb)->cb))
+
 struct vsc8531_private {
 	int rate_magic;
 	u16 supp_led_modes;
@@ -410,6 +417,11 @@ struct vsc8531_private {
 	 */
 	struct mutex ts_lock;
 	struct mutex phc_lock;
+
+	/* list of skbs that were received and need timestamp information but it
+	 * didn't received it yet
+	 */
+	struct sk_buff_head rx_skbs_list;
 };
 
 /* Shared structure between the PHYs of the same package.
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 6f74ce0ab1aa..42cafa68c400 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2335,6 +2335,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
 
+static void vsc85xx_remove(struct phy_device *phydev)
+{
+	struct vsc8531_private *priv = phydev->priv;
+
+	skb_queue_purge(&priv->rx_skbs_list);
+}
+
 /* Microsemi VSC85xx PHYs */
 static struct phy_driver vsc85xx_driver[] = {
 {
@@ -2589,6 +2596,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8574_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
@@ -2614,6 +2622,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8574_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
@@ -2639,6 +2648,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
@@ -2662,6 +2672,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
@@ -2685,6 +2696,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index bce6cc5b04ee..80992827a3bd 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1191,9 +1191,7 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
 {
 	struct vsc8531_private *vsc8531 =
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
-	struct skb_shared_hwtstamps *shhwtstamps = NULL;
 	struct vsc85xx_ptphdr *ptphdr;
-	struct timespec64 ts;
 	unsigned long ns;
 
 	if (!vsc8531->ptp->configured)
@@ -1203,27 +1201,52 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
 	    type == PTP_CLASS_NONE)
 		return false;
 
-	vsc85xx_gettime(&vsc8531->ptp->caps, &ts);
-
 	ptphdr = get_ptp_header_rx(skb, vsc8531->ptp->rx_filter);
 	if (!ptphdr)
 		return false;
 
-	shhwtstamps = skb_hwtstamps(skb);
-	memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
-
 	ns = ntohl(ptphdr->rsrvd2);
 
-	/* nsec is in reserved field */
-	if (ts.tv_nsec < ns)
-		ts.tv_sec--;
+	VSC8531_SKB_CB(skb)->ns = ns;
+	skb_queue_tail(&vsc8531->rx_skbs_list, skb);
 
-	shhwtstamps->hwtstamp = ktime_set(ts.tv_sec, ns);
-	netif_rx(skb);
+	ptp_schedule_worker(vsc8531->ptp->ptp_clock, 0);
 
 	return true;
 }
 
+static long vsc85xx_do_aux_work(struct ptp_clock_info *info)
+{
+	struct vsc85xx_ptp *ptp = container_of(info, struct vsc85xx_ptp, caps);
+	struct skb_shared_hwtstamps *shhwtstamps = NULL;
+	struct phy_device *phydev = ptp->phydev;
+	struct vsc8531_private *priv = phydev->priv;
+	struct sk_buff_head received;
+	struct sk_buff *rx_skb;
+	struct timespec64 ts;
+	unsigned long flags;
+
+	__skb_queue_head_init(&received);
+	spin_lock_irqsave(&priv->rx_skbs_list.lock, flags);
+	skb_queue_splice_tail_init(&priv->rx_skbs_list, &received);
+	spin_unlock_irqrestore(&priv->rx_skbs_list.lock, flags);
+
+	vsc85xx_gettime(info, &ts);
+	while ((rx_skb = __skb_dequeue(&received)) != NULL) {
+		shhwtstamps = skb_hwtstamps(rx_skb);
+		memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
+
+		if (ts.tv_nsec < VSC8531_SKB_CB(rx_skb)->ns)
+			ts.tv_sec--;
+
+		shhwtstamps->hwtstamp = ktime_set(ts.tv_sec,
+						  VSC8531_SKB_CB(rx_skb)->ns);
+		netif_rx(rx_skb);
+	}
+
+	return -1;
+}
+
 static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "VSC85xx timer",
@@ -1237,6 +1260,7 @@ static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.adjfine	= &vsc85xx_adjfine,
 	.gettime64	= &vsc85xx_gettime,
 	.settime64	= &vsc85xx_settime,
+	.do_aux_work	= &vsc85xx_do_aux_work,
 };
 
 static struct vsc8531_private *vsc8584_base_priv(struct phy_device *phydev)
@@ -1564,6 +1588,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
 	mutex_init(&vsc8531->phc_lock);
 	mutex_init(&vsc8531->ts_lock);
+	skb_queue_head_init(&vsc8531->rx_skbs_list);
 
 	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
 	 * the same GPIO can be requested by all the PHYs of the same package.
-- 
2.50.1




