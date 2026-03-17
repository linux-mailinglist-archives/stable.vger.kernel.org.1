Return-Path: <stable+bounces-225758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML7dKS4FuWmEnAEAu9opvQ
	(envelope-from <stable+bounces-225758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:39:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5782A4F27
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A46203012B5B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD1391839;
	Tue, 17 Mar 2026 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NeQYDe/l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7421391505;
	Tue, 17 Mar 2026 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733161; cv=none; b=Av4vpnuOfQShBUK5RPEVY2FIndI42JOSX6o/rTBnjfComKurFXpnr9ID97z0iec993QnIdvfJ8ZJ1CDK4YYVV+jkIl0KeIT6kOjBm1TnoCoyGqboZABRxNdbdmPS+5U43z+Ixqt9SwXGr5lNy4+9eeUM3oVNPDgojjcerwg6wAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733161; c=relaxed/simple;
	bh=JRy7BlW+4YyMcr948u1R8Lh5p331m/L0Ornk6lRsZmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0cfsT0YuWHg+ZnRLl6IML7wCSlf+Tf3CXrEIY3M5rvCorjUtC+zYEsuc/yU2/VaFXzUQH5gbsvZriYxvJ0lakBQKt1qf8cIWpJnR7qGgBVhN5TIUJWNfvLdeLQ2+oevEHvkbS6dwovFNrk3xWvuiOtkZRH9BCopz5LcSo9n2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NeQYDe/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE380C19424;
	Tue, 17 Mar 2026 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773733161;
	bh=JRy7BlW+4YyMcr948u1R8Lh5p331m/L0Ornk6lRsZmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeQYDe/lv5rPotjsuUymvu6fKCCQDuUSo+4iAhsFkm1HyG4EkhUpe4MiaV5Luhz2b
	 zU4z/tBzbDTMMx79QtyDURalBrdYrYC5yE/CvpQB7Koh3RZtkZAOWLXIDcoNm7tr13
	 PKRAR/tSeE+IdC3PQbwiJDYQIt+CKyav41cDzhxM=
Date: Tue, 17 Mar 2026 08:39:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 5.15 000/410] 5.15.202-rc2 review
Message-ID: <2026031714-undusted-rambling-c2ae@gregkh>
References: <20260302160955.2522727-1-sashal@kernel.org>
 <20260305220801.GA3148061@ax162>
 <20260316220533.GD1329928@ax162>
 <abiuxFzZNLKbhz6F@laps>
 <2026031738-glade-glamorous-eacd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031738-glade-glamorous-eacd@gregkh>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225758-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4B5782A4F27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:42:14AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 16, 2026 at 09:30:44PM -0400, Sasha Levin wrote:
> > On Mon, Mar 16, 2026 at 03:05:33PM -0700, Nathan Chancellor wrote:
> > > On Thu, Mar 05, 2026 at 03:08:09PM -0700, Nathan Chancellor wrote:
> > > > On Mon, Mar 02, 2026 at 11:09:55AM -0500, Sasha Levin wrote:
> > > > > Jamie Iles (1):
> > > > >   i3c: remove i2c board info from i2c_dev_desc
> > > > 
> > > > You missed commit 6cbf8b38dfe3 ("i3c: fix uninitialized variable use in
> > > > i2c setup") as a fix for this one, as rightfully pointed out by clang:
> > > > 
> > > >   https://lore.kernel.org/177198114226.2577.15577566399399369654@d14e337afe00/
> > > > 
> > > >   $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper allmodconfig drivers/i3c/master.o
> > > >   drivers/i3c/master.c:2203:3: error: variable 'i2cdev' is uninitialized when used here [-Werror,-Wuninitialized]
> > > >    2203 |                 i2cdev->dev = i2c_new_client_device(adap, &i2cboardinfo->base);
> > > >         |                 ^~~~~~
> > > > 
> > > > I guess that report was missed because it was not actually addressed to
> > > > anyone?
> > > > 
> > > > FWIW, this patch appeared in a previous 5.15-rc release but Ben
> > > > rightfully pointed out it really was not necessary and Greg said he
> > > > would fix it up by hand:
> > > > 
> > > >   https://lore.kernel.org/2026011724-florist-brook-5f1f@gregkh/
> > > > 
> > > > Guess that never happened?
> > > 
> > > Ping? I don't see 6cbf8b38dfe3 queued up in 5.15 and this continues to
> > > break our builds:
> > > 
> > >  https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/23093834605
> > 
> > Hm, I queued it up, but looks like Greg dropped it:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=7c0d6910ad
> > 
> > I'm not sure why.
> 
> I am guessing that it broke some type of build, and so I figured it was
> safer to just drop them all.  I'll try it again later today, sorry about
> that...

Wait, I removed them all, as that should have fixed the issue (I removed
the offending commit that was originally causing the build problem
here.)

Nathan, what errors are you seeing now?  None of these changes are in a
release, and I don't see any i3c patches in the current queue.

confused,

greg k-h

