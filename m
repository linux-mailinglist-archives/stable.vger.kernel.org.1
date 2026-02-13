Return-Path: <stable+bounces-216268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLSEDtlUj2lqQQEAu9opvQ
	(envelope-from <stable+bounces-216268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:44:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F42E138559
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D10B3019B85
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFAA218ACC;
	Fri, 13 Feb 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dhIKwz6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43ED29992B;
	Fri, 13 Feb 2026 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000862; cv=none; b=saNWFas3qGtaHZdX0ZHjEbUrc/FksYVxGVTFuqCgbrJ2xVzhxkXCfUaspQKZBVQoV9Ee/N/VmAZvdtt2KMW3TUbsVkC5htadgIbNlHVOoPZssygU/wNiBQuvr1Rqcuxial73G68h+5Fhldd0ujgiCNCfLzfdIDZmLnZR4QoqikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000862; c=relaxed/simple;
	bh=xeR/60LbN62nVDCHbRH4pbO7J93R/K+jzqaV8eTbPqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJcBKpBbtR3xbHu0Q3Ao5RBj5H36Coo67mxbBB1jjGhqzEbUOEMwHzrkT2FwDyeB1FqV7ZrkXVPHgSOAB5qIGsmV6THm6mdcHRrqnbKjCWlTTkeHi9KRNAsf85h9q5RoVu6xkJm+47bguWAxAt+O8hJDKb18fuD8F3giovvZyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dhIKwz6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E36C116C6;
	Fri, 13 Feb 2026 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771000861;
	bh=xeR/60LbN62nVDCHbRH4pbO7J93R/K+jzqaV8eTbPqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhIKwz6NX2hZqJ3hDLRkvCpemiIYDlAjV7+zten8JJ/qVW+MLtDAL2mLEZFygJPm8
	 GeXhyDFj63f3Icyi1VE3j9CpB3E+mjBMu12zNlrBa4raNkEy7XGFLOqYuomJXSIRLb
	 RcBge4p5kbMHCoC6iBcSOsuchF85o34ZUqNmHQM8=
Date: Fri, 13 Feb 2026 11:41:00 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Achill Gilgenast <achill@achill.org>, helpdesk@kernel.org, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
Message-ID: <20260213-manipulative-proficient-robin-fc9c06@lemur>
References: <20260213134708.713126210@linuxfoundation.org>
 <DGDX0HGRJJ3N.1F1EWJEDMYZND@achill.org>
 <2026021312-magma-dormitory-53af@gregkh>
 <2026021325-repacking-crumpet-5861@gregkh>
 <2026021353-perfume-drum-3776@gregkh>
 <a856f911-c493-4c48-ade8-467d9da1f628@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a856f911-c493-4c48-ade8-467d9da1f628@googlemail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216268-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konstantin@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,achill.org,kernel.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,sladewatkins.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8F42E138559
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 05:26:51PM +0100, Peter Schneider wrote:
> > > Ok, pushed again from my side, let's see if it propagates properly
> > > now...
> > > 
> > 
> > It's a kernel.org mirror issue, it's being worked on right now...
> 
> It seems only the tarballs are affected?! I could git pull this RC just fine
> some 10 minutes ago and build it. Adding Helpdesk and Konstantin in...

It's back in the world of living after a 2-disk RAID6 failure, an LVM cache
removal gone wrong, lots of futzing with /etc/lvm/archive contents, lots of
very heavy swearing in all languages known to me, and lots of nailbiting
as the RAID array rebuilt over 18 hours.

> The 404 is funny though, kudos to whoever made this :-))

Oh, yeah, I totally forgot about that one.

-K

