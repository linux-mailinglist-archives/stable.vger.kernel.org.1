Return-Path: <stable+bounces-147937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F77AC664D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 11:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E65B1892689
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A920E011;
	Wed, 28 May 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWDJNZFR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA5A2D
	for <stable@vger.kernel.org>; Wed, 28 May 2025 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425955; cv=none; b=lsuqLt/LFrPqg4cHPZYFGNZfb3e30hvLXQ4CZieltmKud+lQtqAu1W0YgrsgyyAHfFTQYD9vz+Iis1CPykyOho77LUL01xb+of7hljD35CU3lhs/ZTN1X/qXohKLa2/kG1ukMRJ+207Wt0ldxjptfIsoItDljCyw93fCmJqpt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425955; c=relaxed/simple;
	bh=rCFS/foDqkHrqtWq7TADMWRqoO8X7Mjl+yqgrT4ZHBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/5mhgyqw3kOGr87YNENuwfQF+KReKwQ8FUMmEw/UjI4UXRco9D+7uIV8vztd2DXPZn2Vo2LJRyJA8VH+U90c4I4YY3FsNfSZnFWXxoiBn3eNQAXnF7XkZBc2wRevuSuRueO++QUqnjvV78wH/a7nmJzB4bASz3IN6uy4PNX1jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWDJNZFR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748425953; x=1779961953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rCFS/foDqkHrqtWq7TADMWRqoO8X7Mjl+yqgrT4ZHBA=;
  b=NWDJNZFRUtvy4+IpjUjx3ZiVPOu8m3nY0s7BC0q8uLFVLanyIdwEf8az
   NTBIeJpy/1f9s5VrM6QftY2Yl1yq+g7RpgtuIHmcqQe9gmXvO0uU2n0c4
   VY2SA/4H9YcXNncMwGh6WDjP9DAqJHNI9QJ/Z55i1rpUA/KJ36Aawd5DC
   4hkSQjzck3hHkr+QPaSF2KdrnSefznT9v8If33XKdjpMPTlF08SZ/Aklf
   oC7xM8x2YEe8JH7FpohqQDCzXCxKLWbRahllNg4xJTNYD77tiAvKWnP5i
   IsLJh1e8cbd+XYW5Y+XXJY4qXrExxzv8YmiGUmalnnDmou8C7t9OaC6kg
   w==;
X-CSE-ConnectionGUID: 4Xu5a6v6RNyuaShyTmrHqw==
X-CSE-MsgGUID: YRDumjDeRVyPwlefvpu4DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50143892"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50143892"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 02:52:33 -0700
X-CSE-ConnectionGUID: Eyjhw2k5RD2yvvbHlGQq0w==
X-CSE-MsgGUID: J1o5et9SRpyafie6NhxyrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="148234800"
Received: from fbeltech-mobl2.ger.corp.intel.com (HELO [10.245.80.225]) ([10.245.80.225])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 02:52:32 -0700
Message-ID: <a56c10eb-30d3-4e8e-83b7-7984e75c8d89@linux.intel.com>
Date: Wed, 28 May 2025 11:52:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Use firmware names from upstream repo
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com, stable@vger.kernel.org
References: <20250506092030.280276-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250506092030.280276-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Applied to drm-misc-fixes

On 5/6/2025 11:20 AM, Jacek Lawrynowicz wrote:
> Use FW names from linux-firmware repo instead of deprecated ones.
> 
> Fixes: c140244f0cfb ("accel/ivpu: Add initial Panther Lake support")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---
>  drivers/accel/ivpu/ivpu_fw.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index ccaaf6c100c02..9db741695401e 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
> @@ -55,18 +55,18 @@ static struct {
>  	int gen;
>  	const char *name;
>  } fw_names[] = {
> -	{ IVPU_HW_IP_37XX, "vpu_37xx.bin" },
> +	{ IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v1.bin" },
>  	{ IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v0.0.bin" },
> -	{ IVPU_HW_IP_40XX, "vpu_40xx.bin" },
> +	{ IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v1.bin" },
>  	{ IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
> -	{ IVPU_HW_IP_50XX, "vpu_50xx.bin" },
> +	{ IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v1.bin" },
>  	{ IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v0.0.bin" },
>  };
>  
>  /* Production fw_names from the table above */
> -MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
> -MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
> -MODULE_FIRMWARE("intel/vpu/vpu_50xx_v0.0.bin");
> +MODULE_FIRMWARE("intel/vpu/vpu_37xx_v1.bin");
> +MODULE_FIRMWARE("intel/vpu/vpu_40xx_v1.bin");
> +MODULE_FIRMWARE("intel/vpu/vpu_50xx_v1.bin");
>  
>  static int ivpu_fw_request(struct ivpu_device *vdev)
>  {


