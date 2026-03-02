Return-Path: <stable+bounces-222614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAMOKNWfpWmuCAAAu9opvQ
	(envelope-from <stable+bounces-222614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:33:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD901DAEBC
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4138D301804E
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898A3EDABD;
	Mon,  2 Mar 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxBzQZIN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4268C335066;
	Mon,  2 Mar 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461320; cv=none; b=CA1Xahvqd0a4WyPywCnas5BrFjRumZ/4psKnEUcTuluCmOmPb6uaZT6Sn6nqlquOfYlY+m39OtkHzufLffIRd4vOyUmcO9t8U4KzmJLn/88/JDQkN45cdp1nxuvpJXoCulN2blVUvWxhZKmEfjWt5zm39vEd7ZfJuWc5mG5zX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461320; c=relaxed/simple;
	bh=BRSykI7U/QQK2uY84zUfaNxqyNhDbn0SaQeNkHr5yoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2sXpgpQwiCECFGqR4dfeBRpK86nGSHjRqEbPQ6cb6SxyfcDgLFc/ZttmIs2J2WI1SYWIo0ATkUszVbMuA0wKMc8b2osXEby+hlYJQglJ3F3N5NtaOzvJPOOR3TJftPCWbUVWREXwGJWza8mxkTogEuAq5xsHJ8pG6h7kIxsARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cxBzQZIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B39EC19423;
	Mon,  2 Mar 2026 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772461319;
	bh=BRSykI7U/QQK2uY84zUfaNxqyNhDbn0SaQeNkHr5yoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxBzQZINJBnQZZWR6MU/og4zBnNDD2rIlHlxAzGJvR5Xc1rN0icv6aO/uthXjXn/s
	 pcjhLWDzkc7H/SshIUFw4n6Rfkmc7uZkXq7dSjg9SOgH373XIvOtj9nKvBoe+Le+zL
	 FnTo4hJFa3sKa7cFcGaPauORN5/0hSQe2BMx4hDg=
Date: Mon, 2 Mar 2026 09:21:49 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/385] 6.12.75-rc1 review
Message-ID: <2026030210-projector-excuse-90a7@gregkh>
References: <20260228180001.1567994-1-sashal@kernel.org>
 <41b35d0e-bd7e-4bcd-a22c-cd96ee6c43d8@pobox.com>
 <aaWWE5uQqz_eG69i@laps>
 <2026030203-detector-overlook-93cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026030203-detector-overlook-93cd@gregkh>
X-Rspamd-Queue-Id: AAD901DAEBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222614-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pobox.com,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.001];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:10:11AM -0500, Greg KH wrote:
> On Mon, Mar 02, 2026 at 08:52:19AM -0500, Sasha Levin wrote:
> > On Sun, Mar 01, 2026 at 10:05:02PM -0800, Barry K. Nathan wrote:
> > > On 2/28/26 10:00, Sasha Levin wrote:
> > > > This is the start of the stable review cycle for the 6.12.75 release.
> > > > There are 385 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Mon Mar  2 05:59:55 PM UTC 2026.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > >         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.12.y&id2=v6.12.74
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > > > and the diffstat can be found below.
> > > > 
> > > > Thanks,
> > > > Sasha
> > > 
> > > I just now noticed a sizable discrepancy between what's in the
> > > stable-queue and what's in -rc1, for 5.10.y through 6.12.y. (6.18.y
> > > and 6.19.y appear unaffected.)
> > > 
> > > To make sure this is an apples-to-apples comparison, I'll compare with
> > > the stable-queue as of commit 2370009958172f632d48973387e7b6ae116086b1
> > > ("Drop a broken ACPI patch"); I'd expect the queue as of that commit to
> > > match the -rc1 patches, if I'm not mistaken.
> > > 
> > > 
> > >                      # of patches in         # of patches in
> > >                      stable mailing list     stable-queue git
> > >                      thread                  @ 237000995817
> > > 
> > > 5.10.252-rc1          147                     334
> > > 5.15.202-rc1          164                     411
> > > 6.1.165-rc1           232                     533
> > > 6.6.128-rc1           283                     683
> > > 6.12.75-rc1           385                     953
> > > 6.18.16-rc1           752                     751
> > > 6.19.6-rc1            844                     843
> > > 
> > > The off-by-one difference for 6.18.y/6.19.y is expected, since
> > > (unlike the stable-queue itself) the -rc1 patch and the mailing
> > > list thread include a Makefile patch to update the version number.
> > > 
> > > For the other kernels, though, it looks to me like something
> > > went wrong somewhere. Of course I could be mistaken, but that's
> > > how it appears to me.
> > > 
> > > In any case, I figured I should bring this to your attention.
> > 
> > Barry, this is a great catch. Thank you!
> > 
> > The root cause turned out to be a bug in git-quiltimport. One of the
> > patches queued has the literal text "\0" in its subject line:
> > 
> >   selftests: tc_actions: don't dump 2MB of \0 to stdout
> > 
> > git-quiltimport constructs commit messages using echo(1):
> > 
> >   commit=$( { echo "$SUBJECT"; echo; cat "$tmp_msg"; } | git commit-tree $tree -p $commit)
> > 
> > The problem is that echo interprets backslash escape sequences, so
> > "\0" gets expanded into an actual NUL byte (0x00). git commit-tree
> > then rejects the commit with:
> > 
> >   error: a NUL byte in commit log message not allowed.
> > 
> > This caused git-quiltimport to bail out mid-way through building
> > several trees during -rc construction. The trees that had this patch
> > queued (5.10 through 6.12) only got a partial set of patches into
> > the -rc branch, while 6.18 and 6.19 were unaffected because they
> > hadn't hit the problematic patch yet.
> > 
> > 6.18 and 6.19 were also previously released by Greg, who uses actual
> > quilt rather than git-quiltimport, so he wouldn't have run into this.
> 
> But I use git-quiltimport when creating the releases, so did I somehow
> not apply things properly when that happens, skipping patches in the
> releaase?

As we talked about this on irc, turns out it's a bash vs. dash issue.
Bash works fine, dash does not, hence the problem only showing up for
one of us.

Glad that's figured out :)

greg k-h

