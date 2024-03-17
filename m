Return-Path: <stable+bounces-28310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C96487DC29
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 02:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03801C20F51
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 01:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA41615C0;
	Sun, 17 Mar 2024 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf0VXoRB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F90ED9
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637617; cv=none; b=QtnVQ/sKCEiza9YKWgetaZlleC33qMAztfBhblYxvbjQDGaoA7cwOGEhzY3fZHqcneVIcNgHlRqhXyqGbTUDjnbunsxk9o0lvx84/CvU0B7nCtpHfmhQ4uWvuR/5h4yzjqPDYFr4k+QESE4wFkorO0zNFrRX/BegAQjyf2egS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637617; c=relaxed/simple;
	bh=kkbxPUklrj5Qpr+AmEdN/CvIuLrxyGh/Rg3A/HQUDTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdHPHTdPwkI9PGk5OuP9N/+cSsaXM3LP+vQ35O6WHrv7iKa7wpsvW7f6Og8Cb66yn2AckNQVcDX+gH3WtIU7LJKKvnshuwLzHxt5AwWPdCZNOgM/wTxSObz2bCAPPIvqyI+ovNFXw5ZTIpBQCHF/lHmBQXk2GnGsv4pEdoOxmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf0VXoRB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-413f76fcf41so22444965e9.3
        for <stable@vger.kernel.org>; Sat, 16 Mar 2024 18:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710637613; x=1711242413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGZ8Tb3FlF3wumARS9w388NDLowaapuIWpv1Ge5WwDU=;
        b=Uf0VXoRBg9I5279lMVCu4CSylesLw4KXUOExon44CGk/EjV8Fe3qtQ7pdNx8F3y4u6
         ctLQHvhS6kwO2SZsumZBIDN0P5EITcwUqIQPN3W/OIfldtr1eTEko8+nN6fdGN4AZ1+F
         d1HTtVVEvS6KHUNJGIefTo9j3mtFvA+7myqa2y8U1sSOvkX1OloyvbWHhZ45bUIFsXNs
         yyAk2w7YvKDptQNouxWKbJvjO/o1tkf9AbNw5WoeXBLs6lEtdRqYRp6yswfrk9MKxpmo
         DOyN6Rozza1zb/IRXg5PL9NNU7YUntQIyiPdPZmSLWoc2ihebCZ1i6DjZMfDsoxAgwXU
         HlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710637613; x=1711242413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGZ8Tb3FlF3wumARS9w388NDLowaapuIWpv1Ge5WwDU=;
        b=Etr1cM/zOuPaIcD9+JG8ZnptCUR4qbTRXAA9DkNKZPiBd8vPBaVe8YxLquWe3fXqig
         45grALGcOlebmfpNEiroqpMSNUP6BwQBUdFVFbiVhy8xhj+zW9lLtRErktkMfPueqq37
         ANTIdemqCtVauGz/kGouZp81xotq34zNegRaDil3mRiPHSlaUJ0XV/ous6teyZQeQb3A
         4yMdb/HDr9+ENocyjqwoFlL9hqv5nNwPPafjEXTav6yXebqHz6B/+CK4/hM/8whm2RWD
         Tvh3xRaoPTtIb44Q3IYVnS4nDgqq1wJatqfZqtsdvFwaKbT7SxKQe1jJsD68j6gvah0S
         gJSg==
X-Gm-Message-State: AOJu0YxJMurNyNSPsa7g/qFo1KI0eQ3wuS3aedoc7mt4bdEa4qhco8LS
	LNWgCg1nMozvqqJPdV80WWz9cmJUKsLNCrXZOU9qqYEObFr9vzCEIwI0GHtioVVs
X-Google-Smtp-Source: AGHT+IFPy3ei2nf4fm+xQkZqzfEZ2X+qG8eHiCKCmskGFe6nc5GMgX527UtkSdZs/SSvz6MV6ZFBPg==
X-Received: by 2002:a05:600c:46c9:b0:413:f3f0:c591 with SMTP id q9-20020a05600c46c900b00413f3f0c591mr7064890wmo.41.1710637613301;
        Sat, 16 Mar 2024 18:06:53 -0700 (PDT)
Received: from localhost.localdomain (77-59-144-113.dclient.hispeed.ch. [77.59.144.113])
        by smtp.gmail.com with ESMTPSA id fa21-20020a05600c519500b004140a341f5asm1650042wmb.46.2024.03.16.18.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 18:06:53 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v0 1/2] mfd: intel-lpss: Switch to generalized quirk table
Date: Sun, 17 Mar 2024 02:06:50 +0100
Message-Id: <20240317010651.978346-2-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240317010651.978346-1-alex.vinarskis@gmail.com>
References: <20240317010651.978346-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce generic quirk table, and port existing walkaround for select
Microsoft devices to it. This is a preparation for
QUIRK_CLOCK_DIVIDER_UNITY.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 drivers/mfd/intel-lpss-pci.c | 23 +++++++++++++++--------
 drivers/mfd/intel-lpss.c     |  2 +-
 drivers/mfd/intel-lpss.h     |  9 ++++++++-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index ae5759200622..eb3b0195db2e 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -18,18 +18,24 @@
 
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
 
 static int intel_lpss_pci_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
+	const struct pci_device_id *quirk_pci_info;
 	struct intel_lpss_platform_info *info;
 	int ret;
 
@@ -45,8 +51,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	info->mem = &pdev->resource[0];
 	info->irq = pdev->irq;
 
-	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
-		info->ignore_resource_conflicts = true;
+	quirk_pci_info = pci_match_id(quirk_ids, pdev);
+	if (quirk_pci_info)
+		info->quirks = quirk_pci_info->driver_data;
 
 	pdev->d3cold_delay = 0;
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 00e7b578bb3e..7af0a1fab062 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -401,7 +401,7 @@ int intel_lpss_probe(struct device *dev,
 		return ret;
 
 	lpss->cell->swnode = info->swnode;
-	lpss->cell->ignore_resource_conflicts = info->ignore_resource_conflicts;
+	lpss->cell->ignore_resource_conflicts = info->quirks & QUIRK_IGNORE_RESOURCE_CONFLICTS;
 
 	intel_lpss_init_dev(lpss);
 
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 062ce95b68b9..f636059cbc71 100644
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


