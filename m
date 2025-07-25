Return-Path: <stable+bounces-164759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BEAB122CA
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 19:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDE5AA7FA1
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA912EF9C9;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIO8TXGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197CC2EF66B;
	Fri, 25 Jul 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463655; cv=none; b=npZuVUtejpZYPY4S4OE/l3O2qAOl1M5KgcENVSj+CJAlJnB/XzWgRVWy9fKcwYdWTJcD9X3qeYOZrWKv8lNWiq9LQqTyYNfgSuATCluCD8XqqiLVWQe4tzV8UqeobQhREshMOryiC9dVHKPG8VfSvitsOrtEYpFVWrg0OpTDrWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463655; c=relaxed/simple;
	bh=96RWDqAwsQ+BNNMMv40laI84yj5UkISKimL0LLvCq9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXNr84fBEPaxvAVChoYjqMkW+apNHdxkcWeZ1fUYPkVMksYPvntDsW8WMvciq/g2y0sKP7x1HcnnC6+tZaUgDX8OF4qVI8nsThbR/2gHaMdBzrhSLM9DCU7cnJgpEbDJuI2OwwUn62G7+dHAsvmau3S+n5kwYij7T3ATR1EsG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIO8TXGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B2AC4CEF9;
	Fri, 25 Jul 2025 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753463654;
	bh=96RWDqAwsQ+BNNMMv40laI84yj5UkISKimL0LLvCq9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIO8TXGe6al3/A2gMYESXZ67JW/eECXSwJ+fJR1BE6I8/xhxqbJaiwexsEKJvh2wb
	 YOs4Laf2/rwRTcV8Prp6A24/J5KPrMwrOCH+elBTuwm0EcXrffvHZLZnDrRSgCy9rt
	 clqLWgyn6Fe91EFC3uOf8p6ge5VbGmivvBqpXWQjJM8fr7wrb7u0lf6U2zvoF3nFjx
	 B17R4ANRP6qqyrq1OJeua5hpqM8ShV+LtlI4zP8TKetqAf+y7FFgJVlzvCdxkPWDEe
	 QltpyNhfiGF0gIpSeeWLoEL84HygEaUjwA2duTcc2/5mXmxtQDobdOI1zYFUZLUdo+
	 jvRYqHKbZsIzg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufLzn-000000000Gj-2DbO;
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
	stable@vger.kernel.org,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/5] net: dpaa: fix device leak when querying time stamp info
Date: Fri, 25 Jul 2025 19:12:09 +0200
Message-ID: <20250725171213.880-2-johan@kernel.org>
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

Make sure to drop the reference to the ptp device taken by
of_find_device_by_node() when querying the time stamping capabilities.

Note that holding a reference to the ptp device does not prevent its
driver data from going away.

Fixes: 17ae0b0ee9db ("dpaa_eth: add the get_ts_info interface for ethtool")
Cc: stable@vger.kernel.org	# 4.19
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 9986f6e1f587..7fc01baef280 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -401,8 +401,10 @@ static int dpaa_get_ts_info(struct net_device *net_dev,
 		of_node_put(ptp_node);
 	}
 
-	if (ptp_dev)
+	if (ptp_dev) {
 		ptp = platform_get_drvdata(ptp_dev);
+		put_device(&ptp_dev->dev);
+	}
 
 	if (ptp)
 		info->phc_index = ptp->phc_index;
-- 
2.49.1


