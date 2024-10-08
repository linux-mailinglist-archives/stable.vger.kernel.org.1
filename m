Return-Path: <stable+bounces-81586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B378299478E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43411C23ED0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1E318BC11;
	Tue,  8 Oct 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xN2jzTbx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8717279E
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387889; cv=none; b=JvVKMzMiczU7Kpbh9i6JoPVphGarWtl58nbq7vHw3K8wTFfv+9l2wOL2szU2rWE7vDpHyi1re4wPDupmyIlTI3fg3i6sfzHCynP7Q5Jo3sADN+Ex0QUOffEfGfK7pLmI6bZAJhg16QwIU3xy4gyqO9jubb4Wl7dqBScR/fYa4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387889; c=relaxed/simple;
	bh=FXxjKfs7kJbKJDCsMAfhDUkMZP6oWEXVEo4as/u1py4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ2+GdsxDNm40+96x6K/p7lsM66ZUSwALHCt4DwtdnucsY0shaQrA7pW39YKWCSAL2SUyNwfFbgqIWv5vNd9meILT34MGkD5Lr1miZ4XQAvszAK8j2582STTSdgYDys2cfSOkAgv5SCxqa6Ui3q8JjTMEWIOqjnnuejy7JTopl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xN2jzTbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0765FC4CEC7;
	Tue,  8 Oct 2024 11:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728387889;
	bh=FXxjKfs7kJbKJDCsMAfhDUkMZP6oWEXVEo4as/u1py4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xN2jzTbxiDFBqYcZyKBeN1fAJiD9tY7+pXftJ+rpfdoatI/Svb5XL57w5yLTmLmL9
	 Jo/SVEI49ImJFWv6reNyGMBMu8Gp0hHXGquoMHN4j2TOK31NFjHA/rHHR/N8RWmGxU
	 imaLkgwuJtUnsNuVlGIkVjojT96tBwcjI9NltnC4=
Date: Tue, 8 Oct 2024 13:44:45 +0200
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
Message-ID: <2024100828-scuff-tyke-f03f@gregkh>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <ZwUUjKD7peMgODGB@duo.ucw.cz>
 <2024100820-endnote-seldom-127c@gregkh>
 <ZwUY/BMXwxq0Y9+F@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUY/BMXwxq0Y9+F@duo.ucw.cz>

On Tue, Oct 08, 2024 at 01:35:24PM +0200, Pavel Machek wrote:
> On Tue 2024-10-08 13:24:05, Greg Kroah-Hartman wrote:
> > On Tue, Oct 08, 2024 at 01:16:28PM +0200, Pavel Machek wrote:
> > > On Wed 2024-10-02 09:26:46, Jens Axboe wrote:
> > > > On 10/2/24 9:05 AM, Vegard Nossum wrote:
> > > > > Christophe JAILLET (1):
> > > > >   null_blk: Remove usage of the deprecated ida_simple_xx() API
> > > > > 
> > > > > Yu Kuai (1):
> > > > >   null_blk: fix null-ptr-dereference while configuring 'power' and
> > > > >     'submit_queues'
> > > > 
> > > > I don't see how either of these are CVEs? Obviously not a problem to
> > > > backport either of them to stable, but I wonder what the reasoning for
> > > > that is. IOW, feels like those CVEs are bogus, which I guess is hardly
> > > > surprising :-)
> > > 
> > > "CVE" has become meaningless for kernel. Greg simply assigns CVE to
> > > anything that remotely resembles a bug.
> > 
> > Stop spreading nonsense.  We are following the cve.org rules with
> > regards to assigning vulnerabilities to their definition.
> 
> Stop attacking me.

I am doing no such thing.

> > And yes, many bugs at this level (turns out about 25% of all stable
> > commits) match that definition, which is fine.  If you have a problem
> > with this, please take it up with cve.org and their rules, but don't go
> > making stuff up please.
> 
> You are assigning CVE for any bug. No, it is not fine, and while CVE
> rules may permit you to do that, it is unhelpful, because the CVE feed
> became useless.

Their rules _REQUIRE_ us to do this.  Please realize this.

> (And yes, some people are trying to mitigate damage you are doing by
> disputing worst offenders, and process shows that quite often CVEs get
> assigned when they should not have been.)

Mistakes happen, we revoke them when asked, that's all we can do and
it's worlds better than before when you could not revoke anything and
anyone could, and would, assign random CVEs for the kernel with no way
to change that.

> And yes, I have problem with that.

What exactly do you have a problem with?  The number if CVEs can't be
the issue as to make that smaller would mean that we would not document
bugfixes that are going into our tree.  Surely you don't want us to
ignore them.

> Just because you are not breaking cve.org rules does not mean you are
> doing good thing. (And yes, probably cve.org rules should be fixed.)

Again, we are following the rules as required by cve.org.  If you feel
we are not doing this properly, please let us know.  If you feel that
the rules that cve.org works with are incorrect, wonderful, please work
with them to fix that up as you are not alone.

Here's a talk I just gave, with slides, that explain all of this:
	https://kernel-recipes.org/en/2024/cves-are-alive-but-no-not-panic/

There was also a great BoF at the Plumbers conference a few weeks ago
that went over all of this, and had actionable things for those that are
working on the "downstream" side of the CVE firehose to do to help make
things easier for those groups.  Please work with the people running
that if you wish to make things easier for anyone consuming the cve.org
feed.

greg k-h

