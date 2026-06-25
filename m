Return-Path: <stable+bounces-268555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NrZbFf0zPWrCywgAu9opvQ
	(envelope-from <stable+bounces-268555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:58:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B702A6C650C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:58:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rXYrCJdy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268555-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268555-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D972730154A9
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89F348883;
	Thu, 25 Jun 2026 13:58:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572F2E7394;
	Thu, 25 Jun 2026 13:58:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395884; cv=none; b=FZ4Do9VHEXTD5MWApe4RvmSt4DXKy2EW6+pEXJatmtfOaRAUhaWM4jodce2qTXHLFLWt72dpF6xnX+vbDyMIDwuPJVH+Kh4/i0WN5Qa34qDjiKPUcjWnurACNSvVLW2qQ8V/tCI4+F10GGCTNP7svAMnl1mHLoq8jHQayw2LL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395884; c=relaxed/simple;
	bh=WkpX74Apm5zS3j+opCUVdUTkZMu1z3vSVuewr0vE0WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxLjhtqkBrDeLN+SQQabYPjRSUmjee0jL9n4ak1KWMwZFeWBM6TaDPXB4t68MYjcYECWurRJ78tqvTXS4CspHSIBWXDvJRBB+T0d6oUulDXaoYM5uHsRA5Es2MCKGzGhLB9q8jA392LZ2S+R3UOAXEb2VdlrTTJBCg8H0EfFCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rXYrCJdy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D751F000E9;
	Thu, 25 Jun 2026 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782395882;
	bh=tc+ZdzXRZteGRMtjR4CniifwuVl4SgWaauwfcCEypNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rXYrCJdyjnxpsIjwNB43it0OboJBvuFr+8wBU+n4wpKJm7PthsSxs3TNiqbzuPMio
	 MXr16C/loNOeILGs/+sQkc1Qt7p9YIRRZeCU+Sox80JuYSIEN9g9S1jCg51k3LDUOz
	 S4Z1x57qnuswWmB40dldCGZ7ldwZyTtFN85xzlOA=
Date: Thu, 25 Jun 2026 14:56:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu, michal.pecio@gmail.com,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <2026062551-irritably-monotype-a70b@gregkh>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268555-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhilsolanke5@gmail.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stern@rowland.harvard.edu,m:michal.pecio@gmail.com,m:stable@vger.kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-doc@vger.kernel.org,m:michalpecio@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,rowland.harvard.edu,gmail.com,lwn.net,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B702A6C650C

On Tue, Jun 23, 2026 at 09:40:35PM +0530, Nikhil Solanke wrote:
> @@ -912,6 +915,13 @@ int usb_get_configuration(struct usb_device *dev)
>  	unsigned char *bigbuffer;
>  	struct usb_config_descriptor *desc;
>  	int result;
> +	/*
> +	 * Devices with quirky firmware will stall or reset when asked only for
> +	 * the configuration header. This variable decides which size to use in
> +	 * that case, if the quirk for that device was set.
> +	 */
> +	size_t usb_config_req_size = (dev->quirks & USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE)
> +		? USB_CONFIG_WINDOWS_REQ_SIZE : USB_DT_CONFIG_SIZE;

Please just use if () lines for code logic like this.  Don't abuse ?:
stuff as it's not needed.  Remember, we write code for people first,
compilers second, and in this case the compiler doesn't care either way
at all, but an if () line makes people much happier.

thanks,

greg k-h

