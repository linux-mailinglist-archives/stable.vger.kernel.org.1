Return-Path: <stable+bounces-192224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78AC2CEB5
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 16:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7441B425580
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE87316185;
	Mon,  3 Nov 2025 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWGE4oAT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB5316195
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183933; cv=none; b=JrMFuWhb8u1t4YJk1wzJoXpZ73Sc1ly8bljt8uWBpekUZnzzmkv1dh5AI+NHOAYhW87TJ7d/vGqPQKxrosTmPr1+5bVTuQfv8ZBuha62DbqsO+UWyzzuZkoDt94oEhKWbdDJNHhgNuNnn5tyM/UGyN4/a4FQBiMNL/682eEQP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183933; c=relaxed/simple;
	bh=CLjvPQOnyGhackzsm+kh8BLXHz1of9cY4P8NRMpf1J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxVi6YZ4lLaB8LCcEmil9rSBW8izXoAHUqmhP13zhn6/q/XUY8I0Zn+5pO2WQsZC82kvdsnDouztEOaoacgeBMVWkZr4Njsg2JCakxQkjJL0UZ+7vAklAd6uhQCbzPP9NYo+4Lkdgk6bGYe7Om1VcV0mB/jQbPZwTtTrtQVBOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWGE4oAT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762183930; x=1793719930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CLjvPQOnyGhackzsm+kh8BLXHz1of9cY4P8NRMpf1J8=;
  b=OWGE4oATRghpi41xss6URU0x920X93KxvXu2bhd9fFJavRJpzJNJDlY3
   4EM2TINloBXPrnVHGdSqjSz5RIrM6IiGiqYuZY91qxtoyeDDCLWEaU0sc
   m+GzJAbni+dJUnuEPRnCvNJQqcYzSTwz6ElEk/tNrc+EAgh6ITrUs5cxx
   dxxMQwhw4D9rsKzllvg+e5QZ7+vWyXyjQ1ivLrIzS+fUaGmrB3hPEMTpj
   uxOTJ3OJGvU+yA6P1F415nKfAqtk/AFpdJ3v/V5WpMuktS6UlnhOG6wMa
   g6vM/1eni1YEtj7nKCPrYKvS+8O1tF0VH4pik6U1r5vOFI5tciLp7k+ZY
   A==;
X-CSE-ConnectionGUID: uWLp16EZSf62rUVcioK+DQ==
X-CSE-MsgGUID: R6QRxo4YQgefbcHAXpf3nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89722584"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="89722584"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:32:10 -0800
X-CSE-ConnectionGUID: 8ZxUf6WtTUaf5Xr0cVyDyg==
X-CSE-MsgGUID: 59IB1wMIR5mNfT/itbLbIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186569918"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:32:10 -0800
Message-ID: <01e17cd1-a48d-4bf5-8ec7-4c858d3d0f71@intel.com>
Date: Mon, 3 Nov 2025 08:32:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/testing/nvdimm: Use per-DIMM device handle
To: Alison Schofield <alison.schofield@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: nvdimm@lists.linux.dev, stable@vger.kernel.org
References: <20251031234227.1303113-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251031234227.1303113-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 4:42 PM, Alison Schofield wrote:
> KASAN reports a global-out-of-bounds access when running these nfit
> tests: clear.sh, pmem-errors.sh, pfn-meta-errors.sh, btt-errors.sh,
> daxdev-errors.sh, and inject-error.sh.
> 
> [] BUG: KASAN: global-out-of-bounds in nfit_test_ctl+0x769f/0x7840 [nfit_test]
> [] Read of size 4 at addr ffffffffc03ea01c by task ndctl/1215
> [] The buggy address belongs to the variable:
> [] handle+0x1c/0x1df4 [nfit_test]
> 
> nfit_test_search_spa() uses handle[nvdimm->id] to retrieve a device
> handle and triggers a KASAN error when it reads past the end of the
> handle array. It should not be indexing the handle array at all.
> 
> The correct device handle is stored in per-DIMM test data. Each DIMM
> has a struct nfit_mem that embeds a struct acpi_nfit_memdev that
> describes the NFIT device handle. Use that device handle here. 
> 
> Fixes: 10246dc84dfc ("acpi nfit: nfit_test supports translate SPA")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
> 
> Changes in v2:
> - Use the correct handle in per-DIMM test data (Dan)
> - Update commit message and log
> - Update Fixes Tag
> 
> 
>  tools/testing/nvdimm/test/nfit.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index cfd4378e2129..f87e9f251d13 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -670,6 +670,7 @@ static int nfit_test_search_spa(struct nvdimm_bus *bus,
>  		.addr = spa->spa,
>  		.region = NULL,
>  	};
> +	struct nfit_mem *nfit_mem;
>  	u64 dpa;
>  
>  	ret = device_for_each_child(&bus->dev, &ctx,
> @@ -687,8 +688,12 @@ static int nfit_test_search_spa(struct nvdimm_bus *bus,
>  	 */
>  	nd_mapping = &nd_region->mapping[nd_region->ndr_mappings - 1];
>  	nvdimm = nd_mapping->nvdimm;
> +	nfit_mem = nvdimm_provider_data(nvdimm);
> +	if (!nfit_mem)
> +		return -EINVAL;
>  
> -	spa->devices[0].nfit_device_handle = handle[nvdimm->id];
> +	spa->devices[0].nfit_device_handle =
> +		__to_nfit_memdev(nfit_mem)->device_handle;
>  	spa->num_nvdimms = 1;
>  	spa->devices[0].dpa = dpa;
>  
> 
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada


