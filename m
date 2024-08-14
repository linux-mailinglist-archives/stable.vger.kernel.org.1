Return-Path: <stable+bounces-67670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C20951DAC
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB991F221D4
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D1C1B374E;
	Wed, 14 Aug 2024 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="anyVqNS7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5E1B373F;
	Wed, 14 Aug 2024 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646969; cv=none; b=F/t2iA1vBM4RZgbPoQ7oVyGGw7biIw5uStzRBHlvS40K2QDIQdCeqC4HEBbCzLSkbsCiNpTCmR+vW+gfvY43NZkhg2wd1B0XeisI8OCiq/o7alQqMjYL2lttSi/gW8WTD/T66IgaNW5A/BoXkL8RpAUCIiSTR3AIfIW0Nnr865U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646969; c=relaxed/simple;
	bh=4kdRz8BlKkOvPUewpgc9g8NCtCHRLHq27zCngdMV++o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQJx5x3sd/FceyNjzXWQH4DK2jQM2AJH2ema7F6NV98MFlndH8q6B5QRWcqkjQK8J0/hKcs8o8BPZDqJ7xwFjsoUeq39p4QnrsPhx6Unu01bsCwHKl9dq22DDw0b0P9vi0oaHicXQ5AlKnaLsn8wRDzlfmUWxNmpwygbbhbGVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=anyVqNS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81405C116B1;
	Wed, 14 Aug 2024 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723646969;
	bh=4kdRz8BlKkOvPUewpgc9g8NCtCHRLHq27zCngdMV++o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anyVqNS75CcKASjF/hRi4yDE+x6gzKzfaQjqXrF/zZIhfo8ss+vMH+ZkEkgE25q2e
	 ztWjKu1Z49zGm5ZrsyxTTXqlGNG/R/NEtyPBdfoDERqd1SldHpppyOI0FDC1A+zzOm
	 gicSEgo9uW3vsrZnOKIjXOIEafO6HFr4lEh8mN2o=
Date: Wed, 14 Aug 2024 16:49:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Vitaly Chikunov <vt@altlinux.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH for stable 0/2] ASoC: topology: Fix loading topology issue
Message-ID: <2024081454-creature-subtype-9139@gregkh>
References: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>
 <2024081434-drowsily-stingy-1b09@gregkh>
 <351cb9f0-c016-43d2-a1f4-6635503aed56@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <351cb9f0-c016-43d2-a1f4-6635503aed56@linux.intel.com>

On Wed, Aug 14, 2024 at 04:19:06PM +0200, Amadeusz Sławiński wrote:
> On 8/14/2024 4:12 PM, Greg Kroah-Hartman wrote:
> > On Wed, Aug 14, 2024 at 04:06:55PM +0200, Amadeusz Sławiński wrote:
> > > Commit 97ab304ecd95 ("ASoC: topology: Fix references to freed memory")
> > > is a problematic fix for issue in topology loading code, which was
> > > cherry-picked to stable. It was later corrected in
> > > 0298f51652be ("ASoC: topology: Fix route memory corruption"), however to
> > > apply cleanly e0e7bc2cbee9 ("ASoC: topology: Clean up route loading")
> > > also needs to be applied.
> > > 
> > > Link: https://lore.kernel.org/linux-sound/ZrwUCnrtKQ61LWFS@sashalap/T/#mbfd273adf86fe93b208721f1437d36e5d2a9aa19
> > > 
> > > Amadeusz Sławiński (2):
> > >    ASoC: topology: Clean up route loading
> > >    ASoC: topology: Fix route memory corruption
> > > 
> > >   sound/soc/soc-topology.c | 32 ++++++++------------------------
> > >   1 file changed, 8 insertions(+), 24 deletions(-)
> > > 
> > > 
> > > base-commit: 878fbff41def4649a2884e9d33bb423f5a7726b0
> > > -- 
> > > 2.34.1
> > > 
> > > 
> > 
> > What stable tree(s) is this for?
> 
> For whichever one has 97ab304ecd95 ("ASoC: topology: Fix references to freed
> memory") applied and doesn't have following patches, as far as I can tell:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/sound?h=v6.9.12
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/sound/soc?h=v6.6.46
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/sound/soc?h=v6.1.105
> 
> should I send separate mail for each?

If they do not apply cleanly to all of them, yes.  If not, no.

Please resend these anyway, with the proper git id info so we don't have
to hand paste them in.

thanks,

greg k-h

