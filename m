Return-Path: <stable+bounces-96031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127D79E02F1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626F21614FF
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D24E201277;
	Mon,  2 Dec 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5Yj3Ksk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECF1FDE05;
	Mon,  2 Dec 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145042; cv=none; b=eZCUpglPyIg5wEzocudWoRNsu97RJJfEgeZxMG2eE1+6GfBzfSFRN7aZSa4HwjCRyoQ1y5TEeY+mfBYUDGaNBr/EegQl0TkfO0glZVoJvrl+iUYN4ib0IojCbvxc0idXoEKrn9otSi3edZ1pJIWOn1qguKb/JrLz6QnKH1hBTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145042; c=relaxed/simple;
	bh=HO4UUheOfZr/hJj7JF7ERpOZcPHzNpDSc4ckUhHJH4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p590FFn9GUmddivR+HHETblzL/GK3W+n9X+rSXcnE2Eqp5BXZR/mKSQ8U2CXpsUZHd/TfMilgudgj1qP2R4cgtw6z9XHcd6uq8huZ1da5PgRFiK32MwTANXOiNMkea/+tCoST+wuSSMA54INpVN0Em5+q5Oj+iLLLdghvYsX5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5Yj3Ksk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7919FC4CED2;
	Mon,  2 Dec 2024 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145040;
	bh=HO4UUheOfZr/hJj7JF7ERpOZcPHzNpDSc4ckUhHJH4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E5Yj3KskMWrA7Vb4iackjEGceMQM3OGRbHQI6Ax6Sz7BfIsCEI43Ds0iKeITuCtNu
	 A6/NqqhOkr7TQwNRkFpBmAyDaf5EaWDoLE9HXkZcoDRCH0Tven+AB8y97GI6/07cmh
	 0Lq6MPyatPVxqFWlnQKrIu+eGHOB0hnZrWJfOUaCHPcqaYBvbiiVxrBoLkxd5IDCE/
	 wg1GTztHk700EomzXBV9sBGPl03cO3OxIUzYIONIJuyvg6OeHY8urIkN66tLVyRjOp
	 szKwIqoTXFxdqXBY5Lr2aD/OMM7GhZwTh/yRyVTTZUUMeRV/bfn811I5XslMeo+JxS
	 fO4cW3/tyg/Rg==
From: Mark Brown <broonie@kernel.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241128130554.362486-1-demonsingur@gmail.com>
References: <20241128130554.362486-1-demonsingur@gmail.com>
Subject: Re: [PATCH v3] regmap: detach regmap from dev on regmap_exit
Message-Id: <173314503922.36876.15664394255799919221.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:10:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 28 Nov 2024 15:05:50 +0200, Cosmin Tanislav wrote:
> At the end of __regmap_init(), if dev is not NULL, regmap_attach_dev()
> is called, which adds a devres reference to the regmap, to be able to
> retrieve a dev's regmap by name using dev_get_regmap().
> 
> When calling regmap_exit, the opposite does not happen, and the
> reference is kept until the dev is detached.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: detach regmap from dev on regmap_exit
      commit: 3061e170381af96d1e66799d34264e6414d428a7

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


