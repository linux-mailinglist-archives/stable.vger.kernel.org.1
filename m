Return-Path: <stable+bounces-43618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA68C412B
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EE21F24499
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD06A152187;
	Mon, 13 May 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iE9Az3nT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91415217E;
	Mon, 13 May 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604919; cv=none; b=DQHhWoF6lobYOFJv/2PmnOInMHd28UvxP22RRxBCTSCtKze+QIiY9IKsSvPw/RQdLkNF93p8vmOy3Wr+Ce4fzN5dek0Cihd1HSF7Xu7hWe50wS4ES6qrlCLEDNQU3ck4NCRLNPOajEpvclMYWeWkdhgH4OLkU9Iv9b9Haw60EJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604919; c=relaxed/simple;
	bh=VjHndbJ+gnuBu0nK3t0pUIpVWsxIU6lr5NwTJmuc3tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys4/lVgVEAN4Df9wAXAC0yGTVaS0rokeYjmK1mNuUlwUHeDTiaTTUDcJlyrw0OJ94lqfMGBYgYyi3zu23DV62InSsHsgMyZNACDLqmWBtgfLVVlkzuaMp1s2KHGlsmRG5F1HOczPQjFtRr8giKBq16F0brRE7eXmjefdJ3lgD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iE9Az3nT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ADBC4AF07;
	Mon, 13 May 2024 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715604919;
	bh=VjHndbJ+gnuBu0nK3t0pUIpVWsxIU6lr5NwTJmuc3tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iE9Az3nTILZfjNar4xnsqGNe6XY9QFW5bY6t7zgHNs0kMU/H754zcFHvcaflxiRz7
	 lpaF3DD+t2JS62+WNgy3noak9D9UZBK6LSYJBCFENoCSi3xKaQI6xKau2CE/S441PV
	 9CK/KzLMDURAjxQxB0n73xMUqxz80ueP/iXIVLQg=
Date: Mon, 13 May 2024 14:55:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Lechner <dlechner@baylibre.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: Patch "spi: axi-spi-engine: use common AXI macros" has been
 added to the 6.1-stable tree
Message-ID: <2024051357-creed-grumpily-d4b5@gregkh>
References: <20240506193023.272000-1-sashal@kernel.org>
 <a6253255-9133-424c-8dad-fc7f75bdd38d@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6253255-9133-424c-8dad-fc7f75bdd38d@baylibre.com>

On Mon, May 06, 2024 at 03:46:19PM -0500, David Lechner wrote:
> On 5/6/24 2:30 PM, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     spi: axi-spi-engine: use common AXI macros
> > 
> > to the 6.1-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      spi-axi-spi-engine-use-common-axi-macros.patch
> > and it can be found in the queue-6.1 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> 
> Does not meet the criteria for stable.

Needed for the bugfix after this, which is properly marked in the commit
itself.

