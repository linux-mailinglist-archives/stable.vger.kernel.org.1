Return-Path: <stable+bounces-175065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F1BB366E6
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A4B560917
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A926234DCEC;
	Tue, 26 Aug 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bSWsyyK5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6451034DCF1;
	Tue, 26 Aug 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216048; cv=none; b=Mjlz8DJku0uHsyKPjpKprjpybC/mZ07dD+LkkwmVTD6EVVMKs+FDRs+uWJvKg/ZxvVtTFsaJXsrBwOMmo5l4Lvj5k72ZWuV/MsQKdIgbl1tW42KSICTx0gVc/haFLuQLBDNo3KK94NDOZDMbZiNFVN/TiiJTIOY5u8MJY6mMYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216048; c=relaxed/simple;
	bh=QDc7WqoudhjklEfe7ij/oIX2mJAi2Zr/lZujcCHjXmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xq6OahizY3d1sSBLy2g0jxsdIKYAoml/chwksTWQWjaB0l6KCn/zLMTp3347Qe5AQ541zM0AfsfjQ++2aQR8VOtLAtwV1SR65qHjS8A/zYEK7i+365AGTjl6vpwjSXX/bnBYwdbbK+YbuiBQC95EpojGaKIoWnz4p5LvRz4CklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bSWsyyK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D61CC4CEF1;
	Tue, 26 Aug 2025 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216047;
	bh=QDc7WqoudhjklEfe7ij/oIX2mJAi2Zr/lZujcCHjXmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSWsyyK5YYOOt9g66HgsK+eboPK3oWBbvjchfDuDhr739J4zBp2FGfN7aVwVbztOc
	 Pwppr8/V4E5YewSJkA9vm6vQTBc3KGLQkLFFkfQ0LUDjuhLw94Z+dYYfHw/vFE137G
	 9Mn05nX4cw5lDA1vQJq9l3F8mRDnu4TLqr9mT1fA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 232/644] phy: mscc: Fix parsing of unicast frames
Date: Tue, 26 Aug 2025 13:05:23 +0200
Message-ID: <20250826110952.160760213@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit 6fb5ff63b35b7e849cc8510957f25753f87f63d2 ]

According to the 1588 standard, it is possible to use both unicast and
multicast frames to send the PTP information. It was noticed that if the
frames were unicast they were not processed by the analyzer meaning that
they were not timestamped. Therefore fix this to match also these
unicast frames.

Fixes: ab2bf9339357 ("net: phy: mscc: 1588 block initialization")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250726140307.3039694-1-horatiu.vultur@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc/mscc_ptp.c | 1 +
 drivers/net/phy/mscc/mscc_ptp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 7a3a8cce02d3..92f59c964409 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -897,6 +897,7 @@ static int vsc85xx_eth1_conf(struct phy_device *phydev, enum ts_blk blk,
 				     get_unaligned_be32(ptp_multicast));
 	} else {
 		val |= ANA_ETH1_FLOW_ADDR_MATCH2_ANY_MULTICAST;
+		val |= ANA_ETH1_FLOW_ADDR_MATCH2_ANY_UNICAST;
 		vsc85xx_ts_write_csr(phydev, blk,
 				     MSCC_ANA_ETH1_FLOW_ADDR_MATCH2(0), val);
 		vsc85xx_ts_write_csr(phydev, blk,
diff --git a/drivers/net/phy/mscc/mscc_ptp.h b/drivers/net/phy/mscc/mscc_ptp.h
index da3465360e90..ae9ad925bfa8 100644
--- a/drivers/net/phy/mscc/mscc_ptp.h
+++ b/drivers/net/phy/mscc/mscc_ptp.h
@@ -98,6 +98,7 @@
 #define MSCC_ANA_ETH1_FLOW_ADDR_MATCH2(x) (MSCC_ANA_ETH1_FLOW_ENA(x) + 3)
 #define ANA_ETH1_FLOW_ADDR_MATCH2_MASK_MASK	GENMASK(22, 20)
 #define ANA_ETH1_FLOW_ADDR_MATCH2_ANY_MULTICAST	0x400000
+#define ANA_ETH1_FLOW_ADDR_MATCH2_ANY_UNICAST	0x200000
 #define ANA_ETH1_FLOW_ADDR_MATCH2_FULL_ADDR	0x100000
 #define ANA_ETH1_FLOW_ADDR_MATCH2_SRC_DEST_MASK	GENMASK(17, 16)
 #define ANA_ETH1_FLOW_ADDR_MATCH2_SRC_DEST	0x020000
-- 
2.39.5




