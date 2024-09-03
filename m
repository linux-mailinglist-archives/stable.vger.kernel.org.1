Return-Path: <stable+bounces-72950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C14396AC84
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 00:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B29B1C24874
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B51D58B9;
	Tue,  3 Sep 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu9SHuti"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA31EC01E;
	Tue,  3 Sep 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403833; cv=none; b=qkB2UBk7+1DPum46EXFrwEAnfOeVAli9kh6yZ2AZHVUzXTt9LjGpS+g65pw6G18AR+YOl6cfl/CpPB4J/upieuSE3Tyb8/hHYhAKWel13Yqm80esPlMeAOIs+mBnGlZqtkTp8LpRQ4Yi6fgYmlJUlQaGZTA/yMlTsO52ENEvjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403833; c=relaxed/simple;
	bh=RcOqOyINwBOfmat/yy5LLDQvXssphajynGmHZN35k5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nah5y8oqyuDCDFlSAU5H6+RWNLeQB+xi4f9cC5vC+YhesOXrAiJgDgygBqr6814Ppkq+0PO4LE2GAyFWt5ibIJ6EyvbANIxdJP9oAv3TsJOZHg0T2nxGHfnf9DUcDn0pwBZtg0Fig6569RlHvA7RHhfV/ejw7C15ddV7eOr2BT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu9SHuti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D5FC4CEC5;
	Tue,  3 Sep 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725403831;
	bh=RcOqOyINwBOfmat/yy5LLDQvXssphajynGmHZN35k5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pu9SHuti6kQYDUwCi5M7kDEKI4vvFISgOcTrU4qw1fKl7QMy1CK6S6wDn/j5D0opW
	 43FRPvWIjKyyfh7lS637AjRAesFAf4quZxbUh0uqmKoXmA6bcu7JYJSfyNcqITflQg
	 J4Yo67x2rWLHF4Uy6zrUVxeOdTSN8aSMertkTgCg2dTI17bK/Oae6gGi4hhcFgARR9
	 bf1rmvPw3s411K+njF2GeOAAMIvTI1RIGdbDnrRhJN8ROHr5Eh65Y+uGFcFDsFSX3H
	 ADqwvqfZxGChwiQhdJjBMZbs59V1b12mFHbRdbZ3cgnqjDjuubgMAdEimzWr33bU4z
	 lbPnsvMCfnrrQ==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, derek.fang@realtek.com, Ma Ke <make24@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240830143154.3448004-1-make24@iscas.ac.cn>
References: <20240830143154.3448004-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: rt5682: Return devm_of_clk_add_hw_provider to
 transfer the error
Message-Id: <172540382935.163502.3517411145931559366.b4-ty@kernel.org>
Date: Tue, 03 Sep 2024 23:50:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 30 Aug 2024 22:31:54 +0800, Ma Ke wrote:
> Return devm_of_clk_add_hw_provider() in order to transfer the error, if it
> fails due to resource allocation failure or device tree clock provider
> registration failure.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error
      commit: fcca6d05ef49d5650514ea1dcfd12e4ae3ff2be6

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


