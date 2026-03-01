Return-Path: <stable+bounces-222461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CX1+LaE5pGksawUAu9opvQ
	(envelope-from <stable+bounces-222461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:05:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E2B1CFBDE
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CF1D30157FA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6231717D;
	Sun,  1 Mar 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ixU6JQep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE31391;
	Sun,  1 Mar 2026 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370332; cv=none; b=NM+ouRft81ehm7SbmlaX+QMVXXg+c6/f2jK7zaEuA7+Mkh3hbwppHChVC5edKSW73mZSCFXw05ev95l8Vhdt7rYe+I2daLKUBPgUyRz2cwo2fVoBIhPV4p5dA8ZEhiI1BeaTPcCoqqFg5ipkzaFNvLOixR6td+rxSm3E7P6nhro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370332; c=relaxed/simple;
	bh=uxTfCcbfKfHW0EnnMzDrdW0Amb3YtxxetmIfbXDIa/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLR4KPmenOtXaduA5l42OBf6SpaM+KikpY3RIVchoOiDx+He6pDMA59Sa32YhPP80CRqukaekcdbMif/N26/dp4t9uPMMXadx/eNxlPK4BqhIme2uiGzv7Lf5xwEZ5pgLtqSfbH5yRID32Hb8UFi8bMLVakTtR9WL4rstPS+Y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ixU6JQep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC98C116C6;
	Sun,  1 Mar 2026 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772370331;
	bh=uxTfCcbfKfHW0EnnMzDrdW0Amb3YtxxetmIfbXDIa/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixU6JQepEcXC7U22m2Tnq0Yiv6x+9nBPs1j3eLggafY2nYix73p5sLGqgXDcMZukO
	 V+J3R/VQp8ilF/T1rk+NKzn/wiE9XjMki+NBKIe5FhcqoD6cjY64KR66iM+Q4VQRG2
	 KgfK2g+ox7p7kywln7PZgwsmp8TX5Pj0EJ/5aiEs=
Date: Sun, 1 Mar 2026 08:05:20 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: st_sensors: fix trigger allocation
Message-ID: <2026030112-footpad-overpass-228b@gregkh>
References: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-222461-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vinarskis.com:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30E2B1CFBDE
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 06:11:02PM +0100, Aleksandrs Vinarskis wrote:
> Current hardcoded name prevents adding multiple st-sensors devices
> on the same platform. Fix by aligning trigger name with other drivers.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---
> Some platforms such as Dell XPS 9345 contains multiple accelerometers.
> Fix st_sensors that currently only allows one device at the time.
> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 8a8ab688d7980f6dd43c660f90a0eba32c38388b..3b5615d1b6dd66ee0af6ccc83eb2fbd7b2c64d29 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -124,8 +124,9 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	unsigned long irq_trig;
>  	int err;
>  
> -	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
> -					     indio_dev->name);
> +	sdata->trig = devm_iio_trigger_alloc(parent, "%s-dev%d",
> +					     indio_dev->name,
> +					     iio_device_id(indio_dev));
>  	if (sdata->trig == NULL) {
>  		dev_err(parent, "failed to allocate iio trigger.\n");
>  		return -ENOMEM;
> 
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260228-st-iio-trigger-8ee1f219b566
> 
> Best regards,
> -- 
> Aleksandrs Vinarskis <alex@vinarskis.com>
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

