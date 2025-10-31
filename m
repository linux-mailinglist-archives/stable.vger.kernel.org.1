Return-Path: <stable+bounces-191957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F82C26AE4
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 20:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97541188E8A1
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732B30648A;
	Fri, 31 Oct 2025 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dA+laSN8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0A2F83B3
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937971; cv=none; b=BuQt4glT1zotsW+ABJ48sYYdDBQGKlsRoFLt6KvG2lYqyV0gAvtWzu6VbtaNPiO5Gaw/g+Q07SiVUFmW5G4YciZMPp9vYVJ/PG51W0BHNnWGrNo2msj7Cp5Ev6OYA0ujVChDSHB87whweWjLH/pMItu5c3+YfYTSv9ahvjYjXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937971; c=relaxed/simple;
	bh=LX5p3woLzMcUgFCZNWnFvWK4ckTrzIKT2P3boAHSCHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ek2X9fmiMFR1j/due4ToJJb8etfI4ou4mj/ftm0Yk5M6vnvu42V/L94NioHSW3PZLdQ9w1ApAaQ2SlU8rL1WP+s+vAvShPtm3pe32CAoAcGkV3cV4ikxPwV+QMI9zt74EDg6EtF0KjIpSQqgzZ7rYLZ/vL1nqqA0zAcJFeRe+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dA+laSN8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761937970; x=1793473970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LX5p3woLzMcUgFCZNWnFvWK4ckTrzIKT2P3boAHSCHQ=;
  b=dA+laSN8UyicALz/yW3Ee2hyEo9gPq44cK9D12hd2v8sczJZGtZjK+MS
   u9D6qnru4PrbpjUXKup/VEc4i6NicM9EBgl1SACcTeUVVeQqPmagNK2Ww
   +MDgCFNvYLRIFlpAkXIpM1ArdL145sx3tgkJjJfdS2CVO266zA3iCNq5R
   yEAv4i/SIYsT/MisWNe5GdZHHgTq4/xS+EcUR6zoRmtXjSOShxhwDPdHT
   E8gDGd+AYqFjI0Gtk3pEEzoLEdZ3/KOcB5kiyDq9xX1maPrYBTieXkhtU
   plzIGzQHWp+PoeQpCTjtGH/H8AEe3e71BnxMQZEmzvz28c8nOEz18KOjz
   w==;
X-CSE-ConnectionGUID: 33xrSqpLSveN0HtD8mQF8g==
X-CSE-MsgGUID: t6lYB3jpREynEv6nV0rBbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="74781578"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="74781578"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:12:47 -0700
X-CSE-ConnectionGUID: 38UhnxzhRSS3Y8t8wfSPZw==
X-CSE-MsgGUID: 1YZ6zaFiRgOPRvN8aXiNRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="187049397"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:12:47 -0700
Message-ID: <db69dfe3-3488-4f84-8530-ae694356de38@intel.com>
Date: Fri, 31 Oct 2025 12:12:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/testing/nvdimm: Stop read past end of global handle
 array
To: Alison Schofield <alison.schofield@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: nvdimm@lists.linux.dev, stable@vger.kernel.org
References: <20251030004222.1245986-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251030004222.1245986-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/25 5:42 PM, Alison Schofield wrote:
> KASAN reports a global-out-of-bounds access when running these nfit
> tests: clear.sh, pmem-errors, pfn-meta-errors.sh, btt-errors.sh,
> daxdev-errors.sh, and inject-error.sh.
> 
> [] BUG: KASAN: global-out-of-bounds in nfit_test_ctl+0x769f/0x7840 [nfit_test]
> [] Read of size 4 at addr ffffffffc03ea01c by task ndctl/1215
> [] The buggy address belongs to the variable:
> [] handle+0x1c/0x1df4 [nfit_test]
> 
> The nfit_test mock platform defines a static table of 7 NFIT DIMM
> handles, but nfit_test.0 builds 8 mock DIMMs total (5 DCR + 3 PM).
> When the final DIMM (id == 7) is selected, this code:
>     spa->devices[0].nfit_device_handle = handle[nvdimm->id];
> indexes past the end of the 7-entry table, triggering KASAN.
> 
> Fix this by adding an eighth entry to the handle[] table and a
> defensive bounds check so the test fails cleanly instead of
> dereferencing out-of-bounds memory.
> 
> To generate a unique handle, the new entry sets the 'imc' field rather
> than the 'chan' field. This matches the pattern of earlier entries
> and avoids introducing a non-zero 'chan' which is never used in the
> table. Computing the new handle shows no collision.
> 
> Notes from spelunkering for a Fixes Tag:
> 
> Commit 209851649dc4 ("acpi: nfit: Add support for hot-add") increased
> the mock DIMMs to eight yet kept the handle[] array at seven.
> 
> Commit 10246dc84dfc ("acpi nfit: nfit_test supports translate SPA")
> began using the last mock DIMM, triggering the KASAN.
> 
> Commit af31b04b67f4 ("tools/testing/nvdimm: Fix the array size for
> dimm devices.") addressed a related KASAN warning but not the actual
> handle array length.
> 
> Fixes: 209851649dc4 ("acpi: nfit: Add support for hot-add")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  tools/testing/nvdimm/test/nfit.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index cfd4378e2129..cdbf9e8ee80a 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -129,6 +129,7 @@ static u32 handle[] = {
>  	[4] = NFIT_DIMM_HANDLE(0, 1, 0, 0, 0),
>  	[5] = NFIT_DIMM_HANDLE(1, 0, 0, 0, 0),
>  	[6] = NFIT_DIMM_HANDLE(1, 0, 0, 0, 1),
> +	[7] = NFIT_DIMM_HANDLE(1, 0, 1, 0, 1),
>  };
>  
>  static unsigned long dimm_fail_cmd_flags[ARRAY_SIZE(handle)];
> @@ -688,6 +689,13 @@ static int nfit_test_search_spa(struct nvdimm_bus *bus,
>  	nd_mapping = &nd_region->mapping[nd_region->ndr_mappings - 1];
>  	nvdimm = nd_mapping->nvdimm;
>  
> +	if (WARN_ON_ONCE(nvdimm->id >= ARRAY_SIZE(handle))) {
> +		dev_err(&bus->dev,
> +			"invalid nvdimm->id %u >= handle array size %zu\n",
> +			nvdimm->id, ARRAY_SIZE(handle));
> +		return -EINVAL;
> +	}
> +
>  	spa->devices[0].nfit_device_handle = handle[nvdimm->id];
>  	spa->num_nvdimms = 1;
>  	spa->devices[0].dpa = dpa;
> 
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada


