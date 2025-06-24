Return-Path: <stable+bounces-158355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93BAE6147
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 11:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591BA3B9855
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD3427A93A;
	Tue, 24 Jun 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTguxfQT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07010279DC8;
	Tue, 24 Jun 2025 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758548; cv=none; b=Vioh54n7Ivks4g7SQJfOfE+HAL92+tKoPlFP0bEwkCoUMwjBdgEnXhqbSaIz4/x7nx51axxRfaugdbE52hVBhMT+RClKjGbomy82eBjUzvIp3yh/OWHT8PfwHVoc3rcfujpD1soSUegXXWylQTQ/WAohKoOgEFvPdrWHWn3Z7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758548; c=relaxed/simple;
	bh=Df2lQ1yM1VLk0AsfFlVcfqKjKTRsXS/akMtYJso9klg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyxvtYbTUEw+dbxhEbNUrs3ROeJS12a0CIyxF7snU3eCrxCeoWLcK75bnh1R5jZx0naVuSwdN6D5cUOavRtlYXX86BaAW7jLPiRouH4iS97jEZhSvUnz5YfdLOVdoZPPLNIDuOe/jMyl3QxCfDaUNbGmMxb41GWJjdMfZHldJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTguxfQT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750758547; x=1782294547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Df2lQ1yM1VLk0AsfFlVcfqKjKTRsXS/akMtYJso9klg=;
  b=bTguxfQTHI6I7TeJPJvMafezohKNz/CWPTebQ8LUrKkl3RKry/nDSXhx
   RE5nSEY/UXtiIwPbo9Q29kTIih7usGJZTfb8vtaSvPSHbO3Gy4OdW5+Rz
   e+6OLk9+HbodPZvC81bEPY7doarq4IDgGRF0u5r1LSo3E6oLpwVs7+GIh
   8MtNewdRrGumtuDsKDY1y540SwPIfrJqodBeVQGVbfdG1DKpUawSPPWGQ
   Iz/FrFy+V75UfFcXnvC0tB0ID6N7gwfjjHufucf8e1/Y0IDef+efRtxMb
   mmk4Q4HG0GC1Ty3uxfWrmMfZ5ovPoAwGr8ys3GwmDwY7SiuLKdU0bk2PS
   A==;
X-CSE-ConnectionGUID: JK2cnU2IRsiKYygQjrqLiw==
X-CSE-MsgGUID: Osjh1hWIQbON+COD+gCy9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53061711"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53061711"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 02:49:05 -0700
X-CSE-ConnectionGUID: 0Xvbar7yQgSREy1AAYbIFQ==
X-CSE-MsgGUID: V/CL9jIrTliknCeygMx8zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151463661"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa007.fm.intel.com with ESMTP; 24 Jun 2025 02:49:03 -0700
Message-ID: <e0b58ddf-8593-474e-aa32-156ebb8a92ad@linux.intel.com>
Date: Tue, 24 Jun 2025 12:49:02 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: hub: fix detection of high tier USB3 devices
 behind suspended hubs
To: Alan Stern <stern@rowland.harvard.edu>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, oneukum@suse.com,
 stable@vger.kernel.org, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250611112441.2267883-1-mathias.nyman@linux.intel.com>
 <acaaa928-832c-48ca-b0ea-d202d5cd3d6c@oss.qualcomm.com>
 <c73fbead-66d7-497a-8fa1-75ea4761090a@rowland.harvard.edu>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <c73fbead-66d7-497a-8fa1-75ea4761090a@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.6.2025 2.32, Alan Stern wrote:
> On Mon, Jun 23, 2025 at 10:31:17PM +0200, Konrad Dybcio wrote:
>> On 6/11/25 1:24 PM, Mathias Nyman wrote:
>>> USB3 devices connected behind several external suspended hubs may not
>>> be detected when plugged in due to aggressive hub runtime pm suspend.
>>>
>>> The hub driver immediately runtime-suspends hubs if there are no
>>> active children or port activity.
>>>
>>> There is a delay between the wake signal causing hub resume, and driver
>>> visible port activity on the hub downstream facing ports.
>>> Most of the LFPS handshake, resume signaling and link training done
>>> on the downstream ports is not visible to the hub driver until completed,
>>> when device then will appear fully enabled and running on the port.
>>>
>>> This delay between wake signal and detectable port change is even more
>>> significant with chained suspended hubs where the wake signal will
>>> propagate upstream first. Suspended hubs will only start resuming
>>> downstream ports after upstream facing port resumes.
>>>
>>> The hub driver may resume a USB3 hub, read status of all ports, not
>>> yet see any activity, and runtime suspend back the hub before any
>>> port activity is visible.
>>>
>>> This exact case was seen when conncting USB3 devices to a suspended
>>> Thunderbolt dock.
>>>
>>> USB3 specification defines a 100ms tU3WakeupRetryDelay, indicating
>>> USB3 devices expect to be resumed within 100ms after signaling wake.
>>> if not then device will resend the wake signal.
>>>
>>> Give the USB3 hubs twice this time (200ms) to detect any port
>>> changes after resume, before allowing hub to runtime suspend again.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 2839f5bcfcfc ("USB: Turn on auto-suspend for USB 3.0 hubs.")
>>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>> ---
>> Hi, this patch seems to cause the following splat on QC
>> SC8280XP CRD board when resuming the system:
>>
>> [root@sc8280xp-crd ~]# ./suspend_test.sh
>> [   37.887029] PM: suspend entry (s2idle)
>> [   37.903850] Filesystems sync: 0.012 seconds
>> [   37.915071] Freezing user space processes
>> [   37.920925] Freezing user space processes completed (elapsed 0.001 seconds)
> I don't know what could be causing this problem.
> 
> However, Mathias, I did notice a minor error in the patch when I read it
> again.  It's in the new part of hub_activate() which does this:
> 
> +		queue_delayed_work(system_power_efficient_wq, &hub->init_work,
> +				   msecs_to_jiffies(USB_SS_PORT_U0_WAKE_TIME));
> +		usb_autopm_get_interface_no_resume(
> +			to_usb_interface(hub->intfdev));
> 
> Once queue_delayed_work() has been called, it's possible that the work
> routine will run before the usb_autopm_get_interface_no_resume() call
> gets executed.  These two calls should be made in the opposite order.

Thanks, I'll fix that

-Mathias


