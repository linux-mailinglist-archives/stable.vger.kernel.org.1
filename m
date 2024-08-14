Return-Path: <stable+bounces-67664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492C4951CCC
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 16:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05362281090
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707A1B32B5;
	Wed, 14 Aug 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SaomdTG2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17D1B29BD;
	Wed, 14 Aug 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644764; cv=none; b=ke/pQRsO11PCzedk9frVxi6e+ANTcNSxBEJ1tAiTNeUDW0g2B1hYlKwoELhL4rWs+QkujQXYhaLnMDIeiHoWRsXqCfIAZN6aJ5y7UCaC/R642Sk0oV/LfTpePHwyu5a40QxwLhAFFF0jcVLvUaH36kJpdxYRV1//DhTD9NMrD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644764; c=relaxed/simple;
	bh=2NWTvkTmAjlh1Y9AcicpLHob5jRSU8t+LdyURJCYXbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2t6JdPuXD21AJjOJhOhPvkUup+3D6uRLHtBWY+JHd0sLrq/SwnTpb6rVgYLvdr0TjnBUZS2F4Ggd8I+ng9yz6IhQ7Zpe8m+UqYDixyQgKPR9ZpqjNiQjMhumrbIs0fk/KLKGqln4mNTGb9GTu3/PiPgswjA/jwQtZD/Bacbwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SaomdTG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB92C116B1;
	Wed, 14 Aug 2024 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723644763;
	bh=2NWTvkTmAjlh1Y9AcicpLHob5jRSU8t+LdyURJCYXbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaomdTG25s4riEpnZkVuCh8JeHnzdGrUW50+3y/256GiROMplf8qfBEL1jkNowj80
	 K1JVhbp72a437OAMRApJUimBpxDpCOq82Wj5YpVVHee0cbIxJVWZA9rrP056ljaNkA
	 4yVmh40zpXzKnlW+fGu1TXbg+ljfs7tCv7L4tR74=
Date: Wed, 14 Aug 2024 16:12:40 +0200
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
Message-ID: <2024081434-drowsily-stingy-1b09@gregkh>
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
> 
> Amadeusz Sławiński (2):
>   ASoC: topology: Clean up route loading
>   ASoC: topology: Fix route memory corruption
> 
>  sound/soc/soc-topology.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 878fbff41def4649a2884e9d33bb423f5a7726b0
> -- 
> 2.34.1
> 
> 

What stable tree(s) is this for?

