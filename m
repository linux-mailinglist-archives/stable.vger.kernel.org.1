Return-Path: <stable+bounces-71509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1019964944
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A6F1C21D7B
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096031B1414;
	Thu, 29 Aug 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOeCnxkG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0719306A;
	Thu, 29 Aug 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943414; cv=none; b=X4FbD4SqI0XvtkmDcOMCXeMUa/pJWHE2FlWkJnUXjaWPtzh6PuFuwhgFHln7s4fs4DHqE+IKG0uNOISyTN+UR0g37zCsjjaIeGZnVg1mjBN1kYMvbZOkZWrGad/i03anMkXklAo1dHfde0EKDqI9rs8w1cVKwlivEcazpvO4H0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943414; c=relaxed/simple;
	bh=4wBft1Lldp10vZLlsit+WEGCSpztxtru1Fep2zmzw0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WFg+QqcXsxQ7sgt1MvesVBo59+tu2bi67FsYFmZp+9Ysrmfv/hdPnNq/8EmyYGR1Uu3kgZA3chyiO9uCTK7Rc7IbABB2GDFCBqEIYWnRI4UeugC6Ue4ZoJLNJCahvNq9x3Zh7EaAhWinMQg7WZHgJVYBpPaHh+X4orH8DVZHWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOeCnxkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17CBC4CEC1;
	Thu, 29 Aug 2024 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724943414;
	bh=4wBft1Lldp10vZLlsit+WEGCSpztxtru1Fep2zmzw0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kOeCnxkGVN2R4DNA534Huc1PpC5FcrK72517XYBbrL3hHxeFGWbknZbVCd3PgJi4D
	 KmayVh0df8111J4Z7jn5wgZVqplG6Y1EoWSbL4hsHYov5OzpmoawyO+BtQYQSEFrYy
	 3gMWg9cyUeCveswZ/1Ozt4j2vV3ubo0vCVlth/t+CmBQuyyzk40JcZBZ+l4/wXMN4i
	 ASSuv+i2KI+sZmN/9kfl4qNDsErKcAmq2WzOWGQE3FLnVIvK4KTkpXm16pRFARjR0M
	 0WGgMey5M1SAQy8KQgbad7Sp9Mb05VLJ2I7+ayWuAUs+U+lHixFiX0YXDOrp/uHJOh
	 3NaCe/a73dz3Q==
From: Mark Brown <broonie@kernel.org>
To: Markuss Broks <markuss.broks@gmail.com>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20240829130313.338508-1-markuss.broks@gmail.com>
References: <20240829130313.338508-1-markuss.broks@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)
Message-Id: <172494341364.333436.14919734395100570336.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 15:56:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 29 Aug 2024 16:03:05 +0300, Markuss Broks wrote:
> MSI Bravo 17 (D7VEK), like other laptops from the family,
> has broken ACPI tables and needs a quirk for internal mic
> to work.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)
      commit: 283844c35529300c8e10f7a263e35e3c5d3580ac

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


