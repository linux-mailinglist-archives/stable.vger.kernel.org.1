Return-Path: <stable+bounces-114113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BAA2ABDD
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734681888CAE
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61CB13BADF;
	Thu,  6 Feb 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee6G8+uK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6AB23644D;
	Thu,  6 Feb 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738853494; cv=none; b=Cg74db9AkPrxSCjcm7qiQnqltYaIpbMuOCkmvXZcmgfh1k8FU5XvMhIWbGViQglnn573Au/I4sFuTlvWhBmVfst+HpRTLCj/X1ABLHUfhf3XDjbkUWmfraiLI+lMNwZpa7tPb+gH5F+/fCPUwR5/aiKfYLqNTIrcNrO5xbN+iKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738853494; c=relaxed/simple;
	bh=KdAqLrL8VyzvJH4jbtVBy5CNpC8N2F2KSvfmYkKIW9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XAgTC3vUMMIFfiT4H9/Frd4OHpbKfRjyCnbSuk3bicWqI38eyp2YfhkwtwIAGAJaP+4k99SG7U8oYh1xyU47ETTI3hXu+IZIdxcLUVJmdbkAZ6Zeb7ZG/wkigYAHCCzXycyA45Kk/n4A0J2WmtQ4B31o62sqX2ZiM1rIs8Dyvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee6G8+uK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA24C4CEDD;
	Thu,  6 Feb 2025 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738853494;
	bh=KdAqLrL8VyzvJH4jbtVBy5CNpC8N2F2KSvfmYkKIW9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ee6G8+uKzcGlkaRSY9Sc6zJLliyGDsK8o/FzDfkx0pHU1v6IFoMTvi5dBUYFA9xyH
	 hU/JXmdK6KLeWiQ3NaLSayyp8OGm/q0fgsh9l3NqfU/SoA7Hxi1R6d3u8SytpG7Hwr
	 olQgYX7lAo+zT915NiHHBQumjHRfEbBj8zVVd4OT9+QMJ7DTkc0E+6U7pMt3cUaJFL
	 Txxv+Frei8XEB9cyRU6fESwqvNbClW9BT94sGU6+nUfi9TZMzZ6SPDDq+1WzxWk4CH
	 wTkHc/aozStqcu1cOiNQwo2Ah0pKCxonxsKIM9Z22UIsXcnLbF1JPVByS9jDHnRm6P
	 XCLuAt85q8CFw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org, 
 liam.r.girdwood@intel.com
In-Reply-To: <20241213100146.19224-1-peter.ujfalusi@linux.intel.com>
References: <20241213100146.19224-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: Harden loops for looking up
 ALH copiers
Message-Id: <173885349204.198179.18006741194772257857.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 14:51:32 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 13 Dec 2024 12:01:46 +0200, Peter Ujfalusi wrote:
> Other, non DAI copier widgets could have the same stream name (sname) as
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


