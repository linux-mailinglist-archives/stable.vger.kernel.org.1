Return-Path: <stable+bounces-66464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B53594EB4C
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6D7B20BE9
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 10:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62D116FF39;
	Mon, 12 Aug 2024 10:38:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD416DC2C;
	Mon, 12 Aug 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459132; cv=none; b=afMmSkJ+8MLFrcsyFd2YMtnR7RAHer3ltAFq8azqiz+Wz3cdzsVLmrz9lfI+yQC0E3G2YgAzDMyelp1WUDBgH9O9juwzuT4ScnT4eVhW+bIusg+euURNAKzph/L92tWsviLPXRa+YM9cdaiXs1Tth0wHPZTD8o+oF8HVmZ7308w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459132; c=relaxed/simple;
	bh=4UYDJVRe6KgTAVzMjSOYGd2NkpVsSHKygr+86n9S3QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8Ft9Nnwei7bpfH9paArwGIvxh8x988Nczjis7G5WSJkyR9hLqaASS20f0KinxkndA/5MGhlI07clW6FbMb9VRUI0ffyZNRhaJoMvk80RDrFsY3fTZDnWmxnOO/OViqPKzzQ6/1cuEcjYchFamo90Q9c6+dXADxEv90HZ2jIeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 88ABE72C8CC;
	Mon, 12 Aug 2024 13:38:42 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 78B4836D0246;
	Mon, 12 Aug 2024 13:38:42 +0300 (MSK)
Date: Mon, 12 Aug 2024 13:38:42 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
Message-ID: <20240812103842.p7mcx7iyb5oyj7ly@altlinux.org>
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
 <210a825d-ace3-4873-ba72-2c15347f9812@linux.intel.com>
 <2024081225-finally-grandma-011d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024081225-finally-grandma-011d@gregkh>

Greg,

On Mon, Aug 12, 2024 at 12:25:54PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 12, 2024 at 12:01:48PM +0200, Amadeusz Sławiński wrote:
> > I guess that for completeness you need to apply both patches:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1
> 
> This is already in the tree.
> 
> > was an incorrect fix which was later fixed by:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34
> 
> This commit will not apply :(

It depends upon e0e7bc2cbee9 ("ASoC: topology: Clean up route loading"),
which was in the same patchset that didn't get applied.
  
  https://lore.kernel.org/stable/?q=ASoC%3A+topology%3A+Clean+up+route+loading

I see, Mark Brown said it's not suitable material for stable kernels
(since it's code cleanup), and Sasha Levin dropped it, and the dependent
commit with real fix.

Thanks,

> 
> > Applying just first one will result in runtime problems, while applying just
> > second one will result in missing NULL checks on allocation.
> 
> The second patch can not apply to the stable trees, so we need a
> backported version please.
> 
> thanks,
> 
> greg k-h

