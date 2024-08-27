Return-Path: <stable+bounces-70357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BEB960B81
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344A3B25905
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7791C2DD1;
	Tue, 27 Aug 2024 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dwIM0hj1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441417BED8;
	Tue, 27 Aug 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764320; cv=none; b=IPXCFbEeOZNKsGburIYCkhWSYc6SsqOgt5wzaLnuiB56UCTslxzMw06HOm06xrK745xpXxWVPWFALFHdadfoced17XyQ3wXIZT74kQhVNUVIQjPQSF/mGxrGUxG7qQ6RAVtwD5oxs3N6Cwp6CJlwkdEp/ZFArmJX2+VioJ56AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764320; c=relaxed/simple;
	bh=HwxQP61MZeHik1g5rd3oUzvQxo1n6F6I4rm2AhH1LS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwAkU1CuKpaTegW0IZSIsRnxXiU1c3L9R9z8R7PFe+7snZ8A0hbF0ImmU9pyF1tMmcnxCPC9uNLMOsUrXXOBLEK9l202jlKp+JY9bJPhOMUZXDs1pQBqo86qZWbcR2Bd4bLQjTIo9CYu6umj9UUMs8mz/Yg/fa6fd1WEn67DJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dwIM0hj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42A4C61047;
	Tue, 27 Aug 2024 13:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724764319;
	bh=HwxQP61MZeHik1g5rd3oUzvQxo1n6F6I4rm2AhH1LS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwIM0hj1ugbAfnBmP8vdpFQD7VlNZiTL8QseMV5QTCV4zMuW0cLz6h6AsM486bd11
	 IzAxcoM1tj9hZ93E+6tVK9R+xSDkQThesq/GOox1iS9OLoeUYTgjHEV5hzefRo2cx5
	 k7Y8mXzsHJoZn6tSh4ewy9aOfNnYxu1qLsNwXtAY=
Date: Tue, 27 Aug 2024 15:11:56 +0200
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
Message-ID: <2024082729-subatomic-anemia-003d@gregkh>
References: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>

On Wed, Aug 14, 2024 at 04:06:55PM +0200, Amadeusz Sławiński wrote:
> Commit 97ab304ecd95 ("ASoC: topology: Fix references to freed memory")
> is a problematic fix for issue in topology loading code, which was
> cherry-picked to stable. It was later corrected in
> 0298f51652be ("ASoC: topology: Fix route memory corruption"), however to
> apply cleanly e0e7bc2cbee9 ("ASoC: topology: Clean up route loading")
> also needs to be applied.
> 
> Link: https://lore.kernel.org/linux-sound/ZrwUCnrtKQ61LWFS@sashalap/T/#mbfd273adf86fe93b208721f1437d36e5d2a9aa19

You need to put the git ids in the patches directly do we have a clue
what to do.

Also, what tree(s) do you need/want these in?

Please fix up and resend.

thanks,

greg k-h

