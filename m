Return-Path: <stable+bounces-165029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49FCB14746
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 06:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F081B4E03A6
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 04:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C7C230BDF;
	Tue, 29 Jul 2025 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnq8IlCH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCEA22C339
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753763341; cv=none; b=ikJ9fLJHD64dVBR7yo9OwDYQw36Tfq40mIyAVT9+efzGeAk84ruRfc22EX5gtwCvGv3Svrc395gNUoPleMStOjAmFSyMM9nzKwZ68P7fN+fgZ+aiqOdc7jZ0XrLSP6LpnqkVGxTjQqWjOym96u9XbOrC/1NurxbmLU0t8TNWLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753763341; c=relaxed/simple;
	bh=6f4NWD4YWEEq/KJZGsFSVe723HmycYwpfN7d5cpVXCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrKo716VVXbBSQCI5WoXQaPwJQvSbhPB9w2ASh4M2LIq/woLeH7z3CksN6nRG74EZCb4MXkiQjxOabbfLYdxkJhcAYcd0sPhKkjqgrDjRR7aodC1zVVwsys1SM32LDqDsTn2tDdldovnn+EUBqcr6xmTagVyukQlGiXUjYYbKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnq8IlCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEF3C4CEEF;
	Tue, 29 Jul 2025 04:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753763341;
	bh=6f4NWD4YWEEq/KJZGsFSVe723HmycYwpfN7d5cpVXCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rnq8IlCHPJV8u95c59NSGfInT6a/ZqvuJ34T2Yd3sPkPQAZmp65QntgMxBYBt3YAS
	 mkXmhNL29lTzlyIBUYMROpwEsPwdRnbajXaFM36TpTb5kFvY7d0BLM8oZvk3hIfkKH
	 nKUa2G3iPcyCDf7gS7lkN+qDaiHq/MbKLrBdRu5NYMUXhNFw2zCkD3uXOTFdctIr50
	 Wnc0tGPt6QeYE9UkfRkftM+759QjZ0kH8FqflLEHY6xEOWTCPPyTjUkEnhuPYDkH9p
	 nflJ2aS5H6J8yWs3uJgueKox/VdPT2rnI7WwcvAsSu/yT6ZaMKNrKzg1bnwikGM42E
	 BV8Z4b9SSwI8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] dpaa2-eth: Fix device reference count leak in MAC endpoint handling
Date: Tue, 29 Jul 2025 00:28:53 -0400
Message-Id: <20250729042853.2357022-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729042853.2357022-1-sashal@kernel.org>
References: <2025072840-quickstep-spiny-0e80@gregkh>
 <20250729042853.2357022-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit ee9f3a81ab08dfe0538dbd1746f81fd4d5147fdc ]

The fsl_mc_get_endpoint() function uses device_find_child() for
localization, which implicitly calls get_device() to increment the
device's reference count before returning the pointer. However, the
caller dpaa2_eth_connect_mac() fails to properly release this
reference in multiple scenarios. We should call put_device() to
decrement reference count properly.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 719479230893 ("dpaa2-eth: add MAC/PHY support through phylink")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250717022309.3339976-2-make24@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 9338a7d31545..0a1a7d94583b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4138,12 +4138,19 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 	if (PTR_ERR(dpmac_dev) == -EPROBE_DEFER)
 		return PTR_ERR(dpmac_dev);
 
-	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
+	if (IS_ERR(dpmac_dev))
 		return 0;
 
+	if (dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type) {
+		err = 0;
+		goto out_put_device;
+	}
+
 	mac = kzalloc(sizeof(struct dpaa2_mac), GFP_KERNEL);
-	if (!mac)
-		return -ENOMEM;
+	if (!mac) {
+		err = -ENOMEM;
+		goto out_put_device;
+	}
 
 	mac->mc_dev = dpmac_dev;
 	mac->mc_io = priv->mc_io;
@@ -4169,6 +4176,8 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 	priv->mac = NULL;
 err_free_mac:
 	kfree(mac);
+out_put_device:
+	put_device(&dpmac_dev->dev);
 	return err;
 }
 
-- 
2.39.5


