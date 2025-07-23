Return-Path: <stable+bounces-164491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B23B0F860
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5462BAA83CF
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8121FC0E2;
	Wed, 23 Jul 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkCKKoJp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AF17A2E8;
	Wed, 23 Jul 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289329; cv=none; b=f7h5tL0z/X5p+jn6PNI7Gr6tQeq+LwJwmDvVPyPnLJTHdGxxD8m2XkqXjUiL4U16QC7v+FiDzrHmRs+W6Hd6MOd+S6VPUtUGa4jbPjZDufS2wU5R8zmwFMCs05GLl9Zf2vy9bA3VFVj7SfXquCdkL/vxTrbMxJMv7hYjhB126qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289329; c=relaxed/simple;
	bh=ByZ5PYiT1ej+cqdbA286xENhWOW5ZOiRkfXl/Z6pp5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=erM41t9q5nRKr4Slxert4p0gm4p0BbZs2aGjsDn3MdoLPioUrpT62wxs/PfjQGAlGgVSgQ6vvSoWpfCWsqEyvryS8GvP/xs7bIrsajmj3QB7dUiQbH/X77UhVRTB7MZDZHmeB03sTDUk9z9a8AqR/yfH8gIjyIk3sDoqWs70YvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkCKKoJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19083C4CEF1;
	Wed, 23 Jul 2025 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753289329;
	bh=ByZ5PYiT1ej+cqdbA286xENhWOW5ZOiRkfXl/Z6pp5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qkCKKoJpiV3pjA5YQVloF7LV8OaRYMBeLagUW5Y/gW+dNmwN7EB6t4bO2ioLkhezt
	 LfGuaeU0iqmjIEf8AmdYMCk9HoGYNrste+KO/xv2ve4KWHgG+YvExLWH23XaTU8TVV
	 DGasaE7zWgz2EjIQ4msU54PJ2zQLsZApWmALQVuHN/3w4l46KCHvL4muZGfhTgEeJs
	 TkGcyvwQcFsDUC7gf/UOpViD4YbZzI3OxB2PQjkZlSbqj0I4uAn2vcgxDoEGif5zwk
	 40jX+6vApy/i3EeA3AknaV6RqV/p6InircNGYtQyXW9pY7k+PPVgyaNv75af6NUga7
	 ABF6eng/66Adw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
In-Reply-To: <20250722092542.32754-1-johan@kernel.org>
References: <20250722092542.32754-1-johan@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: common: fix device and OF node leak
Message-Id: <175328932684.84720.16626909941095412727.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 17:48:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 22 Jul 2025 11:25:42 +0200, Johan Hovold wrote:
> Make sure to drop the references to the accdet OF node and platform
> device taken by of_parse_phandle() and of_find_device_by_node() after
> looking up the sound component during probe.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: common: fix device and OF node leak
      commit: 696e123aa36bf0bc72bda98df96dd8f379a6e854

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


