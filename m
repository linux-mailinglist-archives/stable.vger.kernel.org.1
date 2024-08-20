Return-Path: <stable+bounces-69711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB249585B8
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA081C24344
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14D518E04E;
	Tue, 20 Aug 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfVB2p1f"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7D18E351;
	Tue, 20 Aug 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153006; cv=none; b=ohdS6wsZf+P//HJJFxNnOZ5TkILRB36HgZImtaLRNatNOJEaNztVJDfat5udOSEgYe2cIsE9tBjSM4nufv8hqrqZizCxdloPtq9+umUtTOXv6ATGibrcrDNcySd3zhOEAuW7n568sKsp7L6SPl0/lQdEUi1zk9khbpchkQa8iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153006; c=relaxed/simple;
	bh=vs4Ivr8mcleS9d+BMDNEetc09LxW39Zhw3a6BqOGr54=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o/vwPYGQu4p7jCkusK/XHkSr1XVyk9HRQoSFoP+OdjxkRVZBrU3ciw38Aoxt9mBAyUGGgLvRJoJbEN+yshSwqWbdfxgIieIZYVhE/IGH0VETwkrLZ3UxfGod3SRVh5FxqwiL1yAfF+npUFKvzEhOJjgVgZBj19Sgx7k9A0tRXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfVB2p1f; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724153005; x=1755689005;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vs4Ivr8mcleS9d+BMDNEetc09LxW39Zhw3a6BqOGr54=;
  b=MfVB2p1f1TV1upLd3BcBFhWSMDmZdieXWeOuv6JEBHxlt7qKjDIK2LbW
   NC/hWwXOGF0K3c/Zz7b14d/XNcvbHjUAPo9RVGMaq1VV3ipMzL+VQcDka
   P1Hyw3uz8h4KkQ/cf/d6ROwz07+XWhfKPLsBKrrIvTYrQ2Ee8BHprsY2p
   jNdOSOjjX7jflZWx0SZjzreS2xCRIit9iqZzEbzPT6EDHrqx6g1DB1coO
   wkNluQ+ukoy+hNwLD8rEvr1LO6joFlqzRuWcLVjyExDFfcWuat8QShCGN
   nXNcIc7KLbbwpT7PhEKUyfxu5k7hIjzaIZWi2EF5zChMY78l+x0qEnAe0
   g==;
X-CSE-ConnectionGUID: 42WmbfCVR6azzFLyFMk0Zw==
X-CSE-MsgGUID: cHtoriJEQIC0OH+ccLXp8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22610067"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22610067"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:23:24 -0700
X-CSE-ConnectionGUID: 4IPbaCR1Sv2errOjvCyngw==
X-CSE-MsgGUID: hKXnm7PmQoKN/hhm/ZsjQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65059127"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:23:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Aug 2024 14:23:18 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: ISST: Fix return value on last invalid
 resource
In-Reply-To: <20240816163626.415762-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <e525b1ee-da15-a265-4e12-33c68e01b78f@linux.intel.com>
References: <20240816163626.415762-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 Aug 2024, Srinivas Pandruvada wrote:

> When only the last resource is invalid, tpmi_sst_dev_add() is returing
> error even if there are other valid resources before. This function
> should return error when there are no valid resources.
> 
> Here tpmi_sst_dev_add() is returning "ret" variable. But this "ret"
> variable contains the failure status of last call to sst_main(), which
> failed for the invalid resource. But there may be other valid resources
> before the last entry.
> 
> To address this, do not update "ret" variable for sst_main() return
> status.
>
> Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned systems")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: <stable@vger.kernel.org> # 6.10+

Thanks for the patch. Applied to review-ilpo.

While applying, I added the answer to the obvious question: why no new 
checks are needed for the no valid resources case (essentially, noting the 
existing !inst check).

-- 
 i.

> ---
>  drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 7fa360073f6e..404582307109 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -1549,8 +1549,7 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
>  			goto unlock_free;
>  		}
>  
> -		ret = sst_main(auxdev, &pd_info[i]);
> -		if (ret) {
> +		if (sst_main(auxdev, &pd_info[i])) {
>  			/*
>  			 * This entry is not valid, hardware can partially
>  			 * populate dies. In this case MMIO will have 0xFFs.
> 


