Return-Path: <stable+bounces-169816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88937B286BD
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 21:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C811CE34D0
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6876F2288D5;
	Fri, 15 Aug 2025 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BemAIFzd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761A13FEE
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287660; cv=none; b=Z1N/dQIZroDChCL5qhfE5JMpA+z6W/N8+XTN6YwwE1mzZq61xq8iEYIRw93OofjQ7BiF1peOdKuuDKZ9oCv4jvxdt8TNkgDSC4c1PvPIBFP25rEisDabnDXghxVu6y4rBMdW2UsvaZGzGs2PPYnLqzQUudlulCyaUQDmxnBE+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287660; c=relaxed/simple;
	bh=rBXYt/EmK8ff4xZheNyolrU/ZsTO7nxfeEWUT84T7tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXuDKWqkNXOofV+39bx/6s01gMMWrv2V0sMcZVj4npAGOJirp7C59UIs07ZPH+2KrbvsDf7ym+L6v/jWNppZFnk7mSyf8XoufGdV28fLMo7sVDljCf0mBPy20nUIUj67gFVSWTmoWLHBodlj81lciDwsnNn9/q5nPrG1lDbRxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BemAIFzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EFAC4CEEB;
	Fri, 15 Aug 2025 19:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287659;
	bh=rBXYt/EmK8ff4xZheNyolrU/ZsTO7nxfeEWUT84T7tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BemAIFzdNIBmEV2gnuUImHttnPajswQllU4MAjeQ0Ib3JyIlneZCcoph3C8knesth
	 VzDnyjG7QntHy4FLvyX1zpysVM8lg2WaUSSec9wAo1OOGmZ/v+VhtqHera8WNZZs8b
	 mwNAGvZ6bY6H9r23u94/4WiwUSoKtXYH1ks4W7yGXhoyAd8k4KGHCfsfIADUJIJHw0
	 HYLQEW+fdh7a9TJk216f40iPZv4zEsysFA1oeNC2VZ4JnV0VbUmZqSlhYudxbOBa7t
	 9PdLMcyAcNpE63m9sDG/izH8PKjhJ22UABe6JJD4kVX67O/WK8dqzhXGqQNlGlodO8
	 /givBhvXGaMIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: enetc: fix device and OF node leak at probe
Date: Fri, 15 Aug 2025 15:54:16 -0400
Message-ID: <20250815195416.198795-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081556-icon-nursing-ee42@gregkh>
References: <2025081556-icon-nursing-ee42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 70458f8a6b44daf3ad39f0d9b6d1097c8a7780ed ]

Make sure to drop the references to the IERB OF node and platform device
taken by of_parse_phandle() and of_find_device_by_node() during probe.

Fixes: e7d48e5fbf30 ("net: enetc: add a mini driver for the Integrated Endpoint Register Block")
Cc: stable@vger.kernel.org	# 5.13
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250725171213.880-3-johan@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index bdf94335ee99..b84d5a66558a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1207,6 +1207,7 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct platform_device *ierb_pdev;
 	struct device_node *ierb_node;
+	int ret;
 
 	/* Don't register with the IERB if the PF itself is disabled */
 	if (!node || !of_device_is_available(node))
@@ -1214,16 +1215,25 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 
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
 
 static int enetc_pf_probe(struct pci_dev *pdev,
-- 
2.50.1


