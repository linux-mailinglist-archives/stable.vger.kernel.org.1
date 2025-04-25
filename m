Return-Path: <stable+bounces-136714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3741A9CBFF
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDBC4A77BB
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD94252909;
	Fri, 25 Apr 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKD6G4oP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A82522B5
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592459; cv=none; b=pguGOc6GVuXhjLysMTYpq9ge4Jqkikz+RQUfw9JS0CM4sJ2aewmCW/ljwY1iuhh6Si86RhLQYlC85zneK+O5BVLNg9VO1oZzws8QVYrbvxn5V6o4X9bq9soWf0GAM3HXGv3j7IZTn8s7D0x+EK25uJCbDF9Q4YW20/RotKp+/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592459; c=relaxed/simple;
	bh=ZR86yygcf1BYbCaNkN/G4IrxJeupsrmFAwDjwL4KmC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFztYOY8eaBX9MuMmc5AmSmxeRPlxjowT+pT/XdMMnhy8QBt+LNZaq9b20iTbnaRYhs/VqMGhHHANKhrzxo8LS6WlO0efnedEggVJmzlfnZJSbc2wva5/XTRdhCc1uSG+zmJkFgiOHmJBPyQhaja+ZAjc9jKxUmybXUwUHH1G7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKD6G4oP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745592458; x=1777128458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZR86yygcf1BYbCaNkN/G4IrxJeupsrmFAwDjwL4KmC8=;
  b=YKD6G4oPlIxLXFL8oQED41yuMo9OckMY3o6gBbD5Uo+kThc4yfWgjMAu
   fmIXkXfoP3VfHYF+8ns61vsybPrFQQVn++9WgsAcEbFg+xQM/BjBPalns
   LCkp2loG/mh6gBxppi5pObOaWIkGGU/42cJ3bA3zcoshLQKNDMaEMy8aX
   rKpRWeO9dufUc0uEjIm3PGk/MyJy+RN/pBS72GuSgP1+Eusp/U7wupnFC
   OOR8ueyA5NNcTNbJ2qyJHwkHX/OxZs6phgJhBS6vn7yuTrakcZXdrUME3
   UOwf2r76tt/Qi3fPH4/MAqQkF1CJ23F4xb8EA0TDUxYqd4tyOdBi4O5pf
   Q==;
X-CSE-ConnectionGUID: TP0psVjMSNiEf6r5/zog5Q==
X-CSE-MsgGUID: 878Wl+lrRQ+cqbv7CTTh6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="47391191"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47391191"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 07:47:37 -0700
X-CSE-ConnectionGUID: 0leyk7/gTlGda2lM2s1Sag==
X-CSE-MsgGUID: Uo8nGHryTz+xJLQRUjQfvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="138086775"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 25 Apr 2025 07:47:35 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 25 Apr 2025 17:47:33 +0300
Date: Fri, 25 Apr 2025 17:47:33 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: dri-devel@lists.freedesktop.org, jani.nikula@intel.com,
	mario.limonciello@amd.com, harry.wentland@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/dp: Correct Write_Status_Update_Request handling
Message-ID: <aAughd9lynkGlydF@intel.com>
References: <20250424030734.873693-1-Wayne.Lin@amd.com>
 <20250424030734.873693-2-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424030734.873693-2-Wayne.Lin@amd.com>
X-Patchwork-Hint: comment

On Thu, Apr 24, 2025 at 11:07:33AM +0800, Wayne Lin wrote:
> [Why]
> Notice few problems under I2C-write-over-Aux with
> Write_Status_Update_Request flag set cases:
> 
> - I2C-write-over-Aux request with
>   Write_Status_Update_Request flag set won't get sent
>   upon the reply of I2C_ACK|AUX_ACK followed by “M”
>   Value. Now just set the flag but won't send out

drm_dp_i2c_drain_msg() should keep going until an error
or the full message got transferred.

> 
> - The I2C-over-Aux request command with
>   Write_Status_Update_Request flag set is incorrect.
>   Should be "SYNC->COM3:0 (= 0110)|0000-> 0000|0000->
>   0|7-bit I2C address (the same as the last)-> STOP->".
>   Address only transaction without length and data.

This looks like a real issue.

> 
> - Upon I2C_DEFER|AUX_ACK Reply for I2C-read-over-Aux,
>   soure should repeat the identical I2C-read-over-AUX
>   transaction with the same LEN value. Not with
>   Write_Status_Update_Request set.

drm_dp_i2c_msg_write_status_update() already
checks the request type.

> 
> [How]
> Refer to DP v2.1: 2.11.7.1.5.3 & 2.11.7.1.5.4
> - Clean aux msg buffer and size when constructing
>   write status update request.
> 
> - Send out Write_Status_Update_Request upon reply of
>   I2C_ACK|AUX_ACK followed by “M”
> 
> - Send Write_Status_Update_Request upon I2C_DEFER|AUX_ACK
>   reply only when the request is I2C-write-over-Aux.
> 
> Fixes: 68ec2a2a2481 ("drm/dp: Use I2C_WRITE_STATUS_UPDATE to drain partial I2C_WRITE requests")
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 27 +++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 6ee51003de3c..28f0708c3b27 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -1631,6 +1631,12 @@ static void drm_dp_i2c_msg_write_status_update(struct drm_dp_aux_msg *msg)
>  		msg->request &= DP_AUX_I2C_MOT;
>  		msg->request |= DP_AUX_I2C_WRITE_STATUS_UPDATE;
>  	}
> +
> +	/*
> +	 * Address only transaction
> +	 */
> +	msg->buffer = NULL;
> +	msg->size = 0;
>  }
>  
>  #define AUX_PRECHARGE_LEN 10 /* 10 to 16 */
> @@ -1797,10 +1803,22 @@ static int drm_dp_i2c_do_msg(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
>  		case DP_AUX_I2C_REPLY_ACK:
>  			/*
>  			 * Both native ACK and I2C ACK replies received. We
> -			 * can assume the transfer was successful.
> +			 * can't assume the transfer was completed. Both I2C
> +			 * WRITE/READ request may get I2C ack reply with partially
> +			 * completion. We have to continue to poll for the
> +			 * completion of the request.
>  			 */
> -			if (ret != msg->size)
> -				drm_dp_i2c_msg_write_status_update(msg);
> +			if (ret != msg->size) {
> +				drm_dbg_kms(aux->drm_dev,
> +					    "%s: I2C partially ack (result=%d, size=%zu)\n",
> +					    aux->name, ret, msg->size);
> +				if (!(msg->request & DP_AUX_I2C_READ)) {
> +					usleep_range(AUX_RETRY_INTERVAL, AUX_RETRY_INTERVAL + 100);
> +					drm_dp_i2c_msg_write_status_update(msg);
> +				}
> +
> +				continue;
> +			}
>  			return ret;
>  
>  		case DP_AUX_I2C_REPLY_NACK:
> @@ -1819,7 +1837,8 @@ static int drm_dp_i2c_do_msg(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
>  			if (defer_i2c < 7)
>  				defer_i2c++;
>  			usleep_range(AUX_RETRY_INTERVAL, AUX_RETRY_INTERVAL + 100);
> -			drm_dp_i2c_msg_write_status_update(msg);
> +			if (!(msg->request & DP_AUX_I2C_READ))
> +				drm_dp_i2c_msg_write_status_update(msg);
>  
>  			continue;
>  
> -- 
> 2.43.0

-- 
Ville Syrjälä
Intel

