Return-Path: <stable+bounces-69663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28152957BC1
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 05:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82EA1F22E56
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42726AE0;
	Tue, 20 Aug 2024 03:05:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B433F9;
	Tue, 20 Aug 2024 03:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123158; cv=none; b=EafOL37AV8muTTeFzhdPmNZjJS+HAOfKHQVnYeXlxjEu8lyKHj4O9CxzzrJmUAijEfi5CkIzMkpqM+lM+aGbfFi60gKTcowtsfefoQhEMdgDqbnRhopotiL61hY0dz1uLJB05FT7mPmbj0yAm4yYbxBcfG+SGYo2rXiML8likbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123158; c=relaxed/simple;
	bh=h+lJj32e5Les/AKmys15hgtO+gemKk3QMI/MW5nfIz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UagTMqbN7jjUOT413paTeEuzLx1z1WoChRs1XSQ16/edixCRBhw8eHJpUggCIYG28vVoKJulAMjdhg3sLRmctwQUP1/iwJL7WHUiWH0vo6GH0NMnPJva65EleJaKfKucLSvogY+JLTyGwXWHDAmWdKqydTKdzXLUvsqwhLGlFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz4t1724123083troqc9q
X-QQ-Originating-IP: P77o5A9NWfznVPAyzaFB39dZc3GenpqjoGvKa0RjKFQ=
Received: from localhost.localdomain ( [122.235.140.94])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 Aug 2024 11:04:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 563778973539283072
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	stable@vger.kernel.org,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net v3] net: ngbe: Fix phy mode set to external phy
Date: Tue, 20 Aug 2024 11:04:25 +0800
Message-ID: <E6759CF1387CF84C+20240820030425.93003-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

The MAC only has add the TX delay and it can not be modified.
MAC and PHY are both set the TX delay cause transmission problems.
So just disable TX delay in PHY, when use rgmii to attach to
external phy, set PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
And it is does not matter to internal phy.

Fixes: bc2426d74aa3 ("net: ngbe: convert phylib to phylink")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: stable@vger.kernel.org # 6.3+
---
v3:
-Rebase the fix commit for net.
v2:
-Add a comment for the code modification.
-Add the problem in commit messages.
https://lore.kernel.org/netdev/E9C427FDDCF0CBC3+20240812103025.42417-1-mengyuanlou@net-swift.com/
v1:
https://lore.kernel.org/netdev/C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com/

 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index ec54b18c5fe7..a5e9b779c44d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -124,8 +124,12 @@ static int ngbe_phylink_init(struct wx *wx)
 				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 	config->mac_managed_pm = true;
 
-	phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
-	__set_bit(PHY_INTERFACE_MODE_RGMII_ID, config->supported_interfaces);
+	/* The MAC only has add the Tx delay and it can not be modified.
+	 * So just disable TX delay in PHY, and it is does not matter to
+	 * internal phy.
+	 */
+	phy_mode = PHY_INTERFACE_MODE_RGMII_RXID;
+	__set_bit(PHY_INTERFACE_MODE_RGMII_RXID, config->supported_interfaces);
 
 	phylink = phylink_create(config, NULL, phy_mode, &ngbe_mac_ops);
 	if (IS_ERR(phylink))
-- 
2.43.2


