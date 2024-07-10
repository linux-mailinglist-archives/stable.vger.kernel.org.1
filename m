Return-Path: <stable+bounces-59049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D314B92DD1E
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 01:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE1C28610C
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13C415886C;
	Wed, 10 Jul 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWS4TtL2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65FF156997;
	Wed, 10 Jul 2024 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655324; cv=none; b=RwdcYrEsJerV5GYcv/SPmdcp9JmDp2/WbSUWH/0d+mk8rbQS2TVFyR6vGcJvttYEs/q/UCPmF2T7gUtOalRKn2XKUPSmZ823GwWi74jwjbxSn9lamP5I0xxFWa0lq3uvq5FlWV5aoBx0Kd6W6yDwKn3d4f54cM9Qn76PQ1ZLkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655324; c=relaxed/simple;
	bh=yWzx2TsHnZ+PLHk0dmdvk2Z399kXYrvS0ZYOZ6bSS2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/wWe1baFPqmWdJfaT2tCVjRvq1WP9TnxWtMwB0midpQuug1QO6lmUBMCLyfkcmW0hzLJiOxQq+YzPF7YsKqGD3LlSxqmvgs6jWAiKqxnurabd3qSQUa+M/9++rFO2oTPcGqp15bzJkUhdxZJgSAn1wGKxeJVqPW3RQv3/yQXa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWS4TtL2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720655323; x=1752191323;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yWzx2TsHnZ+PLHk0dmdvk2Z399kXYrvS0ZYOZ6bSS2A=;
  b=DWS4TtL2eO4USGau5bNJW+lcHTj3CTB+bIsakOIANYWf+Q/5SFl35ScS
   b4/2ppxj22+MFmaHOxvI43kaWEPmzj0NgY/2pViYa2y8kk1icG4VUeeO6
   u4/QKX8kTqbbEBG/RGn8L9dAVlS1iYs40gbswFhmN9EOn2qtrPpdJW5Ka
   Msk6eo1yFXJTnUiHfPey+x6nqCq3UT4j/v4ewg9Nrzw15lzzJie0AAUoo
   7l759uo5NCZCtQvo9vgDpO2dqHeWZs4fOqih3MNI22U4ZXlYsyNJ4+qjp
   OnliRgIHt1vQEcH1F1DHuEUUSfcCE5aOANnRmbf2xtY3LIunBxg/Jfm97
   A==;
X-CSE-ConnectionGUID: +iW67wmDRoaULgGUOwVkbg==
X-CSE-MsgGUID: y1fhvaTbQ7m7r684sqBF5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="40527430"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="40527430"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:48:42 -0700
X-CSE-ConnectionGUID: pqwBzH28Rmumt/CFRUy/rg==
X-CSE-MsgGUID: BURFX1PjQOGgOobF6ZA7XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="71596699"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:48:41 -0700
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
Subject: Re: [PATCH iwl-net v2 3/3] igc: Fix qbv tx latency by setting
 gtxoffset
In-Reply-To: <20240707125318.3425097-4-faizal.abdul.rahim@linux.intel.com>
References: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
 <20240707125318.3425097-4-faizal.abdul.rahim@linux.intel.com>
Date: Wed, 10 Jul 2024 16:48:41 -0700
Message-ID: <87a5iou7ty.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Faizal Rahim <faizal.abdul.rahim@linux.intel.com> writes:

> A large tx latency issue was discovered during testing when only QBV was
> enabled. The issue occurs because gtxoffset was not set when QBV is
> active, it was only set when launch time is active.
>
> The patch "igc: Correct the launchtime offset" only sets gtxoffset when
> the launchtime_enable field is set by the user. Enabling launchtime_enable
> ultimately sets the register IGC_TXQCTL_QUEUE_MODE_LAUNCHT (referred to as
> LaunchT in the SW user manual).
>
> Section 7.5.2.6 of the IGC i225/6 SW User Manual Rev 1.2.4 states:
> "The latency between transmission scheduling (launch time) and the
> time the packet is transmitted to the network is listed in Table 7-61."
>
> However, the patch misinterprets the phrase "launch time" in that section
> by assuming it specifically refers to the LaunchT register, whereas it
> actually denotes the generic term for when a packet is released from the
> internal buffer to the MAC transmit logic.
>
> This launch time, as per that section, also implicitly refers to the QBV
> gate open time, where a packet waits in the buffer for the QBV gate to
> open. Therefore, latency applies whenever QBV is in use. TSN features such
> as QBU and QAV reuse QBV, making the latency universal to TSN features.
>
> Discussed with i226 HW owner (Shalev, Avi) and we were in agreement that
> the term "launch time" used in Section 7.5.2.6 is not clear and can be
> easily misinterpreted. Avi will update this section to:
> "When TQAVCTRL.TRANSMIT_MODE = TSN, the latency between transmission
> scheduling and the time the packet is transmitted to the network is listed
> in Table 7-61."
>
> Fix this issue by using igc_tsn_is_tx_mode_in_tsn() as a condition to
> write to gtxoffset, aligning with the newly updated SW User Manual.
>
> Tested:
> 1. Enrol taprio on talker board
>    base-time 0
>    cycle-time 1000000
>    flags 0x2
>    index 0 cmd S gatemask 0x1 interval1
>    index 0 cmd S gatemask 0x1 interval2
>
>    Note:
>    interval1 = interval for a 64 bytes packet to go through
>    interval2 = cycle-time - interval1
>
> 2. Take tcpdump on listener board
>
> 3. Use udp tai app on talker to send packets to listener
>
> 4. Check the timestamp on listener via wireshark
>
> Test Result:
> 100 Mbps: 113 ~193 ns
> 1000 Mbps: 52 ~ 84 ns
> 2500 Mbps: 95 ~ 223 ns
>
> Note that the test result is similar to the patch "igc: Correct the
> launchtime offset".
>
> Fixes: 790835fcc0cb ("igc: Correct the launchtime offset")
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---

Good catch.

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

>  drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 9fafe275f30f..efe13a9350ca 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -61,7 +61,7 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
>  	struct igc_hw *hw = &adapter->hw;
>  	u16 txoffset;
>  
> -	if (!is_any_launchtime(adapter))
> +	if (!igc_tsn_is_tx_mode_in_tsn(adapter))
>  		return;
>  
>  	switch (adapter->link_speed) {
> -- 
> 2.25.1
>


Cheers,
-- 
Vinicius

