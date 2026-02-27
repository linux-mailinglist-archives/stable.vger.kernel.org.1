Return-Path: <stable+bounces-219906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAF7GikkoWkyqgQAu9opvQ
	(envelope-from <stable+bounces-219906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:57:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7D1B2C31
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAF8D3077510
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7675B362125;
	Fri, 27 Feb 2026 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2dJuy/O8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB813358DB;
	Fri, 27 Feb 2026 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772168228; cv=none; b=OZoaPp6yBvMxfSBQaZWSqPGteee67EO8iQe5G51VnQBIbDmI/OA06R51GVdAb2cluZK7m6TLiwgPNzcvHOk5GoclwOKr5Sv7HfmOOi+ZkRV8qAlZChxDlmI/twwyXKScz+7avxHEgZELIkLuTGT/vWoBFTm3zuzLYNe97rzWYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772168228; c=relaxed/simple;
	bh=RfTAZ85qVi04OeSRvXN0ytOeNEPF+as7CwcUcE6C5Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Vy1kjLlFlOcbXV0UWMghGiERkmmCifzYEgQ8mwMtFN5qXENMFWJIgXWRKNE7z/NGSxFcTrCb1LMevDf/GkVm2cibY/resggf5uLzabAB4V348O5LspMgtW8QRwBVcPOF/uyIMG+iKVR3t317Ksxo/j4mXI3I16e3w7+xKDiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2dJuy/O8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96856C116C6;
	Fri, 27 Feb 2026 04:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772168227;
	bh=RfTAZ85qVi04OeSRvXN0ytOeNEPF+as7CwcUcE6C5Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2dJuy/O8gbjIjwEbt1agaN7fc3HVCdVWdtROLqn0R77fOe5FwTiUsZmTvRQ4uhcMX
	 jLunY3L4Hq/H5x66h5NOfV9fQRffD9Vx9NQNqMXbPl3YnGMpBQBcWSEGYcdJg0rwvT
	 CWVUsa6MjppqFJRwqVLlsZnpDuHScEESYOYuU2/I=
Date: Thu, 26 Feb 2026 20:56:59 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
	lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Linux 6.19.4 - Oops, regression
Message-ID: <2026022612-buckskin-surfacing-d854@gregkh>
References: <2026022657-clambake-mountable-8175@gregkh>
 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
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
	TAGGED_FROM(0.00)[bounces-219906-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3C7D1B2C31
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:46:02PM -0500, Kris Karas (Bug Reporting) wrote:
> GregKH wrote:
> > I'm announcing the release of the 6.19.4 kernel.
> > All users of the 6.19 kernel series must upgrade.
> 
> Just tried 6.19.4 (and 6.18.14) and am getting a repeatable Oops right when
> networking is initialized, likely when nft is loading its ruleset from
> /etc/nftables/*.conf
> 
> Once the nft Oops triggers, other processes start to throw errors with
> memory allocate/free, resulting very quickly in an unusable system. I have
> several systems that run iptables, which are unaffected, notably my border
> router with 400+ rules. I have three systems running nftables, one of which
> is affected, the affected one having the more sophisticated nft ruleset
> (bridging, 802.1Q, etc).

Ick, not good.  Can you do 'git bisect' to find the problem commit?  As
you have a pretty reliable reproducer it should go pretty fast.

But first, does 7.0-rc1 work or also crash the same way?

thanks,

greg k-h

