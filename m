Return-Path: <stable+bounces-104459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC1F9F461A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 09:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159EF1662CA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC221CDFDE;
	Tue, 17 Dec 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PvIjQAFw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC45156227
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424328; cv=none; b=bdfyK+04pzo6KIvAK7t+Ucve9Tamh0gp8WwtAzyJJdrGfNdDzJDodFXdxk9fhrHMBcUtWyaZBJXTpKsq+XwZKZNrrFnqfF8y4t63WYUT1D92UrIcUDMz57nznKFF1x6rTK6KMm547Gj0wxRY1g8VPnY9Z1OeINkBsvovGjGfTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424328; c=relaxed/simple;
	bh=+kSeNLUq6c2NQDqRM8edJTm0ZvdSgRP88aaj7j2bLWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0ivkOqfddpCd7gzSyRpSdLFqDlDbt5dCodv8fuuL3XWCKQ7lYIQWgZAu65IK0KarVKaKjW0P/owQH4TvEAhHjHTqowKYN1a+JqibUSzSZ2VbqE4o0IIBNkOwDN1xYXKdGFLwckkEZ9G51vH2QU2RTgiuN5aBfshRmMTMm3z6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PvIjQAFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82D9C4CED3;
	Tue, 17 Dec 2024 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734424327;
	bh=+kSeNLUq6c2NQDqRM8edJTm0ZvdSgRP88aaj7j2bLWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvIjQAFwbwS58eC4QeLBnQniYW3LAOyg/ddKHSQkfO1kzQAQ7Z+9Bftp7oeIseX4T
	 fpzDM4HAoE32HfgCb2KphYalNC8pkvBZstPM4ZSfmbhl7kOzVAEAvrNiR0mUPAQfeC
	 +ammLlHdnGj5lDU5XCuUOWBBCvLAvI1l1sZQoIwg=
Date: Tue, 17 Dec 2024 09:32:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 6.6 resubmit 0/3] Fix PPS channel routing
Message-ID: <2024121724-sixteen-unpleased-d9f2@gregkh>
References: <20241213112926.44468-1-csokas.bence@prolan.hu>
 <2024121346-omission-regulate-89c3@gregkh>
 <6d794b77-77ea-4da3-8ca3-1510dd492e2e@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d794b77-77ea-4da3-8ca3-1510dd492e2e@prolan.hu>

On Sun, Dec 15, 2024 at 06:15:41PM +0100, Csókás Bence wrote:
> Hi,
> 
> On 2024. 12. 13. 12:41, Greg Kroah-Hartman wrote:
> > This series is really totally confusing.  Here's what it looks like in
> > my mbox:
> > 
> >     1   C Dec 13 Csókás, Bence   (0.8K) [PATCH 6.6 resubmit 0/3] Fix PPS channel routing
> >     2   C Dec 13 Csókás, Bence   (1.9K) ├─>[PATCH 6.11 v4 2/3] net: fec: refactor PPS channel configuration
> >     3   C Dec 13 Csókás, Bence   (1.8K) ├─>[PATCH 6.11 v4 3/3] net: fec: make PPS channel configurable
> >     4   C Dec 13 Csókás, Bence   (1.4K) ├─>[PATCH 6.11 v4 1/3] dt-bindings: net: fec: add pps channel property
> >     5   C Dec 13 Csókás, Bence   (1.9K) ├─>[PATCH 6.6 resubmit 2/3] net: fec: refactor PPS channel configuration
> >     6   C Dec 13 Csókás, Bence   (1.8K) ├─>[PATCH 6.6 resubmit 3/3] net: fec: make PPS channel configurable
> >     7   C Dec 13 Csókás, Bence   (0.9K) ├─>[PATCH 6.11 v4 0/3] Fix PPS channel routing
> >     8   C Dec 13 Csókás, Bence   (1.4K) └─>[PATCH 6.6 resubmit 1/3] dt-bindings: net: fec: add pps channel property
> > 
> > I see some 6.11 patches (which make no sense as 6.11 is long
> > end-of-life)
> 
> Ah, sorry, it seems those were left in my maildir from a previous
> format-patch as I invoked send-email ./* ...
> 
> > and a "resubmit?" for 6.6, but no explaination as to _why_
> > this is being resubmitted here, or in the patches themselves.
> 
> I submitted it to 6.6 once here, but it got rejected because it wasn't in
> 6.11.y and 6.12.y:
> Link: https://lore.kernel.org/netdev/2024120204-footer-riverbed-0daa@gregkh/
> 
> Since then, it got into 6.12.y, and - as you said - 6.11 got EOL, before it
> could ever get this patch. So I thought to resubmit it for 6.6, as that's
> the version that is of interest to us.
> 
> > Two different branches in the same series is also really really hard for
> > any type of tooling to tease apart, making this a manual effort on our
> > side if we want to deal with them.
> > 
> > What would you do if you got a series that looked like this and had to
> > handle it?  Would you do what I'm doing now and ask, "What in the world
> > is going on?"   :)
> > 
> > Please be kind to those on the other side of your emails, make it
> > blindingly obvious, as to what they need to do with them, AND make it
> > simple for them to handle the patches.
> > 
> > Series is now deleted from my review queue, sorry.
> > 
> > greg k-h
> 
> Sorry for the confusion. So, should I submit the series yet again, without
> "resubmit" (and, obviously, without the left-over 6.11 patches)?

What would you want to see if you were on my end?  (hint, a resend of
the correct things to apply, along with an explaination of what they are
and what version they are and what has changed between versions...)

thanks,

greg k-h

