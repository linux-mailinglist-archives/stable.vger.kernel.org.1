Return-Path: <stable+bounces-34476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A1893F82
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0481F226E6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B798A47F6F;
	Mon,  1 Apr 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="beZKze9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A23D961;
	Mon,  1 Apr 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988250; cv=none; b=tgcLOoHCKuizbmcslSClOq0VwN5cRfFXixeIQ4gdSZHxkf+FFWhyiUHrYKDYxLiN3UF94kugahTwRg9ZvusvN9VMP+qMzI7Ehc5V0ZRwJyKPVR85BskJA0XGP5AWKuvr44z4nyFQkUqeSXjawwiLW+xGurMElaI79gZoLnNW9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988250; c=relaxed/simple;
	bh=XcrBkKR88ZmIqvudhM7x+kK0QTn/voCjh/puiKL2J7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRYLK7+jG3bxjWEMvdi8cs5k0jAD8GwiSH8+a0iBbWyy7o3rZQYuYkQoV5vzKjeRrc4j6G8d4h9Xy+lAbvHsf1A8kQvtL8wr/Glo6ySUuaZzIRZ5+hWnqtmOVajLOYB1B4whEFnbW7VUIoviM7+E55apr+TNZ1GablzSHU92SLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=beZKze9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8574C433F1;
	Mon,  1 Apr 2024 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988250;
	bh=XcrBkKR88ZmIqvudhM7x+kK0QTn/voCjh/puiKL2J7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beZKze9ayl7KD+YG4BGyRA50Ro/v6+4ym96AGfowpTyM71zZOdIbAOS2tlOi+yJh4
	 VliBjRhgyWqMZkzXv55OBpxAXFbYWMpgkbTpskZ4jcK8+pXMIyxxdtMEhNe2EBjdvP
	 zARoCHYyG1cpQnOcewE8pqRVMof0pGEdf5jrK+TY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 128/432] PCI/AER: Block runtime suspend when handling errors
Date: Mon,  1 Apr 2024 17:41:55 +0200
Message-ID: <20240401152556.940636192@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

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
index 59c90d04a609a..705893b5f7b09 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -13,6 +13,7 @@
 #define dev_fmt(fmt) "AER: " fmt
 
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -85,6 +86,18 @@ static int report_error_detected(struct pci_dev *dev,
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
@@ -207,6 +220,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
+	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
+
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
@@ -251,10 +266,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
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




