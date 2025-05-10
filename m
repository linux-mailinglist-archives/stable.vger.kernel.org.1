Return-Path: <stable+bounces-143072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E9FAB20E0
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 03:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE127B55C3
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 01:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C152676C5;
	Sat, 10 May 2025 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoGRaLL8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD491754B;
	Sat, 10 May 2025 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746841787; cv=none; b=SjNHTIKin9vLKU2tTz/hRi9KvOqfem85pIz/rSGjxb7/nFZNBOg8Pjl54HrVclHeDN2W48hfUqev6bu0nZy2Ka5+yCAUoI6QESwdgHJDvDYwK8NGmIGPIwxYJHFnE+aFFkCT1oZwbnA+0XIcEg+N3JqDSTACAXzcRgkCsrs+YqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746841787; c=relaxed/simple;
	bh=Ik6ZOYghUJlSAHRBfjLES7OXj26OGRTV/tgLd6eN058=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n5nOP0MPGi33zUONpk/oVNQ2YM5u/WdT2Xn7/xHZispu/R5YxyoCOgvhYH3KKwDfIjzPTCAH8AJmDyass+pwGN11bcfYrPrYjAfNyKsWsXzu6Ozr/snQGwgz6ZiAEhORMXOmL/yYF4vz31J6UByn5zNcG3g0zYf4q21G0ojOC7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoGRaLL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B36C4CEE4;
	Sat, 10 May 2025 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746841785;
	bh=Ik6ZOYghUJlSAHRBfjLES7OXj26OGRTV/tgLd6eN058=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MoGRaLL8fSLlGu6ujvJjPiA2SI4uviU37OMBa2hOZ5QqFOEUbc1LD2WGpbolIGaMw
	 PRGXWwkEU/XCGSDKMauUNV/YFI3lXUiMuG2QOudioi76I92YrS6M4Qt2hGJiWXVDTo
	 1lGz2PFsIq764BOtNzfboZDUi3Ha/pi4d5v8Yuv8IzfPP29fKkERQPoKWd1icYpJwy
	 Lg6PxA7uyS46ntfpLZ7GtuLCd++IBLKep9Xza+SHrejRidveqMDcMih1bf9hakyK21
	 Z3sYM8KmqGa3mLDwZsGcb7xZdWAbx4quXFh0Bk8KS162FlTuvkBRl3z/WY1quee+8t
	 BdfEu8xHDrCow==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org
In-Reply-To: <20250509085318.13936-1-peter.ujfalusi@linux.intel.com>
References: <20250509085318.13936-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoc: SOF: topology: connect DAI to a single DAI link
Message-Id: <174684178302.47320.17432126730829592282.b4-ty@kernel.org>
Date: Sat, 10 May 2025 10:49:43 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 09 May 2025 11:53:18 +0300, Peter Ujfalusi wrote:
> The partial matching of DAI widget to link names, can cause problems if
> one of the widget names is a substring of another. E.g. with names
> "Foo1" and Foo10", it's not possible to correctly link up "Foo1".
> 
> Modify the logic so that if multiple DAI links match the widget stream
> name, prioritize a full match if one is found.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: SOF: topology: connect DAI to a single DAI link
      commit: 6052f05254b4fe7b16bbd8224779af52fba98b71

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


