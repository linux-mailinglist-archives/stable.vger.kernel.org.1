Return-Path: <stable+bounces-59113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F21092E770
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 13:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4851C1F21A4B
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BEB156993;
	Thu, 11 Jul 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsAFGrTa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FE2904;
	Thu, 11 Jul 2024 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698641; cv=none; b=mUmE8F1Ep03QyO+psM2FQqv3jcSJUndVmE91ar/iLoWECcqUIVOy5/+pniY0W1qxdN14537Ug6H90dGUbdtxSYXpOUmJscCdVtcqZbgRtfrRGySh+Tp63tGnRJTmeS1UofJRPKkCkzJggycNATAyQmB1Bevir7gkqQseIEG0LY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698641; c=relaxed/simple;
	bh=zhGBVttiVu6iyO0JmAAPRwCToWBzxlnb/qyZuGhxfOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6YQxETSpKTpem4Jos9pEhEqs/dsUrG4u1iwwVs0bta/BKCzumZZZreJ+IyFEupYUztbOCZxmRRe/4j1NbdsHGztu1pjznv0pN+Nv0M1N+ZGFmT2UDMPupKJKkqo1GvlB0AOv5C+Dt2gCau098baBJZyaq4uDqme93xKUx3eA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsAFGrTa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720698640; x=1752234640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zhGBVttiVu6iyO0JmAAPRwCToWBzxlnb/qyZuGhxfOM=;
  b=QsAFGrTaA6MbjgebBCPgagBKa2VKpneKawtwdNp+toeGzTCZk7duRhgK
   CIrZEG19ccjo4HyJqSVz9GaccGJFBSRTfLOMblbyb0ETAQ8vDItvFxuQa
   OuC+KcHnZ0zi5nplnHTMud6OegDcc78UKRkkx29TfBoJKsQBybYyHSbs6
   3i9EcNGTHEzdv53xW/6vswTFOeYhl0GeXN4K4C9qsgzEE24FYBeV16GBs
   gDgnzyrRmfwNfjbmITXGXOENX2ool3iUWh7Ve6j4h5x7gs3NB/jKn5+1W
   cOMKOmpTxy41IIW+2oMAt3C/wGLMX4YNsnc57cCkocSdN/8Ty/qm/MIaD
   Q==;
X-CSE-ConnectionGUID: mjluKvxJQSejJmJ5IbclRg==
X-CSE-MsgGUID: ylxBAJJZS6y+PAbVhMbGDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18211443"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="18211443"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 04:50:39 -0700
X-CSE-ConnectionGUID: P4W/58xTR4agRM6PuFkhqw==
X-CSE-MsgGUID: smrXDWcKQROleRzT8/TSyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="79665436"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.74.239]) ([10.247.74.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 04:50:33 -0700
Message-ID: <6bb1ba4a-41ba-4bc1-9c4b-abfb27944891@linux.intel.com>
Date: Thu, 11 Jul 2024 18:50:26 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/3] igc: Fix reset adapter logics when tx mode
 change
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Sasha Neftin <sasha.neftin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
 <20240707125318.3425097-3-faizal.abdul.rahim@linux.intel.com>
 <87o774u807.fsf@intel.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <87o774u807.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vinicius,

On 11/7/2024 6:44 am, Vinicius Costa Gomes wrote:
> Faizal Rahim <faizal.abdul.rahim@linux.intel.com> writes:
> 
>> Following the "igc: Fix TX Hang issue when QBV Gate is close" changes,
>> remaining issues with the reset adapter logic in igc_tsn_offload_apply()
>> have been observed:
>>
>> 1. The reset adapter logics for i225 and i226 differ, although they should
>>     be the same according to the guidelines in I225/6 HW Design Section
>>     7.5.2.1 on software initialization during tx mode changes.
>> 2. The i225 resets adapter every time, even though tx mode doesn't change.
>>     This occurs solely based on the condition  igc_is_device_id_i225() when
>>     calling schedule_work().
>> 3. i226 doesn't reset adapter for tsn->legacy tx mode changes. It only
>>     resets adapter for legacy->tsn tx mode transitions.
>> 4. qbv_count introduced in the patch is actually not needed; in this
>>     context, a non-zero value of qbv_count is used to indicate if tx mode
>>     was unconditionally set to tsn in igc_tsn_enable_offload(). This could
>>     be replaced by checking the existing register
>>     IGC_TQAVCTRL_TRANSMIT_MODE_TSN bit.
>>
>> This patch resolves all issues and enters schedule_work() to reset the
>> adapter only when changing tx mode. It also removes reliance on qbv_count.
>>
>> qbv_count field will be removed in a future patch.
>>
>> Test ran:
>>
>> 1. Verify reset adapter behaviour in i225/6:
>>     a) Enrol a new GCL
>>        Reset adapter observed (tx mode change legacy->tsn)
>>     b) Enrol a new GCL without deleting qdisc
>>        No reset adapter observed (tx mode remain tsn->tsn)
>>     c) Delete qdisc
>>        Reset adapter observed (tx mode change tsn->legacy)
>>
>> 2. Tested scenario from "igc: Fix TX Hang issue when QBV Gate is closed"
>>     to confirm it remains resolved.
>>
>> Fixes: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> ---
> 
> There were a quite a few bugs, some of them my fault, on this part of
> the code, changing between the modes in the hardware.
> 
> So I would like some confirmation that ETF offloading/LaunchTime was
> also tested with this change. Just to be sure.
> 
> But code-wise, looks good:
> 
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> 
> Cheers,


Tested etf with offload, looks like working correctly.

1. mqprio
tc qdisc add dev enp1s0 handle 100: parent root mqprio num_tc 3 \
map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
queues 1@0 1@1 2@2 \
hw 0

No reset adapter observed.

2. etf with offload
tc qdisc replace dev enp1s0 parent 100:1 etf \
clockid CLOCK_TAI delta 300000 offload

Reset adapter observed (tx mode legacy -> tsn).

3. delete qdisc
tc qdisc delete dev enp1s0 parent root handle 100

Reset adapter observed (tx mode tsn -> legacy).


