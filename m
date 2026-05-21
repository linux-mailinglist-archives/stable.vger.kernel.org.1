Return-Path: <stable+bounces-253451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOmXMCuWDmrJAQYAu9opvQ
	(envelope-from <stable+bounces-253451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:20:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884459F05C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17AE030CA1C6
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E577A36A342;
	Thu, 21 May 2026 05:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="s87ro0NW"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315283164C3;
	Thu, 21 May 2026 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340564; cv=none; b=Vj91VWCZy1OZxcw5F0yAOvA9sJHtFhdlpPlONFcqcH3lseitrXVuxTs5JkcrxcIat9/zRBzoed9s/RX6ruhHT53X/0iE6DREypbsLGzi/dfZP1bh/3nND1z/fcOYgt51Q1ok+x3LeIw+mq+NBos3+oJau0fGG/kfTL96S0iDl6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340564; c=relaxed/simple;
	bh=xu6/Ife+f7ulcrWcMzqCN5gxmm1vEk0RkjyqW1vhLz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItY5kPukPpXmmqH47KJoYTWScDXv0ioEcQIqqqx8ndJdv54+gMXljWmP+N5UkZIVtvngHaWPKlt/sXiRgI72QOSSn5CYHpsM9LdH4FslA4IMCQFsgMEz/kChdDG0HwJuvGwHYJksdKWZjV6tz7bA4IE1l8t1YFZvvJqN5OFlgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=s87ro0NW; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-38-208-55.ip72.fastwebnet.it [93.38.208.55])
	by mail11.truemail.it (Postfix) with ESMTPA id 09E751F8CB;
	Thu, 21 May 2026 07:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1779340551;
	bh=yM+hmUNIWAWHzgXKdsdcb55LNHpy0cU8nxP/m8f1bcI=; h=From:To:Subject;
	b=s87ro0NW1XyOLt/uCE0d5AUD8cWDyRO8svZzmgb0T8Zh1Zp9a3QVD/l9AQvoeOUTX
	 7bhlitYboUrpuAHhcCcAW/11VSd1GDvcbG77Ccuf8fqrkKgnCUVC4PPyP5qgs9pTvc
	 ELI36fW0KmG7FZTp5AKVe0VcxWLx1yCuHMFGpirNXmPes4kO6CtAinh1Vmle/goClK
	 f9Nhi2PfN/ckB/XD++8rkMm/3N4PXp6mSwt3Ahvm0Vhy7OMKk1VXRs+LeW2+s879oC
	 73zgVSy5bZET3/5u/B8Gderr1Alti2oQjei7Cl1Z8f+hHJlFdYhveh/mMfokjC5++/
	 9S6CScNYOMFDg==
Date: Thu, 21 May 2026 07:15:42 +0200
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
Subject: Re: [PATCH 6.6 000/508] 6.6.141-rc1 review
Message-ID: <20260521051542.GA6866@francesco-nb>
References: <20260520162058.573354582@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253451-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,toradex.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2884459F05C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:17:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.141 release.
> There are 508 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


