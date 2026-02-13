Return-Path: <stable+bounces-216267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMCaD19Uj2lqQQEAu9opvQ
	(envelope-from <stable+bounces-216267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:42:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 544221384E4
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DC00304A81A
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB33612E8;
	Fri, 13 Feb 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OeAPQK3J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3035DCE4;
	Fri, 13 Feb 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000679; cv=none; b=kh4kj8vsYlwN6mCHSLi0/9fR2mNkVKLomxxYgm9vAaxBz5q+Dw73UnziltYb5xsSFEdZe1K/leZRNrTrAB17LCQNAa9ldayXbwkuOfQ+BBUANhH3GBFyn3OIN1Zcu8RD9R2St5og7odOE9EkUPRZ2LzZcPxKMGVvr3eVuQZRlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000679; c=relaxed/simple;
	bh=byh7XDbRLut9pcrBJ/x87cn2TB46VcVikAGxyGPjHdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A00DfTNasBWhcKYk4SwAo26Z+2nzcADBw2z+PK0owmm+cZ7MvDlwW8XCfhBOj/55fLOdmxYlGm2ODEHQ20N1De6BLIfN8W8x1epFlB2Ol6urRZl46tUO+kOXKyT05fabJYS4zoPaPG1MmLsOqFPLQsavr0wjiHQisuyFAWn/1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OeAPQK3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284ACC116C6;
	Fri, 13 Feb 2026 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771000678;
	bh=byh7XDbRLut9pcrBJ/x87cn2TB46VcVikAGxyGPjHdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeAPQK3Jp4JWFkCxpoaCSN7TEC8pPeZ7PHGmbX1Q4RYboz/cuTaKUJdPM4BmG/1y0
	 U1afEn98luN0vIL3TyWWwh0SNZDRvBFOKWfCLKryPk4AHiU+T96ePI/884cYi7NeqH
	 0IrBS0KxVY8j8UBFSoRKufxl5uaRy8j3LA9y1s0E=
Date: Fri, 13 Feb 2026 17:37:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: Achill Gilgenast <achill@achill.org>, helpdesk@kernel.org,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
Message-ID: <2026021332-contact-footer-2f6b@gregkh>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a856f911-c493-4c48-ade8-467d9da1f628@googlemail.com>
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-216267-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[achill.org,kernel.org,linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,sladewatkins.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 544221384E4
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 05:26:51PM +0100, Peter Schneider wrote:
> Am 13.02.2026 um 16:57 schrieb Greg Kroah-Hartman:
> > On Fri, Feb 13, 2026 at 04:36:39PM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Feb 13, 2026 at 04:35:27PM +0100, Greg Kroah-Hartman wrote:
> > > > On Fri, Feb 13, 2026 at 03:48:19PM +0100, Achill Gilgenast wrote:
> > > > > On Fri Feb 13, 2026 at 2:47 PM CET, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 6.19.1 release.
> > > > > > There are 49 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > > 
> > > > > > The whole patch series can be found in one patch at:
> > > > > > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.1-rc1.gz
> > > > > 
> > > > > Hey, the link to this patch (and all other stable-review patches from
> > > > > today) seem to be not uploaded yet. Is this expected?
> > > > 
> > > > Nope, not at all. let me see if something went wrong on my side...
> > > 
> > > Ok, pushed again from my side, let's see if it propagates properly
> > > now...
> > > 
> > 
> > It's a kernel.org mirror issue, it's being worked on right now...
> 
> It seems only the tarballs are affected?! I could git pull this RC just fine
> some 10 minutes ago and build it. Adding Helpdesk and Konstantin in...

Yes, it's a tarball-only issue.  And helpdesk and Konstantin already
know about this :)

