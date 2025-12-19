Return-Path: <stable+bounces-203096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47697CD036E
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 15:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8720305D7A3
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16722DF13E;
	Fri, 19 Dec 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTPlngP8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD935264628;
	Fri, 19 Dec 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153371; cv=none; b=MDKfLfJMdQaFZwiRv2GXNpeFW2Gvnq6E5+4Vpr/TyRnkelMiS2uDP+AOkvC7L6yhSn/Jw8e6TZp9vGkONWjL1WKwv2MLlfhEWEdLwNzpQcjQb3uVmtM9Kt641vhjeMCmx6r+zxDokfk9oJlUkP1CvzrBfoxo27knEmSFsw4/9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153371; c=relaxed/simple;
	bh=RsohaNGjAAyCO4ow/UBaQkjTs9uq8T3jmxOXAnd7LBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uXlql8nFaPsZA9aq7vG4gRnIeNngEnDgTiJ2IJwvgBxtTZ4CU7lmIE8V4vonLUcAlhcL1JM6CdIPKqbXqhfzeNvehg1bRFeOS8MfGoHd/wajYs9awm4RTobaUyTw4iLluYPz1AjvZ3FDEx7B+U6aEtgng25s/crtfOaJGh5zF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTPlngP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B477C4CEF1;
	Fri, 19 Dec 2025 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766153371;
	bh=RsohaNGjAAyCO4ow/UBaQkjTs9uq8T3jmxOXAnd7LBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kTPlngP8oOQx4elQrkofz4GvfESIbAqkLQAcTNQLV+R5666AIMMbEg8l5zcsq3FB0
	 rrqBBIsnpVWPa7fUMS/FQqMwDloMgMTzJm87kCF3eIVqHiGWktZSMBul0D8tY32dj8
	 KdGMFKjtm8xtdwVEoVT7d7qTrusICFtgOXee8yl5xMsS75qACzEUt8Ea26gT0w1j6w
	 xQ+/xze9rt4CnoNaXLp0puA3cBc2T/6VjQrfpR8+446XYhqIqDakdK4SXUZY2VxX61
	 XEx8mzPZS+V+vL/qU+/CuWfecKJpBb/8Lna4dsH4JGw+ej/z7XAKIROnlQRe5km4RL
	 cLAxacHAgZxFw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, seppo.ingalsuo@linux.intel.com, 
 stable@vger.kernel.org
In-Reply-To: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
References: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v2 0/8] ASoC: SOF: ipoc4: Support for generic bytes
 controls
Message-Id: <176615336928.412520.1247060955061505587.b4-ty@kernel.org>
Date: Fri, 19 Dec 2025 14:09:29 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 15 Dec 2025 16:25:08 +0200, Peter Ujfalusi wrote:
> Changes since v1:
> - correct SHAs for fixes tags
> - add Cc stable tag
> 
> We support bytes control type for set and get, but these are module specific
> controls and there is no way to handle notifications from them in a generic way.
> Each control have module specific param_id and this param_id is only valid in
> the module's scope, other modules might use the same id for different functions
> for example.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: SOF: ipc4-control: If there is no data do not send bytes update
      commit: 2fa74713744dc5e908fff851c20f5f89fd665fb7
[2/8] ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls
      commit: a653820700b81c9e6f05ac23b7969ecec1a18e85
[3/8] ASoC: SOF: ipc4-control: Use the correct size for scontrol->ipc_control_data
      commit: c1876fc33c5976837e4c73719c7582617efc6919
[4/8] ASoC: SOF: ipc4-control: Keep the payload size up to date
      commit: ebcfdbe4add923dfb690e6fb9d158da87ae0b6bf
[5/8] ASoC: SOF: ipc4-topology: Set initial param_id for bytes control type
      commit: 2fdde18a2cb1631c01e4ab87d949564c7d134dd8
[6/8] ASoC: SOF: ipc4: Support for sending payload along with LARGE_CONFIG_GET
      commit: d96cb0b86d6e8bbbbfa425771606f6c1aebc318e
[7/8] ASoC: SOF: ipc4: Add definition for generic bytes control
      commit: 7fd8c216c422c5d42addc3e46d5d26630ff646d1
[8/8] ASoC: SOF: ipc4-control: Add support for generic bytes control
      commit: 2a28b5240f2b328495c6565d277f438dbc583d61

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


