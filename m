Return-Path: <stable+bounces-138943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6AAA1B29
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 21:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D644A853E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED715259C94;
	Tue, 29 Apr 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lryuYrrm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7C216E30;
	Tue, 29 Apr 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953791; cv=none; b=WKe/lgfv7Ey8dhHL2+DYaodrpHyWKKdQvhzG/ItmofMbefk/9Lhq6deWJjgvPuLIJDobk3qLIy8kLk2kethOVzZzUtwJC78j6WHUXV54cESCVxOioCpn2u/TolSlbq2D4T1LLrxJe3ThyROxsVGbk3qukVxmnrJuCTG+x9uKF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953791; c=relaxed/simple;
	bh=Fj8Qwh7Oglt89U7CUjfhi1ViJF/tP8Mruv6gVmeBzPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D+8fA0rCbdM+D++gn6d8QNV9tF5R8JTXqUE5fIKYaDMAMQRFnxhtGy4kEMwI5kY3AlyyknjV8xrRAmuqBADSef0U1laitiv+WkTInRiUmzklGNu4USwXWLG/G4j6qT2xFx2qj2QF7JkACGkMXkIUFD0/nqosUgKJwqueLNLI3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lryuYrrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C66BC4CEE3;
	Tue, 29 Apr 2025 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745953791;
	bh=Fj8Qwh7Oglt89U7CUjfhi1ViJF/tP8Mruv6gVmeBzPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lryuYrrmUsoDN64rRhIQZsAD/VNGrOdczSxzGkxhMeKAlUiAGK8QTadyyTpuXb/TV
	 tfHZpwOJEobn/m2qv16SIwL3YLt5dVEkh7eCUBKl0eACtBxTM1KsaYTrTwx81Q7ktA
	 9IpA6PZfZ6LenIINM7J19yOwCyKMQDXiGRUfYOZ8ZKZEufpr0yCBke2XkxMt5omi8I
	 vATm2tXosgQ2gAG2HiRnmitKo/xOPHDCreA9Rtk93suM/W44p626R/NgXbqswfftZC
	 hPu8bV+Wy9dseac/ADH9Q8cFMzjCT7YkGAdtuqg0GAhxZYd6MBvEtbaOiSw+AmMvej
	 xriR+W6ABymlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C623822D4C;
	Tue, 29 Apr 2025 19:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: mdio: mux-meson-gxl: set reversed bit when using
 internal phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595383001.1770515.9085640338016632104.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 19:10:30 +0000
References: <20250425192009.1439508-1-da@libre.computer>
In-Reply-To: <20250425192009.1439508-1-da@libre.computer>
To: Da Xue <da@libre.computer>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, christianshewitt@gmail.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 15:20:09 -0400 you wrote:
> This bit is necessary to receive packets from the internal PHY.
> Without this bit set, no activity occurs on the interface.
> 
> Normally u-boot sets this bit, but if u-boot is compiled without
> net support, the interface will be up but without any activity.
> 
> The vendor SDK sets this bit along with the PHY_ID bits.
> 
> [...]

Here is the summary with links:
  - [v3] net: mdio: mux-meson-gxl: set reversed bit when using internal phy
    https://git.kernel.org/netdev/net/c/b23285e93bef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



