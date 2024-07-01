Return-Path: <stable+bounces-56218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F0391DFB6
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994A11C22224
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF714D6E4;
	Mon,  1 Jul 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="awQ9+sGH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tDkWg40c"
X-Original-To: stable@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E2158D99;
	Mon,  1 Jul 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837916; cv=none; b=st31efXTWzxHuQuLA9/sqdZav0sHlqoeIWyzPAyqZFypihBMqcZuvCnkWI8oKV28zxv3HgmxfRvVADFNbMZ+hlNR3gRpr3cZCAPJDxas1ytPrL78tW267Kq9CixIMd0acSr9y6N3F6LjjqFDM0R7aq5OoVizo8S8GZS3/RlsyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837916; c=relaxed/simple;
	bh=bA6TyIvMqlPuSh7KeZQbRW2bMXFM40Ms2f5PG/F3MvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UurcoiDRCr6a9Akab0o+/1G6fgtwc2qi9fq52mnpVuOSMSuPYNNoKU1e1o43TH4GzkDNKvxAralQZRnrr2B+kXnNPJYFhFsJS+dkm1K3c00NPQkytway8QU5vr0FHtjJqgbQQhObZTJv0ajxekmrToKIuktFyMv0J5bSexgZ++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=awQ9+sGH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tDkWg40c; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CA7F411401F3;
	Mon,  1 Jul 2024 08:45:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 01 Jul 2024 08:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1719837913; x=1719924313; bh=K0/JgeoZft
	PybuBWwXDcbrzdO4ivXLvgo8jzMxXhG3U=; b=awQ9+sGHNq9ZKB2zdgbXJjCqaf
	39qZM/7oK0p9UaAYAUeh5E5WAoftFF2nj7/0NdPjFkYmHIQ6QVM2gbjabCuPjjU0
	W+t7mSfDanZe1Bo4xQYKghP392NpNubTugdW94Tn1hMU9laORVQS5cqYnBZSdF0k
	Diu4ktTNNriXM2l6jRG3F22+YRSb4AscI1NHioncZNnTNU6elkmvjyfboBUgxJfa
	5Z83vXuszcfgWm8dI0f8UJ7xdiFB4f5eu2NoMM5+1hI103rWIX2rw/a/e1vVXzny
	P0QXqItrEHsObJs9AnM5sUPLNOR+ofi7jNMH5GEY0+8nFGQcfjWheHMmbdDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719837913; x=1719924313; bh=K0/JgeoZftPybuBWwXDcbrzdO4iv
	XLvgo8jzMxXhG3U=; b=tDkWg40cLxCVx6r9miKidYzpTdC9H5wM9ep6g+4MxJoO
	rtmeTaISZ4YhuHRq9pX/2sRJKFHv5qUh8EHqoXCNRMK4563DszW17ejxvkncUjAL
	X1T/TUOY/Y2hQdSxc49l7RictO6yZzgKhDIChKioMRAi878zKw5smnQCgo8njUnL
	p2T0FTX0slbzwy0CJHxV/7o2WKAg/xypvmYAivou+KuQhah5YNKMjf4iZRWbAbLP
	DCW5psZeZsFHDu8buWRtPT9x5v8OPXzoPFG1k/J69Kn6FTa0g9jo5+sRflMyOk0h
	XZIYcsVKaCDkCc74re1o+vURVDcQGF873HMUg+Pqfw==
X-ME-Sender: <xms:2KSCZv9Ix8qyOK3Eb8gSYdG-PJyiOXG7BuVyaVY34c2Tm_uxRp4sDQ>
    <xme:2KSCZrtKeRds8jAMwLss9RVFN2VPxDOIfm3pUXIYHkbfiu-YbZH00Cxeie98_GFKA
    wSZyHZOiFd2sw>
X-ME-Received: <xmr:2KSCZtArjf3VzCLriQ9Pwm0vTwRGU4fCj_ykM-nDGxqF9o4Avfa9y0pGGX1RgkdrQSIq76dMjlSJW2J16UcQrgc5zB8ICIdalIn1eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:2aSCZrfzG9PhNbGXFbjT7IQCVVki4EpEAhG0A_-Cf216QcgMXF2KZQ>
    <xmx:2aSCZkPz1JoQ8oZu2kPZxPkRkrKnCd5WVIwe4CDwVWnTfDvKF60RmA>
    <xmx:2aSCZtlh5Bul-SMaqZS5Y5MIEvRkhaGjNhs0MAkoemTvkh8F_Q_sLw>
    <xmx:2aSCZusw0OS4yX88VIMNzCyZmoQwRooEIdV8hYUzgGrF8ov6ns7kqw>
    <xmx:2aSCZlioHo1qSog_yKaGHmALTTBowUvnFZIyg4TH8jnkdxr0tVHDq3nC>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jul 2024 08:45:12 -0400 (EDT)
Date: Mon, 1 Jul 2024 14:24:35 +0200
From: Greg KH <greg@kroah.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, ms@dev.tdt.de
Subject: Re: Patch "MIPS: pci: lantiq: restore reset gpio polarity" has been
 added to the 6.9-stable tree
Message-ID: <2024070129-circulate-overplant-a7b7@gregkh>
References: <20240627185200.2305691-1-sashal@kernel.org>
 <Zn5easOVbv3VGAMu@alpha.franken.de>
 <2024062827-ransack-macarena-b201@gregkh>
 <Zn7W7SPHgZrsZcrn@alpha.franken.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn7W7SPHgZrsZcrn@alpha.franken.de>

On Fri, Jun 28, 2024 at 05:29:49PM +0200, Thomas Bogendoerfer wrote:
> On Fri, Jun 28, 2024 at 04:18:37PM +0200, Greg KH wrote:
> > On Fri, Jun 28, 2024 at 08:55:38AM +0200, Thomas Bogendoerfer wrote:
> > > On Thu, Jun 27, 2024 at 02:52:00PM -0400, Sasha Levin wrote:
> > > > This is a note to let you know that I've just added the patch titled
> > > > 
> > > >     MIPS: pci: lantiq: restore reset gpio polarity
> > > > 
> > > > to the 6.9-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > 
> > > > The filename of the patch is:
> > > >      mips-pci-lantiq-restore-reset-gpio-polarity.patch
> > > > and it can be found in the queue-6.9 subdirectory.
> > > > 
> > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > can you drop this patch from _all_ stable patches, it was reverted already
> > > in the pull-request to Linus. Thank you.
> > 
> > What is the git id of the revert?
> 
> 6e5aee08bd25 (tag: mips-fixes_6.10_1) Revert "MIPS: pci: lantiq: restore reset gpio polarity"

Now queued up, thanks.

greg k-h

