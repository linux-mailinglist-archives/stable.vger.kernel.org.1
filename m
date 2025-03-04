Return-Path: <stable+bounces-120242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A1A4DDFF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 13:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F1F178BD1
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DA8203707;
	Tue,  4 Mar 2025 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xra/hDtA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489D202F7C;
	Tue,  4 Mar 2025 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091625; cv=none; b=nCGgMwVGh8evZbPW55mySF7qmDlnFX+5UuYuL1qMM7JQwgJtWN2xnyaeUxxQCKduO3YvQOZettOMCwws2OSbxHs/slJ0JEqINLdaff2BtH8xkzRyJtB8x8aAigIRd7ceDC60t2CNHoK3A9fay3RuFY8r0iLovW1M8GY1vHgYnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091625; c=relaxed/simple;
	bh=TsNA83VsfGHxuJXznKqc2gmfbctX5gEAjPkF4aG/umA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XfHPqDnsDiPhcDouabwGAgO2hg4hN/s45QGIuA24c0jrghaRb9OYjg2VEHUWoMC8jzGf7Z+6ao7h0PUonm4uxVZ1xK8jH/MR+k43B3S13qdNuZZGoZSlf4VKo6GbxwtVLLKuD7XIOAn4Wart01m44j09V3fVK3xFDM3KRodUmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xra/hDtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402FFC4CEE5;
	Tue,  4 Mar 2025 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741091624;
	bh=TsNA83VsfGHxuJXznKqc2gmfbctX5gEAjPkF4aG/umA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Xra/hDtAZ1p8zlKY7qL9UC9tW0QAIYrKhS/26297e+rK5sxBwtubTgJldsRlLedXh
	 AoAyHicp7K8tArkm+uQhV9KKS2xOjkgbJ8dBxypuZVJiA6KecK52lxS2/fmZhBUwB9
	 ybNjMoHu9MBYlPhGI3m7sqtpa1UdQBJPeczwk0dw+oq5DoWj998XwNjNdiY6qz+09P
	 WabsqKFo5SPjCM7PuUT9Cq8fJBwcnL4fWpKoxHgcqf+dPETy5CwXvIkOjZuaagT0WS
	 g+Dv9eTqMjYEcenV+1sVPiVIf3iH8Y/UJ1zFtxHEumGw1NI/s2KgNW6mpJQHnWkfzI
	 WGc8nLTSLkHwg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Sheetal <sheetal@nvidia.com>, 
 Sameer Pujar <spujar@nvidia.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Ritu Chaudhary <rituc@nvidia.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250222225700.539673-2-thorsten.blum@linux.dev>
References: <20250222225700.539673-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: tegra: Fix ADX S24_LE audio format
Message-Id: <174109162199.25452.7706567834275487089.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 12:33:41 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 22 Feb 2025 23:56:59 +0100, Thorsten Blum wrote:
> Commit 4204eccc7b2a ("ASoC: tegra: Add support for S24_LE audio format")
> added support for the S24_LE audio format, but duplicated S16_LE in
> OUT_DAI() for ADX instead.
> 
> Fix this by adding support for the S24_LE audio format.
> 
> Compile-tested only.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Fix ADX S24_LE audio format
      commit: 3d6c9dd4cb3013fe83524949b914f1497855e3de

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


