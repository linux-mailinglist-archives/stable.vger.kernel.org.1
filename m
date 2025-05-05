Return-Path: <stable+bounces-139670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE827AA9141
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632FB167CF8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75B1FBE83;
	Mon,  5 May 2025 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9A6mbA/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309491CCB40
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746441289; cv=none; b=NNSsom4HF0Wlmam3NtVC6KIZgfbzhTyziaf+ikSU4hnjOLGCXpOZ2Co56vH9dwQa7ZMe2peCfFC42WQomHyJg47MUaZ9tA4yNUqRW4eUtiKZu5tObkvJSplO97d0uzY0S438qeT2i6ebD/z7gycBnj/cGaAnME52Ger29jMKweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746441289; c=relaxed/simple;
	bh=v/yNwcX6lhLlBhxnUsYnRhzKU7ef2xEUnKnL76+2OBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSaXLn6UB1humsQfYs7+iFkHYMvaxzRs6Fa62vIX4Mpc8D+veXAOpuuXQp2QXJ47ehSdeuYkpT7H8PiKZZWFSfaitU3/nttK4XrTcE53GvfGECXDWOLheQBD2yzdj5VF4HnaoMDpFCzcxyDOOo4+qivnqUZOPlkAPRA/XWA4FFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9A6mbA/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746441288; x=1777977288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v/yNwcX6lhLlBhxnUsYnRhzKU7ef2xEUnKnL76+2OBs=;
  b=U9A6mbA/5S84HPCBePgL1CmmRdCeJOrg8p9Nvm2mw491wVCS+bIeuORT
   PnePDzfw968q4DfqqFwYjioZIdkq+qWrZ+gRU5uIX7i59m2SnvchU6TiZ
   rdRp3knM7BRKFxfsvjaVMnwB+wSN1TDvgKvmoBfYXH5Kh+xBEuMWcrBMf
   DRroO49zTf6Ew3/zQTvtUGXiceIcHGY198QeLCT1nC3RqSbTzhjixwF8g
   quJ9hRy52i2RlJOl6PNZDqJHlPbr8A2Oe43d9/PcKUyK9SppZHAF1fyk5
   ZsiHc21bgqXTAC/ba2VDa+IrvTg1LpJxnCbI7JKZsMJWbWm/ZGvuRPshp
   Q==;
X-CSE-ConnectionGUID: AgohNw++SEyN52+sYjzd2A==
X-CSE-MsgGUID: Fp3HVne8T+ai9wCqPHM2eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="51850247"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="51850247"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:34:47 -0700
X-CSE-ConnectionGUID: 6OFLfC8dQSenj5BL696m7Q==
X-CSE-MsgGUID: motTpRMhQr2Q4qAj0U/15w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135138968"
Received: from unknown (HELO [10.245.83.192]) ([10.245.83.192])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:34:46 -0700
Message-ID: <4616a3c3-fb83-4254-9ad6-17f35fc5822f@linux.intel.com>
Date: Mon, 5 May 2025 12:34:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] accel/ivpu: Abort all jobs after command queue
 unregister
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Karol Wachowski <karol.wachowski@intel.com>
References: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
 <20250430124819.3761263-6-jacek.lawrynowicz@linux.intel.com>
 <2025050504-change-ignore-e99d@gregkh>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2025050504-change-ignore-e99d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/5/2025 8:03 AM, Greg KH wrote:
> On Wed, Apr 30, 2025 at 02:48:17PM +0200, Jacek Lawrynowicz wrote:
>> From: Karol Wachowski <karol.wachowski@intel.com>
>>
>> commit 5bbccadaf33eea2b879d8326ad59ae0663be47d1 upstream.
>>
>> With hardware scheduler it is not expected to receive JOB_DONE
>> notifications from NPU FW for the jobs aborted due to command queue destroy
>> JSM command.
>>
>> Remove jobs submitted to unregistered command queue from submitted_jobs_xa
>> to avoid triggering a TDR in such case.
>>
>> Add explicit submitted_jobs_lock that protects access to list of submitted
>> jobs which is now used to find jobs to abort.
>>
>> Move context abort procedure to separate work queue not to slow down
>> handling of IPCs or DCT requests in case where job abort takes longer,
>> especially when destruction of the last job of a specific context results
>> in context release.
>>
>> Cc: <stable@vger.kernel.org> # v6.12
>> Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
>> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
>> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>> Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-4-maciej.falkowski@linux.intel.com
>> ---
>>  drivers/accel/ivpu/ivpu_drv.c   | 32 +++----------
>>  drivers/accel/ivpu/ivpu_drv.h   |  2 +
>>  drivers/accel/ivpu/ivpu_job.c   | 82 +++++++++++++++++++++++++--------
>>  drivers/accel/ivpu/ivpu_job.h   |  1 +
>>  drivers/accel/ivpu/ivpu_mmu.c   |  3 +-
>>  drivers/accel/ivpu/ivpu_sysfs.c |  5 +-
>>  6 files changed, 77 insertions(+), 48 deletions(-)
> 
> Again, this is different from the original, so please document it as
> such.
> 
> Please fix up both backported series of patches and resubmit a v2 of
> them.

Sure, I've added descriptions of changes to commit messages and resubmitted the patchsets as v2.

Regards


