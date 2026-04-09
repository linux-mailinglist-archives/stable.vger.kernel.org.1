Return-Path: <stable+bounces-235333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFpaGmBX12kFMggAu9opvQ
	(envelope-from <stable+bounces-235333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:38:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7493C71C6
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 954E53011786
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90EE3290C7;
	Thu,  9 Apr 2026 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ecagFyBJ"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA782F6596;
	Thu,  9 Apr 2026 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720285; cv=none; b=MdvC3IzwJzzRZoLGX0xjLwvfrMT7y2mFHqaL+8IyCxgzGpW98vSV28ZuelyxolXMvJ2WxAA9Cp32+1+uLC0WF3/LaYvjOFYcN03NZstC9Cwb07o8kbCJff8d7/lg3984Aom0Da4B73n4DeQ9EkcN43X6C1NeauR2YQ479rVP1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720285; c=relaxed/simple;
	bh=BlSCTi6nsCyyLTqX2bs79ozfG7AIrAlBBm+tvYc6RS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWBvh9Hm97jf0rKU/P7STrwPLWj8s25UD9nx9du5Z1S/wf+lB8QCARrk3hwusKXzM2WpEAU3P/Tg9rPLsOyDv7tRs8qyA86W7BrcQ6K8SSZFnMEMDP5JHga49UA2pzoZJ5zaXD13vW2bln2zz6rN/2FieCqzMzL6LCtuWSFQlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ecagFyBJ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 237521FCF6;
	Thu,  9 Apr 2026 09:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1775720281;
	bh=Q02o/z9ztangTxn0WhfPvglX7oybf+r8cpY7+/HRFS8=; h=From:To:Subject;
	b=ecagFyBJReiPwhG4SPxyAupaDT91sAhfjSDCteRwpSDslMvaO1GRtmSGZT3UTUzgZ
	 f9TZRMDsls3sAuzEVEjBQ7n9u4q4oa5i23DqodQhYyTBU9WlGqI2HRcDm7EkZMKLW9
	 tfFRE4AAgzP6OI6NFS6osx8QHwFfj4vpcKGCPhq87gwRizhsekMZmHehpE/y8AzVQI
	 Tc5TYsxVuLFVhuD/j3/+JyKJEgUctpGnyrT8crFczjITbOBBwa2Xj717KYnpdrdBjo
	 5biCa4RTddG4slob6CdoLJLbaWRDe7dMzbflTBdLq1zhnMrTBRUa2vVH3WdJ6I6s/7
	 QfUvXBBE7Fsjw==
Date: Thu, 9 Apr 2026 09:37:57 +0200
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
Subject: Re: [PATCH 6.12 000/242] 6.12.81-rc1 review
Message-ID: <20260409073757.GA31878@francesco-nb>
References: <20260408175927.064985309@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235333-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dolcini.it:dkim,toradex.com:email]
X-Rspamd-Queue-Id: DC7493C71C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:00:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.81 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


