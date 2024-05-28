Return-Path: <stable+bounces-47602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11A98D27F1
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 00:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8809328B792
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 22:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B70146D60;
	Tue, 28 May 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvSWDs9U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE3145B3D;
	Tue, 28 May 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934834; cv=none; b=J9e1lwjR/ejguT2w9RwIBlG/Psc3wLNUgxXuPtN0n/w96N0csX7dZbRtl2zd3Ah5ynmq0iEOZLtNBJvFBfMFxMusR4RvkIoaWfnwMdAgdFcVNovqj0pWEaQEQUcU3gwTsvCRIZ/cOyEX5KZL5O0g0RHeAskW1MGuf3dRvCeVoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934834; c=relaxed/simple;
	bh=7nKtEjUjrHgnutoVQNvajnXaBJSu8Ka0MfzltiB0bbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns+bUbiyiwid39Pph3Vi2M5ZbJ0csxi847o2sKJNDYmEhaVr6CGwWeYSAovTORFUCG74cOQ7zqjHIpmRPPOs7BwZ24RLbkwVNIIwCwVKqRW6tRvmVbGl3Fldp3c4+W8+1xjRPEav4kfnIYqmKNkyN+cb6a+r95RLNjsuGkWRSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvSWDs9U; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934833; x=1748470833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7nKtEjUjrHgnutoVQNvajnXaBJSu8Ka0MfzltiB0bbw=;
  b=IvSWDs9Up45XlWhVdV0APnKP8DY+uU5TVZaVqXjwHkIyLpjvLxcdBpJR
   KUpc1bgsqJgqBxL0keIIfLd2Ddfq1PRKfxu+WdkJZs3RjXqWlfzRDvDme
   yT+Qhe4gebF5nj5wjY4NquP+izpDyQX+kJrze8UBHVDzjbJBdT1O64/OR
   xNHMG7PqSYljxogVpS/7tK24u+xLuTjkCH4F1rgMGtRt6+aCi2uvWH3y3
   h6gWcWOyBf3kcdtN9d0ebr4MbP7CO+sfTi3d1vdkleEd9bu0drBP7Ua63
   KoAaC18FzAnBM/EmbqLKug6xGvKdURkmKFs2J4kQi5Giz43Ovbb+G4ux2
   g==;
X-CSE-ConnectionGUID: K+hhBmO1T/eEMcYKk1qt4g==
X-CSE-MsgGUID: 88sY8BDwR129tsXnh2l4lA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23866748"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="23866748"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:33 -0700
X-CSE-ConnectionGUID: y4jGWFoXQ3WGhRijcOHfoA==
X-CSE-MsgGUID: rleJA2KpTmKEs3fU2loXtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72658422"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.99.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:31 -0700
Date: Tue, 28 May 2024 15:20:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/pci: Convert PCIBIOS_* return codes to errnos
Message-ID: <ZlZYrsPfzAiFzNLM@aschofie-mobl2>
References: <20240527123403.13098-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527123403.13098-1-ilpo.jarvinen@linux.intel.com>

On Mon, May 27, 2024 at 03:34:02PM +0300, Ilpo Järvinen wrote:
> pci_{read,write}_config_*word() and pcie_capability_read_word() return
> PCIBIOS_* codes, not usual errnos.
> 
> Fix return value checks to handle PCIBIOS_* return codes correctly by
> dropping < 0 from the check and convert the PCIBIOS_* return codes into
> errnos using pcibios_err_to_errno() before returning them.


Do we ever make a bad decision based on the wrong rc value or is this
a correction to the emitted dev_*() messaging, or both?

-- Alison

> 
> Fixes: ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory related info")
> Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> Fixes: 14d788740774 ("cxl/mem: Consolidate CXL DVSEC Range enumeration in the core")
> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/cxl/core/pci.c | 30 +++++++++++++++---------------
>  drivers/cxl/pci.c      |  2 +-
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8567dd11eaac..9ca67d4e0a89 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -121,7 +121,7 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>  					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
>  					   &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
>  		if (valid)
> @@ -155,7 +155,7 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
>  		if (active)
> @@ -188,7 +188,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  	rc = pci_read_config_word(pdev,
>  				  d + CXL_DVSEC_CAP_OFFSET, &cap);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
>  	for (i = 0; i < hdm_count; i++) {
> @@ -225,7 +225,7 @@ static int wait_for_valid(struct pci_dev *pdev, int d)
>  	 */
>  	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (val & CXL_DVSEC_MEM_INFO_VALID)
>  		return 0;
> @@ -234,7 +234,7 @@ static int wait_for_valid(struct pci_dev *pdev, int d)
>  
>  	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (val & CXL_DVSEC_MEM_INFO_VALID)
>  		return 0;
> @@ -250,8 +250,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	int rc;
>  
>  	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> -	if (rc < 0)
> -		return rc;
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
>  
>  	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
>  		return 1;
> @@ -259,8 +259,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	ctrl |= val;
>  
>  	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
> -	if (rc < 0)
> -		return rc;
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
>  
>  	return 0;
>  }
> @@ -336,11 +336,11 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  
>  	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
>  		dev_dbg(dev, "Not MEM Capable\n");
> @@ -379,14 +379,14 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		size = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
>  		if (!size) {
> @@ -400,14 +400,14 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		base = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e53646e9f2fb..0ec9cbc64896 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -540,7 +540,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (cap & PCI_EXP_DEVCTL_URRE) {
>  		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> -- 
> 2.39.2
> 

