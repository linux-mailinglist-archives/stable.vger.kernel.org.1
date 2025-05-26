Return-Path: <stable+bounces-146386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1FAAC4313
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 18:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C815716F9EB
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B32A23D2B0;
	Mon, 26 May 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt3qgdO0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCA202997;
	Mon, 26 May 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748277174; cv=none; b=LOcaoXH3rXDpVnsQeURRIVtTDl+1813s5v6MERTF5wIJX8C7qsNp7az93oMbivm2DKgtfj6m+HsvXGRhzj0Bs+MbJK8vN08DyiDlvr1iFcw39FqxQk9w/DvLwFKfTzkIXla9Bnl9xQRlaE4UvOuW840cpZFXMmDfufq5rBwor2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748277174; c=relaxed/simple;
	bh=u4sjxsvv5Ac2EkBAFE0Tr1FNNPm3T67xccnugKIq/rA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qMgyEiGDCDcCVxn3OpeQVN7nbotqlpr73sFPizQ4BVWX+Dd3wTZBD2MrsXM7u+Af84RNMIgmHRyOMTc8oBaHv9HtGx9q5ycTFuCjW6oQemyH1xc/JFb9yR6DxjaL0CZ+11ue0DhSaHfqOnpCbPeMj6TS1HXvzJyPBeBjaP1APCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt3qgdO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB402C4CEE9;
	Mon, 26 May 2025 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748277173;
	bh=u4sjxsvv5Ac2EkBAFE0Tr1FNNPm3T67xccnugKIq/rA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rt3qgdO0pGKmcY4FJMOF2gFGS2KGenfAox4vf07unir79TndQUYMSwku8zwDHELY6
	 9xt8NfDdLqBjyl6rTM0tkKIXvjCoIrmA2/fZcIRSKxrwGYsJiGmY1NAJNFFsxt9UEW
	 hWzAxY3a8SKquX8agtiVOTpAXF+aqfkbcdLXW+MMFVgVAPvNArwTK9YNXSoLYSp9fG
	 6nvhJ+lMou3Yhjj67Ru86fovIVK8X2nSP664uinZKuDA+DFzm6K7sBIPmqfhhJa3Ot
	 LtCD3oDl7BsEMlkE3jhVGAsEyWhL+OP3nQz3oO1KdRV6JPcfarrli9A7QlLq5s2ASz
	 l+Rrv7rbZicig==
From: Mark Brown <broonie@kernel.org>
To: Linux Sound ML <linux-sound@vger.kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: Simon Trimmer <simont@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 patches@opensource.cirrus.com, stable@vger.kernel.org
In-Reply-To: <20250523155814.1256762-1-perex@perex.cz>
References: <20250523155814.1256762-1-perex@perex.cz>
Subject: Re: [PATCH] firmware: cs_dsp: Fix OOB memory read access in KUnit
 test (wmfw info)
Message-Id: <174827717150.619234.9558259639370763527.b4-ty@kernel.org>
Date: Mon, 26 May 2025 17:32:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 23 May 2025 17:58:14 +0200, Jaroslav Kysela wrote:
> KASAN reported out of bounds access - cs_dsp_mock_wmfw_add_info(),
> because the source string length was rounded up to the allocation size.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Fix OOB memory read access in KUnit test (wmfw info)
      commit: d979b783d61f7f1f95664031b71a33afc74627b2

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


