Return-Path: <stable+bounces-217284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIMbLtC1lWk/UQIAu9opvQ
	(envelope-from <stable+bounces-217284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:51:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D21566DA
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7FF83017F94
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02EE31D362;
	Wed, 18 Feb 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ptfv8FiK"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90F30F950;
	Wed, 18 Feb 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419083; cv=none; b=tr4EsLaVWHW7IKGmi9p2GdbKqisp/96D13s1cjSDjqTs5u4/g8IwRN56sne2txkPQXQ906xgsGzirICT7eRVez8wM1GkHcY3jL7JzcWI91KQ3CXVrNYH0q6y33tzcQWy5f8SPu9diNdQkJI+fSEDNFTrvp094QvExXyHQKEbiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419083; c=relaxed/simple;
	bh=liuZZYlrA43V2EPrxkhvXIqqqCrhh4XS54gi7wHiRUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bdt4bo1y4WZ/o+JYRFlrm9R/f4k6yC9A0v/odydRommxjnKKq1P/GizJ90Veu+qbu+Mo2t/tmjGtq0gPaWUo1iiXYZ0/kWIZ/vuvhsYMnzXs4C1Q9JA6iIrdwL7LEbfVOcEybuETLm0lmVI17cSHXyUaMMLoH8ept4o7IPevXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ptfv8FiK; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1638D1F969;
	Wed, 18 Feb 2026 13:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1771419080;
	bh=57R2bMYcZgJmTh7nc5eturuwK9MC2OzRRt0ZjPOG1Yg=; h=From:To:Subject;
	b=ptfv8FiKx+AehtNPi6zNDNjXqFOjCdYEGvlR40YCuIXVlL2x8xglUJxADVezl8Fze
	 UQD/ae5E6SJMKZ1rVHX/G0I+YfaRdnYzE+VeiBb6BzN2BPZCT4f8Eid+nlvaiHHltZ
	 YIwLXMkxReTihcUqscGzoSO1bz7yy5tDCz0PELaEuF5xoI21xzOtxc/RzS7FUHRpY1
	 jlLMu4ByFnCq++1tnG4WsmkY3+WupvzXnLg0aBMNJU9/No2b4c3K6yD8l69COm0bO1
	 n03YbISuyRPTZoHQoo7uXaAc7oHSVD/sxZCgdKDDvpSfEYYyo79UakOVVMJrD7AxWY
	 r/Sz4qXEd22Kg==
Date: Wed, 18 Feb 2026 13:51:16 +0100
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
Subject: Re: [PATCH 6.12 00/42] 6.12.74-rc1 review
Message-ID: <20260218125116.GA92059@francesco-nb>
References: <20260217200005.998240758@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217200005.998240758@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217284-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dolcini.it:dkim,toradex.com:email]
X-Rspamd-Queue-Id: 304D21566DA
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 09:31:51PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.74 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin AM62
 - Verdin iMX8MP
 - Toradex SMARC iMX8MP

(For the records, unfortunately I had some test failure on Verdin AM62,
 but I am 99% confident that it has nothing to do with this kernel, more
 likely something around my test infrastructure)

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


