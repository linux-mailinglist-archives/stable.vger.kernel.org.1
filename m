Return-Path: <stable+bounces-124621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8018A64996
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 11:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C603B8AAA
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5323F418;
	Mon, 17 Mar 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBPyKZeJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABD22FAF8;
	Mon, 17 Mar 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206672; cv=none; b=o7gkvJuOGiNH+YNm1FhCAhE8k3ekSV0actuBl6xkDkdlslVHUr/f4T7kaCLxCNDUmDj7ztG/cbFjYc4V+cfHN6gxRrbJ/3kCnKpLXFdCw0bf7X/Hx4hFTaquwN6IAnH2sN+rTdtsDjhn/jei7aGsDXSAO9UP5Kb4+JJ98kSZuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206672; c=relaxed/simple;
	bh=pmPCvimg6kIk5bQWxxaiUbnm0Bx4tJEcWlswhbjxRRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n2Q4J7eAh+omBdpw2tpn87MOz0xVZ5ye2lMYVYba1fJzDRKlC+/HxECYvarsZ9q90eecYi0FB7Nner8janWOfSn9fxHdU6WNVRv9VoSxktRB/9zqojAkO5tVkvzLx1GR00lV9YLpcTwAd3tgUAQxeDJL/ymp8Xwpi+geVJuTPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBPyKZeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440DDC4CEE9;
	Mon, 17 Mar 2025 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206672;
	bh=pmPCvimg6kIk5bQWxxaiUbnm0Bx4tJEcWlswhbjxRRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QBPyKZeJ+JopUOzv5v8HMb9dVL2HLdPPZLRBIJdUtwhcrt5bpiT/i9D2gUM3zjKW2
	 lEDVxx+FqMv6aIdWGSzs7fCEHXLnph6AVNlS13H0ljccTnLdFVht08Ko5c/TlT5F7+
	 O0Du3auymsRbGujXNteiTXTp5aOwND6lSpOGTNlGWe4/zmkhnEFTpgQWna73coElUC
	 edICSwkxarhhcewJw23GB7ybQMzRAKx3IFfl/bdtDeTVVjGHPOocvida232pLSsINU
	 7+c0ZrRh4izACdxEQJ9CJzRQy3Z3sb9T9VosetnMeKef8UOOY0NQlnrhL+qOTGwOPw
	 DNm1nurmwSP4A==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 quic_mohs@quicinc.com, krzysztof.kozlowski@linaro.org, 
 quic_pkumpatl@quicinc.com, alexey.klimov@linaro.org, 
 andriy.shevchenko@linux.intel.com, Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250226085050.3584898-1-haoxiang_li2024@163.com>
References: <20250226085050.3584898-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] ASoC: codecs: wcd937x: fix a potential memory leak in
 wcd937x_soc_codec_probe()
Message-Id: <174220666999.86423.7797313057647077449.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 10:17:49 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 26 Feb 2025 16:50:50 +0800, Haoxiang Li wrote:
> When snd_soc_dapm_new_controls() or snd_soc_dapm_add_routes() fails,
> wcd937x_soc_codec_probe() returns without releasing 'wcd937x->clsh_info',
> which is allocated by wcd_clsh_ctrl_alloc. Add wcd_clsh_ctrl_free()
> to prevent potential memory leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd937x: fix a potential memory leak in wcd937x_soc_codec_probe()
      commit: 3e330acf4efd63876d673c046cd073a1d4ed57a8

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


