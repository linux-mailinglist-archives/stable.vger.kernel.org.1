Return-Path: <stable+bounces-204195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14608CE9400
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 10:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0D43031A15
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E42D6401;
	Tue, 30 Dec 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTPi7RvZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B82D4B5F;
	Tue, 30 Dec 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087808; cv=none; b=ktDp6yLYmB18mHX0Jazn8awhmgHrwlwzzskJt/NTVH4/PAeQza+ePIXuXNmgAELZgeNzGCHBIecI4TyZ8eZEtw0UarJvdRdKiRnPZyoNsuqtyEVEbUopYRSeGFWkjWZgOfx8SfKXZacpbY/bLP114G/ByErNJGtZ4GcbhOTEAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087808; c=relaxed/simple;
	bh=UNG7VRzwGNT/5kt2XmvV4+QrA5R2nh64yF4pPmMly/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rt/j3CgutTfaa/d5e/7XLnUOOLb+USduLixBUVoZvvvoZSFRw1BTJWEw+uOPcySIm1JhWuzmcpZX0+lmr/Yua9ZI50I3HrnMjfXSsykvLW2DOp5rY6FDYOb6YvY/n4h2d29C9O76xaqrQarg1J4ksiCORZ+78m4HAhntOBu5iI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTPi7RvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF46AC4CEFB;
	Tue, 30 Dec 2025 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767087807;
	bh=UNG7VRzwGNT/5kt2XmvV4+QrA5R2nh64yF4pPmMly/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uTPi7RvZqjHyIy2DhWjPZXktTRdeO9vE+ZkrdujzvEHaHdKDqIREyTVs3YUW0nGxe
	 lb27DL/JUBZVbfWK66nJUR2BK18zKWap/AKStCUUi9hWIoRmveUFtu+ZOe6j+wI6zM
	 OycdGOGRXNQQEm+uT4S3PhDXs9oMM1M777qJ53KeeWcK/Jahih8LUHe8cJUteqc9q6
	 vKaXCzYYR7gvySYU2OgPdrfO9J/Pympwzb1vMIzIN8r37q1avgzb5GzEcMMujiDcq/
	 yGh/7Ag7Yf89ytkUXn9dMHtD32cpVfqLVCYwNUw74e3RJvLvE3AzORJAZ4nclDt7BD
	 UhyQyQ7Dt8ecA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B72E3808205;
	Tue, 30 Dec 2025 09:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: sr9700: fix incorrect command used to write
 single register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176708760977.3192123.10662503393096586640.git-patchwork-notify@kernel.org>
Date: Tue, 30 Dec 2025 09:40:09 +0000
References: <20251221082400.50688-1-enelsonmoore@gmail.com>
In-Reply-To: <20251221082400.50688-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 21 Dec 2025 00:24:00 -0800 you wrote:
> This fixes the device failing to initialize with "error reading MAC
> address" for me, probably because the incorrect write of NCR_RST to
> SR_NCR is not actually resetting the device.
> 
> Fixes: c9b37458e95629b1d1171457afdcc1bf1eb7881d ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: sr9700: fix incorrect command used to write single register
    https://git.kernel.org/netdev/net/c/fa0b198be1c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



