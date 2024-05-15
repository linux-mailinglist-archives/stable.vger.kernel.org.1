Return-Path: <stable+bounces-45232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43E28C6D0A
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B34B282630
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728C15B0E1;
	Wed, 15 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fv69uZCb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DBC15ADA0;
	Wed, 15 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715803230; cv=none; b=kLf4eqJFMzX1Lj1c6mHXdquMYoRpJvdnslKQ3mpOY+jyHLQt4hJaDrdd2/epdVE6/2XM3X5Q8XXnEb0wea4RBFDifR4nQR6lW9v5hjBb7UpSO4wa9BaOIS9qMu68uYqlKPUJZrl7JlwWQA5kXuocoL/TJhIF981cAUMAom/erac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715803230; c=relaxed/simple;
	bh=dSHISZAMSeuQo9ROse5BQNkX8tjfYGhjBhfmiIfadq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=seE1t/fHIPqrw7Ff/CUhZlZw/5qbjrPUFdMuq82uT7ywdGJHdyVek2Xwpbi1rrpOVIMjhy7z74yKBXH4GnctVu3luP0Q9qvAoZjwNQlceuFXOWEljT/yBkfFsePI5t6/pdx3rJ2mR6oGMntzc5EsRNvGab/mUVyuMR1hZYD4Gqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fv69uZCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2CE4C2BD11;
	Wed, 15 May 2024 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715803229;
	bh=dSHISZAMSeuQo9ROse5BQNkX8tjfYGhjBhfmiIfadq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fv69uZCbNqLkwjYg3VMHoDAAnmxbvJMu3IPWFXSJJjTiBxIy46wQ5RqRR+HaGhQFS
	 iSmkE3/WTDL2CXhYdv4OHHuO0Kx1D26Vo0slKBFjFo9OO44LmstOY+VXWZV5oa9RlE
	 ebQ+84ZTEg/w+UiCuuuYCD1ITDYW453cg78I4csrmc2my1zo+ehcO2pZGZ+HHSBnb8
	 o+RSf0rWnTAVURyKsMqGq+TmaV3M1LFMSDios16Y+g414g5FD9wFfRTSvLszSyIqF3
	 p4NgXILWIGqSOV5HD4GFRtd6HQqkE/N1IPAokhRO1xn87uZ1+0VKNye7NiOFNoiPy0
	 Ri/2t+FPVs7bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF866CF21E3;
	Wed, 15 May 2024 20:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Bluetooth: hci_bcm4377 fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171580322978.27792.17065372036162836418.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 20:00:29 +0000
References: <20240515-btfix-msgid-v2-0-bb06b9ecb6d1@svenpeter.dev>
In-Reply-To: <20240515-btfix-msgid-v2-0-bb06b9ecb6d1@svenpeter.dev>
To: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Cc: marcan@marcan.st, alyssa@rosenzweig.io, marcel@holtmann.org,
 luiz.dentz@gmail.com, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, sven@svenpeter.dev, stable@vger.kernel.org,
 neal@gompa.dev

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 May 2024 18:15:01 +0000 you wrote:
> Hi,
> 
> There are just two minor fixes from Hector that we've been carrying downstream
> for a while now. One increases the timeout while waiting for the firmware to
> boot which is optional for the controller already supported upstream but
> required for a newer 4388 board for which we'll also submit support soon.
> It also fixes the units for the timeouts which is why I've already included it
> here. The other one fixes a call to bitmap_release_region where we only wanted
> to release a single bit but are actually releasing much more.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: hci_bcm4377: Use correct unit for timeouts
    https://git.kernel.org/bluetooth/bluetooth-next/c/9ee7beea5921
  - [v2,2/3] Bluetooth: hci_bcm4377: Increase boot timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/710a05bcfd4a
  - [v2,3/3] Bluetooth: hci_bcm4377: Fix msgid release
    https://git.kernel.org/bluetooth/bluetooth-next/c/bb0e96ccc834

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



