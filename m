Return-Path: <stable+bounces-88022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A789AE140
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670E0282887
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2CF18B488;
	Thu, 24 Oct 2024 09:42:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA116133C;
	Thu, 24 Oct 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762963; cv=none; b=qnr+XI9Jtkm4tEurC9VwgQvsmySae2S76Vd5Jjb5v5L7TTJuSJvM4Sft3nwbiYo75IPZyDhP0tT8LEsF34IQKfWHDWpWzfVUHzL7a5EWlKKi4amTg0YhO/4L5du1RUXRrCy8itG6xqAWMtENIwfQmeDfmySssxJzI637ayoqMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762963; c=relaxed/simple;
	bh=WLyPCKUsxa+aF4s8tvR8dDpecj/YGlAeHvuK7v5dqxU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5rNX/WNZ+1pw0fhDLmpska3HSiPJuvmnTB1AryIQQ1mGPhzOmciHjun7u+xnLp2z4POc0QR1x9KBOC8KzFqk7iprbbvbAAvqU6U2Md9iYdM7VFAELApOsA/YpKKf8lnxDR9WmaMRL+yHzxPxVu2C6X9V2xDrcCEQKdAKrChcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZ1C673TLz6K9CJ;
	Thu, 24 Oct 2024 17:41:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 77A2D140158;
	Thu, 24 Oct 2024 17:42:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Oct
 2024 11:42:38 +0200
Date: Thu, 24 Oct 2024 10:42:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, Gregory Price <gourry@gourry.net>,
	<stable@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] cxl/port: Fix CXL port initialization order when
 the subsystem is built-in
Message-ID: <20241024104237.000067f9@Huawei.com>
In-Reply-To: <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
	<172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Oct 2024 18:43:24 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> When the CXL subsystem is built-in the module init order is determined
> by Makefile order. That order violates expectations. The expectation is
> that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
> the race cxl_mem will find the enabled CXL root ports it needs and if
> cxl_acpi loses the race it will retrigger cxl_mem to attach via
> cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
> enabled immediately upon cxl_acpi_probe() return. That in turn can only
> happen in the CONFIG_CXL_ACPI=y case if the cxl_port object appears
> before the cxl_acpi object in the Makefile.
> 
> Fix up the order to prevent initialization failures, and make sure that
> cxl_port is built-in if cxl_acpi is also built-in.
> 
> As for what contributed to this not being found earlier, the CXL
> regression environment, cxl_test, builds all CXL functionality as a
> module to allow to symbol mocking and other dynamic reload tests.  As a
> result there is no regression coverage for the built-in case.
> 
> Reported-by: Gregory Price <gourry@gourry.net>
> Closes: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
> Tested-by: Gregory Price <gourry@gourry.net>
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")

I don't like this due to likely long term fragility, but any other
solution is probably more painful.  Long term we should really get
a regression test for these ordering issues in place in one of
the CIs.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> Cc: <stable@vger.kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/Kconfig  |    1 +
>  drivers/cxl/Makefile |   20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 29c192f20082..876469e23f7a 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -60,6 +60,7 @@ config CXL_ACPI
>  	default CXL_BUS
>  	select ACPI_TABLE_LIB
>  	select ACPI_HMAT
> +	select CXL_PORT
>  	help
>  	  Enable support for host managed device memory (HDM) resources
>  	  published by a platform's ACPI CXL memory layout description.  See
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index db321f48ba52..2caa90fa4bf2 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,13 +1,21 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +# Order is important here for the built-in case:
> +# - 'core' first for fundamental init
> +# - 'port' before platform root drivers like 'acpi' so that CXL-root ports
> +#   are immediately enabled
> +# - 'mem' and 'pmem' before endpoint drivers so that memdevs are
> +#   immediately enabled
> +# - 'pci' last, also mirrors the hardware enumeration hierarchy
>  obj-y += core/
> -obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> -obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +obj-$(CONFIG_CXL_PORT) += cxl_port.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> -obj-$(CONFIG_CXL_PORT) += cxl_port.o
> +obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>  
> -cxl_mem-y := mem.o
> -cxl_pci-y := pci.o
> +cxl_port-y := port.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
> -cxl_port-y := port.o
> +cxl_mem-y := mem.o
> +cxl_pci-y := pci.o
> 
> 


