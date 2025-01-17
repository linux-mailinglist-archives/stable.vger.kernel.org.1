Return-Path: <stable+bounces-109388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCBCA15297
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1440E3AE21F
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1954313B288;
	Fri, 17 Jan 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nx28BoYa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA413CF9C
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126980; cv=none; b=J/q+JjiDIpKcWp0ZWHCYXIXSGQyoTc1UDOq8ZKEpFAcfsD1w92Sib+ZP6sKe4LB8gLHxjk2VyR8SNSIm4Izgg5JBFEhyVbpT52ka6HeCO2ShjCnFvJHYam96LJphM6YVJ8R1uOV9fB3QbLJAv97KANzZ/4MHiHa2e52AA4iIQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126980; c=relaxed/simple;
	bh=GTlYjw4XeH13oRSOrmoX7kvAafhX341vtehCr0lLpuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YcxjBDapYf6HHEz+EljGg0u/66BIl/QGX3KKl4NdfyUNHa6hRhUrw/jcZmqq9TvVG0ikdlX7QadsuyOL9hDm81iWfSGqz1iash6cQ/Oyouu3tWrU4xpxcrr78bAez5jlNA4n2s3VDwbp6Uy4qZ2spKaWkO66Eh3ia8jyhbTgKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nx28BoYa; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e06af753so1168298f8f.2
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737126977; x=1737731777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQhKS+gjOCCTKL2XCaGm/MHG3dZ6lWD1p/winmNuTrk=;
        b=Nx28BoYaeG2mr+HhUuc7INQ3UV1TUY/nkTO0lnbZqDXLn+yLeplSOycQE9Yr/UuGlF
         GhqbUfK8TxJ0tnyH5TwX7qJ9y8ZjCTZ6AEdET9HbevWDVdZjMrO7vE9f/8CjhL3Z58l7
         5oiz+ZTXvQr3MJleDyNX5dwYkCyxeKkOMtriLGlx6fyd5u1302NvZv/UZp8Li0j+WAaO
         QBl1xjVWfsyTjlOgkiynYgQmPtOefNtNWG2Vl57MwSgzvcLHmufcEag4GZ072ysHRfOL
         qVGEsdemzHduitZM81e+jn45pul4/jSAHwNI2O+i7jEhN4zHaU/iJ38g1ypBRs3dRb0P
         fcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737126977; x=1737731777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQhKS+gjOCCTKL2XCaGm/MHG3dZ6lWD1p/winmNuTrk=;
        b=VOjfWovRmKgAtcmYBO0c+2AOo2Y4+HHNL+s94Z57PdkfJbis8Oin9rsQEtRwF98QGF
         7C3O2TqbZWpjJATJAtl1RcV9QIv8IAKGcBCIOMv1u95CjlWHmXvQPmb5N+qcFXmqnl5M
         G9hS+8lNMNFcyeNoqHhgtoDee7uqVZ3WNfL3MQ/ExwsVZ0DEEeC61HyY8Mv83/9TV6Lp
         GOCXRZebLldRD4SQ1Sfdrw4+j7Z0Lj0BoJunOHmF3qh63VNsRFztVeUn7Dp2A2nX7rF+
         p1ogE7Y/Q8iGfIkB903j4GE73zBD3HE/8bOwbg8tmV+pxZ2rDlwntwjGloamMbE2Zavy
         Wr7A==
X-Gm-Message-State: AOJu0YwmOVqNSR9cXdIT97z3qv72vfYFQox9qNO8q6RaFYlp12CA9gpP
	OzKoymgSAt2sDzrLbdc9RkJzSVX8DZho9Uvln+3piM1F/eGCsg7gGX0H8tYpqQIVuPQ4k7rWrxv
	L
X-Gm-Gg: ASbGncupu6Nf5ZCWjQfxlZFYkLGGqxAkmitBSDFjEcEJpTsgfwW5t9nnxelv5cOlUgM
	FdgGUZUmoufdGqIIfn3jatDmR3I+dYgrEv+RVmTMTQJY8I0K8cMxh7+0KheTMQr8CtIuCVVAOi4
	wiwhrIDYM+mxOMw7HBkn92WTar33F/qq8IOTc/me4aPpbZ3bnxYqlHWjazaebabD3IESojtgD8v
	lEffVcw+w+OL+4BRbIcbeXsphX/bdT/92bbIBJJddsgKywhCbLOvQGJTV/qwwEvIb5rwh+zKAEt
	t8ovxknTQKwjTvCmnG8PzCB+McwdSfkoupdOZoU8Mb5N9M3E+Vtj/XaCYq103wZZ
X-Google-Smtp-Source: AGHT+IERntBIVOD0CajbPIT28KXPVyQuvMyIAnorcB1ClZTrtmePTOyHwF6lxvGnwebuL/oFD3a7Kg==
X-Received: by 2002:adf:ee0a:0:b0:386:380d:2cac with SMTP id ffacd0b85a97d-38bf566c309mr2106047f8f.26.1737126977159;
        Fri, 17 Jan 2025 07:16:17 -0800 (PST)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-169014-cust557.vm26.cable.virginm.net. [82.47.146.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327e213sm2702121f8f.81.2025.01.17.07.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:16:16 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: stable <stable@vger.kernel.org>
Cc: Terry Tritton <ttritton@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Verkamp <dverkamp@chromium.org>,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 5.10] Revert "PCI: Use preserve_config in place of pci_flags"
Date: Fri, 17 Jan 2025 15:15:51 +0000
Message-Id: <20250117151551.6409-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 0dde3ae52a0dcc5cdfe2185ec58ec52b43fda22e which is
commit 7246a4520b4bf1494d7d030166a11b5226f6d508 upstream.

This patch causes a regression in cuttlefish/crossvm boot on arm64.

The patch was part of a series that when applied will not cause a regression
but this patch was backported to the 5.10 branch by itself.

The other patches do not apply cleanly to the 5.10 branch.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 drivers/pci/controller/pci-host-common.c |  4 ++++
 drivers/pci/probe.c                      | 20 +++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 2525bd043261..6ce34a1deecb 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -71,6 +71,10 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
+	/* Do not reassign resources if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b0ac721e047d..02a75f3b5920 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3018,18 +3018,20 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
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


