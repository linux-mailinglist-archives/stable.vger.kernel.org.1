Return-Path: <stable+bounces-249934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPQ3KXjBDWr32wUAu9opvQ
	(envelope-from <stable+bounces-249934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:13:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35958F61B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87EE930D7D17
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5955A3E559B;
	Wed, 20 May 2026 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcOfMHO/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312E21E98EF;
	Wed, 20 May 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285685; cv=none; b=i9+E2eT+r7U6IgZ/bMaBasdO+O+fJxNoIJ3YIfKdgRdkYBw31AiG+d9LXoO9t2CViC1m+pHeKT0WkCS1MgQanIkTcsCYNullsfXlipQJfW+au0w14HNqUsqrUMBYrfVpvL/LJoMbMSGmqAFm6yi+EJGJwAxt8D3n72JfscTxLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285685; c=relaxed/simple;
	bh=wKK0Wrbgy4JXaxSTsV126sf0+qlWK17VZao9y951WYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKQvVv85HySPrF4LidZXLSMikM0MuCHLScoh8Ir5Ni0e3DylhhLROXpM/rs1KfIYAhF2kRSpm8Wk2hjUVIaHTlcttudgBkmvT+VFEbRGzlYBlbBtxM0HKQmbWGSwFDJPoL9EAJtC/Hu/3nVbBsq9BQ4TyXUnU3IAeP7Qdp9XfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcOfMHO/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA30B1F000E9;
	Wed, 20 May 2026 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779285682;
	bh=260mtSoIvf3fImaRDam0Pe5yLIS8ERuEV3CX2QQ6MGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZcOfMHO/0TCan5B9Rr2Chgu4mkBpIOiYteEIn9MPHwcVjQYJfzdPbCrcVXih3yGgu
	 xKwkPb6zNmTGIe8gGMA4hVHZ8ruORDzfdWt8RsS2JsHpy5v+geXHbC6+YMZccpoKhK
	 zstc/QQP1KkFoUN/O+0B0QbdPspKwaeep9Jzw0mKrs58hj9DskBxSIwUeA7iSxHSbV
	 BEGqm7VXJh5KABWuYcCuJsuIYnmrdnlhL8dHv2WHsdnjod1xB2/rtxwAL8je5maKab
	 ij7b3gcC1aIRftptjWY97xzXOxyrKsScBpMwBInzTFWaLSy22HImgY0aIg1be+5bDc
	 dy1kkYcgnGOrQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wPhU8-00000002pbn-1gtj;
	Wed, 20 May 2026 16:01:20 +0200
Date: Wed, 20 May 2026 16:01:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: keyspan: fix missing indat transfer sanity
 check
Message-ID: <ag2-sCZWeaJJ5bSc@hovoldconsulting.com>
References: <20260520101230.657426-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520101230.657426-1-johan@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249934-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hovoldconsulting.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0A35958F61B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:12:30PM +0200, Johan Hovold wrote:
> Add the missing sanity check on the size of usa49wg indat transfers to
> avoid parsing stale or uninitialised slab data.
> 
> Fixes: 0ca1268e109a ("USB Serial Keyspan: add support for USA-49WG & USA-28XG")
> Cc: stable@vger.kernel.org	# 2.6.23
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/keyspan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
> index 46448843541a..a267bc51afc1 100644
> --- a/drivers/usb/serial/keyspan.c
> +++ b/drivers/usb/serial/keyspan.c
> @@ -1187,6 +1187,10 @@ static void usa49wg_indat_callback(struct urb *urb)
>  	len = 0;
>  
>  	while (i < urb->actual_length) {
> +		if (urb->actual_length - i < 3) {
> +			dev_warn_ratelimited(&serial->dev, "malformed indat packet\n");

This dev_printk was a last minute addition before submitting which I
apparently failed to compile test. This should have been
&serial->interface->dev (or &urb->dev->dev).

Will fix up when applying.

> +			break;
> +		}
>  
>  		/* Check port number from message */
>  		if (data[i] >= serial->num_ports) {

Johan

