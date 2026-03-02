Return-Path: <stable+bounces-222575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLPQB0NrpWkaAQYAu9opvQ
	(envelope-from <stable+bounces-222575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:49:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B9B1D6CF7
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB284301BA79
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3757262A;
	Mon,  2 Mar 2026 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="IL2T4Ga/"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A259340A51;
	Mon,  2 Mar 2026 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448259; cv=none; b=hZZcBzoccoMF2SPMvMyxdP2eVMGBq7TeKtxTHcW7cioLbJN1TVeMIOVhnWijKrI+sRoudH9obstxV664DTdZayrnA5l8wF7ERegVXfXQB/H6wWHpUSDe8YSkuUpUEUOp8vkYz+WdxEKjfS6+RFC2NAFLKgbkPvsxXmS4W+QQG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448259; c=relaxed/simple;
	bh=ysE9y8L5j651mPfz7etUcFwhGQ64pPVJAnhoqY88J/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDByUPMAU3G+L+Y9f8fiNtP+ZxlDkYh3a8Hkpn4AzwdhsNZpne4wj4X6VC7ApIDLB5g3TtpQqrbNdwL1rejPp4cK/qVordfKSgXfIqdG4MOSJsAkVuwiaZArkHgC4SEufwhn37wjMOrRKW7h2HeRBFe9Zs/GGOjhdcyzaYJLHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=IL2T4Ga/; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id BE01022A47;
	Mon,  2 Mar 2026 11:44:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1772448255;
	bh=51ucpPcaf8pfmzUtIw4wGGaAo73/GfKlyHEWg0DqVAw=; h=From:To:Subject;
	b=IL2T4Ga/bvIPDD5iE4ru8ANQteG3ifbamnMHKFnWVdA3/ri8q/QG7YOdEOi/jHrwn
	 mwMcNvc8a8+42huL8R6HqcU2yqmIOxn0MVD5dfTbUYMI01+YpbOTcMJBCsK74afUwD
	 l1j45n3fLne9RpgGJKFzubI2o4cnbSb05ATCfBnUn7mZRwnz/YAqzQ+vPO8/NFiLGq
	 OKrJFXYcvEt5vSjvAdLT26W2CmF9IfsL61AEsp3UnNuL1Q8FdciUWfmkRTqLrv5pOt
	 fuYfMinJyfqz/vfe4Eemt16U3OIj0Deej9oGTHXP5ai3nQDkETe41ek3+JjYBHbUUG
	 Dvh8OPtmFit+w==
Date: Mon, 2 Mar 2026 11:44:10 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/283] 6.6.128-rc1 review
Message-ID: <20260302104410.GA43527@francesco-nb>
References: <20260228180659.1583364-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228180659.1583364-1-sashal@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222575-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,toradex.com:email,dolcini.it:dkim]
X-Rspamd-Queue-Id: 25B9B1D6CF7
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 01:06:59PM -0500, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.6.128 release.
> There are 283 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin iMX8MM
 - Colibri iMX6
 - Apalis iMX6
 - Colibri iMX6ULL
 - Colibri iMX7

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


