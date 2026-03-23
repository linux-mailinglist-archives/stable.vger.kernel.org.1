Return-Path: <stable+bounces-227937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MBeNCgMwWmtPwQAu9opvQ
	(envelope-from <stable+bounces-227937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:47:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D252EF4D6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C548A303CEC0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A0386C3B;
	Mon, 23 Mar 2026 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuOym74w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997C3859CE;
	Mon, 23 Mar 2026 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259070; cv=none; b=BylCBLvZ4OcHyDf/tjxOlqy9qmQRTekrEeFau6234CKwwe9AHyMQ2sysClzabGt1mZMGTOJQ5hhPICK2ik/o1owd5rcMgIgKL1eU8NqyTeYuC7j/fOWrabC93QeeIb9uaHOAPfsevPHnNCnE73E1v7Z2UWl0DaAIjdNdcb8thHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259070; c=relaxed/simple;
	bh=4Gd851lvLvJILwJ42KZt3QyiZAzIvQuwtSDen6xjDXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9wXRzCptZZlZA5Cl8od69cVvpotm7X0AwMTMs322ob5gKuE10s//F1gkoiIb+4sAAKsfAisrgdkn9ozjMQjYwhMLUc/MSUFr2YL8UA351qU4q67c5nTsM+OhiVMsNZOE73fJe1mBIEWu5pG8AP978Hzdi8dpCmXNVRrXYs4w84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuOym74w; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774259069; x=1805795069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Gd851lvLvJILwJ42KZt3QyiZAzIvQuwtSDen6xjDXk=;
  b=RuOym74wRAmJpv+bdAQjPfBscISUENa9zDuX0kJP2hyHskY1/XghZYaP
   S701Vd/Y7+j4eJHuFYVlncob0wWeY3e226hERjGQf75sr/BdwMzyxUrFy
   1x8LjvdPLcEtGdojpgkY3590KFv21Dg3jSC3p1g1Kax/p2xZfd6N8DXov
   v057OMFVTz00k5qLp1YT/Arh63Y/iUKMYf1Wn4ahOdWAedSdACzQNY7l3
   V1W0gBu912mE5aIvBXdl1Rq2DTc86ZvZAAYG7WXP/4NJZbOTtT/icuidd
   nMrX4GEjTkXbKE9DjUGGbMG4Nz//E+Q9ssrJKJO1CwgC7vTcibwiJvdK6
   A==;
X-CSE-ConnectionGUID: ieaoLXPhQm2M1ruTTB0pZw==
X-CSE-MsgGUID: I2EaM9hGTU2s73enlhO5gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="79111828"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="79111828"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 02:44:29 -0700
X-CSE-ConnectionGUID: CnDrWjkgQDWsXg8XJSXKsg==
X-CSE-MsgGUID: 9TOZ9+fySbOoYpCqfO6B+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223044951"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 23 Mar 2026 02:44:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id A629195; Mon, 23 Mar 2026 10:44:25 +0100 (CET)
Date: Mon, 23 Mar 2026 11:43:38 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Hans de Goede <hansg@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: fusb302: Switch to threaded IRQ handler
Message-ID: <acELSje2b6alANAk@kuha>
References: <20260317-fusb302-irq-v2-1-dbabd5c5c961@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-fusb302-irq-v2-1-dbabd5c5c961@flipper.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227937-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,flipper.net:email]
X-Rspamd-Queue-Id: 64D252EF4D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 08:30:15PM +0400, Alexey Charkov wrote:
> FUSB302 fails to probe with -EINVAL if its interrupt line is connected via
> an I2C GPIO expander, such as TI TCA6416.
> 
> Switch the interrupt handler to a threaded one, which also works behind
> such GPIO expanders.
> 
> Cc: stable@vger.kernel.org
> Fixes: 309b6341d557 ("usb: typec: fusb302: Revert incorrect threaded irq fix")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Heikki Krogerus <heikki.krogrerus@linux.intel.com>

> ---
> Changes in v2:
> - Re-added the IRQF_ONESHOT flag to the request_threaded_irq() call
>   (thanks Hans de Goede and Sebastian Andrzej Siewior)
> - Link to v1: https://lore.kernel.org/r/20260311-fusb302-irq-v1-1-7e7105706629@flipper.net
> ---
>  drivers/usb/typec/tcpm/fusb302.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index ce7069fb4be6..889c4c29c1b8 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1764,8 +1764,9 @@ static int fusb302_probe(struct i2c_client *client)
>  		goto destroy_workqueue;
>  	}
>  
> -	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
> -			  IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
> +	ret = request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
> +				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +				   "fsc_interrupt_int_n", chip);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
>  		goto tcpm_unregister_port;
> 
> ---
> base-commit: 95c541ddfb0815a0ea8477af778bb13bb075079a
> change-id: 20260311-fusb302-irq-316834765871
> 
> Best regards,
> -- 
> Alexey Charkov <alchark@flipper.net>

-- 
heikki

