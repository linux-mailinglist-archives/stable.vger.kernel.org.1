Return-Path: <stable+bounces-99956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A1D9E769E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB521888378
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F841F3D29;
	Fri,  6 Dec 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMKEJWD4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85881527AC
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504588; cv=none; b=C5reJlAfVHo5wCUYXHGcowknCAihqMuHreIpVqxomF9+4T/usyjGrpeVcE0fUk4Tj9dbUM9KBiM5Mfwm9ctSbWtXNvxBF0uC7y2eFjTEVaZfxwbSC4gX6BbAGZf2Ui1JmAZEMt5OwL45Ksa/TefFjWRuZOf+/F8WWQF3RoHrXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504588; c=relaxed/simple;
	bh=RfsHPNYgh1DFwK0+tMUlaWkD46sOB2zw42A9uqDfe3o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSQHuTea2KR0OH5VSoMlRViqfMULcz7fZGIbBXFXmIR6uDlU4bX8atsSMVAtyZ/fReL1RBTtxWhlFmbDo2IvnC3CORiHbOPESjJPGPW3xGZMyLXOPeK0PyljfIhfbv9NRA6PUqXSSO1hvZxbqyqMA6guVixaoNfiNW82mIa+KaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMKEJWD4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733504586; x=1765040586;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=RfsHPNYgh1DFwK0+tMUlaWkD46sOB2zw42A9uqDfe3o=;
  b=gMKEJWD4fM/mwkd58bVQs27wHnrrFuphpLqLC78U0tleflpakFNXrvg7
   0iaNtYeoULJJhEw6wxM6ycR+IzuxVEDosToYGuJ8yW6uf6HX3r9Ktl6zu
   p79WVk25S9kvnkbDPeMbWdkCkRR3sXb2OM2AkBuUhHiwNmV/7O0VvjPak
   ohnWhD6Qidyg4X2FvwmpopfPFH8/ZR2GS6MLgiiSs3yyzSdHSMsyBj8nl
   mCLDZfciFEr1m4zJcX2ezKVYtj6hdz76RW0ZbQXDeFb/hOFTSt4jEzGbv
   JYMmsQ/ES0CYK2/FBxyV9gPxdLfVUijVcmUpJT24dKOsrY2UXWxCL1gBG
   g==;
X-CSE-ConnectionGUID: +jdFYlEnTYSCftGqAmBrWA==
X-CSE-MsgGUID: U1wtot9LSrCjnbbC1GMtUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37543468"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="37543468"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 09:03:06 -0800
X-CSE-ConnectionGUID: ppxmaOVER5ywcPBernrA3Q==
X-CSE-MsgGUID: J3fm91SYTP+ak9GOlzVBBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="94553845"
Received: from orsosgc001.jf.intel.com (HELO orsosgc001.intel.com) ([10.165.21.142])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 09:03:06 -0800
Date: Fri, 06 Dec 2024 09:03:06 -0800
Message-ID: <85jzcc3fsl.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	John Harrison <john.c.harrison@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH 6.12 129/146] drm/xe/xe_guc_ads: save/restore OA registers and allowlist regs
In-Reply-To: <20241206143532.618496043@linuxfoundation.org>
References: <20241206143527.654980698@linuxfoundation.org>
	<20241206143532.618496043@linuxfoundation.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/28.2 (x86_64-redhat-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII

On Fri, 06 Dec 2024 06:37:40 -0800, Greg Kroah-Hartman wrote:
>

Hi Greg,

> 6.12-stable review patch.  If anyone has any objections, please let me
> know.

No this patch should *NOT* be added. It was later reverted in:

0191fddf5374 ("Revert "drm/xe/xe_guc_ads: save/restore OA registers and allowlist regs"")

Thanks.
--
Ashutosh




>
> ------------------
>
> From: Jonathan Cavitt <jonathan.cavitt@intel.com>
>
> commit 55858fa7eb2f163f7aa34339fd3399ba4ff564c6 upstream.
>
> Several OA registers and allowlist registers were missing from the
> save/restore list for GuC and could be lost during an engine reset.  Add
> them to the list.
>
> v2:
> - Fix commit message (Umesh)
> - Add missing closes (Ashutosh)
>
> v3:
> - Add missing fixes (Ashutosh)
>
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2249
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> Suggested-by: John Harrison <john.c.harrison@intel.com>
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> CC: stable@vger.kernel.org # v6.11+
> Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20241023200716.82624-1-jonathan.cavitt@intel.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/xe/xe_guc_ads.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -13,6 +13,7 @@
>  #include "regs/xe_engine_regs.h"
>  #include "regs/xe_gt_regs.h"
>  #include "regs/xe_guc_regs.h"
> +#include "regs/xe_oa_regs.h"
>  #include "xe_bo.h"
>  #include "xe_gt.h"
>  #include "xe_gt_ccs_mode.h"
> @@ -601,6 +602,11 @@ static unsigned int guc_mmio_regset_writ
>		guc_mmio_regset_write_one(ads, regset_map, e->reg, count++);
>	}
>
> +	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
> +		guc_mmio_regset_write_one(ads, regset_map,
> +					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
> +					  count++);
> +
>	/* Wa_1607983814 */
>	if (needs_wa_1607983814(xe) && hwe->class == XE_ENGINE_CLASS_RENDER) {
>		for (i = 0; i < LNCFCMOCS_REG_COUNT; i++) {
> @@ -609,6 +615,14 @@ static unsigned int guc_mmio_regset_writ
>		}
>	}
>
> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL0, count++);
> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL1, count++);
> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL2, count++);
> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL3, count++);
> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL4, count++);
> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL5, count++);
> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL6, count++);
> +
>	return count;
>  }
>
>
>

