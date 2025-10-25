Return-Path: <stable+bounces-189258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DAEC088DC
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 04:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA081C26F0C
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 02:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9CA23EA8B;
	Sat, 25 Oct 2025 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhAB9P0J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702321CA02;
	Sat, 25 Oct 2025 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358826; cv=none; b=bxELtFkyiMa8g+QH+uFZ7/8+KydM0nsrK//zgq2fwYbwt6F4un15y5lPGFYjMjeOIReZXF1n2aVyPUqIuoIC/VKPGc8y10sHQTtBzbG23Q9Jrw5HaQEThAh9rCJCtXEK71bzrzjuHQJTYNGwa6Az2zeVb13SHEsxsws8nIltz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358826; c=relaxed/simple;
	bh=2u14AvrNR3OwOhbGmZkvkBuYnL6qf3PH8DV9x9B7p+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YzMZ0pf8PGUBbDLxciO+Aw3X73r9xBRA52uiikhrOgA7MSbv2KBCXCSy53zSJ6EAkTrJBbduB5RxRyB75haRSdN6KV2YVNzPolULbfNJ0bc7AEoxaBDgV1099fLmgQnu9q6C/XoKNbPQf5SoQs3BcuD/Uzu5ImGVJDoPp0EYWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhAB9P0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F36C4CEF1;
	Sat, 25 Oct 2025 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761358826;
	bh=2u14AvrNR3OwOhbGmZkvkBuYnL6qf3PH8DV9x9B7p+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uhAB9P0JDQhiUO45nX5sNjaC6NNsxcSFrnECJOPywHRVoemV0QSIJQmFxEdj4FAzz
	 LVNpwo4ZgEVbF/gNv/BkIVCw6wgmLzN7QVngcXoJRZ2zkKGStnlaSXDRsPz/qafgMT
	 nDWC2Nm4rYZtGdxA7zQpdGAWaPrHEvt0UWUaqWeH8Pou/dMy+Fpmzu6RBmRT+VRbN4
	 iAxbHnsxaqdISg3p8Zh3LM/6nBnUakSlQ127lZ7fuNLMW7aCXZuDg/+PotGaQK9N2y
	 +luOZpmcFO7Fq0xgLM5mbWtYlkOR24VSo6p994bkb4h4Tpav6K2/LwpvqJyU/bTMka
	 NL/yXgq4qXbdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2C380AA5C;
	Sat, 25 Oct 2025 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176135880628.4126724.4086948250041165094.git-patchwork-notify@kernel.org>
Date: Sat, 25 Oct 2025 02:20:06 +0000
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, emanuele.ghidoli@toradex.com,
 linux@armlinux.org.uk, o.rempel@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 16:48:53 +0200 you wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> While the DP83867 PHYs report EEE capability through their feature
> registers, the actual hardware does not support EEE (see Links).
> When the connected MAC enables EEE, it causes link instability and
> communication failures.
> 
> [...]

Here is the summary with links:
  - [v1] net: phy: dp83867: Disable EEE support as not implemented
    https://git.kernel.org/netdev/net/c/84a905290cb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



