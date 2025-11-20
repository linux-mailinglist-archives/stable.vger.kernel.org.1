Return-Path: <stable+bounces-195246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0738AC73755
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 11:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1866B2A43B
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362932C321;
	Thu, 20 Nov 2025 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8FH/qXN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8732BF52;
	Thu, 20 Nov 2025 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634641; cv=none; b=gJgizgXHQNmqM8re+oG2b48TYt5+3tK3lsCJulK9JG3k1M4ezrGspEJoH9a43hy2EEZr2q5GWOcOIS/EHM+9PqD5gcfpO0eoEpVZh8SWnYyteBPolXi6PcMAdfOSiP0KXNm7XWWGjhj4ltHB5sKEo4SwdkJ1k9D2jsQSqeR0et8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634641; c=relaxed/simple;
	bh=J+fGTIM35yM1pnJJE2Bn40ap6PS1L5bDXilEDqX2pZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=imBLvCqYlnxNVjEIhejtSNgO3zJdd63eaMr5sEcjljVElqJlFU5PvQ9kBtMmC/Z5Ci/4XJsw6YB3yhc9Q3n0c7HxyzNbVs2C56+EnhSVsH1zF7nDmMSAZQY3aTHd1V80PFrY8em3Y54trKD8/yKlmB9ax7H9Pqomg9vQM58Uo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8FH/qXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82C9C4CEF1;
	Thu, 20 Nov 2025 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763634640;
	bh=J+fGTIM35yM1pnJJE2Bn40ap6PS1L5bDXilEDqX2pZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u8FH/qXN4RaQBDL3SD7Sx9njyJAkEW1gA4TAswKbQKeSibImAJG54KdF0+WKpp8RL
	 f7vAvBakilALRfPQ29GH2j50dhlCB/A00um8Fynx+oUh7sNOQHMaVXZh7s87Fb+hMd
	 8RoYHsEBMm7kuD+csWJaPNaeDop2JT4xuxlYQFipL42lXnLmmlFTzrwvRLokUoa9Ae
	 oQVTFbcw7tJcGfTeGd1PmaWNSpdoJKBOt5wxaahzYp1X3+DL2kQskWhfvc3Slx1HH0
	 4xNmnbDQ7EDXuOMJxfc3X/TWPex9xb/weSGUaMt6fU1IeovusfFRGIlL0aBxe2PrqD
	 r3cePBUOyvuNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7119339EFA6E;
	Thu, 20 Nov 2025 10:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: dsa: microchip: lan937x: Fix RGMII delay
 tuning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176363460626.1565276.14971544367038790990.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 10:30:06 +0000
References: <20251114090951.4057261-1-o.rempel@pengutronix.de>
In-Reply-To: <20251114090951.4057261-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 stable@vger.kernel.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Nov 2025 10:09:51 +0100 you wrote:
> Correct RGMII delay application logic in lan937x_set_tune_adj().
> 
> The function was missing `data16 &= ~PORT_TUNE_ADJ` before setting the
> new delay value. This caused the new value to be bitwise-OR'd with the
> existing PORT_TUNE_ADJ field instead of replacing it.
> 
> For example, when setting the RGMII 2 TX delay on port 4, the
> intended TUNE_ADJUST value of 0 (RGMII_2_TX_DELAY_2NS) was
> incorrectly OR'd with the default 0x1B (from register value 0xDA3),
> leaving the delay at the wrong setting.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: dsa: microchip: lan937x: Fix RGMII delay tuning
    https://git.kernel.org/netdev/net/c/3ceb6ac2116e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



