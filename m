Return-Path: <stable+bounces-183115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DC8BB49F1
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 19:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EC917452D
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B2B258ED9;
	Thu,  2 Oct 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmurp+eC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CABC42A99;
	Thu,  2 Oct 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424812; cv=none; b=qyczea5zMXRCOjwKtf7+nzlNCOkuxkQ5Rc76tlwpwguZ1w5+awlH8tJUJ9bG+EniD+NnoVSK09VX4KEP/40FeZgrwoVNMX7BRULU3JVvm99/6CyP5QhKAgrphxiUe16iYvOj8kE8LN2ynDRKeil2h1T7q2TjYdjiHMWLplfDwlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424812; c=relaxed/simple;
	bh=X/U82S0COSbLUm7gCnAe5j59rq9KR97Yfu7LK1Zj/O8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hzo7YVmsvfQ0XdkWwIPhHQaVNnsfgyyHKYed239DIoO9y4FJxJXQdNXpkuzxYR+Y1Q1TgdlP7GivhgCPMtxZFGL/a/Wi9Qndud6UOKQ7nxPW/FuNW9D7ScaI9u0JvzVT+lQuDeT4mi6gvzheV0xrw9G5ptzV1+b0jdUezaR+e+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmurp+eC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C05C4CEF4;
	Thu,  2 Oct 2025 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759424810;
	bh=X/U82S0COSbLUm7gCnAe5j59rq9KR97Yfu7LK1Zj/O8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Cmurp+eCOGzu7Ps7oEVbnOTIO2lU7/4NWrnj8LRBgL4IxISshl9d8jJATN8xSqU/G
	 /32h0hJunmCxrRcw9hs27Mj90ZPAgZGz2astrBLAJj8V/pA/lVu0P2HAsZMehFj/z5
	 o0w4XBRYUDeL/AbcP5wQkypry3o0e5g0ml5yu2m+2DJzwaUDrRfnRhAzDIRnf6Uvql
	 lcNplcfnz9P9vm1N/rHc0RtOFTP6IQeCHNmYeuKS9gN1Bwu0/lCQc37pyIsy/B890D
	 TNFCdKKfrLPBt1DILJ2W9a2Flyhu3t0856cYwWbdQIv7fDcGEkyyYxttOEmpNtXfnC
	 LnEWvkJRrz7Og==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org
In-Reply-To: <20251002073125.32471-1-peter.ujfalusi@linux.intel.com>
References: <20251002073125.32471-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc3-topology: Fix multi-core and static
 pipelines tear down
Message-Id: <175942480895.110990.5274253507852897704.b4-ty@kernel.org>
Date: Thu, 02 Oct 2025 18:06:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Thu, 02 Oct 2025 10:31:25 +0300, Peter Ujfalusi wrote:
> In the case of static pipelines, freeing the widgets in the pipelines
> that were not suspended after freeing the scheduler widgets results in
> errors because the secondary cores are powered off when the scheduler
> widgets are freed. Fix this by tearing down the leftover pipelines before
> powering off the secondary cores.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3-topology: Fix multi-core and static pipelines tear down
      commit: 59abe7bc7e7c70e9066b3e46874d1b7e6a13de14

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


