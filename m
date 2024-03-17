Return-Path: <stable+bounces-28307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDA687DC24
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 01:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C39B214B6
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 00:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06694139F;
	Sun, 17 Mar 2024 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQQbdcFW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486E380
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710636846; cv=none; b=ZUkLE4ZuK6o4UTwTM52ntRwrqniTBwPxrKDSWgy367oBJR1mzV9n1+TkDRWLcgoJU9l5sryFu9mo/1ACNBjDJHLRNW2TveIKi7K9aDVOoLZvL12OX1Tg9tKam5/jXXF++gqJST/c6mMX98HdjF2fy6nHEhWGd72APZhm61vERPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710636846; c=relaxed/simple;
	bh=5tAj0hAi5dP9n6agGh3FbHzTwAROanvWSK7sKkohpTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6xlmWgMk+DsjNV68cjdwFIuglReMy67/ZDETJPmDfTW+duWMOgB6DH5luSZc4X36EDX1zyQHnB/0WB+OHEfFuVysXDpXbFvltq8h5zH8WKK7MLIqAS49839QJgl0/2S0nDdfvvfQTnIVtgEq6/FuZbyW8URu9UGFBjWVJ1SBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQQbdcFW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4140a54eb33so2740255e9.0
        for <stable@vger.kernel.org>; Sat, 16 Mar 2024 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710636843; x=1711241643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tld0QcMy5hcBtb2vydfEdY6L4Bx+T+qMO5pQVpZvQ8Q=;
        b=EQQbdcFWOmjpFO1keno36xI8Ws3ymUBw9Cjp+WM2GmDnjCvUinWmg0eXBPmGKtVZGk
         2FsH1hmcCxHilNkh0bVCTC0VPlGVXnlhvPtbHiHZielUe2M5mrXK61VY+VXot63jvr3z
         SBbd2HSmH+ttkQJLQSca9d6RhADFytvlU+vG4TvsFiGESnJHQCjeuGZbeMEuHrceywd6
         hdzgvjfSUfBf39sOq0ccTJRQg8+ovqYydEitVOCa3piZ70QIec1hsuJbguNpKL5rTEem
         vzIpV0+dtCLFuP+QfgKJ3cYyy8fy+aZdQ1D7QW97pbSP4uAWgP/Xt9V9Wzv/dqpkzRoP
         2Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710636843; x=1711241643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tld0QcMy5hcBtb2vydfEdY6L4Bx+T+qMO5pQVpZvQ8Q=;
        b=E/jOh9jOesqurgkQlABAW56+/lZ4pGXhPuOvL27mmPnFeeHoK31HLildzThd9nJ6R+
         t6KjMEKiwUxAoU6u3u3IEmm4Ea659JRp+ZsOb08SkN8Z0wP6qz5BEUdh72JS36ahnwP3
         HCnI33nEBFYjBkVUJio8CTa4/nTkr1x3upNphACLPCM15qM5JZ+fUEqAJhc/uhQIwEvR
         I6QdXMfDzPBwUaV2624TyXB0TJeGUauDLMlm8Bwx9XMFK1sp3yRJZw2ZhQThEu7rErr/
         pZ4KUhs7ZoAudZBi8vQ/DzfnDeL9C3vJHjccBblluBSYyVUyLsUvvX0wtJWtBRUVEcIA
         zyjA==
X-Gm-Message-State: AOJu0Yxv3JqR/h8V+40GpGFUf32MAuYtFIhOQ1J7/VuBAPsyMiYBRJ/V
	B++GTFn+vFD4Bq0B6UHpcZw9AFyb50/Xnof2vUQouHZ2Tssut3hfCEH63YhenVgy
X-Google-Smtp-Source: AGHT+IEX7OtpUkOidt3i3m60W+9MfF7WWdyidHCb7xgg/NxeB0Pc0twMA9o0Y0DmI45/yXrJDa7bng==
X-Received: by 2002:a05:600c:35cc:b0:414:204:df50 with SMTP id r12-20020a05600c35cc00b004140204df50mr3699859wmq.4.1710636842341;
        Sat, 16 Mar 2024 17:54:02 -0700 (PDT)
Received: from localhost.localdomain (77-59-144-113.dclient.hispeed.ch. [77.59.144.113])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b0041409d4841dsm2049349wmq.33.2024.03.16.17.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 17:54:02 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v0 1/2] mfd: intel-lpss: Switch to generalized quirk table
Date: Sun, 17 Mar 2024 01:53:59 +0100
Message-Id: <20240317005400.974432-2-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240317005400.974432-1-alex.vinarskis@gmail.com>
References: <20240317005400.974432-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ac9538f6007e1c80f1b8a62db7ecc391b4d78ae5 upstream.

Introduce generic quirk table, and port existing walkaround for select
Microsoft devices to it. This is a preparation for
QUIRK_CLOCK_DIVIDER_UNITY.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231221185142.9224-2-alex.vinarskis@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 23 +++++++++++++++--------
 drivers/mfd/intel-lpss.c     |  2 +-
 drivers/mfd/intel-lpss.h     |  9 ++++++++-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 4621d3950b8f..07713a2f694f 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -23,12 +23,17 @@
 
 #include "intel-lpss.h"
 
-/* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
-static const struct pci_device_id ignore_resource_conflicts_ids[] = {
-	/* Microsoft Surface Go (version 1) I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182), },
-	/* Microsoft Surface Go 2 I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237), },
+static const struct pci_device_id quirk_ids[] = {
+	{
+		/* Microsoft Surface Go (version 1) I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+	},
+	{
+		/* Microsoft Surface Go 2 I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+	},
 	{ }
 };
 
@@ -36,6 +41,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
 	const struct intel_lpss_platform_info *data = (void *)id->driver_data;
+	const struct pci_device_id *quirk_pci_info;
 	struct intel_lpss_platform_info *info;
 	int ret;
 
@@ -55,8 +61,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	info->mem = pci_resource_n(pdev, 0);
 	info->irq = pci_irq_vector(pdev, 0);
 
-	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
-		info->ignore_resource_conflicts = true;
+	quirk_pci_info = pci_match_id(quirk_ids, pdev);
+	if (quirk_pci_info)
+		info->quirks = quirk_pci_info->driver_data;
 
 	pdev->d3cold_delay = 0;
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index eff423f7dd28..aafa0da5f8db 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -412,7 +412,7 @@ int intel_lpss_probe(struct device *dev,
 		return ret;
 
 	lpss->cell->swnode = info->swnode;
-	lpss->cell->ignore_resource_conflicts = info->ignore_resource_conflicts;
+	lpss->cell->ignore_resource_conflicts = info->quirks & QUIRK_IGNORE_RESOURCE_CONFLICTS;
 
 	intel_lpss_init_dev(lpss);
 
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index c1d72b117ed5..2fa9ef916258 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -11,16 +11,23 @@
 #ifndef __MFD_INTEL_LPSS_H
 #define __MFD_INTEL_LPSS_H
 
+#include <linux/bits.h>
 #include <linux/pm.h>
 
+/*
+ * Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources.
+ * Set to ignore resource conflicts with ACPI declared SystemMemory regions.
+ */
+#define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
+
 struct device;
 struct resource;
 struct software_node;
 
 struct intel_lpss_platform_info {
 	struct resource *mem;
-	bool ignore_resource_conflicts;
 	int irq;
+	unsigned int quirks;
 	unsigned long clk_rate;
 	const char *clk_con_id;
 	const struct software_node *swnode;
-- 
2.40.1


