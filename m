Return-Path: <stable+bounces-216247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFBsDMpEj2k5OgEAu9opvQ
	(envelope-from <stable+bounces-216247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:35:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD2C1379A6
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2521E304247C
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7E4273D76;
	Fri, 13 Feb 2026 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vs0xgUxX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CACF41760;
	Fri, 13 Feb 2026 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996931; cv=none; b=Ns9A/o6ij2BX9w5+ZNqHw6hF2SC2ZuV9EC4qonYlj6zZx3GChREJO/hZzZZjSCviizKBbUmGUKtBmYu0jTV2M4EB900SnSyKbHk7U57XdlKhFL4X3GHaSwMCcO6H1jxqeC6YHN6FCxuLVZwYwaor/QlSZhspwWvJmneC4/WlFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996931; c=relaxed/simple;
	bh=4hmbwmLMLMIy+k0Q2u9jCWNyzcRvtkHhf3NUiVyZPJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAq9+ZHWW6oRArLFaevyClzca6FEe5I9GnsQari1yHdJU0PqiYKgIOCC83tFapHNGXWfqz4RpGo8qtY1aD3CJyNgLsw/2L//AxGLpCO0Vg72K94zPlKA1cqfIUWS9B9qE4OijmKrDqCCTsZ0b4GdpdsdGT2ieSe34eGBoxtJhSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vs0xgUxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C04DC16AAE;
	Fri, 13 Feb 2026 15:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770996931;
	bh=4hmbwmLMLMIy+k0Q2u9jCWNyzcRvtkHhf3NUiVyZPJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vs0xgUxXShoHGk98/oZ8C0pFFnhjgyrAr7HRh23d+w7AOtJ2Jtt2g3xet5BL8m8SO
	 lR7UDd2QZJs+0zbufsX2xkBOYOHOW/yz+rcq9KZQTxPyF5pGdx2LWSxOI4OkqHxizk
	 ioXVOu/LjDssxE7eMtHCvUCTwKODQ57xIGFtY908=
Date: Fri, 13 Feb 2026 16:35:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Achill Gilgenast <achill@achill.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
Message-ID: <2026021312-magma-dormitory-53af@gregkh>
References: <20260213134708.713126210@linuxfoundation.org>
 <DGDX0HGRJJ3N.1F1EWJEDMYZND@achill.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGDX0HGRJJ3N.1F1EWJEDMYZND@achill.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216247-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,sladewatkins.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9FD2C1379A6
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 03:48:19PM +0100, Achill Gilgenast wrote:
> On Fri Feb 13, 2026 at 2:47 PM CET, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.19.1 release.
> > There are 49 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.1-rc1.gz
> 
> Hey, the link to this patch (and all other stable-review patches from
> today) seem to be not uploaded yet. Is this expected?

Nope, not at all. let me see if something went wrong on my side...

thanks,

greg k-h

