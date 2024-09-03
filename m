Return-Path: <stable+bounces-72810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAEE969A43
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 437FEB22F0D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B81B9845;
	Tue,  3 Sep 2024 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjWyWp1V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F81AB6E7;
	Tue,  3 Sep 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359613; cv=none; b=YYkK5DUtj85MV0FeFWH+1dN8lm9u2PIro2uFs4CyzmibmsHNtQPEIS4fNK1DPzNs0ZvKpRewM9rgP+J2dTQbaTC6t9jOr7df1s501c2QxeSAY7P6b/P5GncJ0c2/BFG+wq07NntZheEXjhueCU6usoDaSLep51QrX2Y2annP6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359613; c=relaxed/simple;
	bh=fTT+aWDLLhs9sNZV9ZZI20DVYJjcBD7dSH6LGUCMFAI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tOE1sIhhw/qUt9xnwL5iBkpbKh81szyJ/Vlz+E+H6P4whg8QAEMEQTQDLTcxGy0gwBm7PAo2gG3iWNRr8pLMAoACY44SHLz3cD3gmFbQy3QHE8nhujW619oq8oFp+jnrcWgUoxR+U//1ocIBt4blLGux0YnlcZxkDY5ieHZw9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjWyWp1V; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725359611; x=1756895611;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fTT+aWDLLhs9sNZV9ZZI20DVYJjcBD7dSH6LGUCMFAI=;
  b=cjWyWp1V7LEzD6Em5TNJX906vsX70CgNwltkvH905EnwZhVkCINEJi9l
   gVYssMmGvbssM7ikP2xeyJXFqc8RCy1XzIBlofhNmE+QtfvEc8hygM/hd
   GblfQ0XSY5mzfmEGkGCMqvjIwoD1xZSk8YMB3E4BRZdZEEO0W+agGPbHF
   fk8PRKnnEQ5TN8Z+0njqoNWmerk/YLX/HrT79dV8H4TuQ5cQUFWU7E8kO
   0fHLNYkNcZDKEBtkyY7c+IL0Xlh1pteTlnGO06odxnfV1oEnmbTfgYx2T
   EplsxDum8/61EmNIKtn6YHu/IPmuwFcWIry4WY0LMTp5RPGA6RXKcBe3Y
   g==;
X-CSE-ConnectionGUID: CCvJViAZR1aNgbFVCij1MQ==
X-CSE-MsgGUID: /2ttKkeyTiOUliLTrm+fYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24107042"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="24107042"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 03:33:30 -0700
X-CSE-ConnectionGUID: IBoEyzBPS4GWd2zOYfaH/w==
X-CSE-MsgGUID: i8GdTIHWQvahuYCafpyqFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="64546282"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 03:33:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Sep 2024 13:33:23 +0300 (EEST)
To: Hans de Goede <hdegoede@redhat.com>
cc: Andy Shevchenko <andy@kernel.org>, James Harmison <jharmison@redhat.com>, 
    platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] platform/x86: panasonic-laptop: Allocate 1 entry
 extra in the sinf array
In-Reply-To: <20240903083533.9403-2-hdegoede@redhat.com>
Message-ID: <a22f5196-7fa4-6fc4-7354-3fcf8e99c2d8@linux.intel.com>
References: <20240903083533.9403-1-hdegoede@redhat.com> <20240903083533.9403-2-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Sep 2024, Hans de Goede wrote:

> Some DSDT-s have an of by one bug where the SINF package count is

of -> off

> one higher then the SQTY reported value, allocate 1 entry extra.
> 
> Also make the SQTY <-> SINF package count mismatch error more verbose
> to help debugging similar issues in the future.
> 
> This fixes the panasonic-laptop driver failing to probe() on some
> devices with the following errors:
> 
> [    3.958887] SQTY reports bad SINF length SQTY: 37 SINF-pkg-count: 38
> [    3.958892] Couldn't retrieve BIOS data
> [    3.983685] Panasonic Laptop Support - With Macros: probe of MAT0019:00 failed with error -5
> 
> Fixes: 709ee531c153 ("panasonic-laptop: add Panasonic Let's Note laptop extras driver v0.94")
> Cc: stable@vger.kernel.org
> Tested-by: James Harmison <jharmison@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/panasonic-laptop.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index d7f9017a5a13..4c9e20e1afe8 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -337,7 +337,8 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
>  	}
>  
>  	if (pcc->num_sifr < hkey->package.count) {
> -		pr_err("SQTY reports bad SINF length\n");
> +		pr_err("SQTY reports bad SINF length SQTY: %ld SINF-pkg-count: %d\n",
> +		       pcc->num_sifr, hkey->package.count);

Both are unsigned so dont use d but u formatting.

>  		status = AE_ERROR;
>  		goto end;
>  	}
> @@ -968,6 +969,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * Some DSDT-s have an of by one bug where the SINF package count is

off

> +	 * one higher then the SQTY reported value, allocate 1 entry extra.
> +	 */
> +	num_sifr++;
> +
>  	pcc = kzalloc(sizeof(struct pcc_acpi), GFP_KERNEL);
>  	if (!pcc) {
>  		pr_err("Couldn't allocate mem for pcc");
> 

-- 
 i.


