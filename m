Return-Path: <stable+bounces-66442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D582A94EABD
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC4D1F22762
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2509D16F0CF;
	Mon, 12 Aug 2024 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cPjC/vwO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609E16EC16;
	Mon, 12 Aug 2024 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458282; cv=none; b=Z+a6CNBsYxGfNPKdNs1iYY1TnFAo/H6XYlCR/fYbtTHnwGu54BmOFKhrjHaUqHx2Isq94x/CJsmqH78k7zVqvtTcOJ/fBsHNrgM5WnDjblb9U8t3efOC2Ojd8bUtIytgWq+pP+jfl68HKZ9AwVXj8vFaLH8aA53DzLY/PTF6Xwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458282; c=relaxed/simple;
	bh=+cVxtBneiG5GQqDahZath/rPvSDoru3swRCQjqvU6Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcsoQzqUZogHp+6SFQ/1oxWwTEXm+tHNWQaovxJD4XJQrp13fjaZMgabiAUmrhn6IajCQ8iE4l9KMVyMdBS67htzQ/BdMEJ5HtyrBtEv5sN1A1nCI0Nj6+p40cmtL9b/0dS+UXlc+r7K4kZbieAus5EwfZAB4BAKXihMskwX8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cPjC/vwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDB0C32782;
	Mon, 12 Aug 2024 10:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723458282;
	bh=+cVxtBneiG5GQqDahZath/rPvSDoru3swRCQjqvU6Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPjC/vwOU70CRZg8jZYlnOFDuG8J2sg6HRwJZ8seRgE25CTFEdkpvbwWWrdGxhZg4
	 qQdiwyGLZphu3l5QYx1FjgIy+IzUkvgOLh+Z3wNm0wk3pZtrJlRVfJVuCFrOl/GgeB
	 3RNscbtLoBnP4W5FIzdcwhdU90Zl/IvUoJ2fVuM4=
Date: Mon, 12 Aug 2024 12:24:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Vitaly Chikunov <vt@altlinux.org>, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
Message-ID: <2024081204-delirious-nursery-f950@gregkh>
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>

On Mon, Aug 12, 2024 at 11:53:17AM +0200, Thorsten Leemhuis wrote:
> Hi, top-posting for once, to make this easily accessible to everyone.
> 
> Greg, Sasha, to me it looks like something fell through the cracks.
> Pierre-Louis afaics about a week ago asked (see the quote below) to
> revert 97ab304ecd95c0 ("ASoC: topology: Fix references to freed memory")
> [v6.10-rc6, v6.9.11, v6.6.42, v6.1.101] from the stable branches *or*
> pick up b9dd212b14d27a ("ASoC: topology: Fix route memory corruption").

Commit b9dd212b14d27a is a merge commit, nothing that we can take at all
here, sorry.

> But nothing like that has happened yet and I can't see any of those
> resolutions in the 6.6 queue.

Again, I can't take a merge commit :(

thanks,

greg k-h

