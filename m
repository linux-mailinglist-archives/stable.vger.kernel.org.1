Return-Path: <stable+bounces-224830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPkfOlCDsmm6NAAAu9opvQ
	(envelope-from <stable+bounces-224830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:11:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4526F67F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FD0F30254D1
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D5D3AB26C;
	Thu, 12 Mar 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltYU3KOq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29B31E85D;
	Thu, 12 Mar 2026 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306698; cv=none; b=tsDAtYGNK/JkriPGd8gn6F37WkxZRtGyZl5J0bF84Ejy0eFFhNbnqRO9eQAF2RD6pnunqkf/1pWTD27UWwucYquhSboJzXUFOT9WKtHBR8X74fbHae23Ujvs6QUjDENlYSKhm8kZ7jXmPFxMw7/1berdF8LTx1bRFcLIa7x6vqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306698; c=relaxed/simple;
	bh=fvQig8ML4pQVdnMQyjuM7klD7zTknLlXnwbrOd/GNn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIoFiYb7oN2k4xfGVweMCujMHS+YOraLkwJz/oNjshri0wmwi4VsqCpAcT/G6Z/rpY0j/l8YbfeGbcpRhCX4f9usflAZmdzwqdMS73e7RJou2pZuCYfW6zMyJvFJcZUqTmSID6i621cSJwUmBhfqkErfNuSzsdX1QwkYM2b6IDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltYU3KOq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773306696; x=1804842696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvQig8ML4pQVdnMQyjuM7klD7zTknLlXnwbrOd/GNn0=;
  b=ltYU3KOqqI5TIWd3W1jBNqINOH7yH1PxhW3gCTRDQM13Seu+ruirvKoh
   s8suczDq8E9T+N25oIuQfsM3VvAfY6wewTbQqQMSHouN8kM3D6mFj9Z8L
   YgzwAMIYtlHkTi0DR3NLsvHXmtJ9z/F5j23vI6o2yoVVLzi1kuBR0bJpO
   3eWWZVWJyji/DnqYX9JNUiZdASeUf4zhMiWiq560zYaNDww2un5ldPC2z
   uBUBp1amGczwgwoI63bqjTcgk50kD9x670SDyiX+IAItAurGOcgDjXdoG
   c37EOX/75VODMgeiaXR0Ip6VkUcX8VSF9URnH42waTHZ9DVPcA+V8+CmA
   w==;
X-CSE-ConnectionGUID: PwpsEm4qRAqYnG84joFn7Q==
X-CSE-MsgGUID: IHmCxyVhQU6eoWmnzEyCCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74093901"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74093901"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:11:36 -0700
X-CSE-ConnectionGUID: kRfUotUWQtCfzIEj6b6TwQ==
X-CSE-MsgGUID: r6uG1GxoSmeEVMvnMsffqQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 12 Mar 2026 02:11:34 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 78EB295; Thu, 12 Mar 2026 10:11:32 +0100 (CET)
Date: Thu, 12 Mar 2026 11:10:51 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Hans de Goede <hansg@kernel.org>,
	Yongbo Zhang <giraffesnn123@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: Switch to threaded IRQ handler
Message-ID: <abKDG8wHJ-19c3AD@kuha>
References: <20260311-fusb302-irq-v1-1-7e7105706629@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-fusb302-irq-v1-1-7e7105706629@flipper.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,collabora.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-224830-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,flipper.net:email]
X-Rspamd-Queue-Id: 4FC4526F67F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adding Hans and Yongbo,

Wed, Mar 11, 2026 at 06:57:12PM +0400, Alexey Charkov wrote:
> FUSB302 fails to probe with -EINVAL if its interrupt line is connected via
> an I2C GPIO expander, such as TI TCA6416.
> 
> Switch the interrupt handler to a threaded one, which also works behind
> such GPIO expanders.
> 
> Cc: stable@vger.kernel.org
> Fixes: 309b6341d557 ("usb: typec: fusb302: Revert incorrect threaded irq fix")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/usb/typec/tcpm/fusb302.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 19ff8217818e..4f1f24737051 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1755,8 +1755,8 @@ static int fusb302_probe(struct i2c_client *client)
>  		goto destroy_workqueue;
>  	}
>  
> -	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
> -			  IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
> +	ret = request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
> +				   IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
>  		goto tcpm_unregister_port;

While this looks okay to me, since this is now being changed back and
forth, let's look at it a bit more carefully.

Sebastian, Yongbo and Hans. I would really appreciate if you could
check this, and give you ack if it's okay.

Br,

-- 
heikki

