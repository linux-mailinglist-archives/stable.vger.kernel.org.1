Return-Path: <stable+bounces-93600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A6F9CF64A
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 21:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BC4B2F225
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97351D9346;
	Fri, 15 Nov 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ergs1W+V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06090CA5B;
	Fri, 15 Nov 2024 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702840; cv=none; b=ghmwXOZaBCnlKd9mfk+req4bgnKX7MC3I/nIvtIwUSr8Nn6FvGLeSmIVq1Ai5CCC+FjNMpG6iZ30IbTYgbMGfAdmp6mUy6uAaT8MpiTa156RWxmqKJF94yneGdaqVpSrCje3GtvfxuoJxgPiNK4h1S7gNqQF+W347q8IxbZDIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702840; c=relaxed/simple;
	bh=D6MXvLc81Yg075lDxYWl/fqk8OXIog3cLm3vP6cW+90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5hn974s5MVNHSZKb7hnx5T0MDka6NIm82MUwymYKiOf3B7Tsqe0cscnqJgtUMlrIzV+eD8dkXRH6UrL48qEtivKQ8Ka2cOD+HuEsmXaJM8/V7ZHvmw1mE6rBwYbtAgju9yK22peZ1um7Aih4nDnNqumWOCfu4OT9k02yUaAurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ergs1W+V; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731702839; x=1763238839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D6MXvLc81Yg075lDxYWl/fqk8OXIog3cLm3vP6cW+90=;
  b=ergs1W+V+5qAjIrzN76bkMTWIyVUTm1bi2L0pREDS+r5jLpmNP7ap+Dh
   LUwGoxCu93dGQkXSyB9Bt1wiJBj2cAcHx83PtcSb0q+D+9RNLWZMDLrUn
   r7q5ip/SHr8Ek8lY/CbjLJWM3LegSj+3JH+LF793DY9HW4/22MMFpK0rH
   OcjOGM3Y/HQwafY/vuyDvFl5kx217UH4NIfhGnga/cWkBh4CChyu3bAMx
   Tr4wKJbkXoQZU4F/Cvj5qoaPVF5Gq5denfkiVVzceM+dTmeoPnQl3mYMC
   K0dlUt0hsuBDmRsLX8Jj8JdJlYRjrEEMnbBCMCV1H7WAC8BWDbsWn8CKp
   A==;
X-CSE-ConnectionGUID: dYBxQ17URYCikI0qivmEzQ==
X-CSE-MsgGUID: eh4QE3P+QTONbDvEAAueuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31860933"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31860933"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 12:33:58 -0800
X-CSE-ConnectionGUID: WWlh8m5dTD+R7iM/KADzEA==
X-CSE-MsgGUID: l/DrzyGaSO27jDCO8wn4AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93679260"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.122]) ([10.125.108.122])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 12:33:57 -0800
Message-ID: <ccbacc79-6743-4a31-94e8-84f34e001279@intel.com>
Date: Fri, 15 Nov 2024 13:33:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.1.y] cxl/pci: fix error code in
 __cxl_hdm_decode_init()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Ben Widawsky <bwidawsk@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Sasha Levin <sashal@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yanfei Xu <yanfei.xu@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-cxl@vger.kernel.org,
 stable@vger.kernel.org
References: <380871e1-e048-459a-adc5-cfbb6e5d5b94@stanley.mountain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <380871e1-e048-459a-adc5-cfbb6e5d5b94@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/24 7:11 AM, Dan Carpenter wrote:
> When commit 0cab68720598 ("cxl/pci: Fix disabling memory if DVSEC CXL
> Range does not match a CFMWS window") was backported, this chunk moved
> from the cxl_hdm_decode_init() function which returns negative error
> codes to the __cxl_hdm_decode_init() function which returns false on
> error.  So the error code needs to be modified from -ENXIO to false.
> 
> This issue only exits in the 6.1.y kernels.  In later kernels negative
> error codes are correct and the driver didn't exist in earlier kernels.
> 
> Fixes: 031217128990 ("cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8d92a24fd73d..97adf9a7ea89 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -377,7 +377,7 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  
>  	if (!allowed && info->mem_enabled) {
>  		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
> -		return -ENXIO;
> +		return false;
>  	}
>  
>  	/*


