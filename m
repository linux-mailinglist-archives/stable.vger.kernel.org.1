Return-Path: <stable+bounces-136967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E42A9FBF5
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE2C462930
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3138B20E02A;
	Mon, 28 Apr 2025 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCpHiBKH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70DA2045B6;
	Mon, 28 Apr 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874591; cv=none; b=irkX7V10+F2YSYV/chAUmmHb3xdIJvTZLfbpjn0R/sJqkW4fv1HvOoGRXHwXwbjyCTkinBrBeBOyd5NlUrBCKzE2sbUXaQONBJQrA94i743/cYeN1WyUFq7qIQsZQlu8Xzxz3kd6JCqaj2ViBTXZAkFkzDZRcQWYVVCDrUzAH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874591; c=relaxed/simple;
	bh=yiy36mdroK5BS5MpYHLsiy5kqJl0jHvbs321Hw46EYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mvvIWxOJmGsg4n4kWwpS2fPVPiw3VTBqRBPLSyn2o6mJ7piwmBFPH08BMDUvyfHGwoSyGLZL3f7FSqmP+8xXSDqJZ8iVe14g95uP1EUJjuDfELl3FYpvVF8r6U2ri3TbCkGnIiaFiq13m6UZIKxG+Gv6VtC24mA+l6+ykvZzWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCpHiBKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555C3C4CEE4;
	Mon, 28 Apr 2025 21:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745874590;
	bh=yiy36mdroK5BS5MpYHLsiy5kqJl0jHvbs321Hw46EYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NCpHiBKHe4ep3sKARmZOOVTPzUkUpxkz+MoRHWObqy08USusQdR8rhbEGBvjO3Fr4
	 tyE9lB70Sq5esRhSjLj9x7j20jdMhfQvZzpRklrVMb6AOCe/Z8OzLYGcRBf0i8TA4y
	 vphwf3gOy/U9jP1KuhSOaE3NjSSaXj7Hh3YRLq+a9vtFIYOgXBEUOYxhA5uULtBxxd
	 6gy1Mudkp7cZcIZ7hawCDoN32/vt2SIoBUGknjtHZI9b8h33dkoMCayudGfwM6UxjV
	 /lGUmlYLRFTmR67teaRd3rzRjF1w1/4ybqUSHcvWA6+mZ463omxiXgDXJQbmFUwKFw
	 1fy0M5yYrcGsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7104F3822D43;
	Mon, 28 Apr 2025 21:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V3] amd-xgbe: Fix to ensure dependent features are toggled
 with RX checksum offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174587462925.1046038.17969411556581338898.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 21:10:29 +0000
References: <20250424130248.428865-1-Vishal.Badole@amd.com>
In-Reply-To: <20250424130248.428865-1-Vishal.Badole@amd.com>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Thomas.Lendacky@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vishal.badole@amd.com, Raju.Rangoju@amd.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 18:32:48 +0530 you wrote:
> According to the XGMAC specification, enabling features such as Layer 3
> and Layer 4 Packet Filtering, Split Header and Virtualized Network support
> automatically selects the IPC Full Checksum Offload Engine on the receive
> side.
> 
> When RX checksum offload is disabled, these dependent features must also
> be disabled to prevent abnormal behavior caused by mismatched feature
> dependencies.
> 
> [...]

Here is the summary with links:
  - [net,V3] amd-xgbe: Fix to ensure dependent features are toggled with RX checksum offload
    https://git.kernel.org/netdev/net/c/f04dd30f1bef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



