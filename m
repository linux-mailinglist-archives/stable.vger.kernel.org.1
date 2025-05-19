Return-Path: <stable+bounces-144769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12EBABBC2C
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49907168EE2
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594F8274674;
	Mon, 19 May 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4wlDU0Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F81DFFC;
	Mon, 19 May 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653593; cv=none; b=Pa8sTeueJcjRifGYy1Xx/+oMHnhvD5MAfvZCLmhhyzx4PAOklZK4exbfM2rlvKA+1ck0hR0Q4WAvUuXBqMrCJERYk+V4llAQ7TElC3WUsBsMuxcHOcPMQf9QJ2XPO6GpS5FV3T2t6Wx2/ib1UwdPkquaFcQIMI+Gz8IVmcXGreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653593; c=relaxed/simple;
	bh=+/1L7nBOago7zEMsBVJxrLA7VA41M3OJ93q2rhByYpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qbnJRsjbiLOgEYTY+5x3viSvURtbAKTcttad0/KdYzPSEpE8zrVVpZLl1Dx7kWza6F85LBt7JDhVggpFFSBmFcqiIpVaJCF8IE7+cqS4nfskTUef9kuwC1ETgSC3vsD7d8lEoWqp9QD7uPOHWnKlGccwps/+5M/V+CnaBLMlZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4wlDU0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC88C4CEE4;
	Mon, 19 May 2025 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747653592;
	bh=+/1L7nBOago7zEMsBVJxrLA7VA41M3OJ93q2rhByYpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S4wlDU0YDFP74dz9RumjIMEhJ1ueNcB6OCc1fjie04kwiceNVmxkGQcUGd9+2ap9K
	 lrIwCtlgXYNsxtW42Nj7Y8FUT6vg8cL9XcCSBsHBMJ+xAlRJnQppG+yVFCuMB7a0/6
	 aNF6mH5CHVgzzIF9itsF55XfhUIUlHNUoQATkDq7d343lhvxz83Uwk6L8ipmK5NMkZ
	 wZAf6tkQ8Avoor1lcU6bzHdyv5AWeb0FcLwvv2a1oOTpmyZ3IEhW57FG9mUmoOQjps
	 m8tlWXrFveoduIsN90pbSEG1ng8PFLe1K4aNlMAo5HbFoMMmnQqtPJag8byq1YDAKL
	 38YMGkBJ5Pw1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5A380AA70;
	Mon, 19 May 2025 11:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] llc: fix data loss when reading from a socket in
 llc_ui_recvmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174765362875.883795.7035367870465648507.git-patchwork-notify@kernel.org>
Date: Mon, 19 May 2025 11:20:28 +0000
References: <20250515122014.1475447-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20250515122014.1475447-1-Ilia.Gavrilov@infotecs.ru>
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, mhal@rbox.co, acme@mandriva.com,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 May 2025 12:20:15 +0000 you wrote:
> For SOCK_STREAM sockets, if user buffer size (len) is less
> than skb size (skb->len), the remaining data from skb
> will be lost after calling kfree_skb().
> 
> To fix this, move the statement for partial reading
> above skb deletion.
> 
> [...]

Here is the summary with links:
  - [net] llc: fix data loss when reading from a socket in llc_ui_recvmsg()
    https://git.kernel.org/netdev/net/c/239af1970bcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



