Return-Path: <stable+bounces-57944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB34926438
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB72832E3
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D6517BB3B;
	Wed,  3 Jul 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcJTnO6n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC617967F;
	Wed,  3 Jul 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019004; cv=none; b=qBxcHAjk8Lybjd6O0HUsRzxSQzRtquEFC65oLj9+BDW8ch0djz/1mNsE3ccnKiAyTZ9SODAIj4DRWn+prO1a2IZCuNX4j8RMFUrXlBuGcShJ2bRq7S9lujOo4Rs6IPxm9wJaRnEjf71761k8WLhywuxwB7e+01lULvp28ZGn/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019004; c=relaxed/simple;
	bh=FoeiMXNWygQHXGa/435t5CfC/zmEoNiICB+QwCj3c/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT+UX7Ipewgt1ldfAUayQHifHvYRojQx7sP0ZHANp6kF62Wv7azKLx+O6DyZ+uDRhwvVpjqpnJq0vaePSAZsCP6jITrgHH7beIijrt8/i03XkHE8tex43n1mRsi+UGYbTcCsiaBgTxabvwI316PgwZ3a5V3QP03L+ljPxEw45yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcJTnO6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCD9C32781;
	Wed,  3 Jul 2024 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019003;
	bh=FoeiMXNWygQHXGa/435t5CfC/zmEoNiICB+QwCj3c/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcJTnO6nmkVfC0ALn0oTGFLCMNHrRvb6GNLJW75ya9R2xkUGZvDawJi9SFlHKG0Sx
	 aCXF2Sltzp8fBmUhkWlBVYni3OKaW5WqhaPLP2IaS6f+9Zo4NIPaxiEIjK6bmnTHmF
	 IxsXgUsjfnKTZ/by4PY8qZbn/aoqNZUNsGZT943/Ta9EBKoORh7CFqAL8LDDjVOSmq
	 AV4PXOljdV4Q4kmmJ5vPMryNExBmkhJoJYC/rxGT0tgcs7oYluk23dRSElR6kVaCsm
	 qL8913WAiI6zDqk+1+ieA7zYqs8N0gLycgPp4PWiWvLardPjuBY+4o/8UOzDXzh8bU
	 JWSWGuvVvUkSg==
Date: Wed, 3 Jul 2024 16:03:18 +0100
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
Subject: Re: [PATCH iwl-net v1 2/4] igc: Fix reset adapter logics when tx
 mode change
Message-ID: <20240703150318.GN598357@kernel.org>
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
 <20240702040926.3327530-3-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702040926.3327530-3-faizal.abdul.rahim@linux.intel.com>

On Tue, Jul 02, 2024 at 12:09:24AM -0400, Faizal Rahim wrote:
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

Hi Faizal,

Nits below not withstahdning, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/igc/igc_tsn.c | 26 +++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 02dd41aff634..61f047ebf34d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -49,6 +49,13 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
>  	return new_flags;
>  }
>  
> +static bool igc_tsn_is_tx_mode_in_tsn(struct igc_adapter *adapter)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +
> +	return (bool)(rd32(IGC_TQAVCTRL) & IGC_TQAVCTRL_TRANSMIT_MODE_TSN);

Perhaps it is more a question of taste than anything else.
But my preference, FIIW, is to avoid casts.
And I think in this case using !! is a common pattern.

(Completely untested!)

	return !!(rd32(IGC_TQAVCTRL) & IGC_TQAVCTRL_TRANSMIT_MODE_TSN);

> +}
> +
>  void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
>  {
>  	struct igc_hw *hw = &adapter->hw;
> @@ -334,15 +341,28 @@ int igc_tsn_reset(struct igc_adapter *adapter)
>  	return err;
>  }
>  
> +static bool igc_tsn_will_tx_mode_change(struct igc_adapter *adapter)
> +{
> +	bool any_tsn_enabled = (bool)(igc_tsn_new_flags(adapter) &
> +			       IGC_FLAG_TSN_ANY_ENABLED);

Ditto.

> +
> +	if ((any_tsn_enabled && !igc_tsn_is_tx_mode_in_tsn(adapter)) ||
> +	    (!any_tsn_enabled && igc_tsn_is_tx_mode_in_tsn(adapter)))
> +		return true;
> +	else
> +		return false;

Likewise, this is probably more a matter of taste than anything else.
But I think this could be expressed as:

(Completely untested!)

	return (any_tsn_enabled && !igc_tsn_is_tx_mode_in_tsn(adapter)) ||
		(!any_tsn_enabled && igc_tsn_is_tx_mode_in_tsn(adapter));

Similarly in the previous patch of this series.

> +}
> +
>  int igc_tsn_offload_apply(struct igc_adapter *adapter)
>  {
>  	struct igc_hw *hw = &adapter->hw;
>  
> -	/* Per I225/6 HW Design Section 7.5.2.1, transmit mode
> -	 * cannot be changed dynamically. Require reset the adapter.
> +	/* Per I225/6 HW Design Section 7.5.2.1 guideline, if tx mode change
> +	 * from legacy->tsn or tsn->legacy, then reset adapter is needed.
>  	 */
>  	if (netif_running(adapter->netdev) &&
> -	    (igc_is_device_id_i225(hw) || !adapter->qbv_count)) {
> +	    (igc_is_device_id_i225(hw) || igc_is_device_id_i226(hw)) &&
> +	     igc_tsn_will_tx_mode_change(adapter)) {
>  		schedule_work(&adapter->reset_task);
>  		return 0;
>  	}
> -- 
> 2.25.1
> 
> 

