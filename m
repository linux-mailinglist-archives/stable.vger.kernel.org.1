Return-Path: <stable+bounces-216833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFlGB1NylGnVDwIAu9opvQ
	(envelope-from <stable+bounces-216833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:51:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46B414CC2C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7120830488F5
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46A2C21F8;
	Tue, 17 Feb 2026 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UfDmGbzF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C62848BB;
	Tue, 17 Feb 2026 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336231; cv=none; b=fNsJ+OsS09hbu9lJ2lc7fvzRuAeLbf89Nh5wOFXIVqDw/oYvFfykTY2Ne17zQbNcQkbNWtt8ws+2zWP4x2YnWg4xrSrBZXcdABUlR6706LEBssQcU0JA6GBCxJ9O37YltoY28L4csOS3T9shlU0G4d7BnFsuHazfdxQR+IIFlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336231; c=relaxed/simple;
	bh=2q/n7obVICsBUhVx3cRmA/pC+bCZgsAvDLO0dsBRNB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r92Gcc1YaXqi+xaOBqTj4qZT//EY0j+Jud6BWUlZQH3qqWeg9iu4l6HOxEjpkf2DTQFNiCSgWk48SWPQHD3nK2ksAx5EnQtQOi911zqZ7mmNB0QFiDRuvFWD63R9zmtnjwHdF48A8O2guknLLV+LZQthM+oS8hKRWwqY8kdIQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UfDmGbzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3048C19423;
	Tue, 17 Feb 2026 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771336231;
	bh=2q/n7obVICsBUhVx3cRmA/pC+bCZgsAvDLO0dsBRNB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfDmGbzF5JS7yU8GYCcSoiEO/h+3Fc4KlUTVz9lGl5Dsp+EgKbGYei4ACeBTCMSPX
	 xcYYQqTljI0tUwBSA4E6dpDpcBcpNm+flD/QGVXU2Cn6diawx94X+qYKRfMAPhd19e
	 Pzr/7oe+4OlsoRlMFx8yhC6//98eK+e7ORwiIV8g=
Date: Tue, 17 Feb 2026 14:50:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jack Aboutboul <jaboutboul@microsoft.com>,
	Sharath George John <sgeorgejohn@microsoft.com>,
	Noah Meyerhans <nmeyerhans@microsoft.com>,
	Jim Perrin <Jim.Perrin@microsoft.com>
Subject: Re: [PATCH 6.1 0/3]  arm64: Speed up boot with faster linear map
 creation
Message-ID: <2026021717-stellar-skylight-7824@gregkh>
References: <20260217133527.2881603-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217133527.2881603-1-ryan.roberts@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216833-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C46B414CC2C
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 01:35:21PM +0000, Ryan Roberts wrote:
> Hi All,
> 
> This series is a backport that applies to stable kernel 6.1 (base v6.1.163), for
> some speed ups to enable significantly faster booting on systems with a lot of
> memory. The patches were originally posted at:
> 
>   https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-ryan.roberts@arm.com/
> 
> ... and were originally merged upstream in v6.10-rc1.
> 
> I'm requesting this be merged to stable on behalf of a partner who wants to get
> the benefit of this series in Debian 12.

Same here, why not just use 6.12.y?

thanks,

greg k-h

