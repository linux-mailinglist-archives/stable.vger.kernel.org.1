Return-Path: <stable+bounces-61275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C093B0D8
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 14:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0671F22553
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31988157E84;
	Wed, 24 Jul 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr/LY8hz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83C156886;
	Wed, 24 Jul 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823022; cv=none; b=HjAfOo3b+lbklBc6xViwLpB3AYV7uYfoszAdSb0ly1+shG0SyOMEJ1OsGycDcYKfJcvqulAqcvCWJokC8lDlShvIwzGHpLn//uKYba9YmZFvNp83UfxQqYdjHxPwzmPAHUdMDpCsgDxPNsBCJUtN+QrGe9rTK2+cCYq0vweKq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823022; c=relaxed/simple;
	bh=G8Enp6246oi4fdjmxV7Dg2o6nX8YvSL3NzlBi+TKn2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WkuFmWyO4dQgYJP1Qfju3nDXipVdNqWgv5BwGaAcFDWO6M6bsrN/u/t1D8KvgtnoQIwq8P3Ss8oWx4l68GEstvYDmAAsbggwBR3XMiD4PBUqZv8S6BzGyEiBMyzyZjGCHuPMhQag/GbaF/yLQ9FVhsLXuTLyRujDJlomy6Vw0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr/LY8hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D43C32782;
	Wed, 24 Jul 2024 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721823021;
	bh=G8Enp6246oi4fdjmxV7Dg2o6nX8YvSL3NzlBi+TKn2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jr/LY8hzQltGjDo7zvy8TVsNF7jTeROoz9lZmM/d0xY1HZ/ak8L2uXUV5PqyPfkMC
	 WQ7ZpZBdQ7sCTY6/LlCHxl7hBb80E5+9s8sokGxWRjtJTRPnW7M7huhrpgwYi4p/GZ
	 j0WsVexGsf2TceKsx8JkVcTRooj32ZtztJjIWSh/sWF+a/qTBsMQKbEzMXSYyTpYCb
	 ryJblSqqIIsxqUCu/X4JWOWQmtZT9wfqdqcCXphqYPzSAiKq7YNlm71kk2uhEKDUko
	 nCkss3PiiPxunYJdtnSF7HrDJtuTyfMwmtRS4YcIuQS+4KgtVFOnx0QHgWGZ+/lB/N
	 CelIiYRNNiOBA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, pierre-louis.bossart@linux.intel.com, 
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, stable@vger.kernel.org
In-Reply-To: <20240724081932.24542-1-peter.ujfalusi@linux.intel.com>
References: <20240724081932.24542-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH fro 6.11 0/2] ASoC SOF: ipc4-topology: Fix LinkID
 handling for ChainDMA
Message-Id: <172182301951.48524.13848330692814573594.b4-ty@kernel.org>
Date: Wed, 24 Jul 2024 13:10:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 24 Jul 2024 11:19:30 +0300, Peter Ujfalusi wrote:
> A recent patch available in 6.10 [1] uncovered two issues on how the DMA Link ID
> is tracked with ChainDMA and can cause under specific conditions [2] to cause a DSP
> panic.
> The issue is not academic as we have one user report of it:
> https://github.com/thesofproject/linux/issues/5116
> 
> The patches have been marked for stable backport to made there way to 6.10.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: ipc4-topology: Only handle dai_config with HW_PARAMS for ChainDMA
      commit: ae67ed9010a7b52933ad1038d13df8a3aae34b83
[2/2] ASoC: SOF: ipc4-topology: Preserve the DMA Link ID for ChainDMA on unprepare
      commit: e6fc5fcaeffa04a3fa1db8dfccdfd4b6001c0446

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


