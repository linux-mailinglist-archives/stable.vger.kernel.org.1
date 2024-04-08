Return-Path: <stable+bounces-36887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF4F89C260
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5BFB2A524
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA14811FB;
	Mon,  8 Apr 2024 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gwiz/1FL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADE6CDA9;
	Mon,  8 Apr 2024 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582632; cv=none; b=gofwtluVhsRMfKAO8w6dTpkSGaV7RAlShJe7brnpNdFE/4yVrgwG3Rpz5bmgqfnQaRPwg3a85icm/7QSAnnJ1hT6oKG9fYSvoy7/NmdPQY7oU6VrB8o4HyqA51xjHQbA0rqRlWqzbb4OEcpfEfpn0W6La7eO01SCcy2ALLbT9i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582632; c=relaxed/simple;
	bh=rKLPAaK3kW41F2/Mbgoe73+5rH9LInkzF1CXuG8tjj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSBDVIm07chbq5WD3SgAY1QbhEWR/9LBBCF2n+DGiT+4IeTZ0rBq2fmCm60VZi8wcrxHD1jMNtCzrwF/heEwOkUAY/3SIXQ6VHRXh25O9xLJfNqNE7ZDURqQW++WpEQaQOns2leD3c0XJ2EMlnPqeN7oA8azBUDcbqZwOGt3f04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gwiz/1FL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E69C433F1;
	Mon,  8 Apr 2024 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582632;
	bh=rKLPAaK3kW41F2/Mbgoe73+5rH9LInkzF1CXuG8tjj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gwiz/1FLoIlaxtFs/7AmeJoTbV5hb6L9YvzbM5lgZEgvV91EWMhvhd1Y7IIGWCuwp
	 JjiQvmJB1VYoPOmXwHs3kG0X1Uhe804wZZMPof+O+9OXi0nqfvYaGK7hUoRlnRRvvD
	 hJIByDQZ0YkV7UbqAEyYUB14w/DwTrUrCG4nBDJA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Duanqiang Wen <duanqiangwen@net-swift.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 108/252] net: txgbe: fix i2c dev name cannot match clkdev
Date: Mon,  8 Apr 2024 14:56:47 +0200
Message-ID: <20240408125309.994317719@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duanqiang Wen <duanqiangwen@net-swift.com>

commit c644920ce9220d83e070f575a4df711741c07f07 upstream.

txgbe clkdev shortened clk_name, so i2c_dev info_name
also need to shorten. Otherwise, i2c_dev cannot initialize
clock.

Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
Link: https://lore.kernel.org/r/20240402021843.126192-1-duanqiangwen@net-swift.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -20,6 +20,8 @@
 #include "txgbe_phy.h"
 #include "txgbe_hw.h"
 
+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
+
 static int txgbe_swnodes_register(struct txgbe *txgbe)
 {
 	struct txgbe_nodes *nodes = &txgbe->nodes;
@@ -551,8 +553,8 @@ static int txgbe_clock_register(struct t
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
-		 pci_dev_id(pdev));
+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
 	if (IS_ERR(clk))
@@ -614,7 +616,7 @@ static int txgbe_i2c_register(struct txg
 
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
-	info.name = "i2c_designware";
+	info.name = TXGBE_I2C_CLK_DEV_NAME;
 	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);



