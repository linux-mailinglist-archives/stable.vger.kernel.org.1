Return-Path: <stable+bounces-65401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2D947F12
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C8A1F21F33
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1529D15B554;
	Mon,  5 Aug 2024 16:17:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9B149C69;
	Mon,  5 Aug 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874634; cv=none; b=rAUzAcgUtXolBYtwZrQZd9JYWcvywrfuluoqrVV1ENARsBCD7jMvTkVnvm6Uj1k80ZGT78u57O7HJADMXBG11lmpB5EVdAqazofgpu6NjBWot4Sj662JijTol06FMw0yW92BHHSDKiWdbUvvi9STQjUn6GAjsocw4OOQeGhFOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874634; c=relaxed/simple;
	bh=1AU3uHyHgBd+fNoGKpCyHDzwTORE5i8l+dO0lWvgOGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tn5V2iRewAMjaDDy5TQbPfYpdYrs0O3PAZavbJ630T0JBMwcbaNQ76mDF9JXN/RVxn3TvXUoFSqatT9bpqimFQ4YqbT0ZgPHbU0ZdcYqkwLcdB4whuZfEqC/uOcyqn6nHegCqZNPnOwT0H8xG7ZCNi86130DE/Zk17RB3rr97Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 6060872C8FB;
	Mon,  5 Aug 2024 19:17:04 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 58FC636D0168;
	Mon,  5 Aug 2024 19:17:04 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id A772E360BFC2; Mon,  5 Aug 2024 19:17:03 +0300 (MSK)
Date: Mon, 5 Aug 2024 19:17:03 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
Message-ID: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
X-In-Reply-To: <20240709162007.30160-17-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Sasha, Greg,

On Tue, Jul 09, 2024 at 12:18:57PM GMT, Sasha Levin wrote:
> From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> 
> [ Upstream commit 0298f51652be47b79780833e0b63194e1231fa34 ]
> 
> It was reported that recent fix for memory corruption during topology
> load, causes corruption in other cases. Instead of being overeager with
> checking topology, assume that it is properly formatted and just
> duplicate strings.

Can this backport actually be applied to the 6.9/6.6/6.1 stable branches?

I have multiple bug reports about sound not working and memory
corruption on some laptops (for example ICL RAYbook Si1516). See for
example bug reports[1][2], and the fix discussion [3].

dmesg messages from Lenovo ThinkBook 13 gen 1:


  [ 3.555191] sof-audio-pci-intel-cnl 0000:00:1f.3: Firmware info: version 2:2:0-57864
  [ 3.555206] sof-audio-pci-intel-cnl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
  [ 3.574043] sof-audio-pci-intel-cnl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
  [ 3.575180] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink MIXER1.0> not found
  [ 3.575772] sof-audio-pci-intel-cnl 0000:00:1f.3: error: tplg component load failed -22
  [ 3.575793] sof-audio-pci-intel-cnl 0000:00:1f.3: error: failed to load DSP topology -22
  [ 3.575801] sof-audio-pci-intel-cnl 0000:00:1f.3: ASoC: error at snd_soc_component_probe on 0000:00:1f.3: -22

Error messages from other boots showing memory corruption:

  [ 3.904397] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink PCM0C03-std-def-alt0.p11@jh\x86Ŝ\xff\xff@\xc8\xff\x82Ŝ\xff\xff`P\x82\xbb\xff\xff\xff\xff\x94$A\xbc\xff\xff\xff\xff\x06 not found
  [ 3.966777] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sink PGA1.0\x01 not found
  [ 3.899748] sof-audio-pci-intel-cnl 0000:00:1f.3: error: source BUF2.0 not found
  [ 3.975359] sof-audio-pci-intel-cnl 0000:00:1f.3: error: source PCM0P\x01pcsc-lite.conf not found
  [ 7.275851] sof-audio-pci-intel-tgl 0000:00:1f.3: error: source HDA1.IN/0123456789:;<=>? not found

[1] https://github.com/thesofproject/sof/issues/9339
[2] https://github.com/thesofproject/sof/issues/9341
[3] https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d

Thanks,

> 
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Closes: https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d
> Suggested-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> Link: https://lore.kernel.org/r/20240613090126.841189-1-amadeuszx.slawinski@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/soc/soc-topology.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 52752e0a5dc27..27aba69894b17 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1052,21 +1052,15 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
>  			break;
>  		}
>  
> -		route->source = devm_kmemdup(tplg->dev, elem->source,
> -					     min(strlen(elem->source), maxlen),
> -					     GFP_KERNEL);
> -		route->sink = devm_kmemdup(tplg->dev, elem->sink,
> -					   min(strlen(elem->sink), maxlen),
> -					   GFP_KERNEL);
> +		route->source = devm_kstrdup(tplg->dev, elem->source, GFP_KERNEL);
> +		route->sink = devm_kstrdup(tplg->dev, elem->sink, GFP_KERNEL);
>  		if (!route->source || !route->sink) {
>  			ret = -ENOMEM;
>  			break;
>  		}
>  
>  		if (strnlen(elem->control, maxlen) != 0) {
> -			route->control = devm_kmemdup(tplg->dev, elem->control,
> -						      min(strlen(elem->control), maxlen),
> -						      GFP_KERNEL);
> +			route->control = devm_kstrdup(tplg->dev, elem->control, GFP_KERNEL);
>  			if (!route->control) {
>  				ret = -ENOMEM;
>  				break;
> -- 
> 2.43.0
> 

