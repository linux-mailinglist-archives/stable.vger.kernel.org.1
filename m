Return-Path: <stable+bounces-158631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA5AE8FBB
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 22:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4C73BE64A
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4680C210F59;
	Wed, 25 Jun 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpP9Xsbh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B981F4297;
	Wed, 25 Jun 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750885180; cv=none; b=aqvQsdFvM79r92o0oP7Wq0qeqE6n8IyRijxxGd+Mdbg/2mTFVHbTchRkw8xNshiaDiXTcMF1K+jvmVQfwmYDtJomqDpU7wyynSWmq0HSv8kTSEr60NAxwxZT9WwDPYapPtIIhssf4vm2N7KwDndAOaaUBgT9iT5opUotcE8HzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750885180; c=relaxed/simple;
	bh=Rvcc4lTctp09M9xQwfdOzq30dweR+tr4oerHDDndRyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pZSROpNQfoghI/h0zbYzJVtYjNNw6GKaQLhrlJ8mFpTW2dsYXEKy/xaW3lTffqm4ux2SwskI3RFGeeO0qjrvCR5SlzPbny+zNk+UXPTtI7krjj0ojm4T1+tDTewn9q4cM2T8n4OiS3lfqRWh7lRNK6cZ/IWD2Vo7bYXh/lPYr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpP9Xsbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0ACC4CEEA;
	Wed, 25 Jun 2025 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750885179;
	bh=Rvcc4lTctp09M9xQwfdOzq30dweR+tr4oerHDDndRyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KpP9XsbhrXQh27NcbG2R4YtDnyZk5UWtVVNHLGvMnCMQX8OgmqmarwFO1b3XulvpD
	 8mRT0ldhCr0jpHefOkX1YTl6b1VXrFMx9gmzpHMPPgB3J7Vh6FcvSDu4+bjdBPtyVL
	 r7znAuGsNRnwLSV960ZlsMNkBkB5+4CnpjeXoyGpmp++aIdbht3sIqyE6tipIOyZMy
	 UGr68lXtUQ83ItIT+bfL3B9mfM8TL+IsgyoJY1fqFNHq0Tgbcn3xO7Rp3nsp3U8we9
	 OlVDxWIwltUVVk1hlLh+hCiktjie6fgISOlMe0MKtANwR8i0ytFZ5ABJ63WsqwBu5T
	 omeZR/3O5LG/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E583A40FCB;
	Wed, 25 Jun 2025 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] Bluetooth: hci_sync: revert some mesh modifications
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175088520600.619994.15667708350334111089.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 21:00:06 +0000
References: <20250625130931.19064-1-ceggers@arri.de>
In-Reply-To: <20250625130931.19064-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 brian.gix@intel.com, inga.stotland@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 25 Jun 2025 15:09:29 +0200 you wrote:
> This reverts minor parts of the changes made in commit b338d91703fa
> ("Bluetooth: Implement support for Mesh"). It looks like these changes
> were only made for development purposes but shouldn't have been part of
> the commit.
> 
> Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: hci_sync: revert some mesh modifications
    https://git.kernel.org/bluetooth/bluetooth-next/c/1984453983fd
  - [2/3] Bluetooth: MGMT: set_mesh: update LE scan interval and window
    https://git.kernel.org/bluetooth/bluetooth-next/c/41d630621be1
  - [3/3] Bluetooth: MGMT: mesh_send: check instances prior disabling advertising
    https://git.kernel.org/bluetooth/bluetooth-next/c/8dcd9b294572

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



