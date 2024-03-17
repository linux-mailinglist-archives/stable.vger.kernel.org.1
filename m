Return-Path: <stable+bounces-28311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC95187DC2A
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 02:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BB01C20F96
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937C17F8;
	Sun, 17 Mar 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFyYLmw0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C1139B
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637618; cv=none; b=GYJPhOXabbHsQXsuIlYxenNNFeT0r+KOPgZsaAQ5NAPJHdDqFQ40XAhH06VZBFNHYuIUOVy2oIYe728f+ACLYnxkDi5yhPPowqmOHI+h2ONULAq97ku44sEe4nQTa3q/xPl5AcffCNE+FIOTtUyW5HZvRcvyM32KAO0XSHyks6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637618; c=relaxed/simple;
	bh=vrw5Gyq5bPe1AQQM8rjOLMlGhak7diZDzoWq9iSNOyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ayu7vJ3dcEwQjU8xTjSthMtRXLc1mgA7uSGDh0+aUDSakA57RBRXMr60rbSkPWUjyp7EDj07WCACnAEFqjSVRqJwpu12zYScs6GOw5ZuPDZ7XGfGuRlkor22bBvIL2Xh+C4N41aHmiaYdngKzRcJgn7HHxtICBUSFMCoCo85+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFyYLmw0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4140c25d024so993335e9.1
        for <stable@vger.kernel.org>; Sat, 16 Mar 2024 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710637615; x=1711242415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jsmBxF83P+jQV+evZy6ZlVBeriurFn/9h/bZNvNboQ=;
        b=WFyYLmw0lKG0iPDb73ycfkN26zGjCcH2lr2lNCZC7bNas6+BeH39G+DCafyu3rrNLu
         1H53wW7Wtr+yztj3jQ3d6xeyXwNKIkncVEuRs3sWzTpK2dj2IW3rPPHdPiHMhbSAEBL2
         17J7tWM6uIF4sB2NfiaP5BL30tJd9aOQO3xw1PxfOMLXZPCS8GxNUn/cEFkdeOUT11bS
         xlOFCHLQC8qyyZSqIcKIh+5Itg7bI7o/xWTkWFT5PZGhGfeOVXQTTabk6jwWJAJ7Vg3e
         1yF/zzHeK27484Wwq5VDCAgAS4Md8SrNaIKv3RLLxFpP0VMioU8dLfL20Y8Ptniqkru+
         tTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710637615; x=1711242415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jsmBxF83P+jQV+evZy6ZlVBeriurFn/9h/bZNvNboQ=;
        b=kVWbxVL6D1JqK6JlFril6Jod3n8uDdxNRjQpFMskmpbVEJnmHb/hI6DffQFYOEV3X0
         VkySR9FaMVFHgLBzBwhn3rEvm7g2xL0p+5feenwML3+BIyiVs34CUjZsyxWNQwyfk98D
         tZEg+4yiIHtwKuyLaVnxgYPq57ACqYg6RDcooV3AeFd5KGIbNxdDSJ4UWkautnuJ3aG1
         Zn9ZWv5HNKhbJTsN8cvfDORD150zPgE/thJq/32H//WOgCXdZ/WR+9+pEMSCwKQWQXKP
         HzKNobvy67x5fhhgEqH5H79ao7FmbuWkVz/Tly0oLceqrvHFcft/6OevYsihUeBnEC8A
         8WaA==
X-Gm-Message-State: AOJu0YyoRm0anVtRVdkoqGxV8TQwt539ktD/SleXan0Tm/kfqWzvVkRk
	xnyhVG/EqJggtkW06KhZpcIzidQP8w++ewBiaIS6l5+pfxiEIDLGmmOSacXGEUOT
X-Google-Smtp-Source: AGHT+IEopq1IftHETLLv9/RpbvRLR5tItPXOWtTnOeq7ivAHoUVwAaSLtU7rYxafg47XQhwLhvlqfA==
X-Received: by 2002:adf:e285:0:b0:33e:c5fd:cae6 with SMTP id v5-20020adfe285000000b0033ec5fdcae6mr7204373wri.57.1710637614783;
        Sat, 16 Mar 2024 18:06:54 -0700 (PDT)
Received: from localhost.localdomain (77-59-144-113.dclient.hispeed.ch. [77.59.144.113])
        by smtp.gmail.com with ESMTPSA id fa21-20020a05600c519500b004140a341f5asm1650042wmb.46.2024.03.16.18.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 18:06:53 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v0 2/2] mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
Date: Sun, 17 Mar 2024 02:06:51 +0100
Message-Id: <20240317010651.978346-3-alex.vinarskis@gmail.com>
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

Some devices (eg. Dell XPS 9530, 2023) due to a firmware bug have a
misconfigured clock divider, which should've been 1:1. This introduces
quirk which conditionally re-configures the clock divider to 1:1.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 drivers/mfd/intel-lpss-pci.c | 5 +++++
 drivers/mfd/intel-lpss.c     | 7 +++++++
 drivers/mfd/intel-lpss.h     | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index eb3b0195db2e..cab11ed23b4f 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -29,6 +29,11 @@ static const struct pci_device_id quirk_ids[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
 		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
 	},
+	{
+		/* Dell XPS 9530 (2023) */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x51fb, 0x1028, 0x0beb),
+		.driver_data = QUIRK_CLOCK_DIVIDER_UNITY,
+	},
 	{ }
 };
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 7af0a1fab062..d422e88ba491 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -292,6 +292,7 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 {
 	char name[32];
 	struct clk *tmp = *clk;
+	int ret;
 
 	snprintf(name, sizeof(name), "%s-enable", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp), 0,
@@ -308,6 +309,12 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 		return PTR_ERR(tmp);
 	*clk = tmp;
 
+	if (lpss->info->quirks & QUIRK_CLOCK_DIVIDER_UNITY) {
+		ret = clk_set_rate(tmp, lpss->info->clk_rate);
+		if (ret)
+			return ret;
+	}
+
 	snprintf(name, sizeof(name), "%s-update", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp),
 				CLK_SET_RATE_PARENT, lpss->priv, 31, 0, NULL);
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index f636059cbc71..f50d11d60d94 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -19,6 +19,11 @@
  * Set to ignore resource conflicts with ACPI declared SystemMemory regions.
  */
 #define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
+/*
+ * Some devices have misconfigured clock divider due to a firmware bug.
+ * Set this to force the clock divider to 1:1 ratio.
+ */
+#define QUIRK_CLOCK_DIVIDER_UNITY		BIT(1)
 
 struct device;
 struct resource;
-- 
2.40.1


