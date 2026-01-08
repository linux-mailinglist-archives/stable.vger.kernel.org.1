Return-Path: <stable+bounces-206390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F64BD04C2B
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99146304713A
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C282ECEAE;
	Thu,  8 Jan 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0hTXkKg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE92DCF46;
	Thu,  8 Jan 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891226; cv=none; b=M4i9D1iCHb+KBzjuCAqLL8+oNHKVx8CZDGpAfoLBq5J7oFpn9pWbr8q3yJK9IKpuJhYYy9NJhcRtqOuVE09zHPyrmujvGpOhHPV+gA5+rDZA9GwCDBFNgAr0w52qglBHjCw64n8vTKSgk9Cont+ORneugvvPcPmGt6CmZ/J1alA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891226; c=relaxed/simple;
	bh=m4uIYf7XRXQ4HudqrctBnnMhYPZl+6Vzv/7NAPsBjHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cCsyZJPxFZBbrYMOtfzKJPWzid+fQunTMi26/pziBxvpOTE3RJ14uMCTmFmlkc8ZOc+dfkKGRA2xnyCd6HUF3suNDfY9BsHFj3r5J43IjBLfplEkcYDHxGIbZixXzPi0VKF7yIzOFCf+V6qX8u1C7klAhD43AzDDNROlswaj8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0hTXkKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4700BC4AF0B;
	Thu,  8 Jan 2026 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891226;
	bh=m4uIYf7XRXQ4HudqrctBnnMhYPZl+6Vzv/7NAPsBjHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l0hTXkKgc3KwpLWgIVq7oGmjDHOZr4MG+7HMUv4DfkcYra9NqnqwXw0MSKvU08aJ0
	 dikv8LqWrsxtqImw7MwVyDBx13DnT0VznwHhpzJrAdd3ivhtaPOCqzrRa/fwQGUTFU
	 rF2M9tB32+VvHOytIBZp80uGHSXDAl9BphphbE6Ii27xfQvo+VDfvCt0DU5e8OmOEZ
	 Gm46OUjYNsTZWg5vmFjqWskXX6M9YEXGIkC0Us5KxIclJvFX0ikjzoQYPZBCNDHEP3
	 bFdXnvSdCObY3rPChJQz9E7NdWzbzftl+CeBSLJvjeoQlJ1r8dLLjsfGFgpQaAO6ZE
	 jXKUJSxN8L42g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AC23A54A3D;
	Thu,  8 Jan 2026 16:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH NET v2 1/1] net: usb: pegasus: fix memory leak in
 update_eth_regs_async()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789102277.3716059.3717751225941024809.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:50:22 +0000
References: <20260106084821.3746677-1-petko.manolov@konsulko.com>
In-Reply-To: <20260106084821.3746677-1-petko.manolov@konsulko.com>
To: Petko Manolov <petko.manolov@konsulko.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, stable@vger.kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, petkan@nucleusys.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 10:48:21 +0200 you wrote:
> From: Petko Manolov <petkan@nucleusys.com>
> 
> When asynchronously writing to the device registers and if usb_submit_urb()
> fail, the code fail to release allocated to this point resources.
> 
> Fixes: 323b34963d11 ("drivers: net: usb: pegasus: fix control urb submission")
> Signed-off-by: Petko Manolov <petkan@nucleusys.com>
> 
> [...]

Here is the summary with links:
  - [NET,v2,1/1] net: usb: pegasus: fix memory leak in update_eth_regs_async()
    https://git.kernel.org/netdev/net/c/afa27621a28a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



