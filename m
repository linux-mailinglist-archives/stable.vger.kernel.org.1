Return-Path: <stable+bounces-47654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B19FB8D3D39
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EFCAB23B3C
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5361836ED;
	Wed, 29 May 2024 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXG/W3up"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DF181BB4;
	Wed, 29 May 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002687; cv=none; b=ZMCrJbggsocdkGgTdlRh7ChPnsU75Qyp4TwT5gAjvnDSnOA/SIat/53LKJUoCKt36OGRKJZ4HyN9346MG8EH42/tHbEQzltRo+mItNZvCBnG+CRZbxRafW3n9ebxIjaMq2LleQ6heU+QuMNuirG8P+FMlQniNTa839vNGzMnBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002687; c=relaxed/simple;
	bh=7isaBuAxV7kUjazVZawbQgNd83XiAdfBiq+YrhTcl04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UoPvAwD2QksZi36mTHgYSGhgoO3/1iG242p2lCOE0OiU1O267FVfhEUdBT+XEbNmzHLS6YATXSvG7C+2lQ9GmTIabnuBpHXtpOjngOM/BPwJFjJUeSXh0j9ZDDtnchhWaGX4ZoldeKHjR99+80XaKewTwbRoEHjo/G4cRwz0eMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXG/W3up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23189C116B1;
	Wed, 29 May 2024 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717002686;
	bh=7isaBuAxV7kUjazVZawbQgNd83XiAdfBiq+YrhTcl04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oXG/W3uphnUzJR/npNKI/KFM+PcE3KPW0fg0mxJiEnyXOC/41Hs6cdyy0ueyGdvSB
	 qb+UfQQ+FFthCmEhaxHVUc5rG8a0eKATTTslDvl3nZD964n81/IpsFu/n/lucgP3j7
	 qgn/0TM2PhUSBXoksqg8pSqK4pIIo4kgFsqaXJiCyxIKMpLS1EYstWwFGTm+Il7ajd
	 jr/vogHgoFdYzpMrTuQfUFGQBIBcwcpVI2lAkgv8aWInuFZhautaD1A15g/99xN5cM
	 JD/cNvl8i2KGUgTVaK7gSIxnR4wSnAyFV+AsopP2jt/cVWO6rNgp8dnR4Z6G9NXvHG
	 gDEI5N5MHWh2A==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, pierre-louis.bossart@linux.intel.com, 
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 stable@vger.kernel.org, seppo.ingalsuo@linux.intel.com
In-Reply-To: <20240529121201.14687-1-peter.ujfalusi@linux.intel.com>
References: <20240529121201.14687-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 6.10] ASoC: SOF: ipc4-topology: Fix input format query
 of process modules without base extension
Message-Id: <171700268486.145451.15009563711946814816.b4-ty@kernel.org>
Date: Wed, 29 May 2024 18:11:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-2ee9f

On Wed, 29 May 2024 15:12:01 +0300, Peter Ujfalusi wrote:
> If a process module does not have base config extension then the same
> format applies to all of it's inputs and the process->base_config_ext is
> NULL, causing NULL dereference when specifically crafted topology and
> sequences used.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Fix input format query of process modules without base extension
      commit: ffa077b2f6ad124ec3d23fbddc5e4b0ff2647af8

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


