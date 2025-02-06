Return-Path: <stable+bounces-114114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDFA2ABE0
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B351889118
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC11A3174;
	Thu,  6 Feb 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGpCWjHQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC313BADF;
	Thu,  6 Feb 2025 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738853503; cv=none; b=KMTRfPuCdiQZZ8sk3dijRoaB49XENVpnzVq1oL3l7fh1etmLLbnGdgkIX5epcu0OQ/oyNqrkoFSkY7pzwS5frLKtUbF2+eXMNB4J8fniP630u+u8Uuepduq92ArL4HxIIx+nzmPxotiGMVtL5qB7/XW2BODIM10kVgKNqXYGpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738853503; c=relaxed/simple;
	bh=eb+DylOLahZxYsO0Q4BoztK0cUe7UNKEAW19zwfFf4U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=brW22HHyGbSEus8TIi0QPq8tZimTPDiezq9tP3W1R/T1U8S4TMo9JTPbZwx18o3o9sljr0djVMIPqsDrrjleYV5UXAESfOzXl/wbqPr+utkoW9QTh1UO7oUR4YFdG/rGFN31cfTXMSJggTsTKRxgGMWeklX0eJLFqfkeXEJxWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGpCWjHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62748C4CEDF;
	Thu,  6 Feb 2025 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738853503;
	bh=eb+DylOLahZxYsO0Q4BoztK0cUe7UNKEAW19zwfFf4U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mGpCWjHQ8eP8xCMD9Zz1qsYVNeTDS2VykhsXvOb9Da0Yu0LzLaRe8ojzEJuA/Zapt
	 IOJ2vif4t7I8IavJpWOKsI+SwxC+C+68s5Eoal31XcG9hITgH+JhD99FjPtrlD8Pug
	 XbzMMJXjv4/4BAfOMMQq8l9rKOsDSFc68p7XkmVDQX3kebFQc55of4N2CQDHDxU7FT
	 wNej5R+CXYs3TB+gdpUOIutgFeTAdxBaViWVZsSsLKhjSC2SwdfbZRbZlc+iAZlrVh
	 jIghZPSqOHeRTPddmQ5czIa68Pb9HZDX/hvDX3Qm4AMfWGT3/KShLPop/LMkzCsLQc
	 0U1u6FufLVNcg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org, 
 liam.r.girdwood@intel.com
In-Reply-To: <20250206084642.14988-1-peter.ujfalusi@linux.intel.com>
References: <20250206084642.14988-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: SOF: ipc4-topology: Harden loops for looking
 up ALH copiers
Message-Id: <173885350012.198179.10972002395330940159.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 14:51:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 06 Feb 2025 10:46:42 +0200, Peter Ujfalusi wrote:
> Other, non DAI copier widgets could have the same  stream name (sname) as
> the ALH copier and in that case the copier->data is NULL, no alh_data is
> attached, which could lead to NULL pointer dereference.
> We could check for this NULL pointer in sof_ipc4_prepare_copier_module()
> and avoid the crash, but a similar loop in sof_ipc4_widget_setup_comp_dai()
> will miscalculate the ALH device count, causing broken audio.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers
      commit: 6fd60136d256b3b948333ebdb3835f41a95ab7ef

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


