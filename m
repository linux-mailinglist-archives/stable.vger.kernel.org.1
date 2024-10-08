Return-Path: <stable+bounces-83038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A952F995008
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41B41C24F4E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188D01DF25C;
	Tue,  8 Oct 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OHKCAjhU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A01DE885
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394259; cv=none; b=SyWEW4IKE/uTSPI7amCuPzJJoTYZINhzOBti4j/rLBsKqkkr/F0UWznCfyPYqNTkH02oETdPyLQYNXN3f4Ng3z377G6zaQm3TSmaTilToyRiIX417aI7j1BflkdQ6XVtlA4NJZzzesZwVVy9DIZP8AkwVwDOByOjNSR9iOAawM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394259; c=relaxed/simple;
	bh=NhMAVgC7ffxRasqtus1qq21t+jGqt0us6VSwvxqHD9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB32dGx/FqsModAAGNV9YI+uLu1OIAMeTXTSI7til71NRNq1+4rmcoIn8Cpa3j3G5hpjPVynCSnI9mqA4jqxJ9MAah/4WBEteMjOI9eYhjqs66SQaHatSWnTbc3oYds+HNLoQqxMGEB0r8lVj9MRfPllaO0R5sUf9rNkBcE4dvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OHKCAjhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAE8C4CEC7;
	Tue,  8 Oct 2024 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728394259;
	bh=NhMAVgC7ffxRasqtus1qq21t+jGqt0us6VSwvxqHD9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHKCAjhUQEfF5vv1H7tKqKMnuBx0yYQN5z2Ng+BCKR3tEIHPS9UvFkCHD4VGOohig
	 WNDaWnnpohUcdz7dQdl0saaM9b7bGjtLG4ZJ/OiE18CTGoF3iBBr6tuW9bOopiX7Jh
	 nKbQSdioD5jEM3sqv6N9M+KfIkHW3R2OrqrTJUOI=
Date: Tue, 8 Oct 2024 15:02:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@denx.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vegard Nossum <vegard.nossum@oracle.com>,
	stable@vger.kernel.org, cengiz.can@canonical.com, mheyne@amazon.de,
	mngyadam@amazon.com, kuntal.nayak@broadcom.com,
	ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
	shivani.agarwal@broadcom.com, ahalaney@redhat.com,
	alsi@bang-olufsen.dk, ardb@kernel.org,
	benjamin.gaignard@collabora.com, bli@bang-olufsen.dk,
	chengzhihao1@huawei.com, christophe.jaillet@wanadoo.fr,
	ebiggers@kernel.org, edumazet@google.com, fancer.lancer@gmail.com,
	florian.fainelli@broadcom.com, harshit.m.mogalapalli@oracle.com,
	hdegoede@redhat.com, horms@kernel.org, hverkuil-cisco@xs4all.nl,
	ilpo.jarvinen@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
	kirill.shutemov@linux.intel.com, kuba@kernel.org,
	luiz.von.dentz@intel.com, md.iqbal.hossain@intel.com,
	mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, pablo@netfilter.org,
	rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
	vladimir.oltean@nxp.com, xiaolei.wang@windriver.com,
	yanjun.zhu@linux.dev, yi.zhang@redhat.com, yu.c.chen@intel.com,
	yukuai3@huawei.com
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
Message-ID: <2024100854-crushing-catwalk-922c@gregkh>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <ZwUUjKD7peMgODGB@duo.ucw.cz>
 <2024100820-endnote-seldom-127c@gregkh>
 <ZwUY/BMXwxq0Y9+F@duo.ucw.cz>
 <2024100828-scuff-tyke-f03f@gregkh>
 <ZwUml+OpEzrZNTRZ@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUml+OpEzrZNTRZ@duo.ucw.cz>

On Tue, Oct 08, 2024 at 02:33:27PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > And yes, many bugs at this level (turns out about 25% of all stable
> > > > commits) match that definition, which is fine.  If you have a problem
> > > > with this, please take it up with cve.org and their rules, but don't go
> > > > making stuff up please.
> > > 
> > > You are assigning CVE for any bug. No, it is not fine, and while CVE
> > > rules may permit you to do that, it is unhelpful, because the CVE feed
> > > became useless.
> > 
> > Their rules _REQUIRE_ us to do this.  Please realize this.
> 
> If you said that limited manpower makes you do this, that would be
> something to consider. Can you quote those rules?

The rules are that we have to assign a CVE id to every vulnerability
that has been fixed in Linux.  The defintion of "vulnerability" is
defined by them (note, it does NOT include data loss, go figure...)

> I'd expect vulnerability description to be in english, not part of
> english text and part copy/paste from changelog. I'd also expect
> vulnerability description ... to ... well, describe the
> vulnerability. While changelogs describe fix being made, not the
> vulnerability.

If you object to _how_ we write the text, wonderful, please send us
updated texts for any/all CVE ids and we will be glad to update them.
But for now, we are taking them directly from the changelog which is
sufficient so far.

> Some even explain why the bug being fixed is not vulnerability at all,
> like this one. (Not even bug, to be exact. It is workaround for static
> checker).
> 
> I don't believe the rules are solely responsible for this.

Again, you are conflating the fact that you don't like what we
currently put in the changlog with something you said earlier that was
totally different (i.e. we were assigning cve ids for things that did
not deserve them.)

Moving the goal-posts is fun in a discussion, but not something I have
time for here, sorry.

> > > (And yes, some people are trying to mitigate damage you are doing by
> > > disputing worst offenders, and process shows that quite often CVEs get
> > > assigned when they should not have been.)
> > 
> > Mistakes happen, we revoke them when asked, that's all we can do and
> > it's worlds better than before when you could not revoke anything and
> > anyone could, and would, assign random CVEs for the kernel with no way
> > to change that.
> 
> Yes, way too many mistakes happen. And no, it is not an improvement
> over previous situation. 

Based on many discussions I have had with many companies and users over
the past months, they all seem to disagree with you, which is fine, we
always know we can't please everyone.

greg k-h

