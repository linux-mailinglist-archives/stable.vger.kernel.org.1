Return-Path: <stable+bounces-114150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D36A2AEE0
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E4B1690AD
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30C19047F;
	Thu,  6 Feb 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOkHOJVH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995916DEA9;
	Thu,  6 Feb 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863026; cv=none; b=Rx4mLuiB1j19BP9P0LTHdLlsE79gFrhWVBSfW37HB3FGHZzYwMvbG/WdgdCkEthxqqk3VhQ0sWrvteL97bxjSCPZUm9Zv7kZQfp12NNjT7mp7U/uW3nOWBTHevbasJrvEOp07A5Yz+K+f6943btZzRQ5bV7UrOswi4B80zzMxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863026; c=relaxed/simple;
	bh=HqCjcQyLCccFtXHBmscOjjFPNZ77+uvrORcQ76hCDTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MuAZcAWH6TmmZzY0p0TFkc3m3P8PbvmfBerDSBUUu7Cs3MGBHWeaePJB/DR173Cq7dyKNG4jKFxzLJOZkEAJXyIv1Icc4jn7LL7s6ZVTUZ7obE+6vTHuOcc2IINKYikNG7Atc28ZujJC/c3pmv/NR566R/ukhi3kzB+B/3Pdaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOkHOJVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C123FC4CEDD;
	Thu,  6 Feb 2025 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738863025;
	bh=HqCjcQyLCccFtXHBmscOjjFPNZ77+uvrORcQ76hCDTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jOkHOJVH0zzTiQaU2U1YLoPjmuXVRVpgOrfvko6wc4a0o80zJuh2gVBw4MosAF4EU
	 eBeQkdGB93yn+sXTeaWp5e8wW0ghbim73yDdrFTX2ZiB3i9GlgFmLeIYl1dkeNEgtZ
	 ae0aLrM0D3AF2WiAQK71PSLg/HD6/fM9luVNbsHmQJhYlGVAXXAZHp3hz0gAP+bAhL
	 8f4p6lnF41o2GowtCFKu8gq0dlTvD6RlX5g5QCUGXzvB8ODUHWr51wUu9ehCSSKSaz
	 7P7fWqIKdMjyqk3SD+gEqjkBMx755K0uLQ7GLSx0pa9T+IyQJaSPiREWshLUrFy6rK
	 uAP1rgI0SQFsA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org, 
 cujomalainey@chromium.org, daniel.baluta@nxp.com
In-Reply-To: <20250205135232.19762-1-peter.ujfalusi@linux.intel.com>
References: <20250205135232.19762-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v2 0/2] ASoC: SOF: Correct sps->stream and cstream
 nullity management
Message-Id: <173886302350.325569.18363906987699150271.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 17:30:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 05 Feb 2025 15:52:30 +0200, Peter Ujfalusi wrote:
> Changes since v1:
> - fix the SHA of the Fixes tag
> 
> The Nullity of sps->cstream needs to be checked in sof_ipc_msg_data() and not
> assume that it is not NULL.
> The sps->stream must be cleared to NULL on close since this is used as a check
> to see if we have active PCM stream.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
      commit: d8d99c3b5c485f339864aeaa29f76269cc0ea975
[2/2] ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
      commit: 46c7b901e2a03536df5a3cb40b3b26e2be505df6

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


