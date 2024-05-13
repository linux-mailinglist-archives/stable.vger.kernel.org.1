Return-Path: <stable+bounces-43625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2088C4168
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BC71C22DC2
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D60152161;
	Mon, 13 May 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxvDnzpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116814F9E3;
	Mon, 13 May 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605626; cv=none; b=kmpprGVOMev73g6teGjMyuh3Y02b5Ipz1O1RpjllEzqPOsDtazAGaVCmOvzjG+PtuHCNUrhDHY8tQDxDpDa4sFi7qxDXl5ed84VDO284hqoRqmFz2WZCIUjkxl25xVNR9wAzU2eNvXZbyviY+w/aAAbwYizcWx0v73rRON5Qib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605626; c=relaxed/simple;
	bh=LqE70oS/kuQy3aVRmks/8K+o5RcfmPZyHzUAh/R7gHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaY0xb+87mh3p07dvzTDyiYe5Vtr0ipuLB0FiurCt22HogGf14lcHt/29wCe5Fq4aYTaLZiV+AVi04WFlcxj06srrAh32wdZx7xjkSX/VH2X7Y4fnSUQ6YVtetZuq4e++CDLuIeOFatN+p1XKcDJysAbxAmsv+XlzW52NAVnV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxvDnzpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DF6C113CC;
	Mon, 13 May 2024 13:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715605626;
	bh=LqE70oS/kuQy3aVRmks/8K+o5RcfmPZyHzUAh/R7gHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxvDnzpAIiQGIB5x49QS/YcDHl8EBPmU7WPmevMJi7FGQrcSX4v7e7BetA52QTuVW
	 blm7HZc1Qwq/KNYwjMh+amORjHZeH+Q0aGlO/OolmEzVUcPV/77He71yy+6kT7QgGd
	 qg9M3MQO9hp7vUlifVG3ojwc2HxqaYosQypODYhM=
Date: Mon, 13 May 2024 15:07:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: Patch "spi: axi-spi-engine: Convert to platform remove callback
 returning void" has been added to the 6.1-stable tree
Message-ID: <2024051310-spindle-resort-1219@gregkh>
References: <20240506193007.271745-1-sashal@kernel.org>
 <668fcb3c-d00c-4082-b55d-c8584f1b3f7a@baylibre.com>
 <xoadzhyfsjcmvrolb7smsjsvvhfb67m6rcata7sox54yeqm54n@neow3nvsxcti>
 <0ba14e0f-6808-45ae-a6cd-9b9610d119db@baylibre.com>
 <xm5ghowrandbwib2osgihglhwief6buepdcht42uljj65apnya@qgshrnbi2s5r>
 <d2857f45-caa6-4d69-989d-bb95dfcbc7ff@baylibre.com>
 <Zjo9PrCgSm0Jn3KU@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjo9PrCgSm0Jn3KU@finisterre.sirena.org.uk>

On Tue, May 07, 2024 at 11:39:58PM +0900, Mark Brown wrote:
> On Tue, May 07, 2024 at 09:22:48AM -0500, David Lechner wrote:
> 
> > It's just fixing a theoretical problem, not one that has actually
> > caused problems for people. The stable guidelines I read [1] said we
> > shouldn't include fixes like that.
> 
> > [1]: https://docs.kernel.org/process/stable-kernel-rules.html
> 
> > So, sure it would probably be harmless to include it without the
> > other dependencies. But not sure it is worth the effort for only
> > a theoretical problem.
> 
> The written stable guidelines don't really reflect what's going on with
> stable these days at all, these days it's very aggressive with what it
> backports.

It's "aggressive" in that many dependent patches are finally being
properly found and backported as needed to be able to get the "real" fix
applied properly.  That's all, nothing odd here, and all of these
commits have been through proper review and development and acceptance
already, so it's not like they are brand new things, they are required
for real fixes.

> Personally I tend to be a lot more conservative than this
> and would tend to agree that this isn't a great candidate for
> backporting but people seem OK with this sort of stuff.

Again, we want to keep as close as possible with Linus's tree because
ALMOST EVERY time we try to do our own thing, we get something wrong.
Keeping in sync is essencial to rely on our overall testing and future
fix ability to keep in sync properly.

To attempt to do "one off" backports all over the place just does not
work, we have tried it and failed.  To not accept the fix at all leaves
us vulnerable to a known bug, why would that be ok?

Change is good, and these changes are extra-good as they fix things.

thanks,

greg k-h

