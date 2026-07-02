Return-Path: <stable+bounces-271538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IBcDIzisRmp8bQsAu9opvQ
	(envelope-from <stable+bounces-271538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:21:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6646FBF3E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:21:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=mit.edu (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271538-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271538-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED968306E52B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F94135F5E7;
	Thu,  2 Jul 2026 18:20:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78B3A6B71
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 18:20:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016457; cv=none; b=j8RplP9O+s8Y8VnJ2Oa6JIX7HdamnHAuOYKK4jeO2nbvC2jtcrh0PqKJ+DeHy2wK8mvWCCj1Og8ghCWnsyc7QTFcENQEnaKzL4UoetsglN/QT+1CK10UxxJ7y29Q0RJJv5e45DIHnKKkxYe9dtndlKMtwzflL+pStK21QU8xVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016457; c=relaxed/simple;
	bh=kAcZEahDHRfGumFkykTwEcuw4vLnvOKJYhsdf7ZjS5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeMVY8EgPyMlo/EaMQ1EEu+g73+52abpezM/ZQXoNokDyb4/FHPkE70YsuXQxIG/acUb4VP5LGgSaAoo9S1zhM51MpvqR7Ae3G8aV9JOnl9sRFOHcaNKH1L2XPbnmGX2l2lbhwumraOrAJRRL8R86m1flrDkju/Tzg60EsB6Kkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Received: from macsyma.thunk.org (syn-072-043-125-131.biz.spectrum.com [72.43.125.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 662IKEkV009051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Jul 2026 14:20:15 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id E6C0A865EA7; Thu,  2 Jul 2026 14:20:13 -0400 (EDT)
Date: Thu, 2 Jul 2026 14:20:13 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, Wang Jun <1742789905@qq.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        libaokun1@huawei.com, 25125332@bjtu.edu.cn, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCH] ext4: get rid of ppath in get_ext_path()
Message-ID: <akaoai2pRVxE3t-2@mit.edu>
References: <tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq.com>
 <2026062643-tamer-limes-a320@gregkh>
 <rrsgndgpxyrmu6okb43u6wkdaibbidlbyqgugeeijd2b44sf4y@6lzmm4v4xvdp>
 <2026070210-catty-grape-2568@gregkh>
 <8b1d5b5d-61f5-40b1-95d4-35f98a280db8@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b1d5b5d-61f5-40b1-95d4-35f98a280db8@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[mit.edu : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,qq.com,dilger.ca,vger.kernel.org,huawei.com,bjtu.edu.cn,suse.cz,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-271538-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:gregkh@linuxfoundation.org,m:1742789905@qq.com,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:libaokun1@huawei.com,m:25125332@bjtu.edu.cn,m:jack@suse.cz,m:ojaswin@linux.ibm.com,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C6646FBF3E

> 
> This patch is trying to fix the regression which Introduced by this series:
> 
>     [PATCH 6.6 046/567] ext4: get rid of ppath in ext4_ext_insert_extent()
>

The subject line in the patch did not make it clear that this was
fixing a breakage caused by a backport from upstream kernel into 6.6.
So I was quite confused, and given that no one pays me to work on LTS
kernels, and I wasted several days debugging the 6.1 backport before
figuring out what the guilty commit that needed reverting, and life
has gotten super busy at $WORK, I decided to say, oh well, the failure
was only triggered (as far as I know) by tests exercising the shutdown
path, and life was too short to figure out how to untangle 6.6 LTS.

Instead, I've just been telling people that they **really** should
just use far more recent LTS kernels, because from a security
perpsective, lots of patches never get backported to older LTS kernels
--- and in a post Mythos world, it's probably not reasonable to be
using 6.1 or 6.6 --- and sometimes the auto-backport results in flaky
LTS kernels --- and while there had been an attempt to organize
companies to contribute SWE effort to test and stablize xfs, (a) in
the past 18 months, all of the companies who had contriburted SWE time
had with drawn that effort, and (b) I've never been able to recruit
people willing to do this for ext4.  And I'm too busy to spend time
after midnight or on weekends doing it for older LTS kernels for free.

> So I'm confused about the next action will we accept Wang Jun's
> patch or we just revert it as 6.1 did ?

The commit description in Wang Jun's patch needs to explain that it's
fixing a but that was introduced in the LTS backport.  As memory
serves, after the several day effort to figure out the guilty commmt
in 6.1 LTS, we determined that the purported bug that the half-dozen
odd commits (including the dependencies), wasn't even **applicable**
for 6.1.  So it was all just a massive waste of my time.

I have not done the analysis to determine whether the patch series in
6.6 that caused the regression is actually fixing a bug in the 6.6 LTS
kernel.  If it doesn't, perhaps reverting the whole mess is the better
approach.  Or if someone wants to take Wang Jun's patch, and run it
through a full set of regression test suites, using something like:

   gce-xfstests ltm -c ext4/all -g auto

or the equivalent, and it passes without triggering crashes and
without causing more regressions, Wang Jun's patch seems to make
sense.  For more instructions on how to run the test, see [1][2].

[1] https://thunk.org/gce-xfstests
[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md

And if you are interested in helping out with ext4 stable kernel
maintenace, I'd love the volunteer help.  After the mess with the 6.1
and 6.6 LTS backports, I've been tempted to just tell the stable
kernel maintainers to stop backporting fixes to 6.1 and 6.6.  (The XFS
community has standing instructions not to back *any* backports to LTS
kernels,b ecause of this instability problem.  The fix of having
developers actually do QA before sending out backports works, and is
certainly much better than the "it builds, ship it!" approach --- but
the downside is that most companies aren't willing to devote the time
to do that backports, especially now in the post Mythos world, your
internal security teams are probably requiring you to use much newer
LTS kernels anyway.)

Cheers,

						- Ted

