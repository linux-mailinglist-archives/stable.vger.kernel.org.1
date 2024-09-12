Return-Path: <stable+bounces-75939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D912975FDC
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 05:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DBC1F230E5
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 03:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBF718757C;
	Thu, 12 Sep 2024 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDXR90AA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAEA47;
	Thu, 12 Sep 2024 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113032; cv=none; b=TcgPffTrKY7F5E4XK2Bbg+pDiaWzY2aHVEWvPM7xOYs5yRFm9grrY0aMf1QFKZhZC8xxQr45gnFBy7Oz1IJxX8tzCf+HRbkTULJWyKSR6nE/eS2lF5tQrO/gDyq+9CjZd3DCVtMY64erWeAprWVjrY/8WeKIgDi2Y/Yn8vqk3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113032; c=relaxed/simple;
	bh=E9qLCi9wfsxIqQ/dYBEVk+PHRm82TS6Dw1wBk1f4RFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gseh/54l3mxXfXKPQoRpF5mQSxEPT7EWMPfqSSVcewGDh0k7IbikS/+xs3UCPKc7nomrUTLRNKnmCqbHPfbkH7Nrulrom0K1sh8Pca2f8BeB/3vMhyFc7r6Br28TI0GyKV82/jEQXH6vycdacWCcNST31PP7v0hUjW+G71M7hdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDXR90AA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9187BC4CEC3;
	Thu, 12 Sep 2024 03:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726113031;
	bh=E9qLCi9wfsxIqQ/dYBEVk+PHRm82TS6Dw1wBk1f4RFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YDXR90AAPHp1EUfZH5+8BB9Vm3BPPBSbkMHzkBiRXWGElq7X6b0XD3xlzRBTRYtcZ
	 ACjx4B/2VLrsd9BCLInP0wUVSDoutXe9o7O8xWWQAjGVQc5Vg4G0qipY6jBllYxWPn
	 EfOd49YcjTSv+XAiNPAnkYTQvuvzENrMofQvL0Yg37sHdvTvx3tpLShKz6ttG7w9uJ
	 PhuD6QpIO4V3wtupZtPiP1QQERpZF16vCZqYh40MKadGGe6aMSq2UvPZoYNH3B+8Hu
	 cj0Ce5Wtqo3ZMdahYgbpKNBx4a0BbzqkEuVyN1hgLpcwHosccWNkpIhTWzZKf4saNs
	 pNNHx/NSZL0EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE063806656;
	Thu, 12 Sep 2024 03:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: tighten bad gso csum offset check in
 virtio_net_hdr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172611303278.1155279.7529343759399264927.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 03:50:32 +0000
References: <20240910213553.839926-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240910213553.839926-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
 nsz@port70.net, mst@redhat.com, jasowang@redhat.com, yury.khrustalev@arm.com,
 broonie@kernel.org, sudeep.holla@arm.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 17:35:35 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The referenced commit drops bad input, but has false positives.
> Tighten the check to avoid these.
> 
> The check detects illegal checksum offload requests, which produce
> csum_start/csum_off beyond end of packet after segmentation.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: tighten bad gso csum offset check in virtio_net_hdr
    https://git.kernel.org/netdev/net/c/6513eb3d3191

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



