Return-Path: <stable+bounces-95049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229709D7576
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3009DB43322
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC29C20100A;
	Sun, 24 Nov 2024 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmE4SycX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730381D5160;
	Sun, 24 Nov 2024 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455806; cv=none; b=ZwiRplmTaV60wCv0naTIyqks29mraU+/Tc7nN9oEl5CpNEhyFPd7vNApj9v+N3tI3l1B+7NyukFf8uVmAtSA8WNevTZ1VhoALr7XMHrezT4Qr9H7LnsvrOEDdMAIcWnuxi3O1H0MDQ3bzeodDxZcbcNPUawPfQ7NXRW/2sxAofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455806; c=relaxed/simple;
	bh=qv5uR2tjx0Fy6RsqPV3TVLAUoC7db9QSAc69i5NeHZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxn6htSpO8ntp88Ma3OtaiCP81rPZAXKo6oWWX/F4qExtAHLuMIAffqCKqAygTDHTNonV3UMIDykErDD4dJzU+ObzEII8emAvrc0F0xwTAhdkgKWmlwKpS2aDAWQKvtJCMHL9Njacz0Gsj7B3iUfMMFcrZDy+b9ahAhoKHQxGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmE4SycX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B707C4CED3;
	Sun, 24 Nov 2024 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455806;
	bh=qv5uR2tjx0Fy6RsqPV3TVLAUoC7db9QSAc69i5NeHZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YmE4SycXFE8BWE2FWttHg3qN3oSgcrIjDlj5AsHvqyGnosE+2nmqIjhbp5tEgvM2h
	 GfYJDlBT82kUiiTLtakKPxAcdDNb2eoOxfAxw27xv7rT3vxvvdNOheuoN0ayeHdFgn
	 CZj0ebDm8TGGrymvhT5N/k4XjBJ1Rz6aR0+8lN0ehMPFLddhKXoso3BU+BDaJ3FanM
	 IZo6E8VDmS2cdiPrQLMwbN5kNOINZybd0ZX3agYrh0xi2OQYZ4jcZPu0XELDSfnSx/
	 LmqgTnCfuJHW5n9aEj6cIxYzEFgY5dD1GQVHN//GBNv82ZEpXfLrVsmL97OfBG7psM
	 ePsLKXfyKePyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 46/87] net: stmmac: Programming sequence for VLAN packets with split header
Date: Sun, 24 Nov 2024 08:38:24 -0500
Message-ID: <20241124134102.3344326-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Abhishek Chauhan <quic_abchauha@quicinc.com>

[ Upstream commit d10f1a4e44c3bf874701f86f8cc43490e1956acf ]

Currently reset state configuration of split header works fine for
non-tagged packets and we see no corruption in payload of any size

We need additional programming sequence with reset configuration to
handle VLAN tagged packets to avoid corruption in payload for packets
of size greater than 256 bytes.

Without this change ping application complains about corruption
in payload when the size of the VLAN packet exceeds 256 bytes.

With this change tagged and non-tagged packets of any size works fine
and there is no corruption seen.

Current configuration which has the issue for VLAN packet
----------------------------------------------------------

Split happens at the position at Layer 3 header
|MAC-DA|MAC-SA|Vlan Tag|Ether type|IP header|IP data|Rest of the payload|
                         2 bytes            ^
                                            |

With the fix we are making sure that the split happens now at
Layer 2 which is end of ethernet header and start of IP payload

Ip traffic split
-----------------

Bits which take care of this are SPLM and SPLOFST
SPLM = Split mode is set to Layer 2
SPLOFST = These bits indicate the value of offset from the beginning
of Length/Type field at which header split should take place when the
appropriate SPLM is selected. Reset value is 2bytes.

Un-tagged data (without VLAN)
|MAC-DA|MAC-SA|Ether type|IP header|IP data|Rest of the payload|
                  2bytes ^
			 |

Tagged data (with VLAN)
|MAC-DA|MAC-SA|VLAN Tag|Ether type|IP header|IP data|Rest of the payload|
                          2bytes  ^
				  |

Non-IP traffic split such AV packet
------------------------------------

Bits which take care of this are
SAVE = Split AV Enable
SAVO = Split AV Offset, similar to SPLOFST but this is for AVTP
packets.

|Preamble|MAC-DA|MAC-SA|VLAN tag|Ether type|IEEE 1722 payload|CRC|
				    2bytes ^
					   |

Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241016234313.3992214-1-quic_abchauha@quicinc.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 93a78fd0737b6..28fff6cab812e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -44,6 +44,7 @@
 #define GMAC_MDIO_DATA			0x00000204
 #define GMAC_GPIO_STATUS		0x0000020C
 #define GMAC_ARP_ADDR			0x00000210
+#define GMAC_EXT_CFG1			0x00000238
 #define GMAC_ADDR_HIGH(reg)		(0x300 + reg * 8)
 #define GMAC_ADDR_LOW(reg)		(0x304 + reg * 8)
 #define GMAC_L3L4_CTRL(reg)		(0x900 + (reg) * 0x30)
@@ -284,6 +285,10 @@ enum power_event {
 #define GMAC_HW_FEAT_DVLAN		BIT(5)
 #define GMAC_HW_FEAT_NRVF		GENMASK(2, 0)
 
+/* MAC extended config 1 */
+#define GMAC_CONFIG1_SAVE_EN		BIT(24)
+#define GMAC_CONFIG1_SPLM(v)		FIELD_PREP(GENMASK(9, 8), v)
+
 /* GMAC GPIO Status reg */
 #define GMAC_GPO0			BIT(16)
 #define GMAC_GPO1			BIT(17)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 071f128aa4907..7805a66a0bc08 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -534,6 +534,11 @@ static void dwmac4_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value |= GMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
 	writel(value, ioaddr + GMAC_EXT_CONFIG);
 
+	value = readl(ioaddr + GMAC_EXT_CFG1);
+	value |= GMAC_CONFIG1_SPLM(1); /* Split mode set to L2OFST */
+	value |= GMAC_CONFIG1_SAVE_EN; /* Enable Split AV mode */
+	writel(value, ioaddr + GMAC_EXT_CFG1);
+
 	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
 	if (en)
 		value |= DMA_CONTROL_SPH;
-- 
2.43.0


