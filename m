Return-Path: <stable+bounces-59047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9665192DD15
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 01:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515FF282B9D
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 23:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D915DBB7;
	Wed, 10 Jul 2024 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6nssw7L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD9158D92;
	Wed, 10 Jul 2024 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655100; cv=none; b=n9JU7qh2APQqBRRkfA73W5U8Z7WizTO5fMxa/VwuXhd/CAgQe9b/A5nm7DUNHTVSJBv6awQW0PqmX9grhjindZ++QwSTtJQWtDObPc86qk1VtzmN6kib8PVJs/rjLdla4GVjMqO0NpWCQ4qZ+5BG5K6wuAlL1mKrQAleEsR56s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655100; c=relaxed/simple;
	bh=2FL1KLCRwEBjN0Eyy0mybvPOrQPAKC/0qRzk5OZQZ3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H9y8st4WZmS67xmB32rKb+/Jlxn1JUXbL34opbWd/fe94HOftEhY/ec4vzBx/ScdA1q+/K/WhapyRoIDQi7bSpw92TQnFfc1gZctag9LUFQcty8uMjGqzPTFmIZF22vDEUDKNKw+8wADxM6OfRjLmycmk8gvvCJZjMo5tIx/ICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6nssw7L; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720655099; x=1752191099;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2FL1KLCRwEBjN0Eyy0mybvPOrQPAKC/0qRzk5OZQZ3s=;
  b=d6nssw7LzGCWsFDtDHRIL1P2X3rDomVpAclubaCtTO3oTcSNX1tsQ90H
   7hiwyJBC2Xbw+y4+e6fcOos5EL7eHCmkUKIiNxceaZ3TT1bqPYrPKesIL
   +YaVWqegBA+kvavk4jutcyoBrFo6lZ4emqeUafZJTjhGseHNqhm76qIcs
   iLthM/GJ+0aq8G+ahYg+G/RiLvGHyjr1FAB/Gmjb7K8XVaZtKSvvUKlIO
   Y4MQhLkZf6alj0yf7BMAaZBKmyPqunDs5yO7nKvha98gQW4HPDujNB8Ew
   UvctzA1+oYitWrrkfjKsf0oOo2lsBvvwxcKpxLl94NGeGc6RLULhxxa8O
   g==;
X-CSE-ConnectionGUID: xyDz//9LTmO+/BBRZAO5nw==
X-CSE-MsgGUID: ZCDHJCGbSHGAxCPevOm72g==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18145496"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18145496"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:44:59 -0700
X-CSE-ConnectionGUID: EtNu+p8KSAqlqVHEqTAZsw==
X-CSE-MsgGUID: LZ2kLGFIQxadmLv6EIr4Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48344507"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:44:57 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>, Sasha Neftin <sasha.neftin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Faizal Rahim
 <faizal.abdul.rahim@linux.intel.com>
Subject: Re: [PATCH iwl-net v2 2/3] igc: Fix reset adapter logics when tx
 mode change
In-Reply-To: <20240707125318.3425097-3-faizal.abdul.rahim@linux.intel.com>
References: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
 <20240707125318.3425097-3-faizal.abdul.rahim@linux.intel.com>
Date: Wed, 10 Jul 2024 16:44:56 -0700
Message-ID: <87o774u807.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Faizal Rahim <faizal.abdul.rahim@linux.intel.com> writes:

> Following the "igc: Fix TX Hang issue when QBV Gate is close" changes,
> remaining issues with the reset adapter logic in igc_tsn_offload_apply()
> have been observed:
>
> 1. The reset adapter logics for i225 and i226 differ, although they should
>    be the same according to the guidelines in I225/6 HW Design Section
>    7.5.2.1 on software initialization during tx mode changes.
> 2. The i225 resets adapter every time, even though tx mode doesn't change.
>    This occurs solely based on the condition  igc_is_device_id_i225() when
>    calling schedule_work().
> 3. i226 doesn't reset adapter for tsn->legacy tx mode changes. It only
>    resets adapter for legacy->tsn tx mode transitions.
> 4. qbv_count introduced in the patch is actually not needed; in this
>    context, a non-zero value of qbv_count is used to indicate if tx mode
>    was unconditionally set to tsn in igc_tsn_enable_offload(). This could
>    be replaced by checking the existing register
>    IGC_TQAVCTRL_TRANSMIT_MODE_TSN bit.
>
> This patch resolves all issues and enters schedule_work() to reset the
> adapter only when changing tx mode. It also removes reliance on qbv_count.
>
> qbv_count field will be removed in a future patch.
>
> Test ran:
>
> 1. Verify reset adapter behaviour in i225/6:
>    a) Enrol a new GCL
>       Reset adapter observed (tx mode change legacy->tsn)
>    b) Enrol a new GCL without deleting qdisc
>       No reset adapter observed (tx mode remain tsn->tsn)
>    c) Delete qdisc
>       Reset adapter observed (tx mode change tsn->legacy)
>
> 2. Tested scenario from "igc: Fix TX Hang issue when QBV Gate is closed"
>    to confirm it remains resolved.
>
> Fixes: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---

There were a quite a few bugs, some of them my fault, on this part of
the code, changing between the modes in the hardware.

So I would like some confirmation that ETF offloading/LaunchTime was
also tested with this change. Just to be sure.

But code-wise, looks good:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

