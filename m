Return-Path: <stable+bounces-55889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C932919AA6
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 00:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6961F23482
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473701922FB;
	Wed, 26 Jun 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXyxkJ5V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8E53364;
	Wed, 26 Jun 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719440992; cv=none; b=ssIO7LL7eQ0crmbyRI0K/QdDjQkFJ12ouoyviQGtFr8BlsKsPOyo6buCe2bulfK3BlZ+TrKf8ORKDZfMUGOlwT0Na1QJ3mDnSLiPoChIiezQe1O94X0B3EJn7UVKzQuyGOo++jCx98Cb5TsMVxQbWISqkv5dscRgqZYDn59Hrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719440992; c=relaxed/simple;
	bh=HKPx6wQS4nFnsGS0OoSu2HweUTQzD8xHGbwcpQf4KI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H/JfBjFXwQM4KQSOw7zQBBLatuqoUdD4yv7Uj+/oTgME/6rCFhSbSCJwTYftcV4jcuf1fScatLKT4ww+dLy/LqF7z1LYiTsCE1BZ/c/GHPwpmuR2d38Pyj0sb7/rHn+OlN2QOu9itL9I+0Qq2Fxmmr0jTdO06CtDyonWsd4eJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXyxkJ5V; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719440989; x=1750976989;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HKPx6wQS4nFnsGS0OoSu2HweUTQzD8xHGbwcpQf4KI0=;
  b=eXyxkJ5VDZMk8oeBTwRohBcCUadLxF++wyB9XiTEkF9NX7OF6doFlpf1
   /csLdUvMY89VJ9/oFi3fG7xIfXUQGCfBDBQnydp0CcWp3cx5BK89axek7
   3mG+FcND+wWifkDxlGHOTRgi8DTAIWr68jcEhE5yZSrNI7ZpOa5+AEorN
   qfzFMKn3i9zOypgQjDWwnd3K2k5um+hGqMI+ssJJwDlcP2wfYyGH1FcDh
   NWqDrHRpc4p0OU36zox7Y5wvNxLgVAFZ1nErH3L50w+xU7a44JSBl6PL/
   rdltfMfWIHtv7nEFrOML8OAWtyrDmru1zMWX1+bM/eY1DHn32D8VlCM8y
   A==;
X-CSE-ConnectionGUID: 1nMZZhrxQ2aPiVZw1FkJow==
X-CSE-MsgGUID: n/E8Fve7TQ2fi6lDT8U/sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16691753"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16691753"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 15:29:47 -0700
X-CSE-ConnectionGUID: OWvueI1bTI+q4M0XRZrvMw==
X-CSE-MsgGUID: NBCe1hEXSsqfulSIZIrJ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="49319741"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.58])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 15:29:48 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Faizal Rahim
 <faizal.abdul.rahim@linux.intel.com>
Subject: Re: [PATCH net 1/1] igc: Fix double reset adapter triggered from a
 single taprio cmd
In-Reply-To: <20240625082656.2702440-1-faizal.abdul.rahim@linux.intel.com>
References: <20240625082656.2702440-1-faizal.abdul.rahim@linux.intel.com>
Date: Wed, 26 Jun 2024 15:29:47 -0700
Message-ID: <87ed8j72xw.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Faizal Rahim <faizal.abdul.rahim@linux.intel.com> writes:

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
>  drivers/net/ethernet/intel/igc/igc_main.c | 33 ++++++++++++-----------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 87b655b839c1..33069880c86c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6310,21 +6310,6 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>  	size_t n;
>  	int i;
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
>  	if (qopt->base_time < 0)
>  		return -ERANGE;
>
> @@ -6433,7 +6418,23 @@ static int igc_tsn_enable_qbv_scheduling(struct igc_adapter *adapter,
>  	if (hw->mac.type != igc_i225)
>  		return -EOPNOTSUPP;
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

Yeah, moving the command parsing to be done earlier sounds like the
right fix:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


>  	if (err)
>  		return err;
>
> --
> 2.25.1
>

-- 
Vinicius

