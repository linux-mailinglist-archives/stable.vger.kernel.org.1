Return-Path: <stable+bounces-59048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A6392DD1B
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 01:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C913284D2F
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 23:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55E158DA3;
	Wed, 10 Jul 2024 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJdZuh1q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94363A5;
	Wed, 10 Jul 2024 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655220; cv=none; b=qOUatTOrMvN6Dh3Qm0vONqtG0+mOqhz+TpIj9osBq1Phi5L2IJUtJDg0+YnoGFjdrfNeTyWbi1x3W7atZIEUns4Yhyq3qS8+wfAXpGuPXdYByQBufsMy5hBfU/0c2S6pNTZayMQsCVi9UxOXbNCL+FJgsQfyoebxoDL1SsMyp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655220; c=relaxed/simple;
	bh=QB8/3eOL68A8pTiMnSt7yeyEfnMWPcIv2g/lKtnx46A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rnx077ClfQ4v2JJixBnNOLNrr1xMZdNXuWbX6G/C+GnF0wmgyOt2AG17gB7ABl2WixjbUy4kSIm0VsI80BdydDr6umAqwPYwHxzjoGybfRlG9z5hX/4KlDa9kQgglkomf5+xGgeKjfGRfA2pmO7MFXdYVaepGiqE53fK7Lat2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJdZuh1q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720655220; x=1752191220;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QB8/3eOL68A8pTiMnSt7yeyEfnMWPcIv2g/lKtnx46A=;
  b=QJdZuh1qIcj5O/3ttjsLfpWBds3TcnvgZNvVUOa2lvAjla1Zhp+NJxZ7
   dXgWVi+/+a3OWnpI8lli5wi/6wgYC5ARUw4sgAy3+RAP9zDCKhYvRX98E
   iNjoNANQ/YR4JtYBFduYBIZGFje2OiCHNpuShaL5vn9XSTqE12tH57Y8L
   0kDpimalVdQJjtgEkPQIUOMSMB5c00AyCHMWNlKJswvLRpmeDJga16csp
   TUv/aYtcJLe8ed2O3Aaznmix2tqY4KHoq0LZ96t/Q/ao1wxRU8oNiRnZK
   oGgEU/Fk8Y8ef04XUe9FWpt5TSJpOrYcDz2M9dyP+KglVcOruJuMw5ROb
   A==;
X-CSE-ConnectionGUID: A+ZWGag5Sb+cBFGgjjLSdw==
X-CSE-MsgGUID: SL3XTy0dRaC7jh84dUju9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18152049"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18152049"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:46:59 -0700
X-CSE-ConnectionGUID: UTZflU3SSXC3Cwd1Y5qXtQ==
X-CSE-MsgGUID: FyQKValqTn6wDncF77Auzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48345030"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:46:58 -0700
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
Subject: Re: [PATCH iwl-net v2 1/3] igc: Fix qbv_config_change_errors logics
In-Reply-To: <20240707125318.3425097-2-faizal.abdul.rahim@linux.intel.com>
References: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
 <20240707125318.3425097-2-faizal.abdul.rahim@linux.intel.com>
Date: Wed, 10 Jul 2024 16:46:57 -0700
Message-ID: <87ikxcu7wu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Faizal Rahim <faizal.abdul.rahim@linux.intel.com> writes:

> When user issues these cmds:
> 1. Either a) or b)
>    a) mqprio with hardware offload disabled
>    b) taprio with txtime-assist feature enabled
> 2. etf
> 3. tc qdisc delete
> 4. taprio with base time in the past
>
> At step 4, qbv_config_change_errors wrongly increased by 1.
>
> Excerpt from IEEE 802.1Q-2018 8.6.9.3.1:
> "If AdminBaseTime specifies a time in the past, and the current schedule
> is running, then: Increment ConfigChangeError counter"
>
> qbv_config_change_errors should only increase if base time is in the past
> and no taprio is active. In user perspective, taprio was not active when
> first triggered at step 4. However, i225/6 reuses qbv for etf, so qbv is
> enabled with a dummy schedule at step 2 where it enters
> igc_tsn_enable_offload() and qbv_count got incremented to 1. At step 4, it
> enters igc_tsn_enable_offload() again, qbv_count is incremented to 2.
> Because taprio is running, tc_setup_type is TC_SETUP_QDISC_ETF and
> qbv_count > 1, qbv_config_change_errors value got incremented.
>
> This issue happens due to reliance on qbv_count field where a non-zero
> value indicates that taprio is running. But qbv_count increases
> regardless if taprio is triggered by user or by other tsn feature. It does
> not align with qbv_config_change_errors expectation where it is only
> concerned with taprio triggered by user.
>
> Fixing this by relocating the qbv_config_change_errors logic to
> igc_save_qbv_schedule(), eliminating reliance on qbv_count and its
> inaccuracies from i225/6's multiple uses of qbv feature for other TSN
> features.
>
> The new function created: igc_tsn_is_taprio_activated_by_user() uses
> taprio_offload_enable field to indicate that the current running taprio
> was triggered by user, instead of triggered by non-qbv feature like etf.
>
> Fixes: ae4fe4698300 ("igc: Add qbv_config_change_errors counter")
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---

Looks good:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

