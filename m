Return-Path: <stable+bounces-154817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B1EAE0AB2
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 17:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D594A3B2264
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0660238171;
	Thu, 19 Jun 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNBWHuVL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8192237194;
	Thu, 19 Jun 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347588; cv=none; b=LaJk7haUVTUNkYIFPD6n42Mmmy8I4UXZAHnitvyy8OHKws+sB0ASDTFNIdDuuOQsf9EZF7BPpnioQ/M3WoKRA2Hb8CZKSvTDKwf2wBIjoejSNyjMXpnsXNvJA0/xtNo99EB2Zy4/u4dvOo2jv7U/YiwxkZj7c5Z4YjOkSyjNwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347588; c=relaxed/simple;
	bh=8v8M7P3HvOvi5p/hmJXZ4r+vUSQyvqwJvQlUisWZfiY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e8Bs3tY2/H/dl5Ba/k7MaDXmKexQKLNj/u298Q3Qz7CyQWKj8G0+WvKFKMVJsaLobOfOXbK+BwHQ5blecIVP1hPCV1SbKpwyLhK+ISdxMPnMB6JDxsnV2+Hq09tzQ6nmZDhF2M1VbFDx6Xs3V1JVx/Cxi0+8zhAiJbAJs79crOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNBWHuVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BA7C4CEEF;
	Thu, 19 Jun 2025 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347588;
	bh=8v8M7P3HvOvi5p/hmJXZ4r+vUSQyvqwJvQlUisWZfiY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KNBWHuVLlBfdvsolhNU8mX9WzGv+TlF8dDZwWl9iHZ5B7XS5rz5HbB5GPfSXEQlti
	 s3ANincd0dA1IEjylaCgN/nsT5I/jXhMKE8XCuVqpWJBFI562384/o4DLy28Q6FOcl
	 fgumGdRwKbSYxrBx42skFCCNic0DNLDJdaZF5iesaQnGJVj+enyGcO41SScoCk5Ylj
	 A9NxaAIjjdxABfU/51EII/X2L7R1QszM2AbymWgmJ4/ComkYgRh9ohGJdac5aPUN2U
	 CbVlwm/+iC6jLPv6kj8CoiWEGJdHsFOmZO8ffJrAoGIwWUKUMroRY9tC+/LlNchXf1
	 B+2x47PdHikCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DEE38111DD;
	Thu, 19 Jun 2025 15:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] NFC: nci: uart: Set tty->disc_data only in success path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034761624.906129.8870783652676829504.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:40:16 +0000
References: <20250618073649.25049-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250618073649.25049-2-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, cuissard@marvell.com,
 sameo@linux.intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, torvalds@linuxfoundation.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 09:36:50 +0200 you wrote:
> Setting tty->disc_data before opening the NCI device means we need to
> clean it up on error paths.  This also opens some short window if device
> starts sending data, even before NCIUARTSETDRIVER IOCTL succeeded
> (broken hardware?).  Close the window by exposing tty->disc_data only on
> the success path, when opening of the NCI device and try_module_get()
> succeeds.
> 
> [...]

Here is the summary with links:
  - NFC: nci: uart: Set tty->disc_data only in success path
    https://git.kernel.org/netdev/net/c/fc27ab48904c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



