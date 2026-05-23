Return-Path: <stable+bounces-253900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKL7FBRAEWq9jAYAu9opvQ
	(envelope-from <stable+bounces-253900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:50:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15F5BD527
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4C6E3019FE2
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54222265CD9;
	Sat, 23 May 2026 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SMIAwJp4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE91A267;
	Sat, 23 May 2026 05:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515408; cv=none; b=Lj8HeEVDjWBNJetuB3q6NAGF+hkhkbIoWi+73zDQiPlMuPCW7/XXEW+U8QypKhETmK2KiA6a8aqCzNZDW1ADJ1FFehk+MBa1a3aJEghji2FuZT5Y2OLlT1t7dgdJTtmdUzvaPxJnKyERWmr6zWld6VRAAKif+Jc29bj43vDtWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515408; c=relaxed/simple;
	bh=plbnWAW2YrfrfJs/8tnI6kC47UjnZh8/TYJAq5umiQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmpqrqTaNdcrvRQgYTM5yfxmGCLKYV+Wr+0dt3cermvwc1g+IvMswyp02PWhYTJfPH5IIT9PQLV1Vys3Yl5A6fmKeMJ7+wJVU2XIt+nXs0qs1iEBJB5b9e2QZ2fiZU0gTnwZ+eB2Dnz00f2EZKl4AloOMAhNizoAux6SDoNMaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SMIAwJp4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2952D1F000E9;
	Sat, 23 May 2026 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779515406;
	bh=k8UtXgbg0AOquQW8smRGkSzmjVFBEUheshUIfvBSO5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SMIAwJp4g88gOSRDB39xREcrQJmYqHi42Bs/zTEtGcwN5HrVL9Kp8zf7zoIexbCmp
	 L5eDNw+LIqtsOd2NUSbuopewCpfz0x3BR/m/M+geiEnUNMx0xJwBNkglCSpNSOiSj4
	 rbR1LfZqbM1i7g48E9w6psaTHzri+XwHfvFL0rJo=
Date: Sat, 23 May 2026 07:50:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] USB: serial: mxuport: fix memory corruption with small
 endpoint
Message-ID: <2026052301-disinfect-catalyst-0e73@gregkh>
References: <20260522141950.947466-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522141950.947466-1-johan@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253900-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AF15F5BD527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 04:19:50PM +0200, Johan Hovold wrote:
> Make sure that the bulk-out endpoint max packet size is at least eight
> bytes to avoid user-controlled slab corruption should a malicious device
> report a smaller size.
> 
> Fixes: ee467a1f2066 ("USB: serial: add Moxa UPORT 12XX/14XX/16XX driver")
> Cc: stable@vger.kernel.org	# 3.14
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/mxuport.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
> index ad5fdf55a02e..c9b9928c473a 100644
> --- a/drivers/usb/serial/mxuport.c
> +++ b/drivers/usb/serial/mxuport.c
> @@ -962,6 +962,14 @@ static int mxuport_calc_num_ports(struct usb_serial *serial,
>  	 */
>  	BUILD_BUG_ON(ARRAY_SIZE(epds->bulk_out) < 16);
>  
> +	/*
> +	 * The bulk-out buffers must be large enough for the four-byte header
> +	 * (and following data), but assume anything smaller than eight bytes
> +	 * is broken.
> +	 */
> +	if (usb_endpoint_maxp(epds->bulk_out[0]) < 8)
> +		return -EINVAL;
> +
>  	for (i = 1; i < num_ports; ++i)
>  		epds->bulk_out[i] = epds->bulk_out[0];
>  
> -- 
> 2.53.0
>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

