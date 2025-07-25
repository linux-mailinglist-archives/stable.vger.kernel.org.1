Return-Path: <stable+bounces-164761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EB9B122CE
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F7E5808B5
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4052EFD88;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIrc1znd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE852EF9A9;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463655; cv=none; b=I+kounJ2ruUlIxbQP0C+0yfR4AgSeB9eKfa2ngEUqSjjZuzL8HQoe6acGOyBM2nkjzL5Rrr08HHbF90NiMu/kun2uMWyvL1wrlkY2zxLiddfNpxce38b8WVdlx3LNZVuy9YG8ho4btOEQHL3OJf9FGXVmgkgIRFcz4dBYhFaELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463655; c=relaxed/simple;
	bh=cCDHT3cnmuazKqCtjc+IW2jQ2SASLoMsrlCNSn0tgww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFUf089swU8E9y/XADVzGdsehAWlFLvRTnddwVN4rvlwcppv27FNNGXG800j7LtC3BqA7/FETvL0NA5DT+xgTSY07CrBjR7Fy8z58FXO8mt61C9kTTJhIj6R7sCN3hyWUWXXmRIr2Rrap2Ls8R6ZzxFmGG7+qul3MYdoCpJpwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIrc1znd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04235C19421;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753463655;
	bh=cCDHT3cnmuazKqCtjc+IW2jQ2SASLoMsrlCNSn0tgww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIrc1zndoSUNRw7WQ5z4QlFcTrhfDr6rsT9Gla7l61iov06QI+H/BesipknkgOFmw
	 3t6wvTmqzgfo2RdUvbKbJfIGXxq/DaCRJL+QAPjkSuHdVXChcY6AkvBIq5CJ2sxPmM
	 J3qbDPMz8qwSp7NRxZ0gnFCUSZnB2KuJDTywUz9ZNSLmMeZfxL2niG/I5nPQI6pKsG
	 lTBjMSmBtG20FhhX4/AiPUqD3+TO2BBA+xwBSCk7N+sszjAVlJudcjaobIaHsWvPVY
	 kzZOD+fRde/w+P5zO7hdqeJSuMiqmDvb4Y06xBoVFZ6GM7xBYCc5bjn9z56AFpgXm8
	 VpPSGSAmqYWfw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufLzn-000000000Gr-3csz;
	Fri, 25 Jul 2025 19:14:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] net: ti: icss-iep: fix device and OF node leaks at probe
Date: Fri, 25 Jul 2025 19:12:13 +0200
Message-ID: <20250725171213.880-6-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250725171213.880-1-johan@kernel.org>
References: <20250725171213.880-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the references to the IEP OF node and device taken by
of_parse_phandle() and of_find_device_by_node() when looking up IEP
devices during probe.

Drop the bogus additional reference taken on successful lookup so that
the device is released correctly by icss_iep_put().

Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
Cc: stable@vger.kernel.org	# 6.6
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 2a1c43316f46..50bfbc2779e4 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -685,11 +685,17 @@ struct icss_iep *icss_iep_get_idx(struct device_node *np, int idx)
 	struct platform_device *pdev;
 	struct device_node *iep_np;
 	struct icss_iep *iep;
+	int ret;
 
 	iep_np = of_parse_phandle(np, "ti,iep", idx);
-	if (!iep_np || !of_device_is_available(iep_np))
+	if (!iep_np)
 		return ERR_PTR(-ENODEV);
 
+	if (!of_device_is_available(iep_np)) {
+		of_node_put(iep_np);
+		return ERR_PTR(-ENODEV);
+	}
+
 	pdev = of_find_device_by_node(iep_np);
 	of_node_put(iep_np);
 
@@ -698,21 +704,28 @@ struct icss_iep *icss_iep_get_idx(struct device_node *np, int idx)
 		return ERR_PTR(-EPROBE_DEFER);
 
 	iep = platform_get_drvdata(pdev);
-	if (!iep)
-		return ERR_PTR(-EPROBE_DEFER);
+	if (!iep) {
+		ret = -EPROBE_DEFER;
+		goto err_put_pdev;
+	}
 
 	device_lock(iep->dev);
 	if (iep->client_np) {
 		device_unlock(iep->dev);
 		dev_err(iep->dev, "IEP is already acquired by %s",
 			iep->client_np->name);
-		return ERR_PTR(-EBUSY);
+		ret = -EBUSY;
+		goto err_put_pdev;
 	}
 	iep->client_np = np;
 	device_unlock(iep->dev);
-	get_device(iep->dev);
 
 	return iep;
+
+err_put_pdev:
+	put_device(&pdev->dev);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(icss_iep_get_idx);
 
-- 
2.49.1


