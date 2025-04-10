Return-Path: <stable+bounces-132063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1CBA83BA3
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7793D19E5703
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A52D1DE2D7;
	Thu, 10 Apr 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLyfr5zX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29954146A68;
	Thu, 10 Apr 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271384; cv=none; b=FCNsb7C9ls3qAlrMuNbtPyfbadjgo7YDraxyKbVVXhlGWEvDBhRKI+fFDveLmQsljXOxtEi1QkYKrPr4ZOS00q4k0POjT8d7U2vjWpUMQln9VuW7KVf1MESnvErr2A6lhshMy1/afaMsC0o22qTNBDjzT2X6flsxyNxmq9yL1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271384; c=relaxed/simple;
	bh=5WfOUyvNF5HLm1HTPADuyXQbbbxKWD2lpgB0Aio93yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4kIkFNHMjj7fXx4EwJMh+Q+7BsQ36vQfPn7C+q2daPZtNj42M7GCvO1PiTv/5yfODYKUsTu/B/5QjhbNOdpu4sHFeTRFlgJPgclvNeqnfeBo6D2XWjskfOIJ3W5kwwXMkNsv0lW8+/jizBtkHLGY7LMgh7Zd5NJIPRL/5MP3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLyfr5zX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744271382; x=1775807382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5WfOUyvNF5HLm1HTPADuyXQbbbxKWD2lpgB0Aio93yk=;
  b=SLyfr5zXIaZlxOpArLTsX3LwtZf+npPkut+D7G0fS6TVSjmeSbL6voCX
   2wSrN+nhuc5hdQInuj5S+0FYB2jSRI9ys1BIx/vuEVPDp5wNfoGR4kXxi
   QHJB2pTbO/8A1TtGguEV0r9uokSJcutw1WntbdYGWB/3kKQpiyJbi+Cw/
   Ia9obYka7spuYWXTIPTazu81zzEcAiFogKk8HmnCRK/K+KXw26pufq3mu
   oz+F2f0qsu6sgkPDzXPopZkydWkgtplqoTtEX2Dgq71BBLod3HXgms+Td
   1QeHxR83rUqgznly3FSH3t0xVvehhr5M33gybn5Dazc7ZLlsuAKikty/I
   A==;
X-CSE-ConnectionGUID: HJQosfPrRyuzTr3NOdo80g==
X-CSE-MsgGUID: +ShY/4Y7QtiOB+q8HGvfMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45489412"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45489412"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:49:40 -0700
X-CSE-ConnectionGUID: j8t+97cIQaGMk+RpWc3xbA==
X-CSE-MsgGUID: anMfRGz9Tam+0k/+QIb2oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="132961556"
Received: from kwywiol-mobl1.ger.corp.intel.com (HELO [10.245.83.152]) ([10.245.83.152])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:49:39 -0700
Message-ID: <8d96c75d-e8fb-446b-a85c-803a2b5212ed@linux.intel.com>
Date: Thu, 10 Apr 2025 09:49:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add handling of
 VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
To: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Karol Wachowski <karol.wachowski@intel.com>
References: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

This is an important patch for the Intel NPU.
Is there anything it is missing to be included in stable?

Regards,
Jacek

On 4/8/2025 11:57 AM, Jacek Lawrynowicz wrote:
> From: Karol Wachowski <karol.wachowski@intel.com>
> 
> commit dad945c27a42dfadddff1049cf5ae417209a8996 upstream.
> 
> Trigger recovery of the NPU upon receiving HW context violation from
> the firmware. The context violation error is a fatal error that prevents
> any subsequent jobs from being executed. Without this fix it is
> necessary to reload the driver to restore the NPU operational state.
> 
> This is simplified version of upstream commit as the full implementation
> would require all engine reset/resume logic to be backported.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-13-maciej.falkowski@linux.intel.com
> Fixes: 0adff3b0ef12 ("accel/ivpu: Share NPU busy time in sysfs")
> Cc: <stable@vger.kernel.org> # v6.11+
> ---
>  drivers/accel/ivpu/ivpu_job.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> index be2e2bf0f43f0..70b3676974407 100644
> --- a/drivers/accel/ivpu/ivpu_job.c
> +++ b/drivers/accel/ivpu/ivpu_job.c
> @@ -482,6 +482,8 @@ static struct ivpu_job *ivpu_job_remove_from_submitted_jobs(struct ivpu_device *
>  	return job;
>  }
>  
> +#define VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW 0xEU
> +
>  static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32 job_status)
>  {
>  	struct ivpu_job *job;
> @@ -490,6 +492,9 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
>  	if (!job)
>  		return -ENOENT;
>  
> +	if (job_status == VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW)
> +		ivpu_pm_trigger_recovery(vdev, "HW context violation");
> +
>  	if (job->file_priv->has_mmu_faults)
>  		job_status = DRM_IVPU_JOB_STATUS_ABORTED;
>  

