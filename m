Return-Path: <stable+bounces-70311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E096046E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AE41F21E20
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2CB131182;
	Tue, 27 Aug 2024 08:32:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEF14A90
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747544; cv=none; b=H4kVu7O9cBopUqfNsvQJ/M4kvOd+94h6uypp6QGI4Vzff8JMVB6++ymQzGe7ihT+XPX9aZc7XhDLBhE1m2un+kGR+SkXRfcHIwsMCaKA8Jsw/nYKY68Ds2ZYOSLPBYSpBQ4Jt62rfPYrgssXXu9qYKnCDqYIs/h53KEG0PdksBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747544; c=relaxed/simple;
	bh=RCs1GWNmo2ipg03R0BGD++gwGA8LsbQbgac3hWlopYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRQt9mbmtk19GMO0ypJg50asuwTV1FhbfYN2BhxdqMJ01EHyGYUpx0KEgVLAAinPviNIsg5vOJBxNXOhWjMb4y4Dl45H1FVk+FtFj9mrZD5pCHLmmbZ5TbIr7K9Mt4mfw74NiQWU8YSaCHOdHSLly7eUpzW6/9D5uD+kg547aq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp78t1724747505tfu84fb5
X-QQ-Originating-IP: 60TLbpSWLEnb1Mud7G2zmJ+3WQDRIU66YlwPon5cIO8=
Received: from localhost.localdomain ( [101.71.135.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 Aug 2024 16:31:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 705568570378139875
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: stable@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] net: ngbe: Fix phy mode set to external phy
Date: Tue, 27 Aug 2024 16:31:30 +0800
Message-ID: <600F7E75858E218A+20240827083130.94093-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082635-dislike-tipping-1bee@gregkh>
References: <2024082635-dislike-tipping-1bee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

The MAC only has add the TX delay and it can not be modified.
MAC and PHY are both set the TX delay cause transmission problems.
So just disable TX delay in PHY, when use rgmii to attach to
external phy, set PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
And it is does not matter to internal phy.

Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/E6759CF1387CF84C+20240820030425.93003-1-mengyuanlou@net-swift.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit f2916c83d746eb99f50f42c15cf4c47c2ea5f3b3)
Signed-off-by: mengyuanlou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index 591f5b7b6da6..5007addd119a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -215,10 +215,14 @@ int ngbe_phy_connect(struct wx *wx)
 {
 	int ret;
 
+	/* The MAC only has add the Tx delay and it can not be modified.
+	 * So just disable TX delay in PHY, and it is does not matter to
+	 * internal phy.
+	 */
 	ret = phy_connect_direct(wx->netdev,
 				 wx->phydev,
 				 ngbe_handle_link_change,
-				 PHY_INTERFACE_MODE_RGMII_ID);
+				 PHY_INTERFACE_MODE_RGMII_RXID);
 	if (ret) {
 		wx_err(wx, "PHY connect failed.\n");
 		return ret;
-- 
2.25.1


