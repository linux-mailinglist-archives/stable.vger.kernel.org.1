Return-Path: <stable+bounces-237858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMFxEqoz3mlWpAkAu9opvQ
	(envelope-from <stable+bounces-237858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:31:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D43F9FF3
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4E6B300F123
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1943DA7FD;
	Tue, 14 Apr 2026 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OnDvMkyl"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40512B93;
	Tue, 14 Apr 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169895; cv=none; b=JhvKeUXU8Ka1JWl/5MxJ0C81dTlfOIsiGIDqqmIWZYxezEZBS2xCaudL75vfrk7sxHLbf02LYaSy46rsChgkST/Im8z8TZ6cqJvYg3O+9NLfiIGRmxt/2V+GOuZteJb+zOqLYkMrjeB0mnAwDDl6z7ywBdrGI8DtX26ZDi6KDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169895; c=relaxed/simple;
	bh=ZvyKrWciA2dpQkJAWEikb5ixfbn3fbacYycXL+6VmFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYJs8jExxvtCXImG48NWaSYUWs9/ld40QS3f0SBin4PwhwaAIWoDUGPJuoOr6rfsK/6ReGlEVx5vCRG6j8RvqVb+lr/Onuvv4iDcWWEQ1y1ThmC8svx981b2RqA1YjnacoAEFfA3lfaZotn9j9N52dUTUGfUOIyYKBmC/r4xHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OnDvMkyl; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 034E81FB95;
	Tue, 14 Apr 2026 14:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1776169891;
	bh=Pwmrt1n2AthdtiaNT8v67No/MZiNNPUOgPoJ1Xnv3as=; h=From:To:Subject;
	b=OnDvMkyl/jgALVRLc6zV5wGMh26U8VhN20xjJ00DbsRSj/YiW94OpFCqw3I330HJc
	 MLpA+5IM5xazVO2Gf+JEp3aD1w1SODTrgY9EZrCJTqgQvPjtv4ipG2tyOA+zv1wHVa
	 f7sd/DSngDAdnMsQXNdKQhXvPzb4MP36OFdclGODSYuQ79G614DWuYBUvz0eFkXnuH
	 AmLLZrSZyZtPAWuER1eoQzVmnmmXosfkhk65g7kFug6NQCMFMP+7uPjql7Tui+YTq5
	 36oV8LKky+e8ZaYpwg4D/U/cDa/gTc175g+LL7QjZE/uJJgoUgu5DzAxGYrnxZslme
	 hBbqdLm6IXC7w==
Date: Tue, 14 Apr 2026 14:31:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.6 00/50] 6.6.135-rc1 review
Message-ID: <20260414123127.GA88763@francesco-nb>
References: <20260413155724.497323914@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237858-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,toradex.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D50D43F9FF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 06:00:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.135 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

