Return-Path: <stable+bounces-36586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC689C0B6
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C7EB24785
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A5C6FE35;
	Mon,  8 Apr 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bmj7Ms5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA42E62C;
	Mon,  8 Apr 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581759; cv=none; b=kuy32QxSmvqGpe7OazRvzfVHwTV36/M4MEltBHHPJiEeQvjsgWh5GVEt9VFD1DTzYHeR23fJglqw4Htkl6W2Bpom/RxXuOwBbmnWmgpEr9q0FULxupv3DcC42F6z8EGh+Y+/5qCWDWczYXLqkHOoB2HooEKW3BrU4kRJkB9MXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581759; c=relaxed/simple;
	bh=uFdFnXx/mOrKDqo7gotHrdJDDSX5WEreqA52xR3SR18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiQ1oOcpzndhxdymSv69/JDLxwX8i487X89QMYo9wBWE7A/jAElXPMD6QudPQhkGs+B3xV8Y6rQe4bg64sqjQyO6PvOEpkl4FCS7sYJuS6MllGLiiia0u4lsfMuz5r3+teYnPRezkKACSaEA3oIv3GLsKMYlEdLJpCMVepws1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bmj7Ms5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65111C433C7;
	Mon,  8 Apr 2024 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581758;
	bh=uFdFnXx/mOrKDqo7gotHrdJDDSX5WEreqA52xR3SR18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bmj7Ms5QhTlVIj3uRSDBtJcBf/1LCG7BE2wxn9nrPdZEeLEJcBzApWPvff9Pu72Ol
	 v+UNhb4BZfkjVI1uoyZgy5tJSRNDttbaiyMyK5zEFYmnPvojwwkWcUxrej5Z8/35Bj
	 jDQDPpF2e0UT8YhUwNnyfc3ECxUB9edkQza+0X50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 080/690] PCI/AER: Block runtime suspend when handling errors
Date: Mon,  8 Apr 2024 14:49:06 +0200
Message-ID: <20240408125402.397461804@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

[ Upstream commit 002bf2fbc00e5c4b95fb167287e2ae7d1973281e ]

PM runtime can be done simultaneously with AER error handling.  Avoid that
by using pm_runtime_get_sync() before and pm_runtime_put() after reset in
pcie_do_recovery() for all recovering devices.

pm_runtime_get_sync() will increase dev->power.usage_count counter to
prevent any possible future request to runtime suspend a device.  It will
also resume a device, if it was previously in D3hot state.

I tested with igc device by doing simultaneous aer_inject and rpm
suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control and can
reproduce:

  igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
  pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
  pcieport 0000:00:1c.2: AER: subordinate device reset failed
  pcieport 0000:00:1c.2: AER: device recovery failed
  igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible

The problem disappears when this patch is applied.

Link: https://lore.kernel.org/r/20240212120135.146068-1-stanislaw.gruszka@linux.intel.com
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index b576aa890c76b..410fc44d79ee2 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -13,6 +13,7 @@
 #define dev_fmt(fmt) "AER: " fmt
 
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -79,6 +80,18 @@ static int report_error_detected(struct pci_dev *dev,
 	return 0;
 }
 
+static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_get_sync(&pdev->dev);
+	return 0;
+}
+
+static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_put(&pdev->dev);
+	return 0;
+}
+
 static int report_frozen_detected(struct pci_dev *dev, void *data)
 {
 	return report_error_detected(dev, pci_channel_io_frozen, data);
@@ -195,6 +208,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
+	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
+
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
@@ -239,10 +254,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
 	}
+
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
 failed:
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
-- 
2.43.0




