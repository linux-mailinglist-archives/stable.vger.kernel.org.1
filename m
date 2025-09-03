Return-Path: <stable+bounces-177559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954AEB4112A
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 02:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25A01B612C3
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 00:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DCB10942;
	Wed,  3 Sep 2025 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXE0Uf2z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DB3209;
	Wed,  3 Sep 2025 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858206; cv=none; b=sLt5CzLPhGU3PD6vszrczVLI77zqw801wViRM4ZNtjaHewcLHE/O+QNcwAVIwUBL+wM19JlDeImGjGVnRHatzb8Gvnihw92Jawu/8SgcgfeO/o+KpCm6E1goNxqLwlpjJoTwm5Ir9SFtFuOo4aRd8fuJcUrWWyxGBHMEINEw+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858206; c=relaxed/simple;
	bh=r5UTc9faZHOyyQhIRhNymit5oTqFRwFxXUiv7cgAUko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wzv85kCKM8+nmd5AtFnfTmEvphKRXK9+d2f56YgcOH+tIooePBsxmBS4+dABuAmPO6olbzpUjgaMAgCX4aEMAQJVKOpqItI+1tPorfjflYrNPsWTAVLf/PLEq8gRe5KlVHfClu1hF7rFQeC9XMSQo1H211XGFgh3RgJkF/z6Kbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXE0Uf2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976F9C4CEED;
	Wed,  3 Sep 2025 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756858206;
	bh=r5UTc9faZHOyyQhIRhNymit5oTqFRwFxXUiv7cgAUko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dXE0Uf2zBP4bbVygTAmGOJs/yNaXACp1qDqmJ980pRoZfSDI2hNxB+ydNnTI5Y20+
	 w+HfmPSpuit41ioL44XG6H/lDIiYw8S/B7WEyU71R0Fmhv063ZAwGBkxHDsrwIPqgi
	 mZIzr9469aMdYtr53nBpG0FZ9za9fZ33QuPU5Wn4o6nM5dVd425mAgri00LjdgrLH6
	 GiTv2qcU1oJLFdKD5PevmI0P+gLweSIWZZ7usWPbm4i/LTD5wLr6jrMxVNiDPJuAYB
	 uOtXWxN8Bl/YG93JMpPovx32l8v/+gFhez52B+msaRXeAbCbHtasN3qsUq4yXd3nau
	 Lc3S5KeTPmVSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C08383BF64;
	Wed,  3 Sep 2025 00:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: Fix fwnode reference leaks in
 mv88e6xxx_port_setup_leds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685821201.475224.11323348631634915826.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 00:10:12 +0000
References: <20250901073224.2273103-1-linmq006@gmail.com>
In-Reply-To: <20250901073224.2273103-1-linmq006@gmail.com>
To: =?utf-8?b?5p6X5aaZ5YCpIDxsaW5tcTAwNkBnbWFpbC5jb20+?=@codeaurora.org
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.walleij@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 15:32:23 +0800 you wrote:
> Fix multiple fwnode reference leaks:
> 
> 1. The function calls fwnode_get_named_child_node() to get the "leds" node,
>    but never calls fwnode_handle_put(leds) to release this reference.
> 
> 2. Within the fwnode_for_each_child_node() loop, the early return
>    paths that don't properly release the "led" fwnode reference.
> 
> [...]

Here is the summary with links:
  - [v2] net: dsa: mv88e6xxx: Fix fwnode reference leaks in mv88e6xxx_port_setup_leds
    https://git.kernel.org/netdev/net/c/f63e7c8a8389

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



