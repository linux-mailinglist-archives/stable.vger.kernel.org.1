Return-Path: <stable+bounces-191939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AFC25D70
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 16:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5810334F04B
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CD02D5C76;
	Fri, 31 Oct 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCC44dFo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1652741CD;
	Fri, 31 Oct 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924630; cv=none; b=VRRuhi/u1iSxMpxRzFrZPJEjIIlp152g0qLA9TX2cr7koaeJW6DHUK549N/2CAeiqKWZc4uw3tBjZqwPLLjkFuHcs9Ir44j2NJ//xTsgRyNC11eYbDBs+CK96tXYEQr6C14pFEwoXDJ7KBWVLXRRritMeCRxGv0ggCUDwrxGm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924630; c=relaxed/simple;
	bh=LNdVHBNJTXvFdPyWlAGjqanLUHh7aNlbYkry29CGing=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DC6tBlcVH2KUeBAzrl/uIje5YwOMXyYbrHoFyUQfoi6gN/JrjPNdxABtKe5atsWt2/+DBfvg3XjbnpgLPK/uoLodfEm5rYGQIt5OHHDRirE91G3FxqzoBd6WQCr2jzMMRJdh5lK7icsDR+uYpNiSYEboXm/OeXgfyCf2PvWKRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCC44dFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9249AC4CEE7;
	Fri, 31 Oct 2025 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761924629;
	bh=LNdVHBNJTXvFdPyWlAGjqanLUHh7aNlbYkry29CGing=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hCC44dFo8YZHzV5qdl8JJxaxm3AiqfHDe6D6Q7kO09v2ZfT1AB2LOBWwd8dEkLuFh
	 Ye3u4oPOBH45K9f5jq+Q+msp5+vYtdeWDlQAlNc/ccqZIDSUO+cGM8BQU2JoPZwfxX
	 wwXs158YriRe3MSoOm8gHODJg0NuUCgt0W15niwkBhVgM8WAwtWnzDbpXgIMFqh6i8
	 ZmPaadIRYzM3V5M+SMERSmXPxF6FjI3kfj+row9mT8UCodyL+gjyT8BWpdVQ3LcIjQ
	 PBvXzmp3FykiZN37PCMLNOY6/YUJQkXYAb4pARACZ5YQosE+C8YIy3zaH/U+D8HKYx
	 Ys8KDsHcpECLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB74D3A82567;
	Fri, 31 Oct 2025 15:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Bluetooth: MGMT: Fix OOB access in
 parse_adv_monitor_pattern()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176192460576.517485.15986970285103455414.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 15:30:05 +0000
References: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Oct 2025 15:12:55 +0000 you wrote:
> In the parse_adv_monitor_pattern() function, the value of
> the 'length' variable is currently limited to HCI_MAX_EXT_AD_LENGTH(251).
> The size of the 'value' array in the mgmt_adv_pattern structure is 31.
> If the value of 'pattern[i].length' is set in the user space
> and exceeds 31, the 'patterns[i].value' array can be accessed
> out of bound when copied.
> 
> [...]

Here is the summary with links:
  - [net] Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()
    https://git.kernel.org/bluetooth/bluetooth-next/c/e1e9d861e2f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



