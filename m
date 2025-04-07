Return-Path: <stable+bounces-128570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39008A7E3BA
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAF1885ACC
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3981FBCB6;
	Mon,  7 Apr 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxXte7jt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331431DFE36;
	Mon,  7 Apr 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038135; cv=none; b=fw6wSDpfTvvX/CepCsAmuoWBOcmisMp8TI1vE5E0OQOD6Hcw57eAnnat34zJSPpC37PW9kv5fVjUJb9Gc2HqfgXBvkKM6Mx4HOOk+z29Du8TyywlgD2vK7yxg3RIgc+T3FpzJrJCiD1EJKAoqeATfaud4JzKmn4FC/LNg8Vw9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038135; c=relaxed/simple;
	bh=2fqdQpwA72B3FR5XvEN+GgQO9JWALqdvy5MDvgJ70Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4Vxsh2UYFp/2hcF3ChyQp1z+nALy58mCF5LYlPqlhF7ivDCzLgNQsglh3ygfXpPkOFGFC6UkiIXBr01B/0LWqpdAgt3YQhA7ONDfFXGDFTC4KnF8a595x9Z7OrYE7bM1vKn4qUjPDaqOqiC8vT/8NXOMa6xtzYnHPBlg2IF7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxXte7jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F92C4CEDD;
	Mon,  7 Apr 2025 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744038135;
	bh=2fqdQpwA72B3FR5XvEN+GgQO9JWALqdvy5MDvgJ70Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxXte7jtt0OpW5DQPwSxLqjmReRKN2y+5nU/2YQcssunNP0spna87hF1rSHe2cqjz
	 0KKm/8JJl5xifCoaXTyae5Ftxtun7eMuIeLvJEKqNRhwXA07EDUFvaNU8wGPPMfoUy
	 SLHR9jbaP0go4V0m+bKQcF5Lr8J1H2QRILFhAKv8lMB4atxQrtky40gqWIz2o2D+mO
	 gAJUwNJPreDylstewL/sZsKi33yt0n3zzlt2kEB75DkyUQqGiWLUbQdqA5nrlR7v8E
	 flE+SQgRnkIxhjwghl3IQE5a3qhmi+muW76fcuj03rSQ4r9MpHKeGMgRGnvbmx7SCG
	 npHLHAChc9Rig==
Date: Mon, 7 Apr 2025 16:02:10 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] e1000e: Add error handling for e1e_rphy_locked()
Message-ID: <20250407150210.GM395307@horms.kernel.org>
References: <20250407034155.1396-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407034155.1396-1-vulab@iscas.ac.cn>

On Mon, Apr 07, 2025 at 11:41:54AM +0800, Wentao Liang wrote:
> The e1000_suspend_workarounds_ich8lan() calls e1e_rphy_locked to disable
> the SMB release, but does not check its return value. A proper
> implementation can be found in e1000_resume_workarounds_pchlan() from
> /source/drivers/net/ethernet/intel/e1000e/ich8lan.c.
> 
> Add an error check for e1e_rphy_locked(). Log the error message and jump
> to 'release' label if the e1e_rphy_locked() fails.
> 
> Fixes: 2fbe4526e5aa ("e1000e: initial support for i217")
> Cc: stable@vger.kernel.org # v3.5+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 2f9655cf5dd9..d16e3aa50809 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -5497,7 +5497,11 @@ void e1000_suspend_workarounds_ich8lan(struct e1000_hw *hw)
>  			e1e_wphy_locked(hw, I217_SxCTRL, phy_reg);
>  
>  			/* Disable the SMB release on LCD reset. */
> -			e1e_rphy_locked(hw, I217_MEMPWR, &phy_reg);
> +			ret_val = e1e_rphy_locked(hw, I217_MEMPWR, &phy_reg);
> +			if (ret_val) {
> +				e_dbg("Fail to Disable the SMB release on LCD reset.");
> +				goto release;
> +			}
>  			phy_reg &= ~I217_MEMPWR_DISABLE_SMB_RELEASE;
>  			e1e_wphy_locked(hw, I217_MEMPWR, phy_reg);
>  		}

Hi,

The next few lines of this function look like this:

		/* Enable MTA to reset for Intel Rapid Start Technology
		 * Support
		 */
		e1e_rphy_locked(hw, I217_CGFREG, &phy_reg);
		phy_reg |= I217_CGFREG_ENABLE_MTA_RESET;
		e1e_wphy_locked(hw, I217_CGFREG, phy_reg);

And I think that to be consistent with e1000_resume_workarounds_pchlan()
the return value of the above call to e1e_rphy_locked() should also be
checked.

However, I am not at all sure if the current absence of error checking is
intended as part of the logic flow, or if these are oversights.

Have you observed any run-time problems with this code?

I would naively expect that the i217 is or was a widely used device.  And
this code seems to have been around for a well over 10 years in it's
current form. Which makes me thing we should tread carefully when changing
it.


