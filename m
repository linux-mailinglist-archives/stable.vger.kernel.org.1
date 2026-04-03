Return-Path: <stable+bounces-233148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLMjFO1fz2m/vgYAu9opvQ
	(envelope-from <stable+bounces-233148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 08:36:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A8639171D
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 08:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13172301AD23
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 06:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE253009E2;
	Fri,  3 Apr 2026 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vfBt9a19"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26C1A294;
	Fri,  3 Apr 2026 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775198182; cv=none; b=VapdFEKNabOoqMFhJhSL5qlZqB1NW8kzMSeE9GhnkjheKmXmT8sU9xetCujfe0Yr9Kg7hubH7MnPJkIcWWGZ7wSWf5jwNZffG7TE7DAeJGdiTxPF7oIszjIjYA/Lj2Fo8b4AfKA7Bf0fmHwMEB5m4/YAs8PrPcJHhNd6JyTRxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775198182; c=relaxed/simple;
	bh=M47DnlMsF93Y+kcavugEUoOEUCPqDGCLwiKtNWtRmLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1bLQoo5fE/l8lOV0gzEZWmEggQkgIlEgQZgFfCYEM377GDHH0QtsX9KFzRKBkdt062L/IiYINi1Iqt+O4rk0Lil1TltfWPRKsJFEgmcQkKt92JAiTW3/kr4EG5ym2VuxaEfsHzj+sbfCnQceWWSLRNsYGdsON7VvJ3I0hQv1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vfBt9a19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B2EC4CEF7;
	Fri,  3 Apr 2026 06:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775198182;
	bh=M47DnlMsF93Y+kcavugEUoOEUCPqDGCLwiKtNWtRmLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vfBt9a19GS081zItugWKBUyh5G00reYNdVOMyCYgkefH0yF8BpNIT2f063KarygzO
	 mHVLwySMMxrZyDxUCfcW0Z8fXOQE0mtIHSNvSraIwUoTwp2MVYryPjAn8SJR4v1jAD
	 khYCV4GVKYY/oQhall+EKP2tc7bfcVIFMAEJZauA=
Date: Fri, 3 Apr 2026 08:36:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Hans de Goede <hansg@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: fusb302: Switch to threaded IRQ handler
Message-ID: <2026040344-uncouple-maroon-69a1@gregkh>
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
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233148-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A0A8639171D
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

I'll take this, but the testing systems rightly point out that
chip->gpio_int_n_irq may NOT be initialized before this call is made in
some situations, so this whole irq handler might never be set up.

I know your change didn't cause that logic bug to show up, but can you
send a patch to fix that, as you have the ability to test these types of
changes?

thanks,

greg k-h

