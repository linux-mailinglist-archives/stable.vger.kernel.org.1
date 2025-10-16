Return-Path: <stable+bounces-186218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F79BE5CA3
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 01:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9529219A74D7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 23:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF42E6CA4;
	Thu, 16 Oct 2025 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nlcTtEqO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC323C4E0
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657296; cv=none; b=NrP6jT9ge/G4v3YkHPXYKPauNloyZLux9FAN3sD0PJqAkmthURoynNI7vQ9QJURudXGIQ2PQpX4YHgkWnVDL8NSuc9DLoDXqMnIKuK9o7zeDT+c/q7JpThFdOMNQTAE3rqXl+xJa8UnEIna2WZxfqpRXvueQ2CmDg5lIt34E9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657296; c=relaxed/simple;
	bh=XJoRXhF6cct+u5hqeBr/GjrKmq9CEKau2+FBHdOwe7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9w2K+/5lD1aOkmJizBmIWNpJVM1Lj2cTs1yaUEgUD/qlByu8nhVN85WKoXpG657qQ3oIhTRSyfQEjthnVrwrUYfISOUICnVoSzGZ6yDPf1Q5tEHXeEv30HzMGr8ixXKJ1E+/c5Q7N5vEe7q6Otu3wHMsviMHd1bceeSnpKThqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nlcTtEqO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1265190b3a.1
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760657294; x=1761262094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDHKL7YrbYj0WMr/qaC61DmFE96g6L5ksIAhfdoxQrQ=;
        b=nlcTtEqOnd54qW/ICO8glTxNOt8FmeJe9owrl9qhvsPQpg/B2Mp2KNJrvMtdul+Qc0
         5ZrKRVGXHR9+Sciv6jft3dF9eSOcsgAtHbQadNAfu0F+YCXY0RCAJj29LAAA/rB3arHR
         zik0LCswwZQ/Ug93I4EKLk4SwByaxOXB4G2HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760657294; x=1761262094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDHKL7YrbYj0WMr/qaC61DmFE96g6L5ksIAhfdoxQrQ=;
        b=EeO4yojqphn6ThmWiUIlyI0mxrpp3NwiDsv6VaU9vOVZdLjaS2l6zgGHhUNsbmpc90
         WV1IC+odGHh8nlM0Swn7MRA3NApx6pTYA+yv8SSzkn25D4mnDSauggK3xPTINsCCOvGK
         ipB3bBde/S/UyqBww0S9Tp1IpkH5NdZgmvLS8eq7GmJs+DoLVeUrR78mVzJp+qKmiAQn
         c3UkZK2IuyieDaB36kv2QuN7iDZSPD/W/SgcrgBaGvlqmAhILm0bMMTMEdgzlr6rfukc
         5f57DxrP0PkutFpLiP0UwDp/OFn3cI78fYAtzFjtJkmpu6klQFX48s16NfgYa3mZajF9
         Ng0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVCBi9rR8BVsUemhFnKJCTto+009W8TK5/EcmZPwv1HvnxJyRRIlz2YP//bQZ0neDA2VD/Rik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGchptvNZijmUJnEiaZVj0u5IA5pd+Zjk/a8LuwpyD4hKkRpnI
	XIGJ70ry0UOODEnbSzdR7Qb2cl4mHftMADq2xqP833GGV4tSTLYvP76wN2Yl1Wbzcg==
X-Gm-Gg: ASbGncu6zwa57DQxzG0BGooUz9DyvH1JhpuOGKHGfdSdmAdMVhinUIN2zg7ve38/4vM
	vbCfBqaesXlHbiitYf5WZZ3Gi7I7efJwmKLo2fVpkc2UrYc8TUmW0kjqJgBy+zWAZA2kfBfEcn0
	KCb2Q3f1hHSaJEBbUArvcr+MSWLg6lQtF7rPeVSQ3/v8kdymoqaP7pwdy8yi1Vg/vA19nuFxK6h
	LCBqo8twRRDB+e5ZgNCZTELeYsJLc8IMNaWQWtuuoPaTPlQAiZM5bBzMHqevPBVJOJMR7aRiJSa
	jNJzTlyR2ku/Lf/PL1Sxnwb12h9JO9Nm7HFp4TvbFRgysMkUPAIwZE1guRlB1jXJWd6A+rnuRC8
	SObKUVRDnJ0HSbXNcnvfxfbJ/82PiFq8AZI6zL+A9CRTQF2MtwAsFnHEC2rZ3txwo335ZPeBvSd
	1n6M+zgAHwSZTOFgYt8BMBukrqNcE8FFMXWMI9EA==
X-Google-Smtp-Source: AGHT+IHptz2Viou3aQb7JTKgXj8lqBa3xVm9ubMw1J3oe5c1h0nSfI0VxDkbrkw3mL1kDx6q4igwAQ==
X-Received: by 2002:a05:6a20:6a28:b0:32d:b925:22ab with SMTP id adf61e73a8af0-334a78fbd98mr2663524637.17.1760657294603;
        Thu, 16 Oct 2025 16:28:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:98f9:84ca:9891:3fd2])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7992b060b59sm24127004b3a.2.2025.10.16.16.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 16:28:13 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully initialized
Date: Thu, 16 Oct 2025 15:53:35 -0700
Message-ID: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI devices are created via pci_scan_slot() and similar, and are
promptly configured for runtime PM (pci_pm_init()). They are initially
prevented from suspending by way of pm_runtime_forbid(); however, it's
expected that user space may override this via sysfs [1].

Now, sometime after initial scan, a PCI device receives its BAR
configuration (pci_assign_unassigned_bus_resources(), etc.).

If a PCI device is allowed to suspend between pci_scan_slot() and
pci_assign_unassigned_bus_resources(), then pci-driver.c will
save/restore incorrect BAR configuration for the device, and the device
may cease to function.

This behavior races with user space, since user space may enable runtime
PM [1] as soon as it sees the device, which may be before BAR
configuration.

Prevent suspending in this intermediate state by holding a runtime PM
reference until the device is fully initialized and ready for probe().

[1] echo auto > /sys/bus/pci/devices/.../power/control

Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/bus.c | 7 +++++++
 drivers/pci/pci.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6ff588..227a8898acac 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -375,6 +376,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	/*
+	 * Now that resources are assigned, drop the reference we grabbed in
+	 * pci_pm_init().
+	 */
+	pm_runtime_put_noidle(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..06a901214f2c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3226,6 +3226,12 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
+	/*
+	 * We cannot allow a device to suspend before its resources are
+	 * configured. Otherwise, we may allow saving/restoring unexpected BAR
+	 * configuration.
+	 */
+	pm_runtime_get_noresume(&dev->dev);
 	pm_runtime_enable(&dev->dev);
 }
 
-- 
2.51.0.858.gf9c4a03a3a-goog


