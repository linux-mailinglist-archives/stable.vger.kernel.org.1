Return-Path: <stable+bounces-89488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58029B9189
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 14:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A3B280C09
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8219E982;
	Fri,  1 Nov 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hF7E9D+y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CA487A7
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466585; cv=none; b=mcKae4212gX0fDxWg4c7d7g9T2HAOPjpN+Vhrnsd2Igy+iiVCGplSwI/7v6TmhczNfmuGatxPZvAPM0YVEc+NlqYo8Ucl6Lh0LiadyAfldRy2NBjdXWXaO8693lMIqTujR0ix0EVuxnnadWWnDfJOjct9DNyGAMTYSCB8hXGuAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466585; c=relaxed/simple;
	bh=reakP3ivrLQGrTRqXyXOwZgMJId6xDbJYj5i2WrirW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keijeYU85qYWV9B/31TSbSMnLldB9x5lB0mU2rzqaYLPCb1/YPHoXfqy1++3GlmUbnrbQbW+w+weEmiJ2YHGgHxs8YWSw+nJvlR8CpiRlGLNVzWZJWQXZvlVnle1TCwiwzNkR4AJQZxNSyoH7bv4dnDVNgfyQEvO9XDNHHSuQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hF7E9D+y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730466583; x=1762002583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=reakP3ivrLQGrTRqXyXOwZgMJId6xDbJYj5i2WrirW4=;
  b=hF7E9D+yMZZ1mKdEY40jaU0KHhMoaJ7usV9LGKFiK9xd5CBPwhH0v1Y1
   nSpeXSUQ8kvmPHg5ktj1fi1MgONwKD016L12bgf0zfKmYUJcazfVy1WN7
   UED9NYUfnDwyb/QnjAmM0gVuDTh5I8CShupyjoGAW3dK4vxf5N0bcoGSg
   xPEMGAiBMCTAe+cRIA0T2omQQSuTYhxK/vKUXZu8TOoCeQkq8oRbkX141
   ymw0VUS/HH7sojHDrMPwakZiIwkHpgyganEUTwLYxZBVB4+Aw6DVGWl7O
   fi71WeoKoi6jlZgWq5iPkpcrErth9xFXgwvje/7/QyxjctnZmV6k93r5c
   Q==;
X-CSE-ConnectionGUID: 7mS+53K1QWSLjqveyJZcTA==
X-CSE-MsgGUID: 5Og9i6BCTAyRu3gIDu9b/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29998143"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29998143"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:09:43 -0700
X-CSE-ConnectionGUID: vW5n8xsnQR+WNDs5auGGvA==
X-CSE-MsgGUID: 1c28ztoUTWeaTITZQ9Steg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83088007"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.196.144]) ([10.245.196.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:09:39 -0700
Message-ID: <5aa82883-bc68-47d2-8e4b-120f760a8e11@linux.intel.com>
Date: Fri, 1 Nov 2024 14:09:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/xe: Move LNL scheduling WA to xe_device.h
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org,
 John Harrison <John.C.Harrison@Intel.com>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20241029120117.449694-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ping!

On 10/29/2024 1:01 PM, Nirmoy Das wrote:
> Move LNL scheduling WA to xe_device.h so this can be used in other
> places without needing keep the same comment about removal of this WA
> in the future. The WA, which flushes work or workqueues, is now wrapped
> in macros and can be reused wherever needed.
>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> cc: <stable@vger.kernel.org> # v6.11+
> Suggested-by: John Harrison <John.C.Harrison@Intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_device.h | 14 ++++++++++++++
>  drivers/gpu/drm/xe/xe_guc_ct.c | 11 +----------
>  2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
> index 4c3f0ebe78a9..f1fbfe916867 100644
> --- a/drivers/gpu/drm/xe/xe_device.h
> +++ b/drivers/gpu/drm/xe/xe_device.h
> @@ -191,4 +191,18 @@ void xe_device_declare_wedged(struct xe_device *xe);
>  struct xe_file *xe_file_get(struct xe_file *xef);
>  void xe_file_put(struct xe_file *xef);
>  
> +/*
> + * Occasionally it is seen that the G2H worker starts running after a delay of more than
> + * a second even after being queued and activated by the Linux workqueue subsystem. This
> + * leads to G2H timeout error. The root cause of issue lies with scheduling latency of
> + * Lunarlake Hybrid CPU. Issue disappears if we disable Lunarlake atom cores from BIOS
> + * and this is beyond xe kmd.
> + *
> + * TODO: Drop this change once workqueue scheduling delay issue is fixed on LNL Hybrid CPU.
> + */
> +#define LNL_FLUSH_WORKQUEUE(wq__) \
> +	flush_workqueue(wq__)
> +#define LNL_FLUSH_WORK(wrk__) \
> +	flush_work(wrk__)
> +
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 1b5d8fb1033a..703b44b257a7 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -1018,17 +1018,8 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
>  
>  	ret = wait_event_timeout(ct->g2h_fence_wq, g2h_fence.done, HZ);
>  
> -	/*
> -	 * Occasionally it is seen that the G2H worker starts running after a delay of more than
> -	 * a second even after being queued and activated by the Linux workqueue subsystem. This
> -	 * leads to G2H timeout error. The root cause of issue lies with scheduling latency of
> -	 * Lunarlake Hybrid CPU. Issue dissappears if we disable Lunarlake atom cores from BIOS
> -	 * and this is beyond xe kmd.
> -	 *
> -	 * TODO: Drop this change once workqueue scheduling delay issue is fixed on LNL Hybrid CPU.
> -	 */
>  	if (!ret) {
> -		flush_work(&ct->g2h_worker);
> +		LNL_FLUSH_WORK(&ct->g2h_worker);
>  		if (g2h_fence.done) {
>  			xe_gt_warn(gt, "G2H fence %u, action %04x, done\n",
>  				   g2h_fence.seqno, action[0]);

