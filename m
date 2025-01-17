Return-Path: <stable+bounces-109391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B9A152A1
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE9F188E57B
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B51547E0;
	Fri, 17 Jan 2025 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+g9hPQp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55113CF9C
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127018; cv=none; b=RSIUb/nUN9vV5nsFcfOLekFxPBZagUjDIkmhoy7JV8T3BqsVQOxLUeeoQNMc7A4gLBAxDuyo4KyKHkykgmiyk0bdMKg3i+o3Usi9PYeBs3LeDoCVz+0PK57RK//mBxAZT1QQZ/wSr78JzUw9cg7QRNM4fxBJTguQOhHgYYsFudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127018; c=relaxed/simple;
	bh=h0X2VXvAAWi9cbt9KOEkNpn273bdUe9uS6uUDIIjfq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GyoxUmf3/tC2Emh2qT9op0vCunjTBeSwVv6fMO/O9v4bIK5/6Ik2vhlZO8lCPkmXiXBapaC7Te6dn0iLZgJicXUl79tCNvAnZvqqIrVYmdoj2i1oHN+IbCw0LH+E3nO61Zm1pFWV1WfWsZeANY+vBA9YVlJT49yfHih35eZMmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+g9hPQp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso21733795e9.0
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737127015; x=1737731815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+BrOIqxWYZt/I1FyoHZ5CmAjrJ1pDPLVkwqBRaZ+leA=;
        b=K+g9hPQpZxBU1ePE/RokaheiRsI6NByaRkxNGk+BSLW0x2UtvMNHnOgfRd0RcFQXVa
         i+S2+uW/Y04lnHoSkmEbjAappzVJMyq+qvEQUGcvMtDw/15pqWc1R9JB+af3r2tLeate
         EZDWiqInvfzXu2tzv48mICmHNkRj0SFPXDHNOxV2ivVl1xO1R26BD+L28XKvtgx3R2lw
         seX+c1AhUUdNKo9Jlo2DKrMhN4lEtBmp6pr4sKYuH4CDeK76HTTlVRFK7o8TIubzqqI4
         WzFOOZc9lL3kXiu4BVBDFiL6TEbSgvzq+F/6dbMxKQ9MCLqmiHQ89lEbSEq1MLFHCcR3
         FHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737127015; x=1737731815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BrOIqxWYZt/I1FyoHZ5CmAjrJ1pDPLVkwqBRaZ+leA=;
        b=OuW12uV9uxGUm9HVMpAsOe0NRhDDLZTywuEmil//NwkKNKAI2t8lT8Tx5EBD67J34f
         vVBhJu6CUdpusz5jhSiLySSRcXmSFv9FbTPNLCBkIy2f9g22w+jHFxJ03DGlLkgVrvzS
         /wCwsBSFsEiRvXRJpa4IRhz7ebwFHOTyBf0FoGbZ8wT7KcTrK9P6Z0RnqRPhCP+mwmAi
         QPGK8h9iI1FpaqzqkcLR4bogJ1YL1YD9VrkABC7BpIduf/i/UxBrT0/CeLldonc16AtD
         rNVeQhrA3GcNf4pCLQ3Ez05D4yPP4szrIvUF6gzeLAEfgc4zPqNSeWekYZhjSPbgtZe+
         KxXw==
X-Gm-Message-State: AOJu0YxzypU1P+8OP/DKpuWvtDSXn3PDgApbWjLwiCYI3D4TtfxkBQRs
	p16L4alQgWzdzXxbl8eYJvdIaNFO0OXfki3bo5cITYFU/xMzEMhdUl3T68h2afSWkMSKBjVAC6W
	Q
X-Gm-Gg: ASbGnctrXNh4EY7DxcqC34/J6bbTmrvqqTnvv8sxlc+24RauJU4cZ4lwTtaNZKWXAhF
	S72xjOS2wXeuHcRdZ+XG7EXOaJxFx9Fzp8erWLdh41g0BwjpTxIgUzLWs3W4kjesZNun2Ao2NwD
	t6rCgDDlKpoYrofrAhcCXU8LDnYI07kevyYLx39MN31oejJB25Zl/AV5Z328tX7pMrydtVbfyQc
	viIYt1Pl7N8yhNCATgSNjRHJvKKJ8k7tWch1J0l58V08wir610eLk8T0g3HJvRbbgEmLfJUr7e7
	ejAUf/5TzVrkPNfHWKr0FqQvY51E6gHpoxKVItSd+ooSnKMd8KenwKvFwMb5ed7p
X-Google-Smtp-Source: AGHT+IEkelJC7QndwJs5I/PDo1OBr3DYwc2EACC6EoBeYoMFRicGO+n1DDGN0VyD0A0aFEw1NlNYPA==
X-Received: by 2002:a05:600c:1c83:b0:434:a746:9c82 with SMTP id 5b1f17b1804b1-438913be56bmr34294915e9.5.1737127015267;
        Fri, 17 Jan 2025 07:16:55 -0800 (PST)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-169014-cust557.vm26.cable.virginm.net. [82.47.146.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389046b0f5sm36923505e9.39.2025.01.17.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:16:54 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: stable <stable@vger.kernel.org>
Cc: Terry Tritton <ttritton@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Verkamp <dverkamp@chromium.org>,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 6.6] Revert "PCI: Use preserve_config in place of pci_flags"
Date: Fri, 17 Jan 2025 15:16:51 +0000
Message-Id: <20250117151651.6468-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3e221877dd92dfeccc840700868e7fef2675181b which is
commit 7246a4520b4bf1494d7d030166a11b5226f6d508 upstream.

This patch causes a regression in cuttlefish/crossvm boot on arm64.

The patch was part of a series that when applied will not cause a regression
but this patch was backported to the 6.6 branch by itself.

The other patches do not apply cleanly to the 6.6 branch.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 drivers/pci/controller/pci-host-common.c |  4 ++++
 drivers/pci/probe.c                      | 20 +++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index e2602e38ae45..6be3266cd7b5 100644
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
index 7e84e472b338..03b519a22840 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3096,18 +3096,20 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
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


