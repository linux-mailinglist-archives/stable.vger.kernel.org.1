Return-Path: <stable+bounces-66449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB43494EACC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E3C281B17
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75516EBFF;
	Mon, 12 Aug 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bokAFO4Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA3033C7;
	Mon, 12 Aug 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458358; cv=none; b=BgrHiCoDU+kwnnzPmJWkpv8fyBcnck38/bztUkRwzTLvkZN8d/WV8VrVtclzG3cyOEyTujwffd++QPj7gvmnJceb+y+hgANFGhFEo6zVex0qgkfi7YMCCX/2SAzH7VX8NMP0aymepjFZbObmXip+CPK8j4k6ol64Y0DnYbt8Bf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458358; c=relaxed/simple;
	bh=ttaFByXujcrFeaJqlERmoZ+PKQvsCarqcYRjNobIhgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdZRkHPKEz+DfAJOrHKC5Wl9BgLTxRpYdOSLw4O3+briAHmKIrp3Ph0tHowaFBzsdYxUMmkxJlw1LDLPjAQ4wQ5QCMgbgbYgmxDnsm3ccO5ifwe+pviL8VW4IW4GHodwjdZJabSRP7ZPlxi8SfxRRz+10Tt0/EdZapBW5Kx51yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bokAFO4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62FDC32782;
	Mon, 12 Aug 2024 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723458357;
	bh=ttaFByXujcrFeaJqlERmoZ+PKQvsCarqcYRjNobIhgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bokAFO4YoVrOcK6BIu2kjVwcW0z5V8dHJ1YeRJT1Nk4PRWI0o94sozhi8nMt2i/mZ
	 mi1kDPi/XS5s6Xm46wPCSMXPVeet/R9LM/53M+WrYAo7dByzrrw7JhkEeoXb95mX7j
	 guQF/u3LqkKlKoljIiB6hoxj50rfj1q2O0CQzBzE=
Date: Mon, 12 Aug 2024 12:25:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Vitaly Chikunov <vt@altlinux.org>, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
Message-ID: <2024081225-finally-grandma-011d@gregkh>
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
 <210a825d-ace3-4873-ba72-2c15347f9812@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <210a825d-ace3-4873-ba72-2c15347f9812@linux.intel.com>

On Mon, Aug 12, 2024 at 12:01:48PM +0200, Amadeusz Sławiński wrote:
> I guess that for completeness you need to apply both patches:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1

This is already in the tree.

> was an incorrect fix which was later fixed by:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34

This commit will not apply :(

> Applying just first one will result in runtime problems, while applying just
> second one will result in missing NULL checks on allocation.

The second patch can not apply to the stable trees, so we need a
backported version please.

thanks,

greg k-h

