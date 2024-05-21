Return-Path: <stable+bounces-45517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8498CAFB4
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 15:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0CE284920
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E07711E;
	Tue, 21 May 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9eMgMS2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062C55783;
	Tue, 21 May 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299652; cv=none; b=Hfk9QFOTLlX0hk2mmNLTqB22m4LwzoqeKa9cL7VGkq//n/o098ltQmfcMA8Pc/xkqeq5bGrL0/D3j6OaKRwr/MPLoZRYAu12Y1hsA1CLaLu7tNYmsjnSZjdOoHPHr4sgD9uNIwRCOSn4ceTxGlvUTNku0cC8rtDBlWVqYdbV3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299652; c=relaxed/simple;
	bh=b+us2QBIkA4Jbr1GcKU9KO+HMN2AR2yA2pAOg0jMe34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYhwJtq7fm85+CyAJ3Nvh/jJXvJN2z+V7r9k+Bhk6Pg5bHCfKkJfn5winsPUcacIhU/bGDo7fF0CDsMpDYxpTTOsDLsqNhTpi4mOoki2xPRa7brumMNZFLYxtYIrZvx/XJ5bt1BmQp36XrEFA4oFqqvE6qmB+50+eMYKeDdbKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9eMgMS2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716299652; x=1747835652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+us2QBIkA4Jbr1GcKU9KO+HMN2AR2yA2pAOg0jMe34=;
  b=I9eMgMS27qYXVDH8FGUS2jwI9OyPNI948QyghwlhRrh5PKVeqJ9q2T29
   Uf8yEmc2ogiHcMONzbDghfLGldSrs2Pn/e/EkSI4y2HWvxddON/R/tJHq
   cmZIQNFMgKrSPClNFxxpqbd0J0quSz60URBFXWkyPaygovm0CIZyJDKb7
   jEEp1Z0q4KCijkuJhnVeEWEtX1zF/7Lah/Pcb4zLOD6WRIdi5wNEUchNu
   K4axf2v++dSBDNbzCWZNLleYmbDT6e0hvSso7VLWrYV+bTcjrvvYz8Qh7
   payw/oL0ZHUMTpP18UUdJCvFnoubeUirEpsfQFj1Dh6yAM7meJZDhgtdQ
   w==;
X-CSE-ConnectionGUID: fWLLQm7nQ22KBk747S+Qew==
X-CSE-MsgGUID: 9I7kiUKVRsiM7Q5TSPfOBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16320755"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="16320755"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 06:54:11 -0700
X-CSE-ConnectionGUID: IXx87xooSIm76cT5A+yq5Q==
X-CSE-MsgGUID: wgth+0zMReSIgyEQnwSMLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="33053699"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa010.fm.intel.com with SMTP; 21 May 2024 06:54:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 May 2024 16:54:06 +0300
Date: Tue, 21 May 2024 16:54:06 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Kyle Tso <kyletso@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Ignore received Hard Reset in TOGGLING
 state
Message-ID: <ZkynfhXVI3M7qq0z@kuha.fi.intel.com>
References: <20240520154858.1072347-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520154858.1072347-1-kyletso@google.com>

On Mon, May 20, 2024 at 11:48:58PM +0800, Kyle Tso wrote:
> Similar to what fixed in Commit a6fe37f428c1 ("usb: typec: tcpm: Skip
> hard reset when in error recovery"), the handling of the received Hard
> Reset has to be skipped during TOGGLING state.
> 
> [ 4086.021288] VBUS off
> [ 4086.021295] pending state change SNK_READY -> SNK_UNATTACHED @ 650 ms [rev2 NONE_AMS]
> [ 4086.022113] VBUS VSAFE0V
> [ 4086.022117] state change SNK_READY -> SNK_UNATTACHED [rev2 NONE_AMS]
> [ 4086.022447] VBUS off
> [ 4086.022450] state change SNK_UNATTACHED -> SNK_UNATTACHED [rev2 NONE_AMS]
> [ 4086.023060] VBUS VSAFE0V
> [ 4086.023064] state change SNK_UNATTACHED -> SNK_UNATTACHED [rev2 NONE_AMS]
> [ 4086.023070] disable BIST MODE TESTDATA
> [ 4086.023766] disable vbus discharge ret:0
> [ 4086.023911] Setting usb_comm capable false
> [ 4086.028874] Setting voltage/current limit 0 mV 0 mA
> [ 4086.028888] polarity 0
> [ 4086.030305] Requesting mux state 0, usb-role 0, orientation 0
> [ 4086.033539] Start toggling
> [ 4086.038496] state change SNK_UNATTACHED -> TOGGLING [rev2 NONE_AMS]
> 
> // This Hard Reset is unexpected
> [ 4086.038499] Received hard reset
> [ 4086.038501] state change TOGGLING -> HARD_RESET_START [rev2 HARD_RESET]
> 
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 8a1af08f71b6..9c1cb8c11bd6 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6172,6 +6172,7 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
>  		port->tcpc->set_bist_data(port->tcpc, false);
>  
>  	switch (port->state) {
> +	case TOGGLING:
>  	case ERROR_RECOVERY:
>  	case PORT_RESET:
>  	case PORT_RESET_WAIT_OFF:
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog

-- 
heikki

