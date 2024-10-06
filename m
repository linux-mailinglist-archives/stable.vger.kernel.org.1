Return-Path: <stable+bounces-81182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE11991B96
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 02:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBF31C2131B
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 00:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEDF6AB8;
	Sun,  6 Oct 2024 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcsrPliz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574004690;
	Sun,  6 Oct 2024 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174571; cv=none; b=WdZ5qDiAP3v9bVK6LmPYwoUG39kuNtXHGQD+Rx7m2l8ODNq57318yL7eX18333H119Ay0DKB38gv/mt7ns8R4C6SY/6ePOt2v3PIIUMIXTUfxoOLMTvhYczNxc/iwENNQOH/k2vy1KJxAitvZK4ej/7SAXjD/8GhqvIPvaNytsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174571; c=relaxed/simple;
	bh=IVi6F5BlL7sFbhsFG08Yszd8yWzrvkLgEvB1ht1Gyi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re7lDo2fYzbtQicKnxzYKe4wtNPb8V5DcznYvJ22mcir1wcDzVQBDLYpLQDPkdQM0JGAsUainxS8v2clnEq+sDY7dfb0+A2fJEwk+2ZEdWT3Ac/9FDcJcJ0IfE/HjfEXD5mcMv8812IS4QxPZXoLeufTucdE+/ChuPjE1ySpukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcsrPliz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EA0C4CEC2;
	Sun,  6 Oct 2024 00:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728174571;
	bh=IVi6F5BlL7sFbhsFG08Yszd8yWzrvkLgEvB1ht1Gyi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcsrPlizUZtl6KTW88Lvl1GyK9BAwr9Nr1P/xAqXJhpNWkeP3bQRcsBPiwnqUNiCt
	 pDdqDFvqp1es2Vz8BwyC8ONIkGDUQMDriovfWPuvBx7f4wXVCLAWHePsLze/3PXDp/
	 WbjM05WMYnVw9zeHyOaSQOvmYw7D5ojOg1hMCLsYuZ/Vb4o5OtVwzoEZwQnwN7p4UE
	 xSd/WYIR3+NDglCvGqU6L+l9FSLJzyOdi8loAOb2AdBICRIx9HIhG5CLM/9NRfafcQ
	 SU6jDyZ5FJDRXVmd0rlz3nDrrcBYtFo71uYWc+iS7wMHMaB0wk/7FzccbzNs4DgAeI
	 nPlTMWBcNiPfw==
Date: Sat, 5 Oct 2024 20:29:29 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Jerome Brunet <jbrunet@baylibre.com>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.11 109/244] ASoC: soc-pcm: Indicate warning if
 dpcm_playback/capture were used for availability limition
Message-ID: <ZwHZ6ePdG3oNRams@sashalap>
References: <20240925113641.1297102-1-sashal@kernel.org>
 <20240925113641.1297102-109-sashal@kernel.org>
 <ZvP-YQuXTyGDfb8x@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZvP-YQuXTyGDfb8x@finisterre.sirena.org.uk>

On Wed, Sep 25, 2024 at 02:13:21PM +0200, Mark Brown wrote:
>On Wed, Sep 25, 2024 at 07:25:30AM -0400, Sasha Levin wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> [ Upstream commit fd69dfe6789f4ed46d1fdb52e223cff83946d997 ]
>>
>> I have been wondering why DPCM needs special flag (= dpcm_playback/capture)
>> to use it. Below is the history why it was added to ASoC.
>
>...
>
>> Because of these history, this dpcm_xxx is unneeded flag today. But because
>> we have been used it for 10 years since (B), it may have been used
>> differently. For example some DAI available both playback/capture, but it
>> set dpcm_playback flag only, in this case dpcm_xxx flag is used as
>> availability limitation. We can use playback_only flag instead in this
>> case, but it is very difficult to find such DAI today.
>>
>> Let's add grace time to remove dpcm_playback/capture flag.
>>
>> This patch don't use dpcm_xxx flag anymore, and indicates warning to use
>> xxx_only flag if both playback/capture were available but using only
>> one of dpcm_xxx flag, and not using xxx_only flag.
>
>This is a cleanup/refactoring preparation patch, I can see no reason why
>it would be considered for stable.

Dropped, thanks!

-- 
Thanks,
Sasha

