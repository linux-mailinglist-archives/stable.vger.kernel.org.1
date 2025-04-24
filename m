Return-Path: <stable+bounces-136553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E943AA9A9FB
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 12:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C70C17DF07
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B915221260;
	Thu, 24 Apr 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXeWBApD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2BA19F40B;
	Thu, 24 Apr 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490157; cv=none; b=SaVkVyz1RyxfOF5gHayAcC0aKk0w6OAPbwAAIPv1R/YCSZxFVXFymS900da7DRnCaE6rxLKBP/AZQZvVV9kd2lNXi2ET4BHg4p/uirLdpjeefK8+1M1JADUssGyuH1C/4IDuQ28pLokcUphCSQyruhi0cl3pcTA0JFAGTrkECh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490157; c=relaxed/simple;
	bh=Eamh7vthfoRmbWEo5vKkBaCdNQ6uoy/kDRFc+SnM//0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCip+h5HgIZEnnCkWsYUMCqrcpbMgRaNWXqr25r1XFyNXAf9ekc3oXDtko/dbRvXjG9Q0ptRwZN+7YDwe2Kp8g/gABdbBjHgONAn2HvDIyd0l07lQaxBSPWUeALcze79VY8pPGC1kIUNmk2vdZ9oWmzgb6yimnbexBoGiXOQ5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXeWBApD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745490156; x=1777026156;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Eamh7vthfoRmbWEo5vKkBaCdNQ6uoy/kDRFc+SnM//0=;
  b=TXeWBApDin8N6mhdyDRfuI6i6RWwgsIokzdZXy1q6oy53DMBPFEO1Fro
   fVF0cRKs7RCRa5EmgLHCcENQgwYu0V60pdRW20fXGPLu8EKKyTXt5RJ51
   1sEtZbLlT3lVm8qfQU/KGOCv73DAjTUpjJnWg3AmrsHO+e9e/EYZ+78mo
   qqrZCoGn0Cr7Q0/5J0VRORIfEAvI6Ab/touSoSIN6s6IoQQ26Fkll0n6h
   kb+v14UbnP1/W426Ux1FXHq/xZFq6S7yB53GfCijpzSvpykOPOzkHItEs
   PyUelHZwKWuohMNMSw4GyB9mfAtSqs3YqMnYbCXbP/Y+KYGENMEt5FKEm
   A==;
X-CSE-ConnectionGUID: uf53PQJOQKOswAQA4cLn5Q==
X-CSE-MsgGUID: PbQ2jbAKTMq8kJ9bJBpjlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46232608"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="46232608"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 03:22:35 -0700
X-CSE-ConnectionGUID: 6d2rlWgpRmC7Bg1v+3s/7w==
X-CSE-MsgGUID: i74F4pZbQEa57aEhCIn7ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="155806431"
Received: from acushion-mobl2.ger.corp.intel.com (HELO [10.245.83.152]) ([10.245.83.152])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 03:22:34 -0700
Message-ID: <80f49ba8-caea-47d5-be38-dd1eefd09988@linux.intel.com>
Date: Thu, 24 Apr 2025 12:22:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add handling of
 VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Karol Wachowski <karol.wachowski@intel.com>
References: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
 <2025042227-crumb-rubble-7854@gregkh>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2025042227-crumb-rubble-7854@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/22/2025 2:17 PM, Greg KH wrote:
> On Tue, Apr 08, 2025 at 11:57:11AM +0200, Jacek Lawrynowicz wrote:
>> From: Karol Wachowski <karol.wachowski@intel.com>
>>
>> commit dad945c27a42dfadddff1049cf5ae417209a8996 upstream.
>>
>> Trigger recovery of the NPU upon receiving HW context violation from
>> the firmware. The context violation error is a fatal error that prevents
>> any subsequent jobs from being executed. Without this fix it is
>> necessary to reload the driver to restore the NPU operational state.
>>
>> This is simplified version of upstream commit as the full implementation
>> would require all engine reset/resume logic to be backported.
> 
> We REALLY do not like taking patches that are not upstream.  Why not
> backport all of the needed patches instead, how many would that be?
> Taking one-off patches like this just makes it harder/impossible to
> maintain the code over time as further fixes in this same area will NOT
> apply properly at all.
> 
> Think about what you want to be touching 5 years from now, a one-off
> change that doesn't match the rest of the kernel tree, or something that
> is the same?

Sure, I'm totally on board with backporting all required patches.
I thought it was not possible due to 100 line limit.

This would be the minimum set of patches:

Patch 1:
 drivers/accel/ivpu/ivpu_drv.c   | 32 +++-----------
 drivers/accel/ivpu/ivpu_drv.h   |  2 +
 drivers/accel/ivpu/ivpu_job.c   | 78 ++++++++++++++++++++++++++-------
 drivers/accel/ivpu/ivpu_job.h   |  1 +
 drivers/accel/ivpu/ivpu_mmu.c   |  3 +-
 drivers/accel/ivpu/ivpu_sysfs.c |  5 ++-
 6 files changed, 75 insertions(+), 46 deletions(-)

Patch 2:
 drivers/accel/ivpu/ivpu_job.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Patch 3:
 drivers/accel/ivpu/ivpu_job.c     |   2 +-
 drivers/accel/ivpu/ivpu_jsm_msg.c |   3 +-
 drivers/accel/ivpu/vpu_boot_api.h |  45 +++--
 drivers/accel/ivpu/vpu_jsm_api.h  | 303 +++++++++++++++++++++++++-----
 4 files changed, 293 insertions(+), 60 deletions(-)

Patch 4:
 drivers/accel/ivpu/ivpu_job.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

First patch needs some changes to apply correctly to 6.12 but the rest of them apply pretty cleanly.
Is this acceptable?

Regards,
Jacek


