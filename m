Return-Path: <stable+bounces-59148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447A792EE80
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 20:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6E5B22D07
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4749116DED6;
	Thu, 11 Jul 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BW6UBt11"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A616DED4;
	Thu, 11 Jul 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721414; cv=none; b=DUkef/uA6h04/oveyETr1Lp+O0xnfI11f+ahiAY9LSs/q7huRy38iD7fzDUzbOVgO4rM1p/IHbIuVP2fDjl56j5/783wW2+m23XZRSG7b2fON6bJrw+zM2tO9hsjHSf5xI2D+C88Wg881tUQ7Ngsa9N5w/YeyUeTjNlrxSgiYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721414; c=relaxed/simple;
	bh=7kuZlTBmxFWxph6Ful0WMwENSv+aNNJIa+996kwiXtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hKs+1KO0iKzlKhHtNUxmaYVao57oZB+AeyWYCw4BXTRAeJoY6KNZWLdbbaIcFBnazqOcKedpSB6VxkD3fYupdtUGPY9Z9QuQe2yq3TyLQnFiZygRq5cDMDd9fJFvJI7UOmk+6XZXj71kgiId0GwCL3O1GJl3PUBC/j44xpSTDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BW6UBt11; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720721412; x=1752257412;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7kuZlTBmxFWxph6Ful0WMwENSv+aNNJIa+996kwiXtI=;
  b=BW6UBt11tpGhmHo5a11804KtRwVrozP9FkESUvetLyM63ng0s2hI1L+T
   /meeh5ofKeRDP7JesQua3qqUyb+22W9A4iwTrm1D2JfwjTqGfeBHlSeWL
   UlSh2OJaVVesC5WL8Pd1kjPi1pw8Oyg9nKkeKXDNoqrsBqjAz2cRRR2xR
   wly6PbE2kBYBDoUPu1clz630pQ3rQpWA7N6a8gELjVJhcti+HEtqvmNgN
   9//G9sm6x4ut57moXsGgT6BukpAobfCq5BMd2+geB6MNYMvQEV1Us78mG
   NX/YXF+TuDFI0hOC0GTT9RyYj7wGaaeCDntmI99QhUWNoMeo6jQjemz1e
   g==;
X-CSE-ConnectionGUID: H2p5jUJgRQKo6fxRutlb+Q==
X-CSE-MsgGUID: xg/FsuZDSaKxT91vFt8f1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="22000435"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="22000435"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:10:11 -0700
X-CSE-ConnectionGUID: AhDtjmOTRDC36DgLP5DP+A==
X-CSE-MsgGUID: NciQSOPKQaC6oEOiQdCfBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="79345324"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.92])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:10:12 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jesse
 Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Sasha Neftin <sasha.neftin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 2/3] igc: Fix reset adapter logics when tx
 mode change
In-Reply-To: <6bb1ba4a-41ba-4bc1-9c4b-abfb27944891@linux.intel.com>
References: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
 <20240707125318.3425097-3-faizal.abdul.rahim@linux.intel.com>
 <87o774u807.fsf@intel.com>
 <6bb1ba4a-41ba-4bc1-9c4b-abfb27944891@linux.intel.com>
Date: Thu, 11 Jul 2024 11:10:11 -0700
Message-ID: <87le27ssu4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com> writes:

> Hi Vinicius,
>
> On 11/7/2024 6:44 am, Vinicius Costa Gomes wrote:
>> Faizal Rahim <faizal.abdul.rahim@linux.intel.com> writes:
>> 
>>> Following the "igc: Fix TX Hang issue when QBV Gate is close" changes,
>>> remaining issues with the reset adapter logic in igc_tsn_offload_apply()
>>> have been observed:
>>>
>>> 1. The reset adapter logics for i225 and i226 differ, although they should
>>>     be the same according to the guidelines in I225/6 HW Design Section
>>>     7.5.2.1 on software initialization during tx mode changes.
>>> 2. The i225 resets adapter every time, even though tx mode doesn't change.
>>>     This occurs solely based on the condition  igc_is_device_id_i225() when
>>>     calling schedule_work().
>>> 3. i226 doesn't reset adapter for tsn->legacy tx mode changes. It only
>>>     resets adapter for legacy->tsn tx mode transitions.
>>> 4. qbv_count introduced in the patch is actually not needed; in this
>>>     context, a non-zero value of qbv_count is used to indicate if tx mode
>>>     was unconditionally set to tsn in igc_tsn_enable_offload(). This could
>>>     be replaced by checking the existing register
>>>     IGC_TQAVCTRL_TRANSMIT_MODE_TSN bit.
>>>
>>> This patch resolves all issues and enters schedule_work() to reset the
>>> adapter only when changing tx mode. It also removes reliance on qbv_count.
>>>
>>> qbv_count field will be removed in a future patch.
>>>
>>> Test ran:
>>>
>>> 1. Verify reset adapter behaviour in i225/6:
>>>     a) Enrol a new GCL
>>>        Reset adapter observed (tx mode change legacy->tsn)
>>>     b) Enrol a new GCL without deleting qdisc
>>>        No reset adapter observed (tx mode remain tsn->tsn)
>>>     c) Delete qdisc
>>>        Reset adapter observed (tx mode change tsn->legacy)
>>>
>>> 2. Tested scenario from "igc: Fix TX Hang issue when QBV Gate is closed"
>>>     to confirm it remains resolved.
>>>
>>> Fixes: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
>>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>> ---
>> 
>> There were a quite a few bugs, some of them my fault, on this part of
>> the code, changing between the modes in the hardware.
>> 
>> So I would like some confirmation that ETF offloading/LaunchTime was
>> also tested with this change. Just to be sure.
>> 
>> But code-wise, looks good:
>> 
>> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> 
>> 
>> Cheers,
>
>
> Tested etf with offload, looks like working correctly.
>
> 1. mqprio
> tc qdisc add dev enp1s0 handle 100: parent root mqprio num_tc 3 \
> map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
> queues 1@0 1@1 2@2 \
> hw 0
>
> No reset adapter observed.
>
> 2. etf with offload
> tc qdisc replace dev enp1s0 parent 100:1 etf \
> clockid CLOCK_TAI delta 300000 offload
>
> Reset adapter observed (tx mode legacy -> tsn).
>
> 3. delete qdisc
> tc qdisc delete dev enp1s0 parent root handle 100
>
> Reset adapter observed (tx mode tsn -> legacy).
>

That no unexpected resets are happening, is good.

But what I had in mind was some functional tests that ETF is working. I
guess that's the only way of knowing that it's still working. Sorry that
I wasn't clear about that.


Cheers,
-- 
Vinicius

