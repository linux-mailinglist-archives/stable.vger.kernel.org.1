Return-Path: <stable+bounces-253470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJjnLQrDDmqiCAYAu9opvQ
	(envelope-from <stable+bounces-253470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:32:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322C5A1136
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE1EF3004261
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62134F462;
	Thu, 21 May 2026 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M1efj+eB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037F3016FC;
	Thu, 21 May 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352001; cv=none; b=RvWzUgOKqRmp2P55OGK7XJgz7NJDryOVGN/COiGYZKaDCRoPx5FzyO5tQz6rmIPbOgkMhF/req7lfcWpOZi31845rfwHWfp6VN9wMWL7LMsanohth2mbBy+Nc6z+Zo0SCSAmMVCg2IYlOMTJwnby2O3J/3OAKqE9SF15MOnzMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352001; c=relaxed/simple;
	bh=r/yl6nwbQEJvgYR2GKrz70XBX6r1BL4w+ycj9DjTABg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD7a/YE9GOxHW8/+k3+zZv5z8SvgfRo+jBv9tgzk4/0Y1HkaYHYds/Ozv7FOzNlmysuDDiyqeCn1Q3lPAkbSuj1SIcogi+FMGnWTctwstVpCkPSny/L1WKTNvFwniOZLttswdV5a1lOQt4FjI5KMYcWadvY04WPSbgE/2ifhO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M1efj+eB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661D81F000E9;
	Thu, 21 May 2026 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779352000;
	bh=Qo4Zr1wh7M/wroArvcxom/jtTvDkZGPWkHDUgi/0avo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M1efj+eBCm4ilr+Ew22K2UkQz67hvnLwbbnAoSF34Uc5wROHVaN19lo4iccyGYbcf
	 WAwZZdpWTlxl49rtrdReArmMq/CuzPhFxnXqr2ZHqc7xGPvTinCjRHa873fnaHMEXx
	 S3TP3xhazrhzlVdmdkM1X7O9l2uc8CWXRashudn0=
Date: Thu, 21 May 2026 10:26:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/957] 6.18.32-rc1 review
Message-ID: <2026052159-sixties-neurology-d16d@gregkh>
References: <20260520162134.554764788@linuxfoundation.org>
 <980e2543-98d5-4e1e-b9e6-04c826e4054e@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980e2543-98d5-4e1e-b9e6-04c826e4054e@googlemail.com>
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
	TAGGED_FROM(0.00)[bounces-253470-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3322C5A1136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 08:14:32AM +0200, Peter Schneider wrote:
> Hi Greg,
> 
> Am 20.05.2026 um 18:08 schrieb Greg Kroah-Hartman:
> > This is the start of the stable review cycle for the 6.18.32 release.
> 
> Now I'm severely confused. You released 6.18.32 on May 17th, if I'm not mistaken.
> 
> Shouldn't this new 6.18 RC be subversion 33? Did you miss to increment the version number?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.18.y&id=b7adc4ce3f26a74d49d3703c6390645cb313e52d

Ah crap, yes, I had to do it "by hand" due to some mess on my side and I
forgot to bump that number.  I should rely on my scripts to do it
instead, as that's the correct way forward. 

When this is released, it will have the correct number.

thanks,

greg k-h

