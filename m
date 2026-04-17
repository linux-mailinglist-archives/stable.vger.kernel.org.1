Return-Path: <stable+bounces-238424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BAaLZPS4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:26:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D3417631
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF676300F7A7
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EA22DCF55;
	Fri, 17 Apr 2026 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0Fi6Ia7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED175153BE9;
	Fri, 17 Apr 2026 06:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407180; cv=none; b=AjGO5Q1kjXgOgDRzykHaJxP1VbLbf9s5HmIamV51g8eddYwzIScskEpFBAhyaO47Qpabm1w8wRt9AsJQqfVV416HlKT9dgfoYapBQEZY3ZRO4wSkKWJmGlwOjjT9TFGsKblEUj4iZ+vNjNsnKfXUSUQOZl7L7zJAbAyGY2IsKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407180; c=relaxed/simple;
	bh=QLfYJdeUXJOQCpAnvwLBp6nzw8k9f9d/fgS91mKsx1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0XQoggC73BRe/5Sf0rxKkfwRcmb1j0D7kuCBYPfKHmnTRucKR6oNjBpgPhSjQoYyXTp3TioNLqe25vp9rCsxUMHK03QojJ97pyyzRqpdmtu/ib6qkQM0BwJJFpF0H6SDoBxqer+PzqumFYf3Tjqfh0unM4cxNtj04QK2ufkxDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0Fi6Ia7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13505C19425;
	Fri, 17 Apr 2026 06:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776407179;
	bh=QLfYJdeUXJOQCpAnvwLBp6nzw8k9f9d/fgS91mKsx1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0Fi6Ia7TFZbgjIOF+urms8w478fdHYFHFLUVUuHp+JJL3OUGpPpm1IOaa8raX/Fu
	 zwo8qll5dAjGGRpNQwErN0A+VJSNRfYASeuAUqlJZ1aPm7SNZ82ZN/8t/K89oPiT5x
	 70qEWli69g6vSCpAHzo70SgTeDFvzKpPSuxco3bk=
Date: Fri, 17 Apr 2026 08:25:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eddie Chapman <eddie@ehuk.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
Message-ID: <2026041742-armrest-clicker-84fd@gregkh>
References: <20260413155728.181580293@linuxfoundation.org>
 <172f1405-0094-4957-9758-e700ec76516f@ehuk.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172f1405-0094-4957-9758-e700ec76516f@ehuk.net>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238424-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B99D3417631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 07:55:19PM +0100, Eddie Chapman wrote:
> On 13/04/2026 16:59, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.12.82 release.
> > There are 70 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.82-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> I just wanted to point out that the revert of "PCI: Enable ACS after
> configuring IOMMU for OF platforms" is missing here despite being queued in
> the 6.1 & 6.6 rcs (it is meant to be reverted from 6.12 as well). I noticed
> when updating to 6.12.82-rc1 today as I was bit by the regression (all my
> IOMMU groups messed up).
> 
> The revert for 6.12 is in fact here:
> https://lore.kernel.org/stable/20260320172335.29778-1-john@kernel.doghat.io/
> 
> but unfortunately easily missed as shown by the confusion here (same
> thread):
> https://lore.kernel.org/stable/99426bd8-32e5-4246-9d3b-772e136bc078@leemhuis.info/
> 
> subsequently clarified by the patch author here (also same thread):
> https://lore.kernel.org/stable/5hng5r6q525scbclramuv2h2hphljbcsscwohvrs7teuedgfvl@ncr7tqhr4l4z/
> 
> Other than that 6.12.82-rc1 boots and runs fine for me on the one AMD Ryzen
> system I've tried it on.

That was not obvious at all, please don't make us dig through email
threads to know what to and not to apply, it doesn't scale when dealing
with the email volume we get.

Can someone resend that patch, properly marked fro 6.12, so we know to
apply it there?

thanks,

greg k-h

