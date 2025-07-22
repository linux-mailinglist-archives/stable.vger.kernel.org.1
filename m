Return-Path: <stable+bounces-163631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98741B0CEAC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 02:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDFC546007
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 00:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E603595D;
	Tue, 22 Jul 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOMFcrpe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C51DA23;
	Tue, 22 Jul 2025 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753143588; cv=none; b=TwR3KSE4AuvzPvC7M+EMRP7WSuLd+j0UXEwnwBqSdeXZPD6QaG/d8X7PP/P5ltprLbfoH235RGRLnGK0g8KLBW/HeTuTMfJQ+nu8h0zF07jw0FbDdwAumVpOexozsMQFh5ZKKp+fi1FFaWF5VDtz8FavRM9q20pe7jjS5P7tUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753143588; c=relaxed/simple;
	bh=nOnLv6dJo1x+Ckh/9AhCkc7uEgsFVBkIEU9AO+ROxPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZPe76Ntz4fVemMbtRMFkSjcAvY63WTcaCpFJzMM07PseKXDjcqKogXYOuxvaP5mDURwn77GY2Uh8ZZKKxouBdHrdWA95nAetbTrUClWLOgpVvYiPn7Vxnt8nGQa2oqu5DLs4wvWZ1gVgH6HwmL/+HWcvkUrfcaDOx3ncSPIvZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOMFcrpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43942C4CEF5;
	Tue, 22 Jul 2025 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753143588;
	bh=nOnLv6dJo1x+Ckh/9AhCkc7uEgsFVBkIEU9AO+ROxPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bOMFcrpeZckOyOM8sswQJAbXFOERoex49mguLRmqrHk9jjEAeglTMastIDOLHJCtQ
	 oTreTJhgWGmf9nsEyLFtXovyJSv8a1qH/hTFYVH/MQPoXBiXMW3RFvdWEaQqNtms3I
	 hB1cVCOCIY0TQczq3ER6+buQmc5dWIFZgVjHtJrFFFcPeoe+Vf/tN2W9fKEXN8Jn+k
	 2RFmLG6OY+lGoqIdH45VBhfCEqq9+qS9kUZh2iaP/LMgwslh9b8r9CZfF/7Hz1XU2h
	 1u0Mt3YzBoCeQVRZt1B2y2TOxtANnmuFlR5UegJuXkhOLc+dgmkz4NSLUa2Lh3oMog
	 /RwnRURxZt+dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A7B383B267;
	Tue, 22 Jul 2025 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] gve: Fix stuck TX queue for DQ queue format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314360700.240957.15167711748431972414.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 00:20:07 +0000
References: <20250717192024.1820931-1-hramamurthy@google.com>
In-Reply-To: <20250717192024.1820931-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pkaligineedi@google.com, willemb@google.com, joshwash@google.com,
 ziweixiao@google.com, jfraker@google.com, awogbemila@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, thostet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 19:20:24 +0000 you wrote:
> From: Praveen Kaligineedi <pkaligineedi@google.com>
> 
> gve_tx_timeout was calculating missed completions in a way that is only
> relevant in the GQ queue format. Additionally, it was attempting to
> disable device interrupts, which is not needed in either GQ or DQ queue
> formats.
> 
> [...]

Here is the summary with links:
  - [net,v2] gve: Fix stuck TX queue for DQ queue format
    https://git.kernel.org/netdev/net/c/b03f15c0192b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



