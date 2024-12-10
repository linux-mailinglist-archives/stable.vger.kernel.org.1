Return-Path: <stable+bounces-100402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF0C9EAE29
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC7E28366B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AC1DC9AA;
	Tue, 10 Dec 2024 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6qO3rnU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C21323DE9E;
	Tue, 10 Dec 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827214; cv=none; b=JsWl8mE7eyeRxj+sV8GrjqCEbjiji4709dQmY34Hwjn+029ccIeT1ZKCbT+zZh5g7U9TmQvi07LQ84QzKhH6H3hJEUaZCzmDqf8i7RE/fyAaBtHFYscTqOkqznFAxcoprlZYaMF85enjrRz/HpNBbNS7+5YriiKHVyU54H8f2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827214; c=relaxed/simple;
	bh=uQ9yF1tFJQxen8M1Rw2XLoRjQZnopoI36EeXWYEm1Mo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MsOPw7j0pd++7DtrY3UCGKYJnGt9XtrJAKxK+N2bwiKiryTBUls2i7KRGxPpcDkVHL19KDSCj0QvEwBCxff7cXnfHg6PAXQAT/n1Lyn2PYQTPgEdkzQwL23q+z5MZt+oGFNGyC5lgA6d/BeCTMHo/C54yh87ayajG7n3s5oQ+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6qO3rnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7835BC4CED6;
	Tue, 10 Dec 2024 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733827213;
	bh=uQ9yF1tFJQxen8M1Rw2XLoRjQZnopoI36EeXWYEm1Mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R6qO3rnUimhbclMsVVSaZeYd5ywsO93ZhUvKsRMJO73r5bBDX1rXfgGE9QCiVJZyP
	 HpXs2Dn39Pg1L6P5O/H86DztYyuXK92ajFaPsgzWCZt7MO4RkVaRFhUW15ORvhBMm9
	 miNTuTjrjIKUi+GInD/DrCfaMWCWtR/lMyfij55JUXO/zt1ELkhl+g3Y2VySZHncNp
	 0c8IQi83IjE4igzGolbZuVRu7yDEQJYvVpgadG/WXojgzDIWk12UsW661lpK2dpEiL
	 9O6WIpEVGo01ts0YdiGGLaoswic/NQ1WJXYA+Qt4shf60MgqoilQ8ZTR6xil4CPO/t
	 whHfHbvO0Pnsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 63A83380A95E;
	Tue, 10 Dec 2024 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/6] virtio_net: correct netdev_tx_reset_queue()
 invocation points
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173382722925.756341.2427257382387957687.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 10:40:29 +0000
References: <20241206011047.923923-1-koichiro.den@canonical.com>
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Dec 2024 10:10:41 +0900 you wrote:
> When virtnet_close is followed by virtnet_open, some TX completions can
> possibly remain unconsumed, until they are finally processed during the
> first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> [1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
> before RX napi enable") was not sufficient to eliminate all BQL crash
> scenarios for virtio-net.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/6] virtio_net: correct netdev_tx_reset_queue() invocation point
    https://git.kernel.org/netdev/net/c/3ddccbefebdb
  - [net,v4,2/6] virtio_net: replace vq2rxq with vq2txq where appropriate
    https://git.kernel.org/netdev/net/c/4571dc7272b2
  - [net,v4,3/6] virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
    https://git.kernel.org/netdev/net/c/8d6712c89201
  - [net,v4,4/6] virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
    https://git.kernel.org/netdev/net/c/1480f0f61b67
  - [net,v4,5/6] virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
    https://git.kernel.org/netdev/net/c/8d2da07c813a
  - [net,v4,6/6] virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
    https://git.kernel.org/netdev/net/c/76a771ec4c9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



