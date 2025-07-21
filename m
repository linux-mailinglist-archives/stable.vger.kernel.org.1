Return-Path: <stable+bounces-163539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76669B0C08C
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4627AD7D1
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFDF28C851;
	Mon, 21 Jul 2025 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvR4Chrj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CCF2770B;
	Mon, 21 Jul 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091097; cv=none; b=r8BX/XI41JYKpcTQOwzJu5ldgJ2v5V7qeS16Gk5f2Lp/BI2rn3uvliRq0BvLBFCn3wd6MCCG1iwRapqlG86yrN4Axa2AHrAZ205cIAlYwhTi2HJ5vEbrKbeI4T1G+Q3f2kcsouHBZwPzkn9yad3pvKZIU7ZFydVqtfglOS1mZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091097; c=relaxed/simple;
	bh=t5PZvzGpGGUTKRstpGyXHuxNt3rjsNj8x3G0UrWpS2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFlHrbXHfV6BaUmsaBL+8m/SwxnU2PW/pgiLIJVmTZPPdQcxzt0x7FdNmJJa9AxjdeX+efzU74j6pq4L6+5UIfsRlkUuISRghqBgzOK5Ffubq89T+/kyoezNxKDMlgsPBRUm++wHPbdvhzStvbG0B96VE4JNzrbJSnIAvlaKEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvR4Chrj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753091095; x=1784627095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t5PZvzGpGGUTKRstpGyXHuxNt3rjsNj8x3G0UrWpS2g=;
  b=YvR4Chrj98ob5H0haAh2uHYkISE39vY4bRzhGNfpOry76iyeAsFAdbLs
   IDGvhuReXI73G2QyJDylCqhAzE0QaTR2yPlHAU3bmC3PiAAx0qNn0vtD3
   De+yP2u7Jt8GQpS+naaLt48JJ33Ky3hJgrzr/OATtjEKXVwT4d+bELsI/
   4uG6ljpImmjlVRlb7/luzPmEsHUQAUxNMoo9jvxOtH4tuB0W49NVDRcij
   Szo5jxJkj2IuqjOYo1bLsFs8AusHNY6As6A8tI3pqyafqAMOSrwhwZVHx
   8kZ0bimI1fifMMEm+Cy1bWF5pbJ4KCaHKTgzJZ5sbwclo2hQd7j799L7V
   w==;
X-CSE-ConnectionGUID: DpnNfflJTyqV/BarIfLxyQ==
X-CSE-MsgGUID: j9TdRIU2TpWZFvIltRz3ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55258442"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55258442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 02:44:55 -0700
X-CSE-ConnectionGUID: /ymQFKQSTeqqS9DzxTObcQ==
X-CSE-MsgGUID: SJLtCJXSQCqecVcGckIynw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="164271168"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa004.fm.intel.com with SMTP; 21 Jul 2025 02:44:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Jul 2025 12:44:50 +0300
Date: Mon, 21 Jul 2025 12:44:50 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Yueyao Zhu <yueyao@google.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: cache PD RX state
Message-ID: <aH4MEsYX43afRO79@kuha.fi.intel.com>
References: <20250704-fusb302-race-condition-fix-v1-1-239012c0e27a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-fusb302-race-condition-fix-v1-1-239012c0e27a@kernel.org>

On Fri, Jul 04, 2025 at 07:55:06PM +0200, Sebastian Reichel wrote:
> This patch fixes a race condition communication error, which ends up in
> PD hard resets when losing the race. Some systems, like the Radxa ROCK
> 5B are powered through USB-C without any backup power source and use a
> FUSB302 chip to do the PD negotiation. This means it is quite important
> to avoid hard resets, since that effectively kills the system's
> power-supply.
> 
> I've found the following race condition while debugging unplanned power
> loss during booting the board every now and then:
> 
> 1. lots of TCPM/FUSB302/PD initialization stuff
> 2. TCPM ends up in SNK_WAIT_CAPABILITIES (tcpm_set_pd_rx is enabled here)
> 3. the remote PD source does not send anything, so TCPM does a SOFT RESET
> 4. TCPM ends up in SNK_WAIT_CAPABILITIES for the second time
>    (tcpm_set_pd_rx is enabled again, even though it is still on)
> 
> At this point I've seen broken CRC good messages being send by the
> FUSB302 with a logic analyzer sniffing the CC lines. Also it looks like
> messages are being lost and things generally going haywire with one of
> the two sides doing a hard reset once a broken CRC good message was send
> to the bus.
> 
> I think the system is running into a race condition, that the FIFOs are
> being cleared and/or the automatic good CRC message generation flag is
> being updated while a message is already arriving.
> 
> Let's avoid this by caching the PD RX enabled state, as we have already
> processed anything in the FIFOs and are in a good state. As a side
> effect that this also optimizes I2C bus usage :)
> 
> As far as I can tell the problem theoretically also exists when TCPM
> enters SNK_WAIT_CAPABILITIES the first time, but I believe this is less
> critical for the following reason:
> 
> On devices like the ROCK 5B, which are powered through a TCPM backed
> USB-C port, the bootloader must have done some prior PD communication
> (initial communication must happen within 5 seconds after plugging the
> USB-C plug). This means the first time the kernel TCPM state machine
> reaches SNK_WAIT_CAPABILITIES, the remote side is not sending messages
> actively. On other devices a hard reset simply adds some extra delay and
> things should be good afterwards.
> 
> Fixes: c034a43e72dda ("staging: typec: Fairchild FUSB302 Type-c chip driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index f15c63d3a8f441569ec98302f5b241430d8e4547..870a71f953f6cd8dfc618caea56f72782e40ee1c 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -104,6 +104,7 @@ struct fusb302_chip {
>  	bool vconn_on;
>  	bool vbus_on;
>  	bool charge_on;
> +	bool pd_rx_on;
>  	bool vbus_present;
>  	enum typec_cc_polarity cc_polarity;
>  	enum typec_cc_status cc1;
> @@ -841,6 +842,11 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
>  	int ret = 0;
>  
>  	mutex_lock(&chip->lock);
> +	if (chip->pd_rx_on == on) {
> +		fusb302_log(chip, "pd is already %s", str_on_off(on));
> +		goto done;
> +	}
> +
>  	ret = fusb302_pd_rx_flush(chip);
>  	if (ret < 0) {
>  		fusb302_log(chip, "cannot flush pd rx buffer, ret=%d", ret);
> @@ -863,6 +869,8 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
>  			    str_on_off(on), ret);
>  		goto done;
>  	}
> +
> +	chip->pd_rx_on = on;
>  	fusb302_log(chip, "pd := %s", str_on_off(on));
>  done:
>  	mutex_unlock(&chip->lock);
> 
> ---
> base-commit: c435a4f487e8c6a3b23dafbda87d971d4fd14e0b
> change-id: 20250704-fusb302-race-condition-fix-9cc9de73f05d
> 
> Best regards,
> -- 
> Sebastian Reichel <sre@kernel.org>

-- 
heikki

