Return-Path: <stable+bounces-164757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759D2B122C8
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 19:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96ABE5678C9
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1812EF9BA;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZhoVzmj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9C7080D;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463655; cv=none; b=ZiahcCQnVDP1oKwEEgT/e+9nKmEaAAlAOTMpmlwOVYtOURfVVV3q/bXXHtMxSCESC8FbBCk3vpFmY0Gsr+ag2oeI/3QTRCRUFbAAnzDkSJWAMDq0vFoPpFg0jMB3Mdqe9USAL1HT2uA9bYcBVe43FmV/ROJXBsN3oSsVTuGEVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463655; c=relaxed/simple;
	bh=kqBmJJq9ufFHOESJhsjd3Onyd4cgOnDcJ4k/ti6hGV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHwdk6RdMCxncvy1FJtV7X5FDXotioJa9Xnx0XcEodVBNFsnpCxfmDwrhH0NPgQCbTh6xPltZV6H3tAJEbtv/UqjCT0F4YmOw2SvzdbmLxiATDvGbNq4w08t/SmMHYREiXE0Lw0hrX80WoIT43d16/geNkA/n9iVN2B3WYHRoGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZhoVzmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2B4C4CEFB;
	Fri, 25 Jul 2025 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753463654;
	bh=kqBmJJq9ufFHOESJhsjd3Onyd4cgOnDcJ4k/ti6hGV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZhoVzmjTGSEG/8V6D2+TCofzITuvz4FXYSXvQpgd/INthke20gvu8WcB9wS2Njbq
	 kYfrrq1G9XI+6f7vtzrfHumnzdCzR6pbNmZsiC5yr+hBKVb01QuqoLCjSwOEKkc5Id
	 tLFFM9rWCj5WvNG0yELdSU2OLdHskwAYGeHssw2VRJZYum4kWIZgwKatgIhgw8zzqf
	 /3ozk8CwEF7js2p2JtIaafdrBM9RXNkkMUsOETxXFEcKhfDYBss/1cORcvMfbh5Avj
	 aGtgFCKJP5DTGGJnWgvmzDJuF+YKFQXZlIeL91qvZrd3GhK9u5w3/wDxpw8BuJm42H
	 Ii4e3/GOR1u5g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufLzn-000000000Gp-3CXB;
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
Subject: [PATCH 4/5] net: mtk_eth_soc: fix device leak at probe
Date: Fri, 25 Jul 2025 19:12:12 +0200
Message-ID: <20250725171213.880-5-johan@kernel.org>
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

The reference count to the WED devices has already been incremented when
looking them up using of_find_device_by_node() so drop the bogus
additional reference taken during probe.

Fixes: 804775dfc288 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")
Cc: stable@vger.kernel.org	# 5.19
Cc: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 351dd152f4f3..4f3014fc389b 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2794,7 +2794,6 @@ void mtk_wed_add_hw(struct device_node *np, struct mtk_eth *eth,
 	if (!pdev)
 		goto err_of_node_put;
 
-	get_device(&pdev->dev);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		goto err_put_device;
-- 
2.49.1


