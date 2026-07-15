Return-Path: <stable+bounces-274743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vXZYHikpV2q2GQEAu9opvQ
	(envelope-from <stable+bounces-274743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:31:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7388175B115
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:31:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=IMwZU5Wi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274743-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274743-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5974301DEE9
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54422F7AC1;
	Wed, 15 Jul 2026 06:26:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3752FD69A;
	Wed, 15 Jul 2026 06:26:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096790; cv=none; b=vCh6mF+/EmhGE8xDz+k1kPl6vXi16kk8bj1sWYk98uw8LA4ySCtZzpN23Bsf9zSW6Ka9mEqIRNCVM6/s1cVy3lXWPZWOBHLm63Fdcz2FADqPWAK+5LZDKMmgPkKHVT5fkMuOoLW8KfPLaUR0GJ71wiiby9E3tDcedOGurc3PbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096790; c=relaxed/simple;
	bh=eVUYpFVTszWHgQjCjItmi+arc0pkf/Nnj8W6t60TBcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ+DrkvJdmRhKnFp/eS7k1jhi4RQm0I7g6k18rzp+v1emJTEZaVuM0AKuq+fH1iC2KMH/EVTlzee2GxIrN+jlxxYCWPyO4NLeBOrHHgbKi/Kjrq1VRUKB3flsRBrPdtcHIHtRrfLFOyVqdIm43z2zB/6SxyWW5k+QZmAZTcpJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMwZU5Wi; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784096788; x=1815632788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eVUYpFVTszWHgQjCjItmi+arc0pkf/Nnj8W6t60TBcE=;
  b=IMwZU5WiQfeXfCzEfXxsehVMY7LKJhElTdVRLxd0Sx8zg7VTopH3m+Wv
   q4+UWL1TQzkKvj6QmRB/L7BIb/9/SW9AsnmBSBzIdraZuZgt8rvGAXe0B
   i7tAgY9g1B4JcUb3uW5eJb4LyGVQzOr2W5cLod5mAgy5vsyQtT2tLuJL3
   ppEpUjMtIzeuaShc9NMtoaa46ghhJmgUsTOe5dIHct+/LoPgX+kuz7/kt
   NFVmzyObxzXqAFAZS3ZbUQ4mJDKHdL0+bbtKX0HLfYbLto0OJaQRoY6KV
   +VZG5JHuMwbAQAe4SsSuUrnPsAl4/p5ZfByyVmdBDiZnM8C8ASjEESrYZ
   Q==;
X-CSE-ConnectionGUID: jNXlJOPVSXmHNJ9gOvu4pg==
X-CSE-MsgGUID: LkEgOaEDTma+ooAITGcnuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83846396"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="83846396"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:26:27 -0700
X-CSE-ConnectionGUID: QtVcexa8StmR90DYVAb1Sw==
X-CSE-MsgGUID: c/szl3/FQbWGmOckl8I3nw==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:26:25 -0700
Date: Wed, 15 Jul 2026 08:26:22 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] drm/xe/i2c: Fix the interrupt handling
Message-ID: <alcoDtq2aul-tA_h@black.igk.intel.com>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
 <20260713155601.711389-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713155601.711389-3-heikki.krogerus@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274743-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:heikki.krogerus@linux.intel.com,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:mika.westerberg@linux.intel.com,m:andriy.shevchenko@linux.intel.com,m:andi.shyti@kernel.org,m:ramesh.babu.b@intel.com,m:michael.j.ruhl@intel.com,m:linux-kernel@vger.kernel.org,m:intel-xe@lists.freedesktop.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7388175B115

On Mon, Jul 13, 2026 at 05:56:00PM +0200, Heikki Krogerus wrote:
> The platforms that support the interrupt from the I2C
> adapter can not handle the amount of interrupts the adapter
> generates because of the way the IRQ is routed in the
> hardware. The I2C controller driver has to be kept in
> polling mode because of that.
> 
> The AMC MCU can still generate critical alerts that have to
> be handled. The interrupt from SMBus Alert is left enabled
> and handled separately in the Xe. The alerts from the AMC
> will cause the device to be declared wedged for now.

...

> +static void xe_amc_work(struct work_struct *work)
> +{
> +	struct xe_amc *amc = from_work(amc, work, work);
> +	struct i2c_client *client = amc->i2c->client[XE_I2C_CLIENT_AMC];
> +	const struct amc_request *request = &amc_get_alert_reason;
> +	struct amc_response response;
> +	int ret;
> +
> +	ret = i2c_master_send(client, (u8 *)request, sizeof(*request));
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to send request (%d)\n", ret);
> +		return;
> +	}
> +
> +	fsleep(20 * USEC_PER_MSEC);

Nit: Probably worth an explanation.

> +	ret = i2c_master_recv(client, (u8 *)&response, sizeof(response));
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to read response (%d)\n", ret);
> +		return;
> +	}
> +
> +	if (response.header.len == 0) {

Nit: Perhaps !response.header.len?

> +		dev_err(&client->dev, "empty response from AMC\n");
> +		return;
> +	}
> +
> +	if (response.header.command != request->header.command ||

Curious, what about the rest of the header? Would it be any different?

> +	    memcmp(&response.message, &request->message, sizeof(struct amc_message))) {
> +		dev_err(&client->dev, "response does not match the request\n");
> +		return;
> +	}
> +
> +	if (response.error) {
> +		dev_err(&client->dev, "AMC error 0x%02x\n", response.error);
> +		return;
> +	}
> +
> +	dev_dbg(&client->dev, "%s: Alert reason: %d\n", __func__, response.value);

See below [1].

> +	switch (response.value) {
> +	case AMC_ALERT_FW_DOWNLOAD:
> +	case AMC_ALERT_THERMAL_TRIP:
> +	case AMC_ALERT_OOB_REQUEST:
> +	case AMC_ALERT_OOB_RESET:
> +	case AMC_ALERT_CATERR:
> +		xe_device_declare_wedged(i2c_client_to_xe_device(client));
> +		break;
> +	default:
> +		break;
> +	}
> +}

...

> @@ -181,8 +187,7 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
>  	if (!(master_ctl & I2C_IRQ) || !xe_i2c_irq_present(xe))
>  		return;
>  
> -	/* Forward interrupt to I2C adapter */
> -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> +	xe_i2c_handle_smbus_alert(xe->i2c);

[1] Can we move the below re-assert code to wq now? Or do you suspect any
side-effects?

>  	/* Deassert after I2C adapter clears the interrupt */
>  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
> @@ -212,45 +217,6 @@ void xe_i2c_irq_postinstall(struct xe_device *xe)
>  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
>  }

...

> -#define XE_I2C_MAX_CLIENTS		3
> -
>  #define XE_I2C_EP_COOKIE_DEVICE		0xde
>  
>  /* Endpoint Capabilities */
>  #define XE_I2C_EP_CAP_IRQ		BIT(0)
>  
> +enum XE_I2C_CLIENT {
> +	XE_I2C_CLIENT_AMC,
> +	XE_I2C_MAX_CLIENTS = 3,

I know it was already like this but I probably missed why do we have 3
(atleast from driver POV)?

Raag

> +};

