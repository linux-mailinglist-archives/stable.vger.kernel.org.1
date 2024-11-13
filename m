Return-Path: <stable+bounces-92903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3279C6CC9
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 11:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D121F219AB
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198FE1FBCB8;
	Wed, 13 Nov 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eenX3yrZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76C1FBCBD
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493424; cv=none; b=VZ5u2LlAwLZCbjk8vr9RS23D5b2X6VVK/u0JZf88qe26HZdPytOTDfHNgzJ9gdcA3QhvkxZz9rGOTqOxxT4ZufuEokxThWa1qxQA2sJInO1bNEW3dVqijzXRWz1TFEGlT9QOxJyvw5u+2opD/z0z8zYxWapHazNgWpNMgSwj97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493424; c=relaxed/simple;
	bh=1NJclrHY+c/0JlcxaJ85QCbt7t3fjkwkvW8wdas1LCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCP5xl5NpO566Ec3ZeXvn5kFZFwIFkw4JG/6QB9y8rd6iLh3ostqkeCw2rCpHF8X0ZVOvCuMqgmm8BYoZFvtp6DCajTu3ZmgVcLiBoZOfNyNZByFcYgaZfG1UCtVgxgTSpogPBu+1GlGBCkMNz9VlMCAPxaXJpuK8KyqU/HuCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eenX3yrZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731493423; x=1763029423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1NJclrHY+c/0JlcxaJ85QCbt7t3fjkwkvW8wdas1LCQ=;
  b=eenX3yrZEAe+gtZg9yureEVQ3dTWWnI3OVCkxa5v/1DT4SfYqEenxxPN
   dGR8tfuk+Czv/0AP+lfry++r1igwfbOR1CGddObAJpDbXW0vbS6oQG790
   c/nN9878NqjS7Rog/0sTexSqj/BVjazQkJ0tA0QJ7x73XGsFAefJ5xkYR
   UOWsL1a5y3RYq2qwneGJcrC9VrkwjEaFCty+q0TQBGu8GTraM/uD5BiTJ
   TQDMb41AUp5bZL8hMzp6DixPuO5AmFD7kvY4NiFt7r0UDjddo1ACG+0vZ
   Zd0OF87vYrNLHNrKZHRc+PJFwbmElGWxIwFgr89JMqxpb3508fI5y7Og1
   g==;
X-CSE-ConnectionGUID: aRLzyI2eQW+i1+X2NsglWA==
X-CSE-MsgGUID: EEJsTMlQTDmgqhz7OSfJ7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31470031"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31470031"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 02:23:43 -0800
X-CSE-ConnectionGUID: 8Op7CCtYSWurJjgt1Vi00A==
X-CSE-MsgGUID: RICydwwyTI2mbvr3l7pNHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="87992111"
Received: from lhuot-mobl.amr.corp.intel.com (HELO [10.245.80.201]) ([10.245.80.201])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 02:23:42 -0800
Message-ID: <1090e813-3296-45b7-b51e-eae7d7e71da0@linux.intel.com>
Date: Wed, 13 Nov 2024 11:23:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix Qemu crash when running in passthrough
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, quic_jhugo@quicinc.com, stable@vger.kernel.org,
 Karol Wachowski <karol.wachowski@linux.intel.com>
References: <20241106105549.2757115-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20241106105549.2757115-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Applied to drm-misc-next

On 11/6/2024 11:55 AM, Jacek Lawrynowicz wrote:
> Restore PCI state after putting the NPU in D0.
> Restoring state before powering up the device caused a Qemu crash
> if NPU was running in passthrough mode and recovery was performed.
> 
> Fixes: 3534eacbf101 ("accel/ivpu: Fix PCI D0 state entry in resume")
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>  drivers/accel/ivpu/ivpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index 59d3170f5e354..5aac3d64045d3 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -73,8 +73,8 @@ static int ivpu_resume(struct ivpu_device *vdev)
>  	int ret;
>  
>  retry:
> -	pci_restore_state(to_pci_dev(vdev->drm.dev));
>  	pci_set_power_state(to_pci_dev(vdev->drm.dev), PCI_D0);
> +	pci_restore_state(to_pci_dev(vdev->drm.dev));
>  
>  	ret = ivpu_hw_power_up(vdev);
>  	if (ret) {


