Return-Path: <stable+bounces-179059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90432B4A87B
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AFC18841D3
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DF12D9EC8;
	Tue,  9 Sep 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnz8YkpL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420A2D77E4;
	Tue,  9 Sep 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410803; cv=none; b=C5LDLH3OY6Alakako8MHiKp5YK0fKo6oVcutPXtyXb12vxfzUWkoOoW6tuEuG1ZVx5eN02FSPQ/CdULZMqyq5FKBVOsOH8dsinJfv9Z+RFeNzbYg4shY2vkyZlKNwpphKdu4GU8Dxcc5nEdH4vXVnMWLoOo5CaaeJADUNVE5y1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410803; c=relaxed/simple;
	bh=aY9mymuwZMku/84zDRe1CskabLwrW4TRMe/r70bdkrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=geLXJ+r87bZM389XSj31/uMfn69seLY8fBOnf3SV+TjtT/ojhqvYn+jZugzNEkkIwRm8lyTmzzxF4iFHqDuIItOF23z+NOdk/q2RXzHhA1lQCcMmo76Os24tAWMVxNzMP5oOd1zgYcmjKlmlkldAsmRmlzMEMcUqHdYnPYv/pqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qnz8YkpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810D0C4CEF4;
	Tue,  9 Sep 2025 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757410802;
	bh=aY9mymuwZMku/84zDRe1CskabLwrW4TRMe/r70bdkrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qnz8YkpL1QUz5svfQehlNV62+k84mYjBunSpaZXO7t9Np9E99csJEgm24Z6MGlHEe
	 /Y7dG98xA4J/nJWecaUfQASFfbSiaa2XQvE1UxqMQjf6c87yDO7Z6GivUdjFRDGvQQ
	 lOzh7LkC3U+Pwm6AoNNqxk398i4GMQYtz51peGZoUu0tGuTdGwP5y/NEvxKlCPP1Ly
	 sqKu5/t1+g4cn01L708OPlUt2BLM4O+1pZvXrLanGfaLQz+zVXzYJ10bX1S7HGHLQW
	 zTmzWdhb/Hc8x1UafiSXAX34+BbCCBJGAXDHOTWwRHWfCy02nCsmhj4aPna4PSFBuP
	 Ai6LKJZQrHybw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDE383BF69;
	Tue,  9 Sep 2025 09:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] selftests: net: add test for destination in
 broadcast
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175741080575.600517.6688973064003089963.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 09:40:05 +0000
References: <20250902150240.4272-1-oscmaes92@gmail.com>
In-Reply-To: <20250902150240.4272-1-oscmaes92@gmail.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, bacs@librecast.net, brett@librecast.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  2 Sep 2025 17:02:40 +0200 you wrote:
> Add test to check the broadcast ethernet destination field is set
> correctly.
> 
> This test sends a broadcast ping, captures it using tcpdump and
> ensures that all bits of the 6 octet ethernet destination address
> are correctly set by examining the output capture file.
> 
> [...]

Here is the summary with links:
  - [net,v5] selftests: net: add test for destination in broadcast packets
    https://git.kernel.org/netdev/net/c/bf59028ea8d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



