Return-Path: <stable+bounces-121140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47EA54141
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 04:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B743A83C9
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F21946BC;
	Thu,  6 Mar 2025 03:35:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1C185B76;
	Thu,  6 Mar 2025 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232153; cv=none; b=OLkDkQsJL1VsNzi0T4EKA6g8t9q7/UQufqHCAmBRCGFOLp/r/KCnTxw+v61qhYtomq5xkopskBqc7J7gVK7JYJRF6mfNaWuT23b+BjJsByfd2x8i8iFGth9T3gV3vvcG+nrvdL3DAhGDPTthT2JpqN9nIYIW/qpF3NvwKR0VXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232153; c=relaxed/simple;
	bh=FJYMs784lA5chz9oCN41fUHCj/LPe5ipzFX5DvTb3yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oxP0xQJJnFbiTSPxfWy9FOBlBBx2/LypSrHPO3L6df5CtBl4orQRvcIWRwTGxtXVLspH/YGtodWHOvWJlEr3PaUvRGSH1OKEI3wk8J+27D8Rb/T6aoLvlybI72fW6JP/4uu16GxLvy5w783rGKXt7SR38bo9jZoHWZO1pKD/Vmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z7Zhb6wg4z1f0CF;
	Thu,  6 Mar 2025 11:31:27 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A58E1A0190;
	Thu,  6 Mar 2025 11:35:42 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Mar 2025 11:35:41 +0800
Message-ID: <dac30597-6d62-46f4-9493-059344e253c4@huawei.com>
Date: Thu, 6 Mar 2025 11:35:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is there something wrong with v5.10.234 patch 664760c49d98
 ("xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals")?
To: <gregkh@linuxfoundation.org>
CC: <akpm@linux-foundation.org>, <jslaby@suse.cz>,
	<linux-kernel@vger.kernel.org>, <lwn@lwn.net>, <stable@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <chenweilong@huawei.com>,
	<liuyongqiang13@huawei.com>, <arnd@arndb.de>
References: <2025020133-ultimatum-legwork-0940@gregkh>
 <20250306023301.125540-1-zhangzekun11@huawei.com>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <20250306023301.125540-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Sorry for make noise. Please ignore this messgae.
The latter patch c762b76981fc ("Partial revert of xhci: use pm_ptr() 
instead #ifdef for CONFIG_PM conditionals") patial revert the patch, So, 
there is no such problem with the patch.

Thanks,
Zekunk

在 2025/3/6 10:33, Zhang Zekun 写道:
> Hi, Greg,
> The stable patch 664760c49d98 ("xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals") in linux-5.10.y, is different with the mainline patch. In the following code.
> 
> mainline:
> -#ifdef CONFIG_PM
> -       xhci_pci_hc_driver.pci_suspend = xhci_pci_suspend;
> -       xhci_pci_hc_driver.pci_resume = xhci_pci_resume;
> -       xhci_pci_hc_driver.pci_poweroff_late = xhci_pci_poweroff_late;
> -       xhci_pci_hc_driver.shutdown = xhci_pci_shutdown;
> -#endif
> +       xhci_pci_hc_driver.pci_suspend = pm_ptr(xhci_pci_suspend);		
> +       xhci_pci_hc_driver.pci_resume = pm_ptr(xhci_pci_resume);		
> +       xhci_pci_hc_driver.pci_poweroff_late = pm_ptr(xhci_pci_poweroff_late);	
> +       xhci_pci_hc_driver.shutdown = pm_ptr(xhci_pci_shutdown);		
> 
> linux-5.10.y:
> -#ifdef CONFIG_PM
>   	xhci_pci_hc_driver.pci_suspend = xhci_pci_suspend;
>   	xhci_pci_hc_driver.pci_resume = xhci_pci_resume;
>   	xhci_pci_hc_driver.shutdown = xhci_pci_shutdown;
> -#endif
> 
> xhci_pci_shutdown() in mainline is wrapped with pm_ptr(), which is NULL if CONFIG_PM is not enabled, but for linux-5.10.y, xhci_pci_shutdown() it will not be converted to a NULL pointer. The .shutdown() function seems has been used in usb_hcd_platform_shutdown() in usb platfrom device shutdown routine:
> 
> drivers/usb/host/ehci-atmel.c:  .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-brcm.c:   .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-exynos.c: .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-fsl.c:    .shutdown = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-grlib.c:  .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-mxc.c:    .shutdown = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-npcm7xx.c:        .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-omap.c:   .shutdown               = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-orion.c:  .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-platform.c:       .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-ppc-of.c: .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-spear.c:  .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-st.c:     .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ehci-xilinx-of.c:      .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-at91.c:   usb_hcd_platform_shutdown(pdev);
> drivers/usb/host/ohci-at91.c:   .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-da8xx.c:  .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-omap.c:   .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-platform.c:       .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-ppc-of.c: .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-pxa27x.c: .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-s3c2410.c:        .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-sm501.c:  .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-st.c:     .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/ohci-tmio.c:   .shutdown       = usb_hcd_platform_shutdown,
> drivers/usb/host/xhci-plat.c:   .shutdown = usb_hcd_platform_shutdown,
>   
> For the mainline patch seems does not want to call xhci_pci_shutdown() when CONFIG_PM is diabled, is there something wrong with the stable patch?


