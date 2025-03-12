Return-Path: <stable+bounces-124144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A731BA5DBB8
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8FE174681
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C17223C8A1;
	Wed, 12 Mar 2025 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cqmfjosm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A331D63FF;
	Wed, 12 Mar 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779506; cv=none; b=sGt2V68ZoY7K3lCEMhs2/+9y7yyEM8UA7a3EBObNCwPnZ+7UtC59xIGaTwhpfHOOqXNca7bQFup/PCdCi34f06Am43pks+kTgGRjNUnVFad9mcri1HnPkzfy//iKLJISOoq9l5+w3YaTuGKtGR64f6+hMSYvxq1C7JmSWmrpcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779506; c=relaxed/simple;
	bh=SCeea2IRJiR43RYeMEeub5/6lUzFMZzZEgZTvdDWAhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6pW/I9oBnCzhOPLG3L/cU0bhZZoClEWQX4BmbiGhtJtifTq3Yt1Qap4zlq2lXnQ7VWrZmb0UokMYtAfzUkky+IHwDbwlUmi3K4ixJIHJjLLI62QoHC3vo6CoxGXn5scCSfyBJdV8siW48S9mlmjMzP1iJcTAstHTq84boVpsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cqmfjosm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779505; x=1773315505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SCeea2IRJiR43RYeMEeub5/6lUzFMZzZEgZTvdDWAhg=;
  b=CqmfjosmFGmsBiwhpHnZa8fUWEpRj2GZtIQAhKURiTZ2DEiPb9/Qk8SK
   g0wZgw2+3w6Yfn4U23R+AlawUASZgmFXtx0mM1J04CMfAikmSlM1D7ivd
   HAHoi5A8/2xMbBR+rMMVfJFCgJVOOBBVJWYsvVhMftQ8bcLOtuCCVT9Il
   SoCviKUxbyOrSHrZaU2Zo7eTRgk4oVEszZWkhPXs56HcdXT3mMB7d1x4C
   YyjTdI0tr5pXK0yiMT9E0/vTMA0ZeLcjSmrDMrgFdK/GWqBJxfQM1OsXl
   8HI18sGCrRzE1W/DfcW+yTK6ZhpeLBhSWwbPiuYTiL96p2udrPWvVJhkv
   A==;
X-CSE-ConnectionGUID: 6S/joLDPQiSuAz5wlRjcbg==
X-CSE-MsgGUID: /UHQdmCmQMqILnIs67fICQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42727961"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42727961"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:38:24 -0700
X-CSE-ConnectionGUID: UnkrbVrbTZ2lpnbuvBUWTQ==
X-CSE-MsgGUID: 3RX7qHIpQDqIVAKIXSM4mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120829136"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa008.fm.intel.com with SMTP; 12 Mar 2025 04:38:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 12 Mar 2025 13:38:20 +0200
Date: Wed, 12 Mar 2025 13:38:20 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Badhri Jagan Sridharan <badhri@google.com>,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: fix state transition for
 SNK_WAIT_CAPABILITIES state in run_state_machine()
Message-ID: <Z9FyLNcHHczSvpAq@kuha.fi.intel.com>
References: <20250310-fix-snk-wait-timeout-v6-14-rc6-v1-1-5db14475798f@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-fix-snk-wait-timeout-v6-14-rc6-v1-1-5db14475798f@google.com>

On Mon, Mar 10, 2025 at 07:19:07PM -0700, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> A subtle error got introduced while manually fixing merge conflict in
> tcpm.c for commit 85c4efbe6088 ("Merge v6.12-rc6 into usb-next"). As a
> result of this error, the next state is unconditionally set to
> SNK_WAIT_CAPABILITIES_TIMEOUT while handling SNK_WAIT_CAPABILITIES state
> in run_state_machine(...).
> 
> Fix this by setting new state of TCPM state machine to `upcoming_state`
> (that is set to different values based on conditions).
> 
> Cc: stable@vger.kernel.org
> Fixes: 85c4efbe60888 ("Merge v6.12-rc6 into usb-next")
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 47be450d2be352698e9dee2e283664cd4db8081b..758933d4ac9e4e55d45940b068f3c416e7e51ee8 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5117,16 +5117,16 @@ static void run_state_machine(struct tcpm_port *port)
>  		 */
>  		if (port->vbus_never_low) {
>  			port->vbus_never_low = false;
> -			tcpm_set_state(port, SNK_SOFT_RESET,
> -				       port->timings.sink_wait_cap_time);
> +			upcoming_state = SNK_SOFT_RESET;
>  		} else {
>  			if (!port->self_powered)
>  				upcoming_state = SNK_WAIT_CAPABILITIES_TIMEOUT;
>  			else
>  				upcoming_state = hard_reset_state(port);
> -			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
> -				       port->timings.sink_wait_cap_time);
>  		}
> +
> +		tcpm_set_state(port, upcoming_state,
> +			       port->timings.sink_wait_cap_time);
>  		break;
>  	case SNK_WAIT_CAPABILITIES_TIMEOUT:
>  		/*
> 
> ---
> base-commit: 5c8c229261f14159b54b9a32f12e5fa89d88b905
> change-id: 20250310-fix-snk-wait-timeout-v6-14-rc6-7b4d9fb9bc99
> 
> Best regards,
> -- 
> Amit Sunil Dhamne <amitsd@google.com>
> 

-- 
heikki

