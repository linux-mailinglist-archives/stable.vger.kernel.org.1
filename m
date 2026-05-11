Return-Path: <stable+bounces-245156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECqEHhOUAWrsegEAu9opvQ
	(envelope-from <stable+bounces-245156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:32:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4750A234
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41AE03028C08
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10C3ACF0C;
	Mon, 11 May 2026 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dwkQTjPP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C2364952
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487379; cv=none; b=hiI3nN1IkLFHYZLmurAwkGR1LBdItPEuy7A9m8/4qS2XedRUdc5dHEUMN5CIhhwwLdMwyT4Nu77MEw7meUbWSsxOCquayDikAPEgO6cU7q+E/MTh3JMzv4K/fW5CWr9/sxKzUZ0eoc195keH+hw4tL87633XQ4Wq3bNokWZwVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487379; c=relaxed/simple;
	bh=ZKCTD3DchRhhUD3MGMgckTD/kjP+6/tW6yT90f6+Rio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9yMm2fXbRr7PWT4V4JouZ+6zax3PnZUc9btV/46Ph/BFrxm+1hDe4FSuzn8vpNygruJSADXAusp7Op933qGHRahuOAsQk4Z+5QydFtYgq28icKXog02cba4regVGxfAnglC8BfrMUuCpvdL99pz/l/anjesYLF3TeT1hYXE8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dwkQTjPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE2FC2BCB0;
	Mon, 11 May 2026 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778487378;
	bh=ZKCTD3DchRhhUD3MGMgckTD/kjP+6/tW6yT90f6+Rio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwkQTjPPQlGFi6dtWY0gL948pdZsfx0cRRIpEFGvg96cNrC10sSI73H6suggpVAyJ
	 twL4TUzq4PsPMR+ipc0s8R7OhrrYs9FEA0wuaBL0PTUGJGt2LpWy80P/2niguReYob
	 FR/TBgke/HBbZJhbAe3YoeHXxhbCe6yZM3qdH5Qw=
Date: Mon, 11 May 2026 10:16:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shreenidhi Shedi <yesshedi@gmail.com>
Cc: acme@kernel.org, linux@treblig.org, mikhail.v.gavrilov@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y v2 00/18] Backport fixes for -Wdiscarded-qualifiers
 and -Wnonnull with newer glibc
Message-ID: <2026051124-wildlife-entrust-5690@gregkh>
References: <20260511071051.537859-1-yesshedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511071051.537859-1-yesshedi@gmail.com>
X-Rspamd-Queue-Id: E9B4750A234
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-245156-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,treblig.org,gmail.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 12:40:33PM +0530, Shreenidhi Shedi wrote:
> Hi all,
> 
> This patch series backports a number of patches from master to 6.1.y
> to fix `-Wdiscarded-qualifiers` and `-Wnonnull` build issues with
> newer glibc versions.
> 
> I will port these changes to other stable trees once this gets reviewed.

You need to do this first for newer kernel trees, and only if they are
accepted there, should you do this for older ones as you do not want to
have regressions moving to newer kernels, right?

But first, why do this at all?  You should always be using the latest
kernel version of perf on older kernels, especially if you are updating
glibc.

And if you update glibc, WHY ARE YOU NOT UPDATING YOUR KERNEL?

Why would you be using an old kernel tree like this?  That's very odd,
please do not do that.

thanks,

greg k-h

