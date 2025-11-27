Return-Path: <stable+bounces-197541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B9C903BA
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 22:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1ABF3448D9
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1FE322A1F;
	Thu, 27 Nov 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvPLJmbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60E31ED92;
	Thu, 27 Nov 2025 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279801; cv=none; b=T0+nvQgeJ99+8+KKKXckuBh0s4MLMPNmXMsYCAfzA/WTO4Tj9o7CBDisYVVyLqymhRNuUG6Cplj+ODMXRFuqwwrWo6rMjkxw9GKBg/n1Y5DKxRc9hQDYMyoGt2VEk1kCn+2NxeldgipGHGC5sCfmY926ulda193wx+/UqN0/jpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279801; c=relaxed/simple;
	bh=YHxK3mc0tyRl3Vm9qPKwXMRT4F0/TVtmAZowbs3rSIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=taMRL9GbcXoVgvQ/H2zrd9d3iymKT2OsSb7qQ9kaTjKEcgn/PmDcWVwqmlFg3cmgrnfDV8C2WPmRNPZGnOepGYbCjHmzYECwtre0u8x74BHLehoR67F9v4lI/4mRNNP4Y71npH8OTGud5qz8z2pvTAwPUmPAW0QMxvEtbo2mjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvPLJmbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21338C4CEFB;
	Thu, 27 Nov 2025 21:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764279801;
	bh=YHxK3mc0tyRl3Vm9qPKwXMRT4F0/TVtmAZowbs3rSIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mvPLJmbYyUCwhZyHTsND0v3QGL7GCcA6/zNmSBeqArQpDc6+UVWEsLwnS60nKOYl8
	 ySqSEfhqt2tCjg2UhAi09GCis/MNe6uUsSFhWVvuTiFLSqcLc6DCcBmaPK4cbizRzc
	 Ps6tJXsacuAZw4UOvOL9OAkVAF+ZM9jdXw3ajZLqHhhumP/xvXhm4woudo/Dfz4q03
	 vDTb/+A4ez1oN8DjePB+DQAW+/VhrDBU6BDD+kgxp7q/gAcU4j77zUp6dAk1plsLlx
	 w4JwK1X+xjeFSCm1uwBI7pV+WT++3BpEkr4r3RbZEBG9if0si6x4v0pWQcNsx6gyLb
	 TMxQYkMGVL4oA==
From: Mark Brown <broonie@kernel.org>
To: cy_huang@richtek.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Edward Kim <edward_kim@richtek.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Yoon Dong Min <dm.youn@telechips.com>
In-Reply-To: <8527ae02a72b754d89b7580a5fe7474d6f80f5c3.1764209258.git.cy_huang@richtek.com>
References: <8527ae02a72b754d89b7580a5fe7474d6f80f5c3.1764209258.git.cy_huang@richtek.com>
Subject: Re: [PATCH 1/2] regulator: rtq2208: Correct buck group2 phase
 mapping logic
Message-Id: <176427979987.171723.1183612758277430342.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 21:43:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 27 Nov 2025 10:25:50 +0800, cy_huang@richtek.com wrote:
> Correct buck group2 H and F mapping logic.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rtq2208: Correct buck group2 phase mapping logic
      commit: 45cc214152bc1f6b1cc135532cd7cdbe08716aaf
[2/2] regulator: rtq2208: Correct LDO2 logic judgment bits
      commit: 8684229e19c4185d53d6fb7004d733907c865a91

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


