Return-Path: <stable+bounces-215786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIFuJUppjGkMnQAAu9opvQ
	(envelope-from <stable+bounces-215786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:34:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A4E123E52
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C7FC3019529
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076E3148BF;
	Wed, 11 Feb 2026 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LxO1mt0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EE30C619;
	Wed, 11 Feb 2026 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809664; cv=none; b=VRo6cK4v/tyO4z8BbU04nZSo5PEF0N9l9ejX9eNK01YyaI2i356WaZ5v9qQzkQUYyNhR9yRT71/4eas1thXxp70pWxlQ52RKA0YxvKrDHklYflsZAFnrtYcIECedr6ivXFKr/5i5+V9ONE7SlZYD2pMAF/vNCO6v0z2DeDGcYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809664; c=relaxed/simple;
	bh=vMyMBNeMUt3sklnAr4/f2e8cY/XRVFNSUbINEvD2eM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCtfieAfO1mVqae/88x05Hr5602GxkfwfQ6OYvFsuPfWQodC2fIaX7XJrp/7RM7L49Hwoc76f/vqCRG2nrHAWvEG2JfpZK0soT/2zZY1gJj/r0WkW3E3lYyuAJZmAOWiprIvTFsAZbYJ4WWGBczDwWTvG92XE6vY8+a6pd0Um3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0LxO1mt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEEAC4CEF7;
	Wed, 11 Feb 2026 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770809664;
	bh=vMyMBNeMUt3sklnAr4/f2e8cY/XRVFNSUbINEvD2eM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0LxO1mt00/aaWa+nMkx7JtRhGeBv/0RpUeqr6Arvwp/9EL8xlS4V4H83PEhdxgy93
	 BOUK6gpT0+MlzAWf8qQZJzpkI9X6cBigvaB6vCvghEb8ne753O9t9czG/iT8ppe7NA
	 KrUkwbDujoC6LM9bAqcmO9o/Rvd8B2GC10ZXtXxc=
Date: Wed, 11 Feb 2026 12:34:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ron Economos <re@w6rz.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.1 00/69] 6.1.163-rc1 review
Message-ID: <2026021113-sweep-idealness-305e@gregkh>
References: <20260209142301.913348974@linuxfoundation.org>
 <4542559a-ed5a-4ab9-bdae-0978b2dc4b49@w6rz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4542559a-ed5a-4ab9-bdae-0978b2dc4b49@w6rz.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215786-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 35A4E123E52
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:55:28AM -0800, Ron Economos wrote:
> On 2/9/26 06:23, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.163 release.
> > There are 69 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.163-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> There's a build warning on RISC-V.
> 
> arch/riscv/kernel/probes/uprobes.c: In function 'arch_uprobe_copy_ixol':
> arch/riscv/kernel/probes/uprobes.c:164:23: warning: unused variable 'start' [-Wunused-variable]
>   164 |         unsigned long start = (unsigned long)dst;
>       |                       ^~~~~
> 
> This can fixed with the fixup patch that I sent for 6.6.121.
> 
> riscv: Replace function-like macro by static inline function
> 
> commit 0b1ac9743f3d9cfced2ac3cb9f274c0675bd4189
> 
> The cherry-pick applies cleanly.

Now queued up, thanks.

greg k-h

