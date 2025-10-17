Return-Path: <stable+bounces-186240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5E3BE6760
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 07:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94D914F70D7
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 05:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D97213E6A;
	Fri, 17 Oct 2025 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy53zA3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55019DF8D;
	Fri, 17 Oct 2025 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680003; cv=none; b=I8jNUmZgjoILbTZAVh+UKZkyiqM/W2iEqLR77CFp8zzqo2VHqcNDP7fA+u7H98fTd74avfpFBzOAZvh0pE/YMY0llkW+/BP2gUF2lbiQXMFhyEkZrTWsj5/BK52y9vH1HSmi8PNLLiC+n5g56N8s6TLYfPXXoFbjZ+/WfNebAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680003; c=relaxed/simple;
	bh=Cd8WJV+T0Qre6U0JnCFD9btzHPXjuOFvcMNsbRnbuXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B79guNKxcpaewpoIUnWYeyCOpD/DzVJocs9dXxW1glr9DRJBZ3QZRmIui5j0oJbNFw3ETBTZ/uPegmNLrQXdSpE+i8Wets7b0MNWCk6T6+viaebda2XvnDEnNHc+OGPHhuYH44wZ6L3HYvlZE49fJmGAVblrd2nWpyPzrNc9E2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy53zA3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA9BC4CEE7;
	Fri, 17 Oct 2025 05:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760680003;
	bh=Cd8WJV+T0Qre6U0JnCFD9btzHPXjuOFvcMNsbRnbuXg=;
	h=From:To:Cc:Subject:Date:From;
	b=Vy53zA3intR7g8oMAxuhQNRY+p4RE8H9LVZIXfZfkUF1ICV+oZZgXWqxsOsDLJGCE
	 eQK9O0RrsMQNcxxO+Pq5e8XVGpTbYXCwKi8ZxXBOEHQgJrTnT/SmpEAWZtmsEn7n+a
	 v8lYqua2pATeu0pUnPi3y0/7uT75IKYADWfqZJtsFZDP3QfswERnL//Qs/GQ5EPjxQ
	 5Ai/t48CfmF826k/8FqhIo3XeWfStBDegiNMeWfIBDgrw/M6rO6YTDKi/6BtgJns3o
	 irM1LNNkdoGjKw6/gYeblsH1O+Hz+89L2o+/QEe72j2asF+RPJfMS5FzfT4MSbA1Zo
	 CaAZ5ZRiJcmSQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v9dIa-000000001oW-3W25;
	Fri, 17 Oct 2025 07:46:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH] phy: broadcom: bcm63xx-usbh: fix section mismatches
Date: Fri, 17 Oct 2025 07:45:37 +0200
Message-ID: <20251017054537.6884-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Platform drivers can be probed after their init sections have been
discarded (e.g. on probe deferral or manual rebind through sysfs) so the
probe function and match table must not live in init.

Fixes: 783f6d3dcf35 ("phy: bcm63xx-usbh: Add BCM63xx USBH driver")
Cc: stable@vger.kernel.org	# 5.9
Cc: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/broadcom/phy-bcm63xx-usbh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm63xx-usbh.c b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
index 647644de041b..29fd6791bae6 100644
--- a/drivers/phy/broadcom/phy-bcm63xx-usbh.c
+++ b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
@@ -375,7 +375,7 @@ static struct phy *bcm63xx_usbh_phy_xlate(struct device *dev,
 	return of_phy_simple_xlate(dev, args);
 }
 
-static int __init bcm63xx_usbh_phy_probe(struct platform_device *pdev)
+static int bcm63xx_usbh_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bcm63xx_usbh_phy	*usbh;
@@ -432,7 +432,7 @@ static int __init bcm63xx_usbh_phy_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id bcm63xx_usbh_phy_ids[] __initconst = {
+static const struct of_device_id bcm63xx_usbh_phy_ids[] = {
 	{ .compatible = "brcm,bcm6318-usbh-phy", .data = &usbh_bcm6318 },
 	{ .compatible = "brcm,bcm6328-usbh-phy", .data = &usbh_bcm6328 },
 	{ .compatible = "brcm,bcm6358-usbh-phy", .data = &usbh_bcm6358 },
@@ -443,7 +443,7 @@ static const struct of_device_id bcm63xx_usbh_phy_ids[] __initconst = {
 };
 MODULE_DEVICE_TABLE(of, bcm63xx_usbh_phy_ids);
 
-static struct platform_driver bcm63xx_usbh_phy_driver __refdata = {
+static struct platform_driver bcm63xx_usbh_phy_driver = {
 	.driver	= {
 		.name = "bcm63xx-usbh-phy",
 		.of_match_table = bcm63xx_usbh_phy_ids,
-- 
2.49.1


