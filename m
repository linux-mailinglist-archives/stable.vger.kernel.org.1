Return-Path: <stable+bounces-25861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9D86FD11
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B401C2263C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80B19BA6;
	Mon,  4 Mar 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wK66wvwK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B412E73
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544032; cv=none; b=k7nJc3RYBd/ZkTVm70NfnoSw3QWHE5DesTdkgh3jrymF6FvnSKirR8hdm9tmIND3naegJT+5AX8h15Ci9HHfzCmKdYAmi1qyJfTlmAMRe2cQadKOYRZr0rdY2mtBKFxTdJCElAkxfvemqc7oXWA/ACAEembXaWxJVlsHlzPa7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544032; c=relaxed/simple;
	bh=pcwyrB+J6ZLm5l2eBNgOx9zENlCF2v0c8lxGv2nDh2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUk9Wlrv+orO472T6BEBpjKPFFSGN04HNdFxdlcgxB6Ylb9sWA1qzK2s+kndIT6gRS+EaD+4hlUnhQj12a+TwY1hLMc4JXyojfvJ//A5v45vMNkPpiCLGeIN4OMNDAPdaz6gVPW4sJ7dgWmtveRx2PkpPQp3xZd2MbnUyvta6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wK66wvwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDD2C433F1;
	Mon,  4 Mar 2024 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709544031;
	bh=pcwyrB+J6ZLm5l2eBNgOx9zENlCF2v0c8lxGv2nDh2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wK66wvwKtasY0eQ4Rmtej4JhuTwC55JJs/jkDDKkHyOZfl4tikO2AY67/lR/4m+3W
	 egiliKZric2MuFNRb4crB2J0p+IhsvbctHKOt3dOwxNkxyDpjwDiAfrHUQ38RGAMHH
	 dTGqLaPjcxo3wr20B/KSIlB0L3wF1CqTY4CPuCcs=
Date: Mon, 4 Mar 2024 10:20:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	stable@vger.kernel.org, phaddad@nvidia.com, shiraz.saleem@intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
Subject: Re: Backport fix for CVE-2023-2176 (8d037973 and 0e158630) to v6.1
Message-ID: <2024030417-linked-obsessed-7c98@gregkh>
References: <2024022817-remedial-agonize-2e34@gregkh>
 <20240228184123.24643-1-brennan.lamoreaux@broadcom.com>
 <CAD2QZ9YZM=5jDtqA-Ruw9ZcztRPp6W6mZj9tA=UvA5515uYKrQ@mail.gmail.com>
 <2024030407-unshaven-proud-6ac4@gregkh>
 <CAD2QZ9YPmo3X+q8g+_zHd+=Y=_qKFa+xSgvwfTC3dZ0KhiMyOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD2QZ9YPmo3X+q8g+_zHd+=Y=_qKFa+xSgvwfTC3dZ0KhiMyOA@mail.gmail.com>

On Mon, Mar 04, 2024 at 02:21:22PM +0530, Ajay Kaher wrote:
> On Mon, Mar 4, 2024 at 12:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 29, 2024 at 02:05:39PM +0530, Ajay Kaher wrote:
> > > On Thu, Feb 29, 2024 at 12:13 AM Brennan Lamoreaux
> > > <brennan.lamoreaux@broadcom.com> wrote:
> > > >
> > > > > If you provide a working backport of that commit, we will be glad to
> > > > > apply it.  As-is, it does not apply at all, which is why it was never
> > > > > added to the 6.1.y tree.
> > > >
> > > > Oh, apologies for requesting if they don't apply. I'd be happy to submit
> > > > working backports for these patches, but I am not seeing any issues applying/building
> > > > the patches on my machine... Both patches in sequence applied directly and my
> > > > local build was successful.
> > > >
> > > > This is the workflow I tested:
> > > >
> > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > > > git checkout FETCH_HEAD
> > > > git cherry-pick -x 8d037973d48c026224ab285e6a06985ccac6f7bf
> > > > git cherry-pick -x 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95
> > > > make allyesconfig
> > > > make
> > > >
> > > > Please let me know if I've made a mistake with the above commands, or if these patches aren't applicable
> > > > for some other reason.
> > > >
> > >
> > > I guess the reason is:
> > >
> > > 8d037973d48c026224ab285e6a06985ccac6f7bf doesn't have "Fixes:" and is
> > > not sent to stable@vger.kernel.org.
> > > And 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95 is to Fix
> > > 8d037973d48c026224ab285e6a06985ccac6f7bf,
> > > so no need of 0e158 if 8d03 not backported to that particular branch.
> >
> > Ok, so there's nothing to do here, great!  If there is, please let us
> > know.
> >
> 
> In my previous mail, I was guessing why 8d037973d48c commit was not
> backported to v6.1.
> 
> However Brennan's concern is:
> 
> As per CVE-2023-2176, because of improper cleanup local users can
> crash the system.
> And this crash was reported in v5.19, refer:
> https://lore.kernel.org/all/ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com/#t
> 
> However, fix i.e. 8d037973d48c applied to master from v6.3-rc1 and not
> backported to any stable or LTS.
> So v6.1 is still vulnarbile, so 8d037973d48c and 0e15863015d9 should
> be backported to v6.1.

Ah, thanks, sorry for the confusion.  Both now queued up.

greg k-h

