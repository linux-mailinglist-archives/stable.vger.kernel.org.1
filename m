Return-Path: <stable+bounces-52343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B5790A2EA
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 05:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B571F221A3
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 03:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC161FE8;
	Mon, 17 Jun 2024 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bAG5Jp1e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A629D19
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718595611; cv=none; b=ORx4EypdpD9nV5MSmWRA3QGa0m7bE/pQvin+2ZP/w4e1gMSB6P7zkOu0kGPNLsp87i2jMM0SzMtOqCYqY4GbgRrPKgZ5xHYVYTv1CuyImCLG9nkvkV4+FccIcBBiXoF9cFPXp9vvrYunrrKyhY8OnfDn2Z0SgkbgR8r8yKf2yU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718595611; c=relaxed/simple;
	bh=GoRObZwvjcIlow5bvP3vlgsTncJc7V4OoV3jbrPTUgg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Wn8BabTZWIv6/3frcUtune2L5AQoBqT63SYb4jJOpyOv40F5/Yln2gNrn2rGEY/Ssb+tZb3vNv8zlqfZ1+9od8pNC3qrJuf7vIyOGbdTmWdDXqQEk9v7LZZchE724pFXT8Er0mgDu/E1VJ4LEa/BcRdO5rDxP9SxXnL8E2uE4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bAG5Jp1e; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c2e72128b4so2756835a91.0
        for <stable@vger.kernel.org>; Sun, 16 Jun 2024 20:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718595607; x=1719200407; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EwglCx8Qz1vDs6Ch4kVIzvrzdSC0LXoFN2DojGuQw0=;
        b=bAG5Jp1e96o7PSQc49ifRcZDyOcWjn8bOH2xxkcUQ0C6KcWYS2TKlOz/3hX/P9pfU+
         D6mfmNF9+1kSeRbfDodLwJijjRoumc2hkBymCVBgD0/dnqrMgdfRq5XV0kgkz9XOkbi6
         sWT4alSXaxu/CC1gJ7J+2sP35ZUTXsBL/ReUAb4JmdaWO/BIbzl63c1+YmtSmRj52VVv
         W0aYZQ+dh85DxHcD5uewwJKs7Moa2VkS7vMrKmAj69F+JYioPh825coEpDUBpoBkIgoc
         NbU9bWqd14onIrGu5py9ruqiFx2qlXeR58eYW/quSJJpdPsQ0NvdVGjUkdQzHvp+DQq2
         Dhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718595607; x=1719200407;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EwglCx8Qz1vDs6Ch4kVIzvrzdSC0LXoFN2DojGuQw0=;
        b=xIyZ7KMXVyKhZJUjb4Z5N+Rk0lpJ2xSTbZTM13WsXBO4cn9rLmHWrNKEnUUwI/P7n5
         eJ4gsbMfQyPqjYsY5qR9706YhUtYGIg7lWesfe0wvZgt2qZ0RhodI+BsYE+TiVwFVnXX
         jgmoAbPQWqiyQznwkDUTEDFcKDMlbtN5vzRcSq6j/p/p+RMYwTA2D4U5/+RU+yQkko25
         Ne8BedPpu16eKxz3cvaVK0m8MOrIi7AR7x5/KzDEyTuYuRauIuvjhKdGcphPF9jw1HMQ
         r3ktuIoYEePFwTTkGTcBrnxshlM/XPm9sYEYQuYPJKvW70lP0VnTcLD1LzdTVAmkxKo/
         BfeA==
X-Forwarded-Encrypted: i=1; AJvYcCUXHZGLDcsYFKc/dAI176kB049E6SPOcsLSgGlF1Pur2JHFAbK2qoi9cuICh7ekSnVxeuN9wC5cyXnC5XVlb2F9RYo7U5A1
X-Gm-Message-State: AOJu0YzB8rSsXqvOY/2b2h9haBBkpi/Jq3oF25LvBahzaP3KpoNM2rVn
	m99Ghx4KdXVRIKuObh4t3+jhWeehq7tlz8hEGuBu1a/ALwhB/egnCJK82on/Rf7oHd4LW/q7iBR
	e
X-Google-Smtp-Source: AGHT+IFF7KX40HLPX7MtiX6Qu3YxXZE5l0KzeUmd77Sd+JiMclW7MxHbHRCkmJ65S9N2xozyRo4jug==
X-Received: by 2002:a17:90b:364a:b0:2c4:fb76:9cf9 with SMTP id 98e67ed59e1d1-2c4fb769dbcmr8196837a91.5.1718595607514;
        Sun, 16 Jun 2024 20:40:07 -0700 (PDT)
Received: from 5CG3510V44-KVS.localdomain ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769beb8sm10269497a91.41.2024.06.16.20.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 20:40:07 -0700 (PDT)
From: "guojinhui.liam" <guojinhui.liam@bytedance.com>
To: guojinhui.liam@gmail.com
Cc: Jinhui Guo <guojinhui.liam@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v7] driver core: platform: set numa_node before platform_device_add()
Date: Mon, 17 Jun 2024 11:01:23 +0800
Message-Id: <20240617030123.4632-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Jinhui Guo <guojinhui.liam@bytedance.com>

Setting the devices' numa_node needs to be done in
platform_device_register_full(), because that's where the
platform device object is allocated.

Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
V6 -> V7
  1. Fix bug directly by adding numa_node to struct
     platform_device_info (suggested by Rafael J. Wysocki).
  2. Remove reviewer name.

V5 -> V6:
  1. Update subject to correct function name platform_device_add().
  2. Provide a more clear and accurate description of the changes
     made in commit (suggested by Rafael J. Wysocki).
  3. Add reviewer name.

V4 -> V5:
  Add Cc: stable line and changes from the previous submited patches.

V3 -> V4:
  Refactor code to be an ACPI function call (suggested by Greg Kroah-Hartman).

V2 -> V3:
  Fix Signed-off name.

V1 -> V2:
  Fix compile error without enabling CONFIG_ACPI.
---

 drivers/acpi/acpi_platform.c    |  5 ++---
 drivers/base/platform.c         |  4 ++++
 include/linux/platform_device.h | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..1ae7449f70dc 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -168,6 +168,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	pdevinfo.num_res = count;
 	pdevinfo.fwnode = acpi_fwnode_handle(adev);
 	pdevinfo.properties = properties;
+	platform_devinfo_set_node(&pdevinfo, acpi_get_node(adev->handle));
 
 	if (acpi_dma_supported(adev))
 		pdevinfo.dma_mask = DMA_BIT_MASK(32);
@@ -178,11 +179,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
 			PTR_ERR(pdev));
-	else {
-		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
+	else
 		dev_dbg(&adev->dev, "created platform device %s\n",
 			dev_name(&pdev->dev));
-	}
 
 	kfree(resources);
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba25003..c733bfb26149 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -808,6 +808,7 @@ struct platform_device *platform_device_register_full(
 {
 	int ret;
 	struct platform_device *pdev;
+	int numa_node = platform_devinfo_get_node(pdevinfo);
 
 	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
 	if (!pdev)
@@ -841,6 +842,9 @@ struct platform_device *platform_device_register_full(
 			goto err;
 	}
 
+	if (numa_node >= 0)
+		set_dev_node(&pdev->dev, numa_node);
+
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7a41c72c1959..78e11b79f1af 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -132,10 +132,36 @@ struct platform_device_info {
 		u64 dma_mask;
 
 		const struct property_entry *properties;
+
+#ifdef CONFIG_NUMA
+		int numa_node;	/* NUMA node this platform device is close to plus 1 */
+#endif
 };
 extern struct platform_device *platform_device_register_full(
 		const struct platform_device_info *pdevinfo);
 
+#ifdef CONFIG_NUMA
+static inline int platform_devinfo_get_node(const struct platform_device_info *pdevinfo)
+{
+	return pdevinfo ? pdevinfo->numa_node - 1 : NUMA_NO_NODE;
+}
+
+static inline void platform_devinfo_set_node(struct platform_device_info *pdevinfo,
+					     int node)
+{
+	pdevinfo->numa_node = node + 1;
+}
+#else
+static inline int platform_devinfo_get_node(const struct platform_device_info *pdevinfo)
+{
+	return NUMA_NO_NODE;
+}
+
+static inline void platform_devinfo_set_node(struct platform_device_info *pdevinfo,
+					     int node)
+{}
+#endif
+
 /**
  * platform_device_register_resndata - add a platform-level device with
  * resources and platform-specific data
-- 
2.20.1


