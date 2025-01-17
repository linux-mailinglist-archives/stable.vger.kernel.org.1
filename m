Return-Path: <stable+bounces-109390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F5A15298
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0264716B717
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7581531C0;
	Fri, 17 Jan 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+pDnT/k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527A2B9B9
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127008; cv=none; b=FqLfPRjHHi52TQYxc+3APxe2LK22TXpvBeQQpnh8eb6G1XkIB0Q0wdtcRBwBibRAnH/smvcg2/CAgc+2WcyG0bmzWjiSv1u89P96aBPEJMT+cJ3N4x25EOzL2M3mSf4Xqhn+AnPKFaCn4I8RRQ6i6+4zWyumq7L6aMQ2DS3AngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127008; c=relaxed/simple;
	bh=FECLf5DnZzHzdS4xA1l2DA8/NnzwQUFrXflkzrIMPys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CmfTWuPpsQTVoBOrKz9BhxgZ8tLENl2mK5/DG+TShL49SvrmBj6xhOtvWThrSGpjo9d+fQMVQ0EFcAMhJlaQl4FvbDRkZCDsO6J5JnZsHYCJvGG5Qkn7n2BAf1tLdX4Zw4SjBWzWlSKxRDTRwZnmC56/1Q5dfZhH9Qm34DXvo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g+pDnT/k; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso15249965e9.2
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737127005; x=1737731805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQEgBMalZFEfE3cx3caxle40n9Xjep0LLO2UYYOmIXs=;
        b=g+pDnT/kD9asUnA2UIdvpHUQO9vaigWXfBL3Kby8cY7g3ehqedC4tRp9fwuwzK4bAT
         P3RfK/JhPiDmIHgxV6hWMFTvyMe/+TvBNGfTm5pylnvw+poeO7luTQrpcc7zhQLym3Rw
         KQWTB03TBdT+VfRUO6XBoO0lbHWk6EkMNx8i8EcNRXz30YL3zmvGCb1wZkVjeeSuTFQf
         zwQdKAQP1/q6xTDSawtEDB9u7iD+i5HpAKdgDq3kiOU4sBNiYKR31ns14xm6ny62VtYP
         X9Chr4CjxXtDYbiHbI4qbm3uLtwj963TxWp8nhtCVB/ISnyaMKT058R2teGuYr/TRP8P
         RnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737127005; x=1737731805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQEgBMalZFEfE3cx3caxle40n9Xjep0LLO2UYYOmIXs=;
        b=apqNbNKldPi0F5J+OtGWD8L5Dyb+ytFZbXEoyL4tW1NlBZo4Ry3ZKkCHb21RESKzeL
         w5nglzwBy97meo+SsdyHtkqzFVao4KbbSrtNlNSY0zPMpYS3ROJdmQmbi9sv9zLyvWwp
         Vj79i1PBCpOZKV416u6d3JgFc+Xz01w4JfiKhNy9Ni2P1GH+d7Ib2PF0NvbNXwk/wmhK
         HsctxYh7Af/RjYwVHmD0KgkD1+BkBB3BJK2e5GcoldPkkjlQSM7Rf6CJhyeLNMTpbuHa
         C7NCH7OdrB4TV0z+92FeLthThUT2maMR6qfQxL19NMekSsw5rYhvm1GRHA23KHK0gQqO
         PTBg==
X-Gm-Message-State: AOJu0Yz/sXflxU1JbgGGNmWauEjE+LmZJKL1UOXP2HHTGkW5MTyWLVV6
	uLACAJ16VYL82x/jUiVWCG3tGEMDHnLpMRgRIlqQWZWL2+e9QTRAyeaXDlZZwH6+93Om0hT8IjH
	X
X-Gm-Gg: ASbGncuDZynOlZG6P9TteufVrzIs8VNrytAIbDfOC4747K7vowJnmzZN+IazHcj2qRH
	4Ebm7y0hKAnJlph6Cou+qwqiZAhRR1n48U0uyNOt5Wo3QOk2GWlUIduOfAiWe2fkVWxNGlhoSa8
	Kha7kYoIu+7ThOKCncLdN8BJlBxmj0NNqGjM8jnsmQzOowJrAXXiwbtIHIcnQ4JgQSnHSLnOoGj
	PwVO3ZZOjNa03HySb89zfUPeQNmrJV8XPodWY/lVDOXiGAa+E0Y+zOXX7L3nvHJu81QXbmNHGlR
	b7jll3MLYJRLvR052582S8CXhMThno/jZGkF+/wfqiGC62fgganm1Seuc6kK24Yt
X-Google-Smtp-Source: AGHT+IFe4i4nXs8zJ4RwNMaCwkY8DlrnpN6/Y5TNLhWoQVsTA4pO9a5SfHIqJWl1mWyORBhL9/PKoA==
X-Received: by 2002:a05:6000:178e:b0:385:fd24:3303 with SMTP id ffacd0b85a97d-38bf55c5f54mr3226655f8f.0.1737127004489;
        Fri, 17 Jan 2025 07:16:44 -0800 (PST)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-169014-cust557.vm26.cable.virginm.net. [82.47.146.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275562sm2807100f8f.66.2025.01.17.07.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:16:44 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: stable <stable@vger.kernel.org>
Cc: Terry Tritton <ttritton@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Verkamp <dverkamp@chromium.org>,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 6.1] Revert "PCI: Use preserve_config in place of pci_flags"
Date: Fri, 17 Jan 2025 15:16:39 +0000
Message-Id: <20250117151639.6448-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f858b0fab28d8bc2d0f0e8cd4afc3216f347cfcc which is
commit 7246a4520b4bf1494d7d030166a11b5226f6d508 upstream.

This patch causes a regression in cuttlefish/crossvm boot on arm64.

The patch was part of a series that when applied will not cause a regression
but this patch was backported to the 6.1 branch by itself.

The other patches do not apply cleanly to the 6.1 branch.

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
index fbb47954a96c..5c1ab9ee65eb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3082,18 +3082,20 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
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


