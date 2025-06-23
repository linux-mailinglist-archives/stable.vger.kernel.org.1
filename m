Return-Path: <stable+bounces-156145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B081BAE49A0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 18:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341B3188D567
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5529A300;
	Mon, 23 Jun 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK3Vfo7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE4299A90;
	Mon, 23 Jun 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694430; cv=none; b=QMXqUHUlJgiX4q5rGO/B6RODG6JohaGCXBkc/x4dvx7h8Rz3s1x0uz5wRQPkPo2mRGUfXoRFLb3TAgxtvRXaYUUdsEmRl5OCKERBR3SMc/H5sXpYqtLjwwTNvbKnm69IpO58ytpcpnMnID1EiTABIjXunXcs4MwSRVp6/QEU2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694430; c=relaxed/simple;
	bh=hIn8HQlDO+pApqiZiANU0y9WNLKRLEwJhisgrOwz1mE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XAH6/xA9hGO20W4NqCeDM3Q18AW5VbQb2qegvd+e7XU3GVYavxhWlwS5TI43kkP+mWp8GOoUwbbEegSn0yc94eq2UZi3FwMbm8TcPu3BHf2o3nCqzGnBoA+6WV74PrCimSEf32X7DBg/9G57qQfAxY6xYPzXzH6r+co9Va+c/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK3Vfo7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1B9C4CEEA;
	Mon, 23 Jun 2025 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750694430;
	bh=hIn8HQlDO+pApqiZiANU0y9WNLKRLEwJhisgrOwz1mE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rK3Vfo7U4i7VY/RwH6myXTp1fUDq106EJfmM9IzbME+izSc12TBRPu+51FJq1yvfu
	 LJ69rJ27UwcnFmf4fSp1wD6Iabhve7neLADUr5oR/NfQFjQhgiWAe78WN0t4CdukL5
	 ewVH9V/dNal/qMeVdsqpno5WX2R2Va6GyNeZkGuEVrXx0sqEdryjEZBTPH2KTSSK3a
	 mbD5PIAsH6VsTBlrZdBqpYR8OKSNve4AV3dSuSiPKdO8GZClQc/zCyggnLvsuBcEP7
	 +1kaUJ/iQ/swlRqZw5lD81HJxnNyMxK8Gry62WLl5rKMSBcp7iTMMVIeKXNLdaskrO
	 n8RhNGIVC8Ezw==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.com>, 
 Oliver Schramm <oliver.schramm97@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250621223000.11817-2-oliver.schramm97@gmail.com>
References: <20250621223000.11817-2-oliver.schramm97@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for Lenovo IdeaPad Slim 5
 15
Message-Id: <175069442786.140181.17086249250006921001.b4-ty@kernel.org>
Date: Mon, 23 Jun 2025 17:00:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-08c49

On Sun, 22 Jun 2025 00:30:01 +0200, Oliver Schramm wrote:
> It's smaller brother has already received the patch to enable the microphone,
> now add it too to the DMI quirk table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for Lenovo IdeaPad Slim 5 15
      commit: bf39286adc5e10ce3e32eb86ad316ae56f3b52a0

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


