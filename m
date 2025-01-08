Return-Path: <stable+bounces-108042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37AEA06907
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 23:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C2F3A1D93
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 22:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FD2040A3;
	Wed,  8 Jan 2025 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XB8W616J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0211F0E35
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736377068; cv=none; b=piYcrwNNzKkw7GNFmfkWHnwBjX09r7RD33lqMs8HOk/6NG4ipWnO8+2w/4+K6Xle4IpH1uu+qb38IbO/vkNfuc8tvHwMJzkIkgpVw77FrpOcHhSLly7zFIrY+ht2tdaWRhtkHMPYL9Soc2N7+yevnOuP7ERSHJQEI0fxdIN2pYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736377068; c=relaxed/simple;
	bh=qwcSuymj34f1GNonsGKLyHpsC0uAWjAPPqOf7b7rQ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jynFv9+7LLEJiaoUlQbkqAIuyrDogUvmtOGQErb6fwqBtbxX+ykb1zVXeFWpaG06WHridokXUKz5T+FfyumXBeAvxQVrBffceSLmgZKVzHQsX+QggCPp8c9kbaOkehnIy81U2T1xWhzGsMkfTEzGPT/N2hGgB04Nhyz/aeBQa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XB8W616J; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736377067; x=1767913067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qwcSuymj34f1GNonsGKLyHpsC0uAWjAPPqOf7b7rQ+0=;
  b=XB8W616JW8IaTw/HCpd0GPLgxCiGz4sfjvCCxBoxZa3TmAsBYuFyY+I4
   7isouKyjh0/KOZzjf+VbDVk70FWWNk2HTbw5N1QDymjg0oHgUhNXcptVR
   uAWKuTfJU4Nsijn3KEi85UEtybiMUA8cps9NYSJwl8la1YW2eKLVVTezn
   SMgtWbhNPvAhuSmC95X8o+wNJrLZIrVJowNpfJWPfmjHL6BY/Yt3qv1vt
   WX6CvZwvMWhyGovrRnXl7EjJxTdOfFy6jPTsqYzbZVR8sC1NGtsVCZW6v
   Z6/5J6cXFTd6TRPyKK60dh6a6sA3W+FZREeq4i16/7JK/shwdTCJC+wGn
   w==;
X-CSE-ConnectionGUID: FtXWrwdCQY6E3R9ZCwnjgg==
X-CSE-MsgGUID: 8Lpak8R2SqWVYlle0WC6ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36506213"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="36506213"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:57:46 -0800
X-CSE-ConnectionGUID: yyMc2+YNSbuHhs9QGoNGuA==
X-CSE-MsgGUID: vVSpWuGHRd2+MxmvtpTwrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="103301993"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.111.59])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:57:46 -0800
Date: Wed, 8 Jan 2025 16:57:40 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: intel-xe@lists.freedesktop.org, matthew.brost@intel.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <yucnyvz3vdhvxlpuxsd2c5jyzqpbdcpxoxhw2lbvfvjpndr7nb@7tiqvwmaxg2t>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
 <Z3xcy2Z3CuwkR9L1@orsosgc001>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z3xcy2Z3CuwkR9L1@orsosgc001>

On Mon, Jan 06, 2025 at 02:44:27PM -0800, Umesh Nerlige Ramappa wrote:
>On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
>>This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
>>queue file lock usage."). While it's desired to have the mutex to
>>protect only the reference to the exec queue, getting and dropping each
>>mutex and then later getting the GPU timestamp, doesn't produce a
>>correct result: it introduces multiple opportunities for the task to be
>>scheduled out and thus wrecking havoc the deltas reported to userspace.
>>
>>Also, to better correlate the timestamp from the exec queues with the
>>GPU, disable preemption so they can be updated without allowing the task
>>to be scheduled out. We leave interrupts enabled as that shouldn't be
>>enough disturbance for the deltas to matter to userspace.
>
>Assuming
>
>- timestamp from exec queues = xe_exec_queue_update_run_ticks()
>- GPU timestamp = xe_hw_engine_read_timestamp()
>
>shouldn't you also move the xe_hw_engine_read_timestamp() within the 
>preempt_disable/preempt_enable section?

this is what I thought I had done, but it seems I messed up.

>
>Something like this ..
>
>	preempt_disable();
>
>	xa_for_each(&xef->exec_queue.xa, i, q)
>		xe_exec_queue_update_run_ticks(q);
>
>	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);

I'd move the gpu_timestamp to be done before the exec queue, so we don't
call it with the exec queue mutex still taken. AFAIR this is what I was
doing in the test machine, but sent the wrong version of the patch. Let
me double check locally here and resend.

thanks
Lucas De Marchi

>
>	preempt_enable();
>
>Thanks,
>Umesh
>
>>
>>Test scenario:
>>
>>	* IGT'S `xe_drm_fdinfo --r --r utilization-single-full-load`
>>	* Platform: LNL, where CI occasionally reports failures
>>	* `stress -c $(nproc)` running in parallel to disturb the
>>	  system
>>
>>This brings a first failure from "after ~150 executions" to "never
>>occurs after 1000 attempts".
>>
>>Cc: stable@vger.kernel.org # v6.11+
>>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>---
>>drivers/gpu/drm/xe/xe_drm_client.c | 9 +++------
>>1 file changed, 3 insertions(+), 6 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
>>index 298a587da7f17..e307b4d6bab5a 100644
>>--- a/drivers/gpu/drm/xe/xe_drm_client.c
>>+++ b/drivers/gpu/drm/xe/xe_drm_client.c
>>@@ -338,15 +338,12 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
>>
>>	/* Accumulate all the exec queues from this client */
>>	mutex_lock(&xef->exec_queue.lock);
>>-	xa_for_each(&xef->exec_queue.xa, i, q) {
>>-		xe_exec_queue_get(q);
>>-		mutex_unlock(&xef->exec_queue.lock);
>>+	preempt_disable();
>>
>>+	xa_for_each(&xef->exec_queue.xa, i, q)
>>		xe_exec_queue_update_run_ticks(q);
>>
>>-		mutex_lock(&xef->exec_queue.lock);
>>-		xe_exec_queue_put(q);
>>-	}
>>+	preempt_enable();
>>	mutex_unlock(&xef->exec_queue.lock);
>>
>>	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>>-- 
>>2.47.0
>>

