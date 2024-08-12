Return-Path: <stable+bounces-66539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F3194EF36
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1362C283433
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437C17DE16;
	Mon, 12 Aug 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z8so9v+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D317D354;
	Mon, 12 Aug 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471903; cv=none; b=cIPSEg+yBVMooeTIIx9JY5rNaIfcgJ80dEpJKB8oa1144Q3k6Lv+BrPr/pb7sWmrYJEpKe6g+znyVL88P1260bBchYAHQvjokAKvNZBu+X8hAeKOdpT57CabcLMpnQzo5+cicTHBKIbOJlh76GAwDnAFS3/zJLdtRafgIl+j8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471903; c=relaxed/simple;
	bh=gKJvIG9hbJBYPQKEZrJUxeBcBJnzTBvTuXGF+X5/AcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/w4JUzhr/AUd2c2NyRugniC6uY1Girg5F37YMENJvooY25/j5XNOQsiYGl6+0tPmejtcumiEJO0H2ZckRPImBYW9trFrXOXCLTgisjGKSYWuihNeGhR6rNz+odbBfkNyH0P+y58Ey6Oh5oNA9Z828RLVjV2L8wfeqYGG2oSYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z8so9v+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4612FC4AF0D;
	Mon, 12 Aug 2024 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723471902;
	bh=gKJvIG9hbJBYPQKEZrJUxeBcBJnzTBvTuXGF+X5/AcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z8so9v+2zqO7LZvSRu33YPAG1N39VT/VdTyRosPCjMk6pycW3bchMHsDXMDeXA+v7
	 63scewEZ3+2RohR4qF1146VbplLd9R5P10Icj+PjNpXA8+i1TC03kE+D9OMM7eSf3M
	 Ca7wFNlfPPjEvb8HqYf8vNo+xsHdi74r4iKmyd1g=
Date: Mon, 12 Aug 2024 16:11:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
Message-ID: <2024081227-wrangle-overlabor-cf31@gregkh>
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
 <210a825d-ace3-4873-ba72-2c15347f9812@linux.intel.com>
 <2024081225-finally-grandma-011d@gregkh>
 <20240812103842.p7mcx7iyb5oyj7ly@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812103842.p7mcx7iyb5oyj7ly@altlinux.org>

On Mon, Aug 12, 2024 at 01:38:42PM +0300, Vitaly Chikunov wrote:
> Greg,
> 
> On Mon, Aug 12, 2024 at 12:25:54PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Aug 12, 2024 at 12:01:48PM +0200, Amadeusz Sławiński wrote:
> > > I guess that for completeness you need to apply both patches:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1
> > 
> > This is already in the tree.
> > 
> > > was an incorrect fix which was later fixed by:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34
> > 
> > This commit will not apply :(
> 
> It depends upon e0e7bc2cbee9 ("ASoC: topology: Clean up route loading"),
> which was in the same patchset that didn't get applied.
>   
>   https://lore.kernel.org/stable/?q=ASoC%3A+topology%3A+Clean+up+route+loading
> 
> I see, Mark Brown said it's not suitable material for stable kernels
> (since it's code cleanup), and Sasha Levin dropped it, and the dependent
> commit with real fix.

Ok, then someone needs to provide a working backport please...

thanks,

greg k-h

