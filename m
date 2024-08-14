Return-Path: <stable+bounces-67558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CC9510D9
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B9CB25244
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 00:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B068A953;
	Wed, 14 Aug 2024 00:01:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567AB19E;
	Wed, 14 Aug 2024 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593663; cv=none; b=Ar3uHtfhn5XJF3+8JOf30zvq/TJgVx5sF+EuQXR2i7S0AmLbNqj8AW6/HtWH39zJcD0BexI/U/LGgBzKyj0i/qxL9OwfsECjhVE3BFvoLBTcHlmYBwZcQrIxtMAyx8JUsG5Tvn3lRon2e0FwrBiPvofqaovNJi5eqmqHxNDmGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593663; c=relaxed/simple;
	bh=/jt2KQ3hYUB2qH6NZxlcN8hjxzqNHCvKIia+tiAkrmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLabdBJpJXVoxVJvPoyokyOzfr+H2Xqt/6OGBqAJYAYa850n05QWS2nzUsnwQe2fCG/Ibe7XvJHnKsH9Vuu83yzzwla7qUkyHxHL8JSVV8v8UqIVyw4Crhd5UKrKvxV4vUGCq0zvmzskBg4Mec6rZttOFysd79HtLZFlrCjnz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 7C9D172C8CC;
	Wed, 14 Aug 2024 03:00:53 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 65D5936D0246;
	Wed, 14 Aug 2024 03:00:53 +0300 (MSK)
Date: Wed, 14 Aug 2024 03:00:53 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
Message-ID: <20240814000053.posrfbgoic2yzpsk@altlinux.org>
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
 <210a825d-ace3-4873-ba72-2c15347f9812@linux.intel.com>
 <2024081225-finally-grandma-011d@gregkh>
 <20240812103842.p7mcx7iyb5oyj7ly@altlinux.org>
 <2024081227-wrangle-overlabor-cf31@gregkh>
 <53ab1511-b79c-4378-b2b5-ea9e19e8f65b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53ab1511-b79c-4378-b2b5-ea9e19e8f65b@linux.intel.com>

Greg, Amadeusz,

On Tue, Aug 13, 2024 at 04:42:04PM +0200, Amadeusz Sławiński wrote:
> On 8/12/2024 4:11 PM, Greg Kroah-Hartman wrote:
> > On Mon, Aug 12, 2024 at 01:38:42PM +0300, Vitaly Chikunov wrote:
> > > Greg,
> > > 
> > > On Mon, Aug 12, 2024 at 12:25:54PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Aug 12, 2024 at 12:01:48PM +0200, Amadeusz Sławiński wrote:
> > > > > I guess that for completeness you need to apply both patches:
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1
> > > > 
> > > > This is already in the tree.
> > > > 
> > > > > was an incorrect fix which was later fixed by:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34
> > > > 
> > > > This commit will not apply :(
> > > 
> > > It depends upon e0e7bc2cbee9 ("ASoC: topology: Clean up route loading"),
> > > which was in the same patchset that didn't get applied.
> > >    https://lore.kernel.org/stable/?q=ASoC%3A+topology%3A+Clean+up+route+loading
> > > 
> > > I see, Mark Brown said it's not suitable material for stable kernels
> > > (since it's code cleanup), and Sasha Levin dropped it, and the dependent
> > > commit with real fix.
> > 
> > Ok, then someone needs to provide a working backport please...
> > 
> 
> Should this be cherry-pick of both (they should apply cleanly):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34
> or just the second one adjusted to apply for stable trees?

I think having commit with memory corruption fix is more important to
stable kernels than not having the code cleanup commit. So, I would
suggest stable policy to be changed a bit, and minor commits like this
code cleanup, be allowed in stable if they are dependence of bug fixing
commits.

Additionally, these neutral commits just make stable trees become closer
to mainline trees (which allows more bug fix commits to be applied
cleanly).

Thanks,


