Return-Path: <stable+bounces-64018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509F9941BBE
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741BF1C23156
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935521898F8;
	Tue, 30 Jul 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WCIabnXN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F617D8BB;
	Tue, 30 Jul 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358710; cv=none; b=YMqaQVTHippcTiStUu7X8UpgGLuwnHJ6SmVYIWqCPsB+nWGwtwtFsYicoxoA1SH5Giw6TvIqo2I+eZIjMpM1EopwF+MhGOfxGv1xn65OzoTtB8rb6mb9aJynX68LyyUWv5Ln4kgFu84QVgEwFrBb/IbADllUtXAGXVxs6CoXvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358710; c=relaxed/simple;
	bh=3Y5vZ2yIYs/m/Nb/x+nOAWh3P70V4cD4Xje0tKmC7K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FleFuScRsRpDZd4ZGhg95N+w0t+xuv62OoR13zvCmRCjT9tD+GtcmEIg1jIwCBp6hdiFnumZxTzOUS6+6zGFik8N3mJvcZI+y62Um62NCx5Ll6NGS6BH7K088s2gUtefWG67+o6lFvdwvJBzebCLSZLfcMqBCY+y6ATcwyLVYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WCIabnXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9823C32782;
	Tue, 30 Jul 2024 16:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358710;
	bh=3Y5vZ2yIYs/m/Nb/x+nOAWh3P70V4cD4Xje0tKmC7K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCIabnXNQ4OixxVX8crcTAkmxAsmlvbe2+Kp15Nso6rQQDiRcHgd/+mbK3oRj+p02
	 sy46MrIIP26YxOO4+EjZReYtX2Hmhv4EXQ8BgElM05tII2Wg0n0p49rc5g0S7dUyc5
	 o+bGTX9+PDHFxdqHJLPWe+eCedvUkFCsHJNycyJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 415/440] net: stmmac: Correct byte order of perfect_match
Date: Tue, 30 Jul 2024 17:50:48 +0200
Message-ID: <20240730151631.998937855@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

From: Simon Horman <horms@kernel.org>

[ Upstream commit e9dbebae2e3c338122716914fe105458f41e3a4a ]

The perfect_match parameter of the update_vlan_hash operation is __le16,
and is correctly converted from host byte-order in the lone caller,
stmmac_vlan_update().

However, the implementations of this caller, dwxgmac2_update_vlan_hash()
and dwxgmac2_update_vlan_hash(), both treat this parameter as host byte
order, using the following pattern:

	u32 value = ...
	...
	writel(value | perfect_match, ...);

This is not correct because both:
1) value is host byte order; and
2) writel expects a host byte order value as it's first argument

I believe that this will break on big endian systems. And I expect it
has gone unnoticed by only being exercised on little endian systems.

The approach taken by this patch is to update the callback, and it's
caller to simply use a host byte order value.

Flagged by Sparse.
Compile tested only.

Fixes: c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if HASH is not available")
Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 39112d5cb5b80..687eb17e41c6e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -971,7 +971,7 @@ static void dwmac4_set_mac_loopback(void __iomem *ioaddr, bool enable)
 }
 
 static void dwmac4_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				    __le16 perfect_match, bool is_double)
+				    u16 perfect_match, bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index dd73f38ec08d8..813327d04c56f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -582,7 +582,7 @@ static int dwxgmac2_rss_configure(struct mac_device_info *hw,
 }
 
 static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				      __le16 perfect_match, bool is_double)
+				      u16 perfect_match, bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index b2b9cf04bc726..820e2251b7c88 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -366,7 +366,7 @@ struct stmmac_ops {
 			     struct stmmac_rss *cfg, u32 num_rxq);
 	/* VLAN */
 	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
-				 __le16 perfect_match, bool is_double);
+				 u16 perfect_match, bool is_double);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
 	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
 				   struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e2d51014ab4bc..93630840309e7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6311,7 +6311,7 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
 static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 {
 	u32 crc, hash = 0;
-	__le16 pmatch = 0;
+	u16 pmatch = 0;
 	int count = 0;
 	u16 vid = 0;
 
@@ -6326,7 +6326,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 		if (count > 2) /* VID = 0 always passes filter */
 			return -EOPNOTSUPP;
 
-		pmatch = cpu_to_le16(vid);
+		pmatch = vid;
 		hash = 0;
 	}
 
-- 
2.43.0




