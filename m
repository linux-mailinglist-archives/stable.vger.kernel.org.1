Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EAA7A0FDD
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 23:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjINV3m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 17:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINV3l (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 17:29:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AB92701
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 14:29:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-577fb90bbebso903719a12.1
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694726954; x=1695331754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RzuuSbvQBu+IbXhqgSc/Jh1UYlftCrb0q8uG/spw850=;
        b=M5uBLUiJxHDXY/0fAIw28Gl81DWM983G1Y87YkqpRWNCFuWcOBFvvjSl4MmfQDOwN8
         h/NsQo6gk57UaLWJ0I7S8NU2eTKZMnzo/2sFk7cemKpmnES8xo8oyFXH67XuaNy4wrj+
         4ZW/XaTWJYgaXgkHPCDN0hEXYW4xVw3iLbRfn2Hezgb8l8OaJGuPPnrPxRghg6QcXJC0
         9THJ8SbRCT/kNk81AFZsZ3AzKhDUK/M55AOSPec8UJpHWe3uzk/utaYaVdQrBvm210Sy
         uUQU7kFtrL5xDZx0ulQY7oSGBhSU/mQuqNzKrzgYTm1Zrr5+mVdAyejT2F58IfeCt4qz
         rpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726954; x=1695331754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzuuSbvQBu+IbXhqgSc/Jh1UYlftCrb0q8uG/spw850=;
        b=P30miezjChdswN5gPBP87E0dL/BpOWT/qLOBBZekJV1OSgeVZkGD/ge/hUdi905Dco
         S7VBKVPSfEPoxYC/739ziFXFvEazOZI05bIroFThjGY/EZCquX5jPRzJdanZaEFyp7yz
         dWIu1C6qurJT+8mpjZnIe7CajHMBB8cpVEj9ai6MHmcsbam2KHFkIUj+uqe2vFbfTgid
         oXwBYuiHuFG7Lh34dsw5LMnF5iK+c6NeCiZ4V1kbCBTVtQ9G9kDnJB8ppg4pa8GNpi00
         Iy0AVn2NZEjmXP8fXt7u0z3sYaQTHuHtZADJnxMqpoDUWBVu3OjtqSeWFLJ3eL8+Bx3S
         fxHw==
X-Gm-Message-State: AOJu0Yw9YfffNlerx3S/IrB+ggPty+ooW6xnzyTC0tqb44Vr6M6IpMGp
        uidhEUhiC0VvYOv1JecIPL9sbQ==
X-Google-Smtp-Source: AGHT+IH2pBL+GCnm88FsSCmbVeSzooGPx1NYltGxuJiHW+YZPSu2JTInlBHQVlYA9XjiQHLjHSQqow==
X-Received: by 2002:a17:902:c40d:b0:1bc:3944:9391 with SMTP id k13-20020a170902c40d00b001bc39449391mr8221930plk.25.1694726954522;
        Thu, 14 Sep 2023 14:29:14 -0700 (PDT)
Received: from PF2LML5M-SMJ.lan ([49.7.199.134])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001b8b26fa6c1sm2022826plg.115.2023.09.14.14.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:29:14 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     guojinhui.liam@gmail.com, guojinhui.liam@hotmail.com,
        guojinhui.liam@outlook.com
Cc:     Jinhui Guo <guojinhui.liam@bytedance.com>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5] driver core: platform: set numa_node before platform_add_device()
Date:   Fri, 15 Sep 2023 05:28:53 +0800
Message-Id: <20230914212853.3509-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

platform_add_device() creates the numa_node attribute of sysfs according
to whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
of device before creating numa_node attribute of sysfs.

Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
V4 -> V5: Add Cc: stable line and changes from the previous submited
patches
V3 -> V4: Refactor code to be an ACPI function call
V2 -> V3: Fix Signed-off name
V1 -> V2: Fix compile error without enabling CONFIG_ACPI

 drivers/acpi/acpi_platform.c | 4 +---
 drivers/base/platform.c      | 1 +
 include/linux/acpi.h         | 5 +++++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..adcbfbdc343f 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -178,11 +178,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
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
index 76bfcba25003..35c891075d95 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -841,6 +841,7 @@ struct platform_device *platform_device_register_full(
 			goto err;
 	}
 
+	set_dev_node(&pdev->dev, ACPI_NODE_GET(ACPI_COMPANION(&pdev->dev)));
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a73246c3c35e..6a349d53f19e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -477,6 +477,10 @@ static inline int acpi_get_node(acpi_handle handle)
 	return 0;
 }
 #endif
+
+#define ACPI_NODE_GET(adev) ((adev) && (adev)->handle ? \
+	acpi_get_node((adev)->handle) : NUMA_NO_NODE)
+
 extern int pnpacpi_disabled;
 
 #define PXM_INVAL	(-1)
@@ -770,6 +774,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)
 #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
+#define ACPI_NODE_GET(adev)		NUMA_NO_NODE
 
 #include <acpi/acpi_numa.h>
 
-- 
2.20.1

