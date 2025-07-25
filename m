Return-Path: <stable+bounces-164758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBC2B122C9
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 19:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1759BAA7DEB
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D372EF9C5;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbaaHGfw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A12EE975;
	Fri, 25 Jul 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463655; cv=none; b=TiB4axhzzGA4XZkbk1wZ54byCUj4OD9APXQquKzjGWtbz0+CYVSkQev3jUGeApDkSqcC653RROOKHvBqSDIZl2W62CcKYcuoMe25O5HEtiu6M1SzJcOBYBC5Shfx2xGvgktzd914BEWT5P/zLC92BjanohRSLaxZCyR7W7JNhGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463655; c=relaxed/simple;
	bh=DPOgPYviBfB+YHd/zP7d5WCcSDdGAgNwqCv1/XcAoio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NigIXZtPGx+CGhrWPS5h6O9VsfcFDoEiUk9TKnI6kpvZJuWifm6pgn5BvVJO7nBokW2ugCetMHpRbS9uduDiKtTvhmwF51/u/a0iVSPeaGGjCNgmDdNimTwVuihwzpMrxjyoJseQEm0ctrfwIpM5vi4LISpMBSTwFUcZdsh7Iao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbaaHGfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A708EC4CEF4;
	Fri, 25 Jul 2025 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753463654;
	bh=DPOgPYviBfB+YHd/zP7d5WCcSDdGAgNwqCv1/XcAoio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbaaHGfwuUvzJ4UU3mc0H4B8VA77NIWevPWiNxidyDvyB+KE8ttALvA+Xl1nJRy7V
	 0hsiJAQhF+fKqRLiHP1K73YCiXd8+Od30h1tASREUj0vd50oZIV2be/a/9b0K/DW5M
	 xm8G5oyTGxM++J8QhdjeSL0X3reRfHM1xEWoKE58ZkGxtbrLDrE05uDI9kpFeTTVYP
	 0ykmWRoP1yat8vdEBsVy2wXw3qjlRRNBWGF12i5eEK8aMQI642zJs3g+JzzUJ6Xv/i
	 bkDITaAmmP5gJjs8deYXzhzyy2ljpbR8VA9jncXfZ8kFQpK7VcveWX7/qf/sTpJkKr
	 xxxKqpwpmxT/A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufLzn-000000000Gl-2XgC;
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
Subject: [PATCH 2/5] net: enetc: fix device and OF node leak at probe
Date: Fri, 25 Jul 2025 19:12:10 +0200
Message-ID: <20250725171213.880-3-johan@kernel.org>
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

Make sure to drop the references to the IERB OF node and platform device
taken by of_parse_phandle() and of_find_device_by_node() during probe.

Fixes: e7d48e5fbf30 ("net: enetc: add a mini driver for the Integrated Endpoint Register Block")
Cc: stable@vger.kernel.org	# 5.13
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index f63a29e2e031..de0fb272c847 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -829,19 +829,29 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 {
 	struct platform_device *ierb_pdev;
 	struct device_node *ierb_node;
+	int ret;
 
 	ierb_node = of_find_compatible_node(NULL, NULL,
 					    "fsl,ls1028a-enetc-ierb");
-	if (!ierb_node || !of_device_is_available(ierb_node))
+	if (!ierb_node)
 		return -ENODEV;
 
+	if (!of_device_is_available(ierb_node)) {
+		of_node_put(ierb_node);
+		return -ENODEV;
+	}
+
 	ierb_pdev = of_find_device_by_node(ierb_node);
 	of_node_put(ierb_node);
 
 	if (!ierb_pdev)
 		return -EPROBE_DEFER;
 
-	return enetc_ierb_register_pf(ierb_pdev, pdev);
+	ret = enetc_ierb_register_pf(ierb_pdev, pdev);
+
+	put_device(&ierb_pdev->dev);
+
+	return ret;
 }
 
 static const struct enetc_si_ops enetc_psi_ops = {
-- 
2.49.1


