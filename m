Return-Path: <stable+bounces-95628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4929DAA3A
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 15:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F6FB22A01
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E71F9A9F;
	Wed, 27 Nov 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmc+sYsj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9848CB652
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719555; cv=none; b=ERCqwLWW8lNOW16hIUMJ6WKlN3VAKP8306PhTuCR5c6fVunGWt9/CE/G2KmOWH0reud09j4hlQ0O42c1zxwk5V3G18JoeCiQLqSqJI5QIM5WyA5NlHnKb8XWi4S64utNtKVv0z83BIKLQAQSvJ5WMjStgRIe8sANkVTwKeVt5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719555; c=relaxed/simple;
	bh=ysSOJFJ8Lhyyqj3BWafUVtyKTltSltArjUyAKNtACNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jj5MKPsUOjxYfAhfahRzrGtXlCryyZuKmm+QhXjqo8nphFhqH2QQfavhf2EZXXPxh+DVlNgkwL3q7OixZixtfaTfsiu6oE1IrVgKJCB1esZGFVo2pc1k8SeF4UXIPiR0+JRGirXPhelywFhpWG2xZ129wS12IA7qScDYn0U+3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bmc+sYsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B220C4CECC;
	Wed, 27 Nov 2024 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732719555;
	bh=ysSOJFJ8Lhyyqj3BWafUVtyKTltSltArjUyAKNtACNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Bmc+sYsjZFRehUWH53Gb0ccobYGUq+9tWNAggY0yBVWCZH5u6Zi+0EA5073LmLX4W
	 v90CAYFye4mi5Ejx3fWgKHdWC89bFz15jNp488noLCooq1PxP1kUWJob4c/SjUClrH
	 GLbUnG2tmcTlaeagPKccDOpkeQPprbFdvnd/Boi1Ck1gUcIyYma9tBhcrjdMTjfXVV
	 aAdr7W5X1+cf3rGAVbsTLMXifpfjAYygWbk0EeS3ZstLqoX+CpzclVshvFk4mkdon1
	 sbO25rS1CsOmaZY3mnjtLeRJgu2bhugI4pp24jtEW3Vl436gCqDVnoEweiXPlZoYOj
	 3Fdivy6utHETw==
From: Mark Brown <broonie@kernel.org>
To: Ilya Zverev <ilya@zverev.info>
Cc: stable@vger.kernel.org
In-Reply-To: <20241127134420.14471-1-ilya@zverev.info>
References: <20241127134420.14471-1-ilya@zverev.info>
Subject: Re: [PATCH] ASoC: amd: yc: Add a quirk for microfone on Lenovo
 ThinkPad P14s Gen 5 21MES00B00
Message-Id: <173271955434.493990.5752359110711297055.b4-ty@kernel.org>
Date: Wed, 27 Nov 2024 14:59:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 27 Nov 2024 15:44:20 +0200, Ilya Zverev wrote:
> New ThinkPads need new quirk entries. Ilya has tested this one.
> Laptop product id is 21MES00B00, though the shorthand 21ME works.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add a quirk for microfone on Lenovo ThinkPad P14s Gen 5 21MES00B00
      commit: b682aa788e5f9f1ddacdfbb453e49fd3f4e83721

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


