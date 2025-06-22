Return-Path: <stable+bounces-155247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A9AE2EF6
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EE83B3D47
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522A1ADC7E;
	Sun, 22 Jun 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdrUVuQ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5388347DD;
	Sun, 22 Jun 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750583451; cv=none; b=uiHnUwRWHs0wdrJo64mzsdL+m+Qj7yHb2DIQdb3aDi4LIVl5HELzBmIY+7TmE7Bup0dtZkPxCb1AvQRsVpJdw5Ra+aImXkamsET19cgeD8AqBOHGmVJn0pCtry/l15kiuRqaPxPTXe+axtm6YPNvdmoIvAf3XnLTcT+AWPGZqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750583451; c=relaxed/simple;
	bh=zVuqY37en/DKxiVJYxlp6D3HbV0uNfcMQBfBnwgXRPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntYpcqMfXPQU9bxJ2JKi1S0Wou4dlZluo3LalS220UXqa0R9RhY4D4plO5HNJojkh9Rw/DZpToXGtV1MUkNCoj191wL2Ev+wTGQIDodJdJ2DURSP5rq+OnogKzzeO7NiLSXMPyHoOkDw1xzxa1naHyj4cvpW0+yzDLrwZbdn7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdrUVuQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EB1C4CEE3;
	Sun, 22 Jun 2025 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750583451;
	bh=zVuqY37en/DKxiVJYxlp6D3HbV0uNfcMQBfBnwgXRPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdrUVuQ0WU0qMhIbKMWuW9/d24ydilDNRV5S1KgGD9JFRWt2uomXBFSy7se9/8M0G
	 ffnWRE1fDhbJ85wIhGxQR1Ksi6yBlXK4uBm5CfmwcWiab78PV/LWSpjWDYO1/96F4O
	 pxUuNSxCpFkPfAF8qC+y8JNuzSsVfNb5Uwtqd5XQ=
Date: Sun, 22 Jun 2025 11:10:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Willem de Bruijn <willemb@google.com>
Cc: Brett Sheffield <brett@librecast.net>,
	Brett Sheffield <bacs@librecast.net>, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: 6.12.y longterm regression - IPv6 UDP packet fragmentation
Message-ID: <2025062212-erasable-riches-d3eb@gregkh>
References: <aElivdUXqd1OqgMY@karahi.gladserv.com>
 <2025061745-calamari-voyage-d27a@gregkh>
 <aFGl-mb--GOMY8ZQ@karahi.gladserv.com>
 <CA+FuTSen5bEXdTJzrPELKkNZs6N=BPDNxFKYpx2JQmXmFrb09Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FuTSen5bEXdTJzrPELKkNZs6N=BPDNxFKYpx2JQmXmFrb09Q@mail.gmail.com>

On Tue, Jun 17, 2025 at 02:25:02PM -0400, Willem de Bruijn wrote:
> On Tue, Jun 17, 2025 at 1:29 PM Brett Sheffield <brett@librecast.net> wrote:
> >
> > Hi Greg,
> >
> > On 2025-06-17 15:47, Greg KH wrote:
> > > On Wed, Jun 11, 2025 at 01:04:29PM +0200, Brett Sheffield wrote:
> > > > Longterm kernel 6.12.y backports commit:
> > > >
> > > > - a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a "ipv6: save dontfrag in cork"
> > >
> > > It's also in older kernels:
> > >       5.10.238
> > >       5.15.185
> > >       6.1.141
> > >       6.6.93
> > >
> > > > but does not backport these related commits:
> > > >
> > > > - 54580ccdd8a9c6821fd6f72171d435480867e4c3 "ipv6: remove leftover ip6 cookie initializer"
> > > > - 096208592b09c2f5fc0c1a174694efa41c04209d "ipv6: replace ipcm6_init calls with ipcm6_init_sk"
> > > >
> > > > This causes a regression when sending IPv6 UDP packets by preventing
> > > > fragmentation and instead returning EMSGSIZE. I have attached a program which
> > > > demonstrates the issue.
> 
> Thanks for the analysis. I had received a report and was looking into
> it, but had not yet figured out this root cause.
> 
> > >
> > > Should we backport thse two to all of the other branches as well?
> >
> > I have confirmed the regression is present in all of those older kernels (except
> > 5.15.185 as that didn't boot on my test hardware - will look at that later).
> >
> > The patch appears to have been autoselected for applying to the stable tree:
> >
> > https://lore.kernel.org/all/?q=a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a
> >
> > The patch follows on from a whole series of patches by Willem de Bruijn (CC), the
> > rest of which were not applied.
> >
> > Unless there is a good reason for applying this patch in isolation, the quickest
> > fix is simply to revert that commit in stable and this fixes the regression.
> >
> > Alternatives are:
> >
> > 1) apply a small fix for the regression (patch attached). This leaves a footgun
> > if you later decide to backport more of the series.
> >
> > 2) to backport and test the whole series of patches. See merge commit
> > aefd232de5eb2e77e3fc58c56486c7fe7426a228
> >
> > 3) In the case of 6.12.33, the two patches I referenced apply cleanly and are enough
> > to fix the problem.  There are conflicts on the other branches.
> >
> > Unless there is a specific reason to have backported
> > a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a to stable I'd suggest just reverting
> > it.
> 
> FWIW, I did not originally intend for these changes to make it to stable.
> 
> The simplest short term solution is to revert this patch out of the
> stable trees. But long term that may give more conflicts as later
> patches need to be backported? Not sure what is wiser in such cases.

For now, I've applied the above 2 to the 6.12.y tree.  They do not apply
any older.  If I should drop the change from the older stable trees,
please let me know.

thanks,

greg k-h

