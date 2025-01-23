Return-Path: <stable+bounces-110274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45FA1A4B5
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D293188C099
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8185920F087;
	Thu, 23 Jan 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gawXx626"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AE2F3B;
	Thu, 23 Jan 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737637956; cv=none; b=nVL2C+eTRRXZ+91QsCOxQS6D3DcKvYIpjdA4Rht4pVT5FXyF6DjipfNAFUgn6kQ8dvv8CQ42lgDRoplOf+6EXUxYnZWofSYEMyDjoJujX6jwOHF5jDD474lVGSTaN3XnHeKYnnlKl+onbj++pjbsVFFFFDjccDc5kvjuthESXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737637956; c=relaxed/simple;
	bh=edKXsLhx0dhFASUPDNMk4gjPbyfbfJBAyhTL57gxeyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nI4sDfWCuXrLF/HySNxAVfplL8LCTTTGrcyfQkbQl5WumfaEEOM1fLe8uzx6KPjTn8TmBdxAili619yfzWI3B131H7725tIVo55eYJDfy5+p2hWU+QlHbypNExqcuzk+Rifb0kBM6x3iA9Gn+A7V+7Lj3/QKu3t1QfvtJwcSjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gawXx626; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE36CC4CEDD;
	Thu, 23 Jan 2025 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737637955;
	bh=edKXsLhx0dhFASUPDNMk4gjPbyfbfJBAyhTL57gxeyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gawXx626mmIA/CMbSoD+p1MYmPUNDQ2XuRiPy167dnkXw66qEnzVkaZfR3n1nvg12
	 P9fAuEDWjCnO4ZTAlaVEBS6/nXF+xDORerB58Pzh1IRjPSCRl0XR+5BWq6yE5X/YmU
	 jOunJccecdroFdQ3U8d9qFr+spNsFXldh3iVhF6ns8N6AE7/B9pg9vWOzGuFu3OaSo
	 9I8CB/q9cBuZrXsxWrJkP11VLVFAo9DXweN/+FORACvCHuEcT8WqwbhlXgo4/BX/Rz
	 346vP5diZKU+b6Q2cz3i/LjuXkjs8ITbndj90ri3be5fnSPelFaWqiQT9nf7xRW4se
	 /7Y4drexa9kGA==
From: Mark Brown <broonie@kernel.org>
To: mario.limonciello@amd.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Mario Limonciello <superm1@kernel.org>
Cc: nijs1@lenovo.com, pgriffais@valvesoftware.com, 
 mpearson-lenovo@squebb.ca, stable@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20250123024915.2457115-1-superm1@kernel.org>
References: <20250123024915.2457115-1-superm1@kernel.org>
Subject: Re: [PATCH] ASoC: acp: Support microphone from Lenovo Go S
Message-Id: <173763795340.45842.5572738309580367598.b4-ty@kernel.org>
Date: Thu, 23 Jan 2025 13:12:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 22 Jan 2025 20:49:13 -0600, Mario Limonciello wrote:
> On Lenovo Go S there is a DMIC connected to the ACP but the firmware
> has no `AcpDmicConnected` ACPI _DSD.
> 
> Add a DMI entry for all possible Lenovo Go S SKUs to enable DMIC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: acp: Support microphone from Lenovo Go S
      commit: b9a8ea185f3f8024619b2e74b74375493c87df8c

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


