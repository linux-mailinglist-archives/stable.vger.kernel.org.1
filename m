Return-Path: <stable+bounces-164760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB7EB122CC
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 19:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308DE5805C7
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802382EF9D5;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl1wDLS4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25E2EF66C;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463655; cv=none; b=mFAe55OI+2uPwkYKNctL8def0hM60OIbs+ciPGy58ewj/ixaVA01ljB2mrsfoTukHs2AoA4gwxP3b9nrJgSUgsKEqeaSAT7IftgX2A4yDNJVVDubGKxDOPNgyEhjOus4eXHylSVp9ry2OMPi0X/QKA0kHVdRGkdcK89cXAA/rTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463655; c=relaxed/simple;
	bh=gWZO1ES2r3jh5Yq67JXLsbmiESc165KttdqT3NHuvcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MshE3zUfl5wC318sBIjr0da3vmTw3oUh3TxudyY8nRdyOnT6cI9sI1e+ZIDBBRiu0NLLexi56Dg0iq/e9w+/VgZMkkNOGCIDm+BRvJUVBn13DOx/Ow+w8B/S04CWJbRTJuJBApg/yrzH9/M+7VJCjQRSZU2yZZDmuhOmUoQlFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl1wDLS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3B4C4CEFA;
	Fri, 25 Jul 2025 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753463654;
	bh=gWZO1ES2r3jh5Yq67JXLsbmiESc165KttdqT3NHuvcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hl1wDLS4RHtasJPd9cADa4JxDlrhcvWQECdErTzeMhnBp1xwsq+q13wvPJxhoc2kz
	 FN2URXemjnzNNmSAaGch5rdbzvWVbTuSzwqjge66PPZV4BmN8eYzzfS/+jrN7W1fk/
	 3K3gME7exeOcgJ9z1cQ259SYUbt+Eu0wV4i1675vo9wUCg9LjgykI0v64PZ9CbY+FQ
	 uGYhJbAQIksIkkGOArt7BWRWLReAr7W38T8C20KMcN/scav9OXVe7Rw18ItnxykKPV
	 Aq/usys1+lcgIM1sWxyLazT0OFKkxqrpIS+yVQRQ8zK9t5kW+BVDWQrfEcx9PN793a
	 2grxKjo+vLG6w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufLzn-000000000Gn-2s8N;
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
Subject: [PATCH 3/5] net: gianfar: fix device leak when querying time stamp info
Date: Fri, 25 Jul 2025 19:12:11 +0200
Message-ID: <20250725171213.880-4-johan@kernel.org>
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

Fixes: 7349a74ea75c ("net: ethernet: gianfar_ethtool: get phc index through drvdata")
Cc: stable@vger.kernel.org	# 4.18
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/freescale/gianfar_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 781d92e703cb..c9992ed4e301 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -1466,8 +1466,10 @@ static int gfar_get_ts_info(struct net_device *dev,
 	if (ptp_node) {
 		ptp_dev = of_find_device_by_node(ptp_node);
 		of_node_put(ptp_node);
-		if (ptp_dev)
+		if (ptp_dev) {
 			ptp = platform_get_drvdata(ptp_dev);
+			put_device(&ptp_dev->dev);
+		}
 	}
 
 	if (ptp)
-- 
2.49.1


