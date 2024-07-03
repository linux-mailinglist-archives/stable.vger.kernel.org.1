Return-Path: <stable+bounces-57946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180BE926456
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FA51C2298A
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F4817DA02;
	Wed,  3 Jul 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDEq7msq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA11DFEA;
	Wed,  3 Jul 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019315; cv=none; b=r3QeDwlescoM0KmoZPoimYIqddm3x2x+JI5XzoqEHW1BrwddeRs++yxUutsRINnssJXPEjbN4EO8kKpP55gKtasitRmkwWvaoQNPn/pML5DFXqtuPFq0y5fzbVPqBYsYbepgARk8C5lGqOHtC8QesRUQN+HQm/VeaPs5aOGIPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019315; c=relaxed/simple;
	bh=lAX7AD5BLSxqIQUwHe6xLlpQ2JbfV2Twnsd17wFHnnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIKj7sIpWVyW4ptOVRgducB+A9zBAFArfEybu1qDoPgT/SgLAOriOtTSmUoSEAoT0ZQ8tfvZO9f+aDvyljHXiB9+d/kJG5SrEjRfKOAOyHUwUVtcel9YqcbHCw46mlHJo2xrxRBpnq00FF3Y3Yj2N2tn00IBdATu2/dgKb5mM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDEq7msq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11F9C2BD10;
	Wed,  3 Jul 2024 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019315;
	bh=lAX7AD5BLSxqIQUwHe6xLlpQ2JbfV2Twnsd17wFHnnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDEq7msq+dt6Fu6rj8PED1k/VmxDrbkjC5MhrEbatrm7NUkDuD16Gc6u1EC+CeABl
	 i8dbrvDwdvJcUp7qqcmUlgb1va59/INITxOSX8/oe2EH6lG0Pwq6YMvwYIJ8mEyaiP
	 TG8xKk0eTNZyJHK+bB7PFdiRUXOdrDTOVqc3u0Q0GySc21XZD9s/wNMQg8GfcIU2aA
	 Ba2MvPpYxnsbZQwSFfJC4jqeCiWWmsyFWVhGyIJGaS18ImwK2XTq7qngSqj7bfEqxK
	 2sREfTTwSKo6ELP+W5UybPGfSMJz77FKLfk9GaU6tWt4W5Iy1kM8u3e89ya2F3Fqai
	 UB+d2JxBWhbqA==
Date: Wed, 3 Jul 2024 16:08:30 +0100
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v1 1/4] igc: Fix qbv_config_change_errors logics
Message-ID: <20240703150830.GO598357@kernel.org>
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
 <20240702040926.3327530-2-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702040926.3327530-2-faizal.abdul.rahim@linux.intel.com>

On Tue, Jul 02, 2024 at 12:09:23AM -0400, Faizal Rahim wrote:
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

Thanks Faizal,

My nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 22cefb1eeedf..02dd41aff634 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -78,6 +78,17 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
>  	wr32(IGC_GTXOFFSET, txoffset);
>  }
>  
> +bool igc_tsn_is_taprio_activated_by_user(struct igc_adapter *adapter)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +
> +	if ((rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
> +	    adapter->taprio_offload_enable)
> +		return true;
> +	else
> +		return false;

As per my response to patch 2/4, I think something like this is a bit
nicer:

(Completely untested!)

	return (rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
		adapter->taprio_offload_enable;


> +}
> +
>  /* Returns the TSN specific registers to their default values after
>   * the adapter is reset.
>   */

...

