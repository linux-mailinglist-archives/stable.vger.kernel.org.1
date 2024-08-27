Return-Path: <stable+bounces-70356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A12960B7E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A972B1C213B1
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08901BFDE1;
	Tue, 27 Aug 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+BzcIKO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8617BED8;
	Tue, 27 Aug 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764289; cv=none; b=rZluS8N8BeFRmiLqjNh+sKzMUNLod9FSCvY0M6WH2sSXOfphfBR5DweFqn4li4T3V8j4sHle1q595mRAJg2m/lC4wNXwiYvfsXl8bn+4WZsiG221JLFPJGKOWm4iesFQCr6+TtUmjvZlin8OxiTaj65FHFHmPvBrfyrDzKFGU6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764289; c=relaxed/simple;
	bh=qN6dpShJUykDX9o7BQJcl6txKhwbuyYjFcaoIeQCvOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRWFmRovfSHV75F1cHcQjt8Ii9CgGxRmKxDktiSzisbWOqo4mJ7AQ5vRN14FumfbqwNBE0VaLI+370sbAN+thyeL4sIb45H9Bkrqsrpl2mM3Wet4P97Ylsh2lKiZaOZabmLoggruxpoQa0CLoLrr3pwpT38XMfJAVB7pEeXfMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+BzcIKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5923FC61041;
	Tue, 27 Aug 2024 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724764288;
	bh=qN6dpShJUykDX9o7BQJcl6txKhwbuyYjFcaoIeQCvOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+BzcIKOZzL7yxHkm7xPuGPYd9NuxhHLpy6SefX8EBPZ/7TIjUrNk5tMrnyJgN4d0
	 GbygD8axfkP1vpQeIizi7hBP2Rz30TfeqSu73S0hMr6bpLijf1EtAO4Pi78AtSzy8a
	 E/NLgu9nFg0g4gRk09D8DUaAPhSotd2a7/7A6r1o=
Date: Tue, 27 Aug 2024 15:11:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Vitaly Chikunov <vt@altlinux.org>, Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH for stable 1/2] ASoC: topology: Clean up route loading
Message-ID: <2024082711-unsettled-floral-a4e0@gregkh>
References: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>
 <20240814140657.2369433-2-amadeuszx.slawinski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814140657.2369433-2-amadeuszx.slawinski@linux.intel.com>

On Wed, Aug 14, 2024 at 04:06:56PM +0200, Amadeusz Sławiński wrote:
> Instead of using very long macro name, assign it to shorter variable
> and use it instead. While doing that, we can reduce multiple if checks
> using this define to one.
> 
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> Link: https://lore.kernel.org/r/20240603102818.36165-5-amadeuszx.slawinski@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/soc-topology.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)

What is the git id of this commit?

thanks,

greg k-h

