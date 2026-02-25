Return-Path: <stable+bounces-218034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N2CB8RInmnXUQQAu9opvQ
	(envelope-from <stable+bounces-218034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:56:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BAA18E6E8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55D533094CCE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2002309B2;
	Wed, 25 Feb 2026 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJgKEhX3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804141FF1B4
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771980987; cv=none; b=m14kOITnEUHqKZEboxHJVuQ1VfvgBFIXPrk7m5lWciP9rEkWDv7AXOaZWVO2jvGdIyclAdbSWOx2DmvNbGMDLyXWY1BtFtwH6bO0e07IH3w+MD5tQPgA9MZRrdQgMSi3QUGBE2qMX4EIb/utC54IYsEmRo6CucAILUiP9nBM4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771980987; c=relaxed/simple;
	bh=xEcUc7W3qiFHF35hcVVs8f/wgo3AgwVEfwSf4n7SPw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjNWIwLmjuNHI3FCfoE4Ny9zNLyt2OrnDxSqdDiGX7C5g242X1Y2es6/Q3W+p9gWtXscxvkpUqm93p2Yog7GuPQ3GY7rcDIa0kfd+afXsKbs3b1w88aKJ7YiWkVN30dStRYKiKKXHanZQ24NDneb1WvciTIhqgln7rt0oQX7azw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJgKEhX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1533BC2BC86;
	Wed, 25 Feb 2026 00:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771980987;
	bh=xEcUc7W3qiFHF35hcVVs8f/wgo3AgwVEfwSf4n7SPw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJgKEhX3nGx2cr4sHzGfpL4QBQxx/yMD8/iQ/qLnb9eShRjnAPbpAfs7DrxhFUrc9
	 IFUmaVOHs2xhO3FigmgeY9WvT0dySVNszUnWrRz/DtL1d9IQ0/Lb7gC+QFH09LJKqj
	 5j0Opyq+up3sC3eN3XnodOX/DsNmL3DS/EdqW89s=
Date: Tue, 24 Feb 2026 16:56:20 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>
Subject: Re: A few HDMI fixes for 6.18.y
Message-ID: <2026022401-fondness-unburned-7a44@gregkh>
References: <2525eb93-1515-4213-ba81-6d654c5db2ee@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2525eb93-1515-4213-ba81-6d654c5db2ee@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218034-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4BAA18E6E8
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 02:04:05PM -0600, Mario Limonciello wrote:
> Hi,
> 
> There was a commit in 6.18 that caused a problem:
> c918e75e1ed9 ("drm/amd/display: Add an HPD filter for HDMI")
> 
> This has been fixed by these commits:
> commit 6a681cd90345 ("drm/amd/display: Add an hdmi_hpd_debounce_delay_ms
> module")
> commit 17b2c526fd80 ("drm/amd/display: Clear HDMI HPD pending work only if
> it is enabled")
> 
> Can we please bring to 6.18.y and 6.19.y?

These only apply to 6.18.y, but not 6.19.y, so can you provide a working
backport for both?

thanks,

greg k-h

