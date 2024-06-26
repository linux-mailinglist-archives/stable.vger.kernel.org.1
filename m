Return-Path: <stable+bounces-55815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46823917580
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 03:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CFD1C217E7
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFABD2F0;
	Wed, 26 Jun 2024 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ed0SwHvu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE906647;
	Wed, 26 Jun 2024 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364781; cv=none; b=F8Oxfkyk3V5/yG/XIEDH8X07cXHaUO+cC+r2/UQ/SDHTBs4y7DgKlhrhTBmMO7coj2stSOxNkkZsX9OFUPkjU8mzlMHsA5c9QE+n2h+odtiY2Tat7C6cbq73qpHbpx3UdJPaCm+e9WvKwA5bEBeUSPi3LSuNhltAW9pe9N7/RgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364781; c=relaxed/simple;
	bh=/ZaYhtjBB6pfsj/x9la5o1sL1jgDGNz1LjDhyzmUjwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/MASa3aa1DXiXVBCyF+UMGJnOWQFwIcjT5duqGBojg5vVHOiF/WRNvARL+Oq7sTMP63z3/wrStdQveG3CV7xxm6/TFCMVNW5Vqq/S1DmA7/Q0otNJFd2KMASk5YA7FRQiEv0JOLQoSGRZwIfeWniAEJu05oUTD9Do2gwf9808A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ed0SwHvu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719364780; x=1750900780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/ZaYhtjBB6pfsj/x9la5o1sL1jgDGNz1LjDhyzmUjwQ=;
  b=ed0SwHvuctocHusyRE78QnFP9JEF61bhiSPtMoqRyTVa87802dxdYmAO
   bCY/xagzFfHGhfo86r3x+hbHwDtbC8oxVt3tARrF4jTzUo+ZlXCSR+AIM
   yk5o26WMTITSkWpjkcTsh7rSc5flhzMVf2/2MCbdYLDyRNgZ13S1PPDqA
   Fd4REdavpHitDIJWJi93v2oJvnNhZMqQ3e4hyBO9giBPGp66B1oi3mcYe
   8QR/pbDdMvPxcRvraHz0DhOqWdHMMt9s8MhiRYZ9obt6pSD70a8QRpURK
   Xs/VUPP5F4Y2Eq8sfxKqidi0zcxIRRMZt4/sdhfOdvn2Q2r9OJsWS73/S
   A==;
X-CSE-ConnectionGUID: qAlesu3fSGm385LvTc0bhA==
X-CSE-MsgGUID: VJ6uDGUmT6uoPda5b9YSpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20222699"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="20222699"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 18:19:39 -0700
X-CSE-ConnectionGUID: Jvap4mEuRuiaOAexReNxjg==
X-CSE-MsgGUID: lQ9+WCG/QFKlJVqQa1/JTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48409095"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.120.43]) ([10.247.120.43])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 18:19:36 -0700
Message-ID: <106e0d31-c520-4ef6-994e-df1a4c9a986e@linux.intel.com>
Date: Wed, 26 Jun 2024 09:19:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] igc: Fix double reset adapter triggered from a
 single taprio cmd
To: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 muhammad.husaini.zulkifli@intel.com
References: <20240625082656.2702440-1-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20240625082656.2702440-1-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Added Vladimir and Husaini in CC.

On 25/6/2024 4:26 pm, Faizal Rahim wrote:
> Following the implementation of "igc: Add TransmissionOverrun counter"
> patch, when a taprio command is triggered by user, igc processes two
> commands: TAPRIO_CMD_REPLACE followed by TAPRIO_CMD_STATS. However, both
> commands unconditionally pass through igc_tsn_offload_apply() which
> evaluates and triggers reset adapter. The double reset causes issues in
> the calculation of adapter->qbv_count in igc.
> 
> TAPRIO_CMD_REPLACE command is expected to reset the adapter since it
> activates qbv. It's unexpected for TAPRIO_CMD_STATS to do the same
> because it doesn't configure any driver-specific TSN settings. So, the
> evaluation in igc_tsn_offload_apply() isn't needed for TAPRIO_CMD_STATS.
> 
> To address this, commands parsing are relocated to
> igc_tsn_enable_qbv_scheduling(). Commands that don't require an adapter
> reset will exit after processing, thus avoiding igc_tsn_offload_apply().
> 
> Fixes: d3750076d464 ("igc: Add TransmissionOverrun counter")
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 33 ++++++++++++-----------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 87b655b839c1..33069880c86c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6310,21 +6310,6 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>   	size_t n;
>   	int i;
> 
> -	switch (qopt->cmd) {
> -	case TAPRIO_CMD_REPLACE:
> -		break;
> -	case TAPRIO_CMD_DESTROY:
> -		return igc_tsn_clear_schedule(adapter);
> -	case TAPRIO_CMD_STATS:
> -		igc_taprio_stats(adapter->netdev, &qopt->stats);
> -		return 0;
> -	case TAPRIO_CMD_QUEUE_STATS:
> -		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
> -		return 0;
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -
>   	if (qopt->base_time < 0)
>   		return -ERANGE;
> 
> @@ -6433,7 +6418,23 @@ static int igc_tsn_enable_qbv_scheduling(struct igc_adapter *adapter,
>   	if (hw->mac.type != igc_i225)
>   		return -EOPNOTSUPP;
> 
> -	err = igc_save_qbv_schedule(adapter, qopt);
> +	switch (qopt->cmd) {
> +	case TAPRIO_CMD_REPLACE:
> +		err = igc_save_qbv_schedule(adapter, qopt);
> +		break;
> +	case TAPRIO_CMD_DESTROY:
> +		err = igc_tsn_clear_schedule(adapter);
> +		break;
> +	case TAPRIO_CMD_STATS:
> +		igc_taprio_stats(adapter->netdev, &qopt->stats);
> +		return 0;
> +	case TAPRIO_CMD_QUEUE_STATS:
> +		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
>   	if (err)
>   		return err;
> 
> --
> 2.25.1
> 

