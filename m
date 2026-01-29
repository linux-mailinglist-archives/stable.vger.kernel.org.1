Return-Path: <stable+bounces-212731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KDwLy7iemnw/AEAu9opvQ
	(envelope-from <stable+bounces-212731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 05:29:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5AABAD2
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 05:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6205F300FB55
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 04:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21523F26A;
	Thu, 29 Jan 2026 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOaZA8C0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CFB2797AC
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660969; cv=none; b=EhHUd9G7eySx7yg0101t8+KTQrKmtcpzVUyK2JA/iu1GrhPmglT8gNHibfYJGHbB8QxDEMjTxv8xtyC66UIZ9tYkuTUDK48Sw2H3z8vKBlU9AFZqca1YCW4AlB09+lC49U4ipMuk0CPxXcaa1STIUyng2D1Y/S2qnf7XHTq+PT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660969; c=relaxed/simple;
	bh=umLeoIezuuzWDN9KcyKP6hmewbYcA3GAdo8L2bv2ZrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7EL5h7qLIrkTuqo/wNMAhv1LxgpakjyTx3toMxlvhVa/Q5w6tHUEDRJPo0HOGPuSHXLjhG3CbY0HytGzWIcS7pwCau5+H8Yep+dvUhQvmp+7iRMTC9pF6m8YbHdKpoO48Z3/oRleTbkahQzL7c0nVKvsmgbUl5rbHBXs2+mw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOaZA8C0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so5295675e9.2
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 20:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769660966; x=1770265766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLsfEdXp1ghYI/zV3x1liW6kVNIuPDvLp5lPLO4doYE=;
        b=ZOaZA8C0o/Tf235t+A/S/cl8EPfsJONJNNwqLA6ghOTu7fV3xPyaKkswSE4Xw+MNM5
         JHr3vVww1hJarqL0vlDXiueQMD/mFjsixebWvucthWz2Nf2rMvKHHx16eAHT9rxlyMIi
         peEem6q1ak6NYI3j9lwsuilF3U7tfjTJ7z0oK5fE1PLa2kNTyF9IQ+JzLZjnD25QbxBO
         cuN+mPYKDhn5LhPtvvgzKd/YXXcvlItawxarTJxpX+HD4Q2YVuhW7PvYiP3tlbwxhVEg
         /U7AzjrOxlwHsKZNXI0yQFWvmJlWJNR6ZLyYAOiHD2ZuTb7FurD8PE6nhmgCkzLSiidD
         YK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769660966; x=1770265766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLsfEdXp1ghYI/zV3x1liW6kVNIuPDvLp5lPLO4doYE=;
        b=XDhbfdxvMf9G7FgxPYG5MFxuWKNPctZYV+ANt35ZopBzS78MU5dRFhJQ0K80/Nqtp8
         w5TiLSsNHlc7tWKUNgT7tQWDWF51mlz8IuR6PCGBZL4HmnWZRuYHvu9TTMTnJcMkHAY3
         s/9b4wqxo4tNFv4x6dILXfV8/VvfgDqzPye10Zl5h2UzYFET72ZZrDCWQlYA+lVNGjlN
         G5ye6y+H0MORWKZAvb9SeoUd4O0nejMDWmqXZkF+suWV9y1ct7jHLCv3TZcXrG0MiPEl
         kcjGszUVfij8YQWiGsdJ4W38l/UJ2dx2cjtoP70xi9hv9J8VNTrGYnYPD0LwMPtm9chJ
         tfaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOdzF2l8fKLEBlVM1VAD/PsUF9ZO0Ze09Lc5R7j6uODlNqfz+dzyxX9qN020A/c6xAiWktplg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvGOyYUOGiFeCLTocCjYnRrU+y+mSv03/1/7fBGFW4JlYapzW
	5mTcfNIxAtGfQxYic0n7FOnDVjs2Yt1gH/LjftxjfVihsW3biOGlJf4=
X-Gm-Gg: AZuq6aLaZdFuXXfck7fnc8Mj3leQsU8/4+dmV3wU0itWq0Uiom3MpZVAxNtEMW6Sfny
	cz+tjAbOtEJi+JS5yzwJF2n+2i6BPz/TrKLNXcMJbo7M5eHSYcMV4zWc75YDH3ttN1FYPE2IMl6
	f1ycl0NtCE2U7uzvlLYO528W4fqP11Gcd8L9YJDpQxidAkr5Lp5z9gWgR5mynyD2JrQEa0ZEkHu
	Jw9pAzpeInxbk3afaV+oNSkLCEGTGEwkaigJ9U9vz6U4NuJ0QU83l2aPrNi90TUEAsgM5TfRGoP
	YVrK9Iz+1kvyjqym+oTIykbaZHTD+ROvRcUSA7HW55Hsux2ZImEUwddZe+92ZzMxaI0rszf37ts
	lYZ1XtkwP+bC5OMvX0nAtp9XGfdNdHA+lA0vrQNW6IIm452r1xRylXh1a9O4k+27z9ppv0Zrl8o
	ijbEkX
X-Received: by 2002:a05:600c:468c:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-48069c54167mr87577045e9.20.1769660965693;
        Wed, 28 Jan 2026 20:29:25 -0800 (PST)
Received: from localhost ([2a02:169:c218:1:5130:f7b6:9c17:fb83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e474csm11650096f8f.2.2026.01.28.20.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 20:29:23 -0800 (PST)
From: Tomas Hlavacek <tmshlvck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dlan@kernel.org,
	wangruikang@iscas.ac.cn,
	Tomas Hlavacek <tmshlvck@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] net: spacemit: k1-emac: fix jumbo frame support
Date: Thu, 29 Jan 2026 05:29:08 +0100
Message-ID: <20260129042908.410326-1-tmshlvck@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iscas.ac.cn,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212731-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmshlvck@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38E5AABAD2
X-Rspamd-Action: no action

The driver never programs the MAC frame size and jabber registers,
causing the hardware to reject frames larger than the default 1518
bytes even when larger DMA buffers are allocated.

Program MAC_MAXIMUM_FRAME_SIZE, MAC_TRANSMIT_JABBER_SIZE, and
MAC_RECEIVE_JABBER_SIZE based on the configured MTU. Also fix the
maximum buffer size from 4096 to 4095, since the descriptor buffer
size field is only 12 bits. Account for double VLAN tags in frame
size calculations.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Cc: stable@vger.kernel.org
Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
---
v3:
- Set all three frame/jabber registers, fix 12-bit buffer size field
  overflow, use actual frame size with VLAN headroom consistently.

v2: https://lore.kernel.org/netdev/20260126171449.83288-1-tmshlvck@gmail.com/
- Added Fixes tag and Cc stable.

v1: https://lore.kernel.org/netdev/20260126135919.77168-1-tmshlvck@gmail.com/
---
 drivers/net/ethernet/spacemit/k1_emac.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 220eb5ce7583..cd6879d7434c 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -38,7 +39,7 @@
 
 #define EMAC_DEFAULT_BUFSIZE		1536
 #define EMAC_RX_BUF_2K			2048
-#define EMAC_RX_BUF_4K			4096
+#define EMAC_RX_BUF_MAX			FIELD_MAX(RX_DESC_1_BUFFER_SIZE_1_MASK)
 
 /* Tuning parameters from SpacemiT */
 #define EMAC_TX_FRAMES			64
@@ -202,8 +203,7 @@ static void emac_init_hw(struct emac_priv *priv)
 {
 	/* Destination address for 802.3x Ethernet flow control */
 	u8 fc_dest_addr[ETH_ALEN] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x01 };
-
-	u32 rxirq = 0, dma = 0;
+	u32 rxirq = 0, dma = 0, frame_sz;
 
 	regmap_set_bits(priv->regmap_apmu,
 			priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
@@ -228,6 +228,15 @@ static void emac_init_hw(struct emac_priv *priv)
 		DEFAULT_TX_THRESHOLD);
 	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
 
+	/* Set maximum frame size and jabber size based on configured MTU,
+	 * accounting for Ethernet header, double VLAN tags, and FCS.
+	 */
+	frame_sz = priv->ndev->mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN;
+
+	emac_wr(priv, MAC_MAXIMUM_FRAME_SIZE, frame_sz);
+	emac_wr(priv, MAC_TRANSMIT_JABBER_SIZE, frame_sz);
+	emac_wr(priv, MAC_RECEIVE_JABBER_SIZE, frame_sz);
+
 	/* Configure flow control (enabled in emac_adjust_link() later) */
 	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
 	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
@@ -924,14 +933,14 @@ static int emac_change_mtu(struct net_device *ndev, int mtu)
 		return -EBUSY;
 	}
 
-	frame_len = mtu + ETH_HLEN + ETH_FCS_LEN;
+	frame_len = mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN;
 
 	if (frame_len <= EMAC_DEFAULT_BUFSIZE)
 		priv->dma_buf_sz = EMAC_DEFAULT_BUFSIZE;
 	else if (frame_len <= EMAC_RX_BUF_2K)
 		priv->dma_buf_sz = EMAC_RX_BUF_2K;
 	else
-		priv->dma_buf_sz = EMAC_RX_BUF_4K;
+		priv->dma_buf_sz = EMAC_RX_BUF_MAX;
 
 	ndev->mtu = mtu;
 
@@ -2005,7 +2014,7 @@ static int emac_probe(struct platform_device *pdev)
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features |= ndev->hw_features;
 
-	ndev->max_mtu = EMAC_RX_BUF_4K - (ETH_HLEN + ETH_FCS_LEN);
+	ndev->max_mtu = EMAC_RX_BUF_MAX - (ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN);
 	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 
 	priv = netdev_priv(ndev);
-- 
2.52.0


