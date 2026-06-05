Return-Path: <stable+bounces-260722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2+zqDu3nImo6fAEAu9opvQ
	(envelope-from <stable+bounces-260722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 17:14:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 107A0649304
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 17:14:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=gk698xd8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260722-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260722-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE8CE30BA2FB
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2C41325F;
	Fri,  5 Jun 2026 15:08:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34F38F950;
	Fri,  5 Jun 2026 15:08:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672133; cv=none; b=YvIHnvhxa6wEm8QF7UTf7v0qVXOuKsVkbCuHMo2gbBIInjWQTZfu8B1MyjdPjezaLpFvyYvDnW3O1mgs2CtlbWerKohgaQncmcSHetCyC0pDky5d6vOILx6ZsrayFeqr8oeKCm6Q/qVAfFCkTX269tuGJMWpfT1sKvjbFZFp1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672133; c=relaxed/simple;
	bh=Ka+Eb/FEZvD5N6ORxhXDgUwD0Fv1aSsd50rN1HNpq3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZExpprn4s6QnkkzGwjP2g3iGkrdAeKj09w0ujxKcoHuEQXq1SsXwOn1TA2C41D6+4U7nHSLoOjuxHNztKsXTWkiZt1eCj+BITOGAKCCTrJ90uv4SfvGW4Fg5cYjP3XbqE1cur5DU6hfv/HBhTjS4EbU+EqV7r3VWCYJ0uSMOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gk698xd8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398D61F00893;
	Fri,  5 Jun 2026 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780672132;
	bh=xnZ8VJR/NtJ4iVq439h37B8f7/qDJZDqnfWnma9gDqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gk698xd8jPUog/7tZiu9YM3LI4fC+ZvUEZ28kWX6wX4GPbL0VOlIUqnN70uH50dpg
	 /ljRPLPcKbFo5ebX5Jnb2se7tJhCAjdzvx2l4Cl0M8uLRY2yTEbTtSAwOv6U4l0SfD
	 9pKrVJwzaDN+Wa/06KmEOsUmWfnIpdr9ax17Bj90=
Date: Fri, 5 Jun 2026 16:59:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vishal Kumar <vishalmimani008@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
	stable@vger.kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, digetx@gmail.com
Subject: Re: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before DMA
 unmap
Message-ID: <2026060548-bakery-supply-f9e0@gregkh>
References: <6a227a57.b453d089.3d0874.3012@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a227a57.b453d089.3d0874.3012@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260722-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vishalmimani008@gmail.com,m:linux-usb@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:stable@vger.kernel.org,m:thierry.reding@gmail.com,m:jonathanh@nvidia.com,m:digetx@gmail.com,m:thierryreding@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 107A0649304

On Fri, Jun 05, 2026 at 12:27:19AM -0700, Vishal Kumar wrote:
> From: Vishal Kumar <vishalmimani008@gmail.com>
> Date: Fri, 5 Jun 2026 14:08:54 +0900
> Subject: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before DMA
>  unmap
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

Something went wrong here :(

thanks,

greg k-h

