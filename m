Return-Path: <stable+bounces-108134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D06A07D3D
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557FE7A10E1
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FF2224AE1;
	Thu,  9 Jan 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAvCBxtp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D25221D9F;
	Thu,  9 Jan 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439398; cv=none; b=B8p2Sp7s1jeAJGznJZMJgD/xIDKKCP5LmJwACLbWHOMWOunFs9S/WsfENPpWUFHgBinMgNTVD0paw/UdHJqgHaHdcfF4Uh6FAkFob5i82/82+Butl3Wyc/QaDf+k1swfeOf0ScD8VKG1jsSsUfaSP3twsxKv2scA9ccuMRZgCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439398; c=relaxed/simple;
	bh=IWttuhlwlQnX1EnSOFdjIOs03ZVqS9WprcVW6tKzbqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bpbrpk2w1LR1+9xdw6zD4Lnxgc3/LAOaH6jv4isOiUYmJa0/bmy6qU9L+ZU3C+urW+mLWuKj60UjX0SMedx81p41mGIy5LUoKbt9zYBAAbKOAvl3EGS0tLXwCwUsmd3AIS2b+LDiP6xuyN8KB4HCnrqHZK4q3Ww190o/RJaz+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAvCBxtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BB3C4CED2;
	Thu,  9 Jan 2025 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439398;
	bh=IWttuhlwlQnX1EnSOFdjIOs03ZVqS9WprcVW6tKzbqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QAvCBxtpMEmCV8rfm31Hjt9C8Jv5CA0NcO3Fl7h9SMjoyokYwtwTp0R0yGYYQbfx3
	 Nrb2Iv0MNZm3prceGAO4+BzqaI1Kh10aJqM2XbTA+grAcoWEcmlos9X3Y9B9Ne22VE
	 j0UHhxsemVz7AXJtU4KxX7hFEuYsxxkn1QINhmy2JB4TBGlPtOexugIaLB87MjKdUT
	 qlra4KvQP5Azy20UfM1wZ9I9kK7DOhBnsozsL66ntYk2q9pOXPJWUaA8k/ZuhsrpSD
	 Mnb210XYWdqd85xETumxiWC83aLB7+2fjZML1h9D36NVIbFPJ8tRcUns86OCL2gf8f
	 rs7DTXYSLSCww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B95380A97D;
	Thu,  9 Jan 2025 16:17:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: handle NULL sock pointer in
 l2cap_sock_alloc
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173643941974.1375203.8976214892409778601.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:16:59 +0000
References: <20241217211959.279881-1-pchelkin@ispras.ru>
In-Reply-To: <20241217211959.279881-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: luiz.dentz@gmail.com, kuba@kernel.org, johan.hedberg@gmail.com,
 marcel@holtmann.org, ignat@cloudflare.com, kuniyu@amazon.com,
 edumazet@google.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 netdev@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Dec 2024 00:19:59 +0300 you wrote:
> A NULL sock pointer is passed into l2cap_sock_alloc() when it is called
> from l2cap_sock_new_connection_cb() and the error handling paths should
> also be aware of it.
> 
> Seemingly a more elegant solution would be to swap bt_sock_alloc() and
> l2cap_chan_create() calls since they are not interdependent to that moment
> but then l2cap_chan_create() adds the soon to be deallocated and still
> dummy-initialized channel to the global list accessible by many L2CAP
> paths. The channel would be removed from the list in short period of time
> but be a bit more straight-forward here and just check for NULL instead of
> changing the order of function calls.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
    https://git.kernel.org/bluetooth/bluetooth-next/c/a5d2ee08adc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



