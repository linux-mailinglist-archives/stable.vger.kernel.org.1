Return-Path: <stable+bounces-163605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA369B0C7B8
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED4B3AAA5B
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555632DEA67;
	Mon, 21 Jul 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBop5EWm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD071ADC90;
	Mon, 21 Jul 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112217; cv=none; b=i4pdSHa+7WLeIC7MhA1oB+rnaW+VvB3UOXpi+yOAVl3688p7N/Q5sHVol9ssDNwXBDo56ziXpVEuz2STV0CULu4BHMk13DzhDvB4rv1GU1L0lwnYGM/gkbKGHK1liEXhGpVy0YNCtnbV5tnUDkfh2CxrJe9VZv8JIaFoJd3D+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112217; c=relaxed/simple;
	bh=zxoeM+AI8QziYunKUu9GbEUPVSVeqvBaUFHxaPVVke4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp9AYLHlH1BWrrlqga0TUqjIUxISIkgmbLcS5mYDQSo6xjTDSL+9Ax6VjrvSJSWoAFiLreLzAkpspMSUX0YbM9BeFbGJPaBcOcheySudfyHL25ePPEfJLdPBQtpbUXAZWGdQEK2OUASuOOzk1Tfpj0k/zhBh2GCyxd87QzJg4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBop5EWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D600CC4AF09;
	Mon, 21 Jul 2025 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753112216;
	bh=zxoeM+AI8QziYunKUu9GbEUPVSVeqvBaUFHxaPVVke4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBop5EWm6ZdCtmYtxJXx0h1kFdiRcr0j5nfe8ki7tEdKioXsp2wdBOnaI6FBOPt1C
	 kl0Qw02BarnHZaLDM0sYyzyT57e9Yy6ykB2DYGzmy4j4s2YTuk+24KYXuloIANSy/f
	 diQRsWkl70v5zZvUYfVKyFq79RAsBDPUTxx6rUoiZVer5IT8zryT73TqHVJ5o1jEEo
	 7PXvwSU107ADXxj2gP1kw5OTFjXnmAuvHLf2f20hm15QHv4S1RwOaCFKI4cA+JIWBe
	 EXDLWDVKAYw9dPgrbxogQtiqjb1QfLyLNXZybHKFY8LL31TA0lTqYn7gq3HWyPqQdv
	 YSun25UlMsdBg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1udsZK-000000002Fh-18NF;
	Mon, 21 Jul 2025 17:36:46 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] PCI/pwrctrl: Fix device and OF node leak at bus scan
Date: Mon, 21 Jul 2025 17:36:08 +0200
Message-ID: <20250721153609.8611-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250721153609.8611-1-johan+linaro@kernel.org>
References: <20250721153609.8611-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the references to the pwrctrl OF node and device taken
by of_pci_find_child_device() and of_find_device_by_node() respectively
when scanning the bus.

Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
Cc: stable@vger.kernel.org	# 6.15
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/probe.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..c5f59de790c7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2515,9 +2515,15 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	struct device_node *np;
 
 	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
-	if (!np || of_find_device_by_node(np))
+	if (!np)
 		return NULL;
 
+	pdev = of_find_device_by_node(np);
+	if (pdev) {
+		put_device(&pdev->dev);
+		goto err_put_of_node;
+	}
+
 	/*
 	 * First check whether the pwrctrl device really needs to be created or
 	 * not. This is decided based on at least one of the power supplies
@@ -2525,17 +2531,24 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	 */
 	if (!of_pci_supply_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
-		return NULL;
+		goto err_put_of_node;
 	}
 
 	/* Now create the pwrctrl device */
 	pdev = of_platform_device_create(np, NULL, &host->dev);
 	if (!pdev) {
 		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
-		return NULL;
+		goto err_put_of_node;
 	}
 
+	of_node_put(np);
+
 	return pdev;
+
+err_put_of_node:
+	of_node_put(np);
+
+	return NULL;
 }
 
 /*
-- 
2.49.1


