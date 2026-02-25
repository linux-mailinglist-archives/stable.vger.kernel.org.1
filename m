Return-Path: <stable+bounces-219193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ0SBTmQnmnTWAQAu9opvQ
	(envelope-from <stable+bounces-219193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F21D192384
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3FF63038289
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C59F24A044;
	Wed, 25 Feb 2026 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xmzr8d9/"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4B199FD3;
	Wed, 25 Feb 2026 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771999271; cv=none; b=Po+Ljp+wfhEU/fiX8AvYg8Y2sHCsJOuHTKPKJ5ZDDP9elupCYELXH4y3AaAZbJC29eM9QcL3yRiaAjqreidM+0ERkNX9XybsOgL/jJ68r4JJSDGAyG3S7Z/ftuLgvU3o4e2bzAcecOBUEhRHTEj68OM4AFPBhXt6aSFtjRbeZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771999271; c=relaxed/simple;
	bh=DT9NsupW7KzpsaNFgyM+p+iisHu+Ve6ksNpG7sPqzhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c9mXHsdbU37tTNXVN7f6TXrALEAftzhnFgX3K8vMuXUILz9O2krvIRZkwXIuSsRc+1hwNE2X/DFo9gR4poY3XdVfDUJayKmefa7XlwDW/Se3Jn+4bvSIXymUC3ZmWcOaF3czLCdy7z7EvRRVtb8sq3jnKPg7poXx4+VO9+rfi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xmzr8d9/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mI
	oOCyEWs+jYPUjAQfAjzIi7XgqcEbmsiZSQIKnrn2Q=; b=Xmzr8d9/34T+/LLfVt
	A4l1tFPuX2xkhIbVgK7BRUuVYnNBRo7SWLCTp+bS4ddZNcO9x5yadHidHdmJ9zel
	dmw2y2qf2ljggFRB0fhjU4birYdpjXv0NI91RVuh9JnjXSMVtHdv+gNrCEyyvAv1
	l3VQEnGngV5HItl4cXVAO7wqI=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnwnP0j55pCMp3Ow--.36060S2;
	Wed, 25 Feb 2026 14:00:21 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.6.y] eth: bnxt: always recalculate features after XDP clearing, fix null-deref
Date: Wed, 25 Feb 2026 14:00:20 +0800
Message-Id: <20260225060020.3361855-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnwnP0j55pCMp3Ow--.36060S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr1Dury8KryfCF4UZFy8Grg_yoWxGw45pa
	yUGasruw4kJr45XaykKay8Ar15X397t34rWFW7JayF93WjyFyUJF1kKasFvF90qrW8GF12
	yF42vry3AF1DXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piG2NPUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3hUjvGmej-XTyAAA3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219193-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,broadcom.com,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 7F21D192384
X-Rspamd-Action: no action

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit f0aa6a37a3dbb40b272df5fc6db93c114688adcd ]

Recalculate features when XDP is detached.

Before:
  # ip li set dev eth0 xdp obj xdp_dummy.bpf.o sec xdp
  # ip li set dev eth0 xdp off
  # ethtool -k eth0 | grep gro
  rx-gro-hw: off [requested on]

After:
  # ip li set dev eth0 xdp obj xdp_dummy.bpf.o sec xdp
  # ip li set dev eth0 xdp off
  # ethtool -k eth0 | grep gro
  rx-gro-hw: on

The fact that HW-GRO doesn't get re-enabled automatically is just
a minor annoyance. The real issue is that the features will randomly
come back during another reconfiguration which just happens to invoke
netdev_update_features(). The driver doesn't handle reconfiguring
two things at a time very robustly.

Starting with commit 98ba1d931f61 ("bnxt_en: Fix RSS logic in
__bnxt_reserve_rings()") we only reconfigure the RSS hash table
if the "effective" number of Rx rings has changed. If HW-GRO is
enabled "effective" number of rings is 2x what user sees.
So if we are in the bad state, with HW-GRO re-enablement "pending"
after XDP off, and we lower the rings by / 2 - the HW-GRO rings
doing 2x and the ethtool -L doing / 2 may cancel each other out,
and the:

  if (old_rx_rings != bp->hw_resc.resv_rx_rings &&

condition in __bnxt_reserve_rings() will be false.
The RSS map won't get updated, and we'll crash with:

  BUG: kernel NULL pointer dereference, address: 0000000000000168
  RIP: 0010:__bnxt_hwrm_vnic_set_rss+0x13a/0x1a0
    bnxt_hwrm_vnic_rss_cfg_p5+0x47/0x180
    __bnxt_setup_vnic_p5+0x58/0x110
    bnxt_init_nic+0xb72/0xf50
    __bnxt_open_nic+0x40d/0xab0
    bnxt_open_nic+0x2b/0x60
    ethtool_set_channels+0x18c/0x1d0

As we try to access a freed ring.

The issue is present since XDP support was added, really, but
prior to commit 98ba1d931f61 ("bnxt_en: Fix RSS logic in
__bnxt_reserve_rings()") it wasn't causing major issues.

Fixes: 1054aee82321 ("bnxt_en: Use NETIF_F_GRO_HW.")
Fixes: 98ba1d931f61 ("bnxt_en: Fix RSS logic in __bnxt_reserve_rings()")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Link: https://patch.msgid.link/20250109043057.2888953-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ The context change is due to the commit 1f6e77cb9b32
("bnxt_en: Add bnxt_l2_filter hash table.") in v6.8 and the commit
8336a974f37d ("bnxt_en: Save user configured filters in a lookup list")
in v6.9 which are irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  7 ------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e337b6c7ee6f..32bccea60645 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3996,7 +3996,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 /* Changing allocation mode of RX rings.
  * TODO: Update when extending xdp_rxq_info to support allocation modes.
  */
-int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
+static void __bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 {
 	struct net_device *dev = bp->dev;
 
@@ -4017,15 +4017,30 @@ int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 			bp->rx_skb_func = bnxt_rx_page_skb;
 		}
 		bp->rx_dir = DMA_BIDIRECTIONAL;
-		/* Disable LRO or GRO_HW */
-		netdev_update_features(dev);
 	} else {
 		dev->max_mtu = bp->max_mtu;
 		bp->flags &= ~BNXT_FLAG_RX_PAGE_MODE;
 		bp->rx_dir = DMA_FROM_DEVICE;
 		bp->rx_skb_func = bnxt_rx_skb;
 	}
-	return 0;
+}
+
+void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
+{
+	__bnxt_set_rx_skb_mode(bp, page_mode);
+
+	if (!page_mode) {
+		int rx, tx;
+
+		bnxt_get_max_rings(bp, &rx, &tx, true);
+		if (rx > 1) {
+			bp->flags &= ~BNXT_FLAG_NO_AGG_RINGS;
+			bp->dev->hw_features |= NETIF_F_LRO;
+		}
+	}
+
+	/* Update LRO and GRO_HW availability */
+	netdev_update_features(bp->dev);
 }
 
 static void bnxt_free_vnic_attributes(struct bnxt *bp)
@@ -13773,7 +13788,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto init_err_pci_clean;
 
-	bnxt_set_rx_skb_mode(bp, false);
+	__bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 	rc = bnxt_set_dflt_rings(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d96c9aabf97a..bc1ff1085da7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2332,7 +2332,7 @@ void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data);
 u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
 void bnxt_set_tpa_flags(struct bnxt *bp);
 void bnxt_set_ring_params(struct bnxt *);
-int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
+void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
 int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
 			    int bmap_size, bool async_only);
 int bnxt_hwrm_func_drv_unrgtr(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 07a458ecb7cc..b6320b64b8e7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -422,15 +422,8 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 		bnxt_set_rx_skb_mode(bp, true);
 		xdp_features_set_redirect_target(dev, true);
 	} else {
-		int rx, tx;
-
 		xdp_features_clear_redirect_target(dev);
 		bnxt_set_rx_skb_mode(bp, false);
-		bnxt_get_max_rings(bp, &rx, &tx, true);
-		if (rx > 1) {
-			bp->flags &= ~BNXT_FLAG_NO_AGG_RINGS;
-			bp->dev->hw_features |= NETIF_F_LRO;
-		}
 	}
 	bp->tx_nr_rings_xdp = tx_xdp;
 	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
-- 
2.34.1


