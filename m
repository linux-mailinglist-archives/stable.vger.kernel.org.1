Return-Path: <stable+bounces-109389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E324DA152A0
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CAD189038F
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E69189B86;
	Fri, 17 Jan 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYQLinn1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B513CF9C
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126996; cv=none; b=YoDmANUiZJBreYC4WVXzUcGF1xKGsjkyiATbZisFJwp9H17+pfOrKdsSnOky6cZ6gxbQqexlBGTdLta8L3eRId/fPinXZFMBHcma+9lQ+3QW3Z6igO/snQ/UoiO9VVAPZocFzXkEugmxplOWNe+yRtX08UzZ31jdHQ2OMQTx7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126996; c=relaxed/simple;
	bh=gAN6RUX0qhMDYM+eSdv1hJN6UhUBaAT+wWjdLTOqhCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aMs66ycGeXef+mqRjWfqLMDCJ83FU6bdg6nLBgoo+PiCulcf+GTugtwfi/xfVae21fnHCwAMnTDuf+eGm8er+xGDcmJV6/NnUBYFb82eB6AOhTnvDM/CGKM7MpCU7fjhzYPFUb75rJ+or2Blr4+UHEBCF18vm4lHhaYwjZ4/jEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tYQLinn1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38637614567so1103334f8f.3
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737126992; x=1737731792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZHjkl0fKIl5YQZmPXAKiGh8ww6uDO31dSv9UXTiDTY=;
        b=tYQLinn1KO3O+UAcI+U+1IjB62odVGZ7RK2Bz4FzReFqvX2yjUf+zpF+jKJguBeO5C
         zJEjfs9II4w1+19eeKWUEl/xmlZkX7RcRotdvx/mfCSKHDbrRBRSFTUCiJY8mY9tqmPe
         noJR72fJhI8Zw5T9OQefMXWSjEcA9pb7XCMCZdc13gkAO5dIKOvEX5GE4mdyUFKFzj7H
         ygvUf2wWTpbmRfHok5kh9vWGZxbetvkAztFUXDK3ngvbQn74zPKX1dzPDJEVDxgaW7Nd
         9KC/9fcAStdqR30/rH8zJeL3KJBsaIZb2dHIJRPUa6NBW9cXYHyp/RW52AVvEnWXJEAX
         2qEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737126992; x=1737731792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZHjkl0fKIl5YQZmPXAKiGh8ww6uDO31dSv9UXTiDTY=;
        b=eiptdcoeJ/Jtk0Stq46vUARTCynmBTeCZZwMnfsdxNBcOPDHIEcHxl14fpj8+Yw0M4
         VDZmj/yEOPt9WZXy41Wdvl6YM9hqroUTCkDssyMTqSB8f9l3RysfAX93LbhlkKspQWTL
         B5ihb5EzcHLthWwq1dg8vqACQ+4sqxzSNseCDh7+wzLOP7XGABgh3kuTIaVqyxaxAg+u
         k39wUZXkUlrk3K/zHWCnD/KHPEM0F8PYSW8yy5hw15sicmwmSVOV1cAz7CcDWhlZq2Fd
         Sk2JFkYCcHznTk7yboBpciULgAprzN3gxHzY7EI9V299ZweEqyoYaodj0joBs2azLFUE
         ed5g==
X-Gm-Message-State: AOJu0Yw1zvW4Tl11OSuKPSkLdr9Xan/pLculrxVw+HSpu7p4u+VWsKDp
	RIOvR5UDpe9i90fI0NfJwYGOaGJkaiYPFdpVyiElvj0YfItgNPUtu/UO6uYkD+vEIbdsycP8XbY
	C
X-Gm-Gg: ASbGncv1qGzDFRqvtgeOlSCsRvpD/cY6ehfbhXpLee49ABD5HZyqd/b+1KzavYZx3Iq
	vnVQaG6lwRH5FV/TfFyOg6T3yRz2GXETcVsadh8cR0GPnvn3bOhHwK+cI9clF7y88VSwtYeoCnB
	v5OwMRXqmQdNUaRbi+YQ5RiWpZgzC8kBmBmHPmUCcQ+VzvH3JCK02R+XAztnYw/8BEZHZ4BVrMG
	x5n/xeQu2hHH3y2UAqYY03L6WjUpREBt/87DfYGBi7YfmU8gsk5fM9Q+hZQ4StiLt8AeLgfcG3o
	ET5UqCJ/6IohN2KhZ2L7UZIZStNFTtClCJxvksWDzNUDvQq9vWidkWsdO/IuIoKN
X-Google-Smtp-Source: AGHT+IHi33ct+4itT5d/oQl1Vb29/GD9dcCpC4Ik+jEr39q00ocknSRoR61qL18U3dBn2P0w1fzjng==
X-Received: by 2002:a5d:508d:0:b0:38a:673b:3738 with SMTP id ffacd0b85a97d-38bf5688e01mr2649306f8f.33.1737126990909;
        Fri, 17 Jan 2025 07:16:30 -0800 (PST)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-169014-cust557.vm26.cable.virginm.net. [82.47.146.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74995f6sm98262995e9.1.2025.01.17.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:16:30 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: stable <stable@vger.kernel.org>
Cc: Terry Tritton <ttritton@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Verkamp <dverkamp@chromium.org>,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 5.15] Revert "PCI: Use preserve_config in place of pci_flags"
Date: Fri, 17 Jan 2025 15:16:25 +0000
Message-Id: <20250117151625.6429-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit c1a1393f7844c645389e5f1a3f1f0350e0fb9316 which is
commit 7246a4520b4bf1494d7d030166a11b5226f6d508 upstream.

This patch causes a regression in cuttlefish/crossvm boot on arm64.

The patch was part of a series that when applied will not cause a regression
but this patch was backported to the 5.15 branch by itself.

The other patches do not apply cleanly to the 5.15 branch.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 drivers/pci/controller/pci-host-common.c |  4 ++++
 drivers/pci/probe.c                      | 20 +++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index fd3020a399cf..d3924a44db02 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,6 +73,10 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
+	/* Do not reassign resources if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cda6650aa3b1..dd2134c7c419 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3048,18 +3048,20 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
 	bus = bridge->bus;
 
-	/* If we must preserve the resource configuration, claim now */
-	if (bridge->preserve_config)
-		pci_bus_claim_resources(bus);
-
 	/*
-	 * Assign whatever was left unassigned. If we didn't claim above,
-	 * this will reassign everything.
+	 * We insert PCI resources into the iomem_resource and
+	 * ioport_resource trees in either pci_bus_claim_resources()
+	 * or pci_bus_assign_resources().
 	 */
-	pci_assign_unassigned_root_bus_resources(bus);
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_claim_resources(bus);
+	} else {
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
 
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
 
 	pci_bus_add_devices(bus);
 	return 0;
-- 
2.39.5


