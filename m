Return-Path: <stable+bounces-150124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30259ACB620
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26EA54C40B6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1C1E3772;
	Mon,  2 Jun 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cT1LROmk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E922540F;
	Mon,  2 Jun 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876110; cv=none; b=SGok828WqcMnIIWQsuS6n2Ma6S7kD6jzmp6FQoCnPggDg8dQeo05P5k2P7q5uqXpj1uv2nuleVqC0z9CBGnxPuYUkJQ/UgEwSFAZXE50W7qHio4uuq2HsQDG4cFVaW5Rx4Vtr34j02d7bobv+8vJ/7lHt3ao2+vBpc1uxvjKWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876110; c=relaxed/simple;
	bh=TOAchiHbLl5hYlScoE9XG5I/lqmoT9APQ4E1/fNUJLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRyWK6PZ1GaMlkE2fqJIh0r+hoRomAwac0qU10rl193/PVScYpcNXRjl+J4PAr/cUzwgsWDA9srfBGXgN3xj+Zas+bcJ1hpIAnmslC5ynz+HKAvHg82Jfv7hTpRHzF0TE1dA2rrwz+FlDk8gUM1NVw8GQdwaVf/vT3ajODu+9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cT1LROmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40248C4CEEB;
	Mon,  2 Jun 2025 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876110;
	bh=TOAchiHbLl5hYlScoE9XG5I/lqmoT9APQ4E1/fNUJLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cT1LROmkKEBfuwcNpJY7kIWc+zJhrr4b/dOGi2iD3swLcPsccq0lvEAdHtD+96w05
	 pVy3gallLaFb/ceUqjM2qcWQ9fNz8+iOwkA9Eji4XUoNiVW9jOgWyyFz4d5iEcsYD8
	 xQvmURs6p16JYUBGB+sC4Om/+DrPRMhPrWqYxix0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 074/207] net: ethernet: ti: cpsw_new: populate netdev of_node
Date: Mon,  2 Jun 2025 15:47:26 +0200
Message-ID: <20250602134301.636390457@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

[ Upstream commit 7ff1c88fc89688c27f773ba956f65f0c11367269 ]

So that of_find_net_device_by_node() can find CPSW ports and other DSA
switches can be stacked downstream. Tested in conjunction with KSZ8873.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Link: https://patch.msgid.link/20250303074703.1758297-1-alexander.sverdlin@siemens.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_new.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 13e34ad72f265..923746ba87a61 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1418,6 +1418,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		ndev->netdev_ops = &cpsw_netdev_ops;
 		ndev->ethtool_ops = &cpsw_ethtool_ops;
 		SET_NETDEV_DEV(ndev, dev);
+		ndev->dev.of_node = slave_data->slave_node;
 
 		if (!napi_ndev) {
 			/* CPSW Host port CPDMA interface is shared between
-- 
2.39.5




