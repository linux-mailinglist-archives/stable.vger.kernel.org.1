Return-Path: <stable+bounces-126933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E4AA74BE5
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 15:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793291B63A34
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9E21ADC5;
	Fri, 28 Mar 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyNuM56o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7221B9DC;
	Fri, 28 Mar 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169801; cv=none; b=dGPW13DU+XSBsjDHjy6m/0bDJcbxWdWc1n0kB3yNuWh8HZ9FSOGs2WfmVQ9tqrDlSw1Y4SrjDaB9tRo8RV0UXDdrxokAqpdhJ5P/IaE8Ifz7c1MSXZnBsK9Y1L3q3c2SHgAS9/LjXDOWMzDYxc6oTi1GFIyEm89P45ATb/ruuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169801; c=relaxed/simple;
	bh=bytdEJsWxc2MzGpyA8pJAcQkpLhKdSKhNixsc65l/QE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AcVSaG513FIgq1FXxMNViYslf3dAkzHsqUohy/vekvhbIqH7AtL9A6h/ZJmKC7rAPwWeko+dHvb/xkrL1XxWP+BVt9iAYKic+8kpEdZITzdbPJS0xFJNhDAsjC+LANhpoQXTPycDUhAdFNOECc3ye61Oizs5cBYr3cjXKsGkfT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyNuM56o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A88AC4CEF0;
	Fri, 28 Mar 2025 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743169801;
	bh=bytdEJsWxc2MzGpyA8pJAcQkpLhKdSKhNixsc65l/QE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KyNuM56oJ6cqMaMVEBrdBtW0my/amCPBhvYy/z6QYF2fp4b+iNuVSTurOEqTzFGLi
	 8Ox6Z8Xj3prDaQEkf9K29s7+kE22oS41X/mQG2i6tE9GL2HsFle7G/yQxSwSQIAFGG
	 8r+0YYmPMcwcJVbaFrjB7bFiLIS3C0pN4VIvWI1d516DjtgSY1Whc83j+iQm1YzFyw
	 eEER0O0zQrh4IVZtmBYn50lRynTT9vTIYhR+djaezzH3wL+sj5IqjA5Y+hWsy5dsH/
	 +r/stLbM6u8ASYBITTsR5ZJiHe6cfizvcOR9eqTDsr1lO7TNjOTwKc1hMMtrEyb3KP
	 cDJzfAK4WtwJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5D380AA66;
	Fri, 28 Mar 2025 13:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: usbnet: restore usb%d name exception for
 local mac addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174316983751.2839333.8852822669091857678.git-patchwork-notify@kernel.org>
Date: Fri, 28 Mar 2025 13:50:37 +0000
References: <20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com>
In-Reply-To: <20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, naseefkm@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Mar 2025 17:32:36 +0900 you wrote:
> commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") assumed
> that local addresses always came from the kernel, but some devices hand
> out local mac addresses so we ended up with point-to-point devices with
> a mac set by the driver, renaming to eth%d when they used to be named
> usb%d.
> 
> Userspace should not rely on device name, but for the sake of stability
> restore the local mac address check portion of the naming exception:
> point to point devices which either have no mac set by the driver or
> have a local mac handed out by the driver will keep the usb%d name.
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: usbnet: restore usb%d name exception for local mac addresses
    https://git.kernel.org/netdev/net/c/2ea396448f26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



