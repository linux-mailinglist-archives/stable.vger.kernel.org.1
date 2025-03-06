Return-Path: <stable+bounces-121135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10349A540CB
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446E5168F5D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5218E054;
	Thu,  6 Mar 2025 02:42:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68961BE46;
	Thu,  6 Mar 2025 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228946; cv=none; b=SWKuErvyhAGKMfs1QUoPCCo8I+lK4NBNPM9Eduh7s3uFyXbkFkpVKvWz4IvDS9U0IVAcbBnEeWYMLvBY7HMBmBRJEnJe+9pX7gLnLsM4PH/92NGm2uBYBYJMGW1CO/r8YNWQMbJlMsZKbilhDojMuGkiyV2o0hRSaiPMIEWcwN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228946; c=relaxed/simple;
	bh=/lrfeCf3sMekVjZTiHvHgbFc5dmY9dc80TFu61Ml3+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BztAxTqa4dXcmADvs5KHgm9Gtead28j5eYEQdsDMJUKgt/gHapFvonoiKcYFzq2QrI30xR5oN7/4+IMN+vFMIwN4pm4JkdlZKJA9zLs7uMoA+VTY2xBaQSpGifpg4BGgAR1Gv4zsfgNOc3uNU8hQ2+Js858OyTzmeAlH1QGMoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z7YWr4rl4zCs9Q;
	Thu,  6 Mar 2025 10:38:48 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B1E8B1800CD;
	Thu,  6 Mar 2025 10:42:18 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Mar
 2025 10:42:17 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <akpm@linux-foundation.org>, <jslaby@suse.cz>,
	<linux-kernel@vger.kernel.org>, <lwn@lwn.net>, <stable@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <chenweilong@huawei.com>,
	<liuyongqiang13@huawei.com>, <arnd@arndb.de>, <zhangzekun11@huawei.com>
Subject: Is there something wrong with v5.10.234 patch 664760c49d98 ("xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals")?
Date: Thu, 6 Mar 2025 10:33:01 +0800
Message-ID: <20250306023301.125540-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <2025020133-ultimatum-legwork-0940@gregkh>
References: <2025020133-ultimatum-legwork-0940@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Hi, Greg,
The stable patch 664760c49d98 ("xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals") in linux-5.10.y, is different with the mainline patch. In the following code.

mainline:
-#ifdef CONFIG_PM
-       xhci_pci_hc_driver.pci_suspend = xhci_pci_suspend;
-       xhci_pci_hc_driver.pci_resume = xhci_pci_resume;
-       xhci_pci_hc_driver.pci_poweroff_late = xhci_pci_poweroff_late;
-       xhci_pci_hc_driver.shutdown = xhci_pci_shutdown;
-#endif
+       xhci_pci_hc_driver.pci_suspend = pm_ptr(xhci_pci_suspend);		
+       xhci_pci_hc_driver.pci_resume = pm_ptr(xhci_pci_resume);		
+       xhci_pci_hc_driver.pci_poweroff_late = pm_ptr(xhci_pci_poweroff_late);	
+       xhci_pci_hc_driver.shutdown = pm_ptr(xhci_pci_shutdown);		

linux-5.10.y:
-#ifdef CONFIG_PM
 	xhci_pci_hc_driver.pci_suspend = xhci_pci_suspend;
 	xhci_pci_hc_driver.pci_resume = xhci_pci_resume;
 	xhci_pci_hc_driver.shutdown = xhci_pci_shutdown;
-#endif

xhci_pci_shutdown() in mainline is wrapped with pm_ptr(), which is NULL if CONFIG_PM is not enabled, but for linux-5.10.y, xhci_pci_shutdown() it will not be converted to a NULL pointer. The .shutdown() function seems has been used in usb_hcd_platform_shutdown() in usb platfrom device shutdown routine:

drivers/usb/host/ehci-atmel.c:  .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-brcm.c:   .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-exynos.c: .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-fsl.c:    .shutdown = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-grlib.c:  .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-mxc.c:    .shutdown = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-npcm7xx.c:        .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-omap.c:   .shutdown               = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-orion.c:  .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-platform.c:       .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-ppc-of.c: .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-spear.c:  .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-st.c:     .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ehci-xilinx-of.c:      .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-at91.c:   usb_hcd_platform_shutdown(pdev);
drivers/usb/host/ohci-at91.c:   .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-da8xx.c:  .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-omap.c:   .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-platform.c:       .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-ppc-of.c: .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-pxa27x.c: .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-s3c2410.c:        .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-sm501.c:  .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-st.c:     .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/ohci-tmio.c:   .shutdown       = usb_hcd_platform_shutdown,
drivers/usb/host/xhci-plat.c:   .shutdown = usb_hcd_platform_shutdown,
 
For the mainline patch seems does not want to call xhci_pci_shutdown() when CONFIG_PM is diabled, is there something wrong with the stable patch? 

