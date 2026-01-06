Return-Path: <stable+bounces-205061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C66CF796E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 10:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5972C301B8B6
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C7E3246F3;
	Tue,  6 Jan 2026 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LESvLVJM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C83242CF;
	Tue,  6 Jan 2026 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692684; cv=none; b=usGP/pi3TYNG3USRXPWAGS7ZiFhqe1nnVgFz0ceASPYRukOGRNdRwg087ZQtZDHURWJF4BJvkN0/Wan1USDggl7qcMS/vEpHmzR5UXtTfnp+rIttnsyXR9UPqUO4GHvJmDF+G4r8MeyOsj6FF6/DYMqvnqqEtyaNK3nMrUSTisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692684; c=relaxed/simple;
	bh=OxWQv3c9R3W1KnWbJtbr/p11sVZFVRrKl+EOUmSqBLI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jxl6ddw4TYE5Y3JqOyqZpngGbSxcRtTf3kYJU76aDTAlhOUBJzB/ibCE32PDQ4Sr6FvOuNplcXWvJX27cl77Y8nVJQHaynoNWYKpY3Xm+98cWQ5bDI7GOzSYUT7BzfmFiTjlM2iYWFHYo/7NBimqVQlwXao+lNrPyxe9DrAFxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LESvLVJM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767692683; x=1799228683;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OxWQv3c9R3W1KnWbJtbr/p11sVZFVRrKl+EOUmSqBLI=;
  b=LESvLVJMjmXBofAllxpnD0Fh3Gr74pmrXVUtwqUgrt7iSr4rGyZx+L2P
   xNXj5dooQ49C1Z5nbwdIzraKueYktP1cpOvYAQh7zQ7NNW0MGZCFw+M0E
   SefcwvA5DT2r75KMBNxj6G8qOrveZwKVEpaziOGcJHFh2EwpmF0C1G5iR
   6GVhH+kxrHnnSof9AcaDNtHG+ck5V+CZJLBe4/JRudZeJPpZmCwBIRwLy
   vV+bRLnYdmP5XKmwnBd6oA2fav++yXd5n72PUez3j5z8PTRmq+POWbyca
   Ly3wSqYbs+Z3l9DpWsJqNaaKh3TIkI87DlOAiU++vSmlgvzKbCLT4gCi4
   w==;
X-CSE-ConnectionGUID: M6qqGKhQTeSJHX9Cp2MSKg==
X-CSE-MsgGUID: nKzFGzGaQ4ayL+2BgYVsqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="68255602"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="68255602"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 01:44:42 -0800
X-CSE-ConnectionGUID: rPqO67NZTE63PJ2CDTUvlw==
X-CSE-MsgGUID: 4DYgq28gSWm7EdAjhLCKkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="202239537"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.6])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 01:44:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Jan 2026 11:44:36 +0200 (EET)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: ISST: Store and restore all domains
 data
In-Reply-To: <20251229183450.823244-3-srinivas.pandruvada@linux.intel.com>
Message-ID: <39be18a6-d50e-e625-1347-7709cea78ea6@linux.intel.com>
References: <20251229183450.823244-1-srinivas.pandruvada@linux.intel.com> <20251229183450.823244-3-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Dec 2025, Srinivas Pandruvada wrote:

> The suspend/resume callbacks currently only store and restore the
> configuration for power domain 0. However, other power domains may also
> have modified configurations that need to be preserved across suspend/
> resume cycles.
> 
> Extend the store/restore functionality to handle all power domains.
> 
> Fixes: 91576acab020 ("platform/x86: ISST: Add suspend/resume callbacks")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> CC: stable@vger.kernel.org
> ---
>  .../intel/speed_select_if/isst_tpmi_core.c    | 53 ++++++++++++-------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index f587709ddd47..47026bb3e1af 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -1723,55 +1723,68 @@ EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, "INTEL_TPMI_SST");
>  void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev)
>  {
>  	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
> -	struct tpmi_per_power_domain_info *power_domain_info;
> +	struct tpmi_per_power_domain_info *power_domain_info, *pd_info;
>  	struct oobmsm_plat_info *plat_info;
>  	void __iomem *cp_base;
> +	int num_resources, i;
>  
>  	plat_info = tpmi_get_platform_data(auxdev);
>  	if (!plat_info)
>  		return;
>  
>  	power_domain_info = tpmi_sst->power_domain_info[plat_info->partition];
> +	num_resources = tpmi_sst->number_of_power_domains[plat_info->partition];
>  
> -	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
> -	power_domain_info->saved_sst_cp_control = readq(cp_base + SST_CP_CONTROL_OFFSET);
> +	for (i = 0; i < num_resources; i++) {
> +		pd_info = &power_domain_info[i];
> +		if (!pd_info || !pd_info->sst_base)
> +			continue;
>  
> -	memcpy_fromio(power_domain_info->saved_clos_configs, cp_base + SST_CLOS_CONFIG_0_OFFSET,
> -		      sizeof(power_domain_info->saved_clos_configs));
> +		cp_base = pd_info->sst_base + pd_info->sst_header.cp_offset;
>  
> -	memcpy_fromio(power_domain_info->saved_clos_assocs, cp_base + SST_CLOS_ASSOC_0_OFFSET,
> -		      sizeof(power_domain_info->saved_clos_assocs));
> +		pd_info->saved_sst_cp_control = readq(cp_base + SST_CP_CONTROL_OFFSET);
> +		memcpy_fromio(pd_info->saved_clos_configs, cp_base + SST_CLOS_CONFIG_0_OFFSET,
> +			      sizeof(pd_info->saved_clos_configs));
> +		memcpy_fromio(pd_info->saved_clos_assocs, cp_base + SST_CLOS_ASSOC_0_OFFSET,
> +			      sizeof(pd_info->saved_clos_assocs));
>  
> -	power_domain_info->saved_pp_control = readq(power_domain_info->sst_base +
> -						    power_domain_info->sst_header.pp_offset +
> -						    SST_PP_CONTROL_OFFSET);
> +		pd_info->saved_pp_control = readq(pd_info->sst_base +
> +						  pd_info->sst_header.pp_offset +
> +						  SST_PP_CONTROL_OFFSET);
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_suspend, "INTEL_TPMI_SST");
>  
>  void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
>  {
>  	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
> -	struct tpmi_per_power_domain_info *power_domain_info;
> +	struct tpmi_per_power_domain_info *power_domain_info, *pd_info;
>  	struct oobmsm_plat_info *plat_info;
>  	void __iomem *cp_base;
> +	int num_resources, i;
>  
>  	plat_info = tpmi_get_platform_data(auxdev);
>  	if (!plat_info)
>  		return;
>  
>  	power_domain_info = tpmi_sst->power_domain_info[plat_info->partition];
> +	num_resources = tpmi_sst->number_of_power_domains[plat_info->partition];
>  
> -	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
> -	writeq(power_domain_info->saved_sst_cp_control, cp_base + SST_CP_CONTROL_OFFSET);
> -
> -	memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET, power_domain_info->saved_clos_configs,
> -		    sizeof(power_domain_info->saved_clos_configs));
> +	for (i = 0; i < num_resources; i++) {
> +		pd_info = &power_domain_info[i];
> +		if (!pd_info || !pd_info->sst_base)
> +			continue;
>  
> -	memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET, power_domain_info->saved_clos_assocs,
> -		    sizeof(power_domain_info->saved_clos_assocs));
> +		cp_base = pd_info->sst_base + pd_info->sst_header.cp_offset;
> +		writeq(pd_info->saved_sst_cp_control, cp_base + SST_CP_CONTROL_OFFSET);
> +		memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET, pd_info->saved_clos_configs,
> +			    sizeof(pd_info->saved_clos_configs));
> +		memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET, pd_info->saved_clos_assocs,
> +			    sizeof(pd_info->saved_clos_assocs));

Why is the use of empty lines inconsistent between suspend and resume?

> -	writeq(power_domain_info->saved_pp_control, power_domain_info->sst_base +
> -				power_domain_info->sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
> +		writeq(pd_info->saved_pp_control, power_domain_info->sst_base +
> +		       pd_info->sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_resume, "INTEL_TPMI_SST");
>  
> 

-- 
 i.


