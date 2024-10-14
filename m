Return-Path: <stable+bounces-83772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58F699C906
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A75B292004
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ADD19F117;
	Mon, 14 Oct 2024 11:33:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC919F42F;
	Mon, 14 Oct 2024 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905618; cv=none; b=IBXnABXEZrrjFVwzju2Wq/ZITFpOzJDgaKHF0MeTocUUcVoqcNpms1niPqPHGfb6MZj3PdScCcWXI2yxwMshsmBfNB2uWKXLgs+Mqzn7+zIqNBHRHQHHIZ96Y4qBA9hQ4oF4GRMgfM9eWzIVNSCIF3LW66Mh0er3HRDttwt+dgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905618; c=relaxed/simple;
	bh=7Yl/4VbTnnC4Gh9bjyUQwT0KZLPhHoojN635dgyGWl0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4tw/HJebzfVmfFslocQCChb2l9Nx52MFrOHyc0FRqBRLoiQNk+yq4flZZBCMoKTSytC0RvLtcUfhIQGENJAMocCDu4Xc3yjjAuf2HHeY/J63ZKL+7ZAPyzzJkyammvXS/+Hqn82IWNaTSWRB6nmjuDMvWM+Iy33Xf+zHfD7FNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRw3j3dj5z6LDMX;
	Mon, 14 Oct 2024 19:29:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B0A7140C72;
	Mon, 14 Oct 2024 19:33:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 13:33:31 +0200
Date: Mon, 14 Oct 2024 12:33:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <ira.weiny@intel.com>, Gregory Price
	<gourry@gourry.net>, <stable@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/5] cxl/port: Fix CXL port initialization order when
 the subsystem is built-in
Message-ID: <20241014123329.00000045@Huawei.com>
In-Reply-To: <172862484072.2150669.9910214123827630595.stgit@dwillia2-xfh.jf.intel.com>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
	<172862484072.2150669.9910214123827630595.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Oct 2024 22:34:02 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> When the CXL subsystem is built-in the module init order is determined
> by Makefile order. That order violates expectations. The expectation is
> that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
> the race cxl_mem will find the enabled CXL root ports it needs and if
> cxl_acpi loses the race it will retrigger cxl_mem to attach via
> cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
> enabled immediately upone cxl_acpi_probe() return. That in turn can only

upon

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

My testing is all modular too :( 

> 
> Reported-by: Gregory Price <gourry@gourry.net>
> Closes: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
> Tested-by: Gregory Price <gourry@gourry.net>
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
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
>  drivers/cxl/Makefile |   12 ++++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)
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
> index db321f48ba52..374829359275 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,13 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y += core/
> -obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> -obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +obj-$(CONFIG_CXL_PORT) += cxl_port.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o

Needs some comments on the ordering being required.
Otherwise some future 'cleanup' will reorder them again.
However relying on build order is nasty.

> +obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> -obj-$(CONFIG_CXL_PORT) += cxl_port.o
> +obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  
> -cxl_mem-y := mem.o
> -cxl_pci-y := pci.o
> +cxl_port-y := port.o
>  cxl_acpi-y := acpi.o
> +cxl_pci-y := pci.o
>  cxl_pmem-y := pmem.o security.o
> -cxl_port-y := port.o
> +cxl_mem-y := mem.o
> 
> 


