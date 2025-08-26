Return-Path: <stable+bounces-175329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4DBB367B6
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1305803D8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524BF2BEC45;
	Tue, 26 Aug 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uVB80F6A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3761341ABD;
	Tue, 26 Aug 2025 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216748; cv=none; b=GhUoZkyr+uuLnxhdh4HOV6vPtE4YmhdMd2jmHeG9XmD4axNS37r9WeC0HuWXuphQl2/0Xl8M5DlU1F1HR0IP4WNhUoIuRA0sTgTXuOTHyQM4fUiEisYnd3nG4vH22NKmjgW4C+LhE7yR79ZXYq39G7dWi5V68xxODeU3F7BhS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216748; c=relaxed/simple;
	bh=aPQwKdzhGFFhER0+PtTE6+uR+GyOgC7lQ18kIyWTPpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3NpuTyl6n8QoLi+7Pkr2qlcWAqhE8EpoidpmuL5aqkWdoSiJD/jyUr/89Y9GmDafN42VIplw7w/BhyBXuzGy4dyc48VIf8txmJQ6ZrWuBu9eJQkNR8HO+qRd87NCnYpx6EyMN+8ea6o6IUmPnhwVT9UgA42ZRre+tD2Q5VJu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uVB80F6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E83AC4CEF1;
	Tue, 26 Aug 2025 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216747;
	bh=aPQwKdzhGFFhER0+PtTE6+uR+GyOgC7lQ18kIyWTPpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVB80F6AVVKHsp2Ln5zSHc+S5uSM6D8zhtFRJjQ8t+BkX90tv/lnx269Rl8xUXQ+N
	 2Sz/m0dsOhIxUXO0RCrfy3vB0VjNKv2PEZKaADTzowPY2pB7EJhzOOzQoVWS2FOz9t
	 jVIkTynjo2hvXojwuddZqp+mxV9BNtt7GwXSInT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Johan Hovold <johan@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 528/644] net: enetc: fix device and OF node leak at probe
Date: Tue, 26 Aug 2025 13:10:19 +0200
Message-ID: <20250826110959.595470034@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1206,6 +1206,7 @@ static int enetc_pf_register_with_ierb(s
 	struct device_node *node = pdev->dev.of_node;
 	struct platform_device *ierb_pdev;
 	struct device_node *ierb_node;
+	int ret;
 
 	/* Don't register with the IERB if the PF itself is disabled */
 	if (!node || !of_device_is_available(node))
@@ -1213,16 +1214,25 @@ static int enetc_pf_register_with_ierb(s
 
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



