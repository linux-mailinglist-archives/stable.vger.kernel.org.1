Return-Path: <stable+bounces-172163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FE9B2FD8E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB98B7AADA3
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1DE2836B5;
	Thu, 21 Aug 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dsIK0u11"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC322F6194
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788341; cv=none; b=cBYYiC/b7UC7ChyiQyIzXhNtytHiZiQ7GLy0HFGapwedUMmSkhTUQR/3VmEQ/rf8EjN+Ugad8VW2Z5ww/QZTr8hQjaKruMwKrrEbkVMZAHfMeZyPA7o5JesMHiL7gAx4OBujp5Eo7YWNzW9yP+Y6LsOJFjsz3wevprLjvpm+akU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788341; c=relaxed/simple;
	bh=Tz/VZwFoOgQ0Y4zvdRFkegcxdyj0tPL1i1gvMWA7+7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1J/utW/F7JPnEupfFGusnWIqOdnMWGGac1s4Jgb4077pKh7lE95fiVhaASf5/0RKKDcNHaLhcxvW7WoGSXiW3a0PgrjHaNkGzNrB/AYkwBAkQ0XG6Py5rT8M7GcbGrV/02wsNbviq9F5lTJJt9DCpU2Z7q/tB+IbhX3WLs94+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dsIK0u11; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-245f19a324bso10030325ad.0
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755788339; x=1756393139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaLinSTBsg2Heqd5n/Y8HcIpri3LMWuuwE5FV81Iuv8=;
        b=dsIK0u11Uj2shhL/rM82sHsgOs/rTJuf7U4i6Kw/NZ8/E4cl4wQD1yLrHaQ9XGISGH
         OEn9H+qpR5Y9JniVagCZSBGmOoOO6LIoVMd/7lGT8VLhnzWXmxrRTVmhO02hFuMqn75o
         bIfH5DLdHzk6EegT9kMohlQENMXNSInMHb2sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788339; x=1756393139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaLinSTBsg2Heqd5n/Y8HcIpri3LMWuuwE5FV81Iuv8=;
        b=i5l6uzpVKvCa65c9Fi8tjKW6t08fR9w8u0Csw4ZSsBEnIEMh6bDhF8sWMqX3hFAdZT
         030FLrX3lGoGio6CfKMoHj2HqfDgZ5J93QxNDxGb8mSp/gCMcjPPjBWum9S5q/tq3dCB
         qrKTmbiCQjck+uqrh/u3gGEFyiuLmTOCAe/OjicVcTzFDDSoEGFBC0abSRUJDT4IMB2b
         sLUyzZdi5gHXmlq9z9guBDeTOgGt3rM4etufIx+kxlp7SoUznTuDArteBwfVQNt97tJE
         arUNDa7cnpUDVhR8JllZjRaLVJSAOOIvpfOw9UjzodXl9Rf6C6oKI+J4fZgd32roWtmv
         XFsA==
X-Forwarded-Encrypted: i=1; AJvYcCX77/j7d1oMJM2B0OOiG2HBxjzO5gBhLDvxXm5X6rnVwM5pDdQQuHXqmzSPxET8VgBeOAiBI1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwiC3hNn0k/l2jGCYnEjDnkeDeFIPToK2z8S+IKHgpdzQvLU1
	kj+sOYR+pwxfw7ARAHjKdSXQoOoX5+yrz9obpMOXECSIcMavJXGhYQwdDGGzLMuwFA==
X-Gm-Gg: ASbGncsFwg+4gWSQoSyfZ9EFsiMiq896HnvNv++gYMR7iocKjrSGPAZmsXbUkUecTTE
	a93/lVaJ46STlGkRHD4Lszs0kqVuUFLCGDCRlib1IElJTJoU3Izi4xm776LkGVTMWXgoDH+D0w2
	grYHcKTQGyMGXV0e0Qq4K4cE3/KHMyD/eNZ4MmeH997tErwQeTq3xUgnP4Af5uxUeJOUiiyGPmx
	XMHSxP++Ul+JtSIVgnury9WLYpEhiKe0+9fhqE1+uQifYnxVmJrZY4jufaUqm1IcfadQsg5mcsZ
	jmbMylaWmpPKqj7X6fNzZFkxcTccJYoht+U0pvUbz8v3WRIIlMnNWumgl/zRSbaLyjIihWFrwew
	cYFkuHrNsEE5kQaIewLvqm6YKBMizS2hgqULGK7b9IuX2japvYPR6KIe4QtyUdn2I4kZgRdM=
X-Google-Smtp-Source: AGHT+IF5jd207eAHYlWkozFvV4W7rHhk80wb+yRJAbAhw3XVWRLn8xbVDIiu2vgUdgY7fOZrtSdwdQ==
X-Received: by 2002:a17:902:d4cd:b0:246:571:4b21 with SMTP id d9443c01a7336-24605714c9dmr35347695ad.58.1755788338577;
        Thu, 21 Aug 2025 07:58:58 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2283:604f:d403:4841])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed33aa3esm58509915ad.24.2025.08.21.07.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:58:58 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI/PM: Ensure power-up succeeded before restoring MMIO state
Date: Thu, 21 Aug 2025 07:58:12 -0700
Message-ID: <20250821075812.1.I2dbf483156c328bc4a89085816b453e436c06eb5@changeid>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

As the comments in pci_pm_thaw_noirq() suggest, pci_restore_state() may
need to restore MSI-X state in MMIO space. This is only possible if we
reach D0; if we failed to power up, this might produce a fatal error
when touching memory space.

Check for errors (as the "verify" in "pci_pm_power_up_and_verify_state"
implies), and skip restoring if it fails.

This mitigates errors seen during resume_noirq, for example, when the
platform did not resume the link properly.

Cc: stable@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/pci-driver.c | 12 +++++++++---
 drivers/pci/pci.c        | 13 +++++++++++--
 drivers/pci/pci.h        |  2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..d66d95bd0ca2 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -557,7 +557,13 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
 
 static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 {
-	pci_pm_power_up_and_verify_state(pci_dev);
+	/*
+	 * If we failed to reach D0, we'd better not touch MSI-X state in MMIO
+	 * space.
+	 */
+	if (pci_pm_power_up_and_verify_state(pci_dev))
+		return;
+
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
 }
@@ -1101,8 +1107,8 @@ static int pci_pm_thaw_noirq(struct device *dev)
 	 * in case the driver's "freeze" callbacks put it into a low-power
 	 * state.
 	 */
-	pci_pm_power_up_and_verify_state(pci_dev);
-	pci_restore_state(pci_dev);
+	if (!pci_pm_power_up_and_verify_state(pci_dev))
+		pci_restore_state(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e698278229f2..c75fec3b094f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3144,10 +3144,19 @@ void pci_d3cold_disable(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_disable);
 
-void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
+int pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
 {
-	pci_power_up(pci_dev);
+	int ret;
+
+	ret = pci_power_up(pci_dev);
 	pci_update_current_state(pci_dev, PCI_D0);
+
+	if (ret < 0 && pci_dev->current_state == PCI_D3cold) {
+		dev_err(&pci_dev->dev, "Failed to power up device: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1c48bc447f58..87ad201417d5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -233,7 +233,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
 void pci_dev_complete_resume(struct pci_dev *pci_dev);
 void pci_config_pm_runtime_get(struct pci_dev *dev);
 void pci_config_pm_runtime_put(struct pci_dev *dev);
-void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
+int pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
 void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_msi_init(struct pci_dev *dev);
-- 
2.51.0.rc1.193.gad69d77794-goog


