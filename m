Return-Path: <stable+bounces-194620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16EC52E8F
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 16:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CF355E39
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5233AD9A;
	Wed, 12 Nov 2025 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enBY7x6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6333859C;
	Wed, 12 Nov 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959037; cv=none; b=AhdGxxUCBpTcw2wChv57KHSfw4zZCe/iOfP7+0mPxQM9IuRxCET+L4XnrykcoFF0Mq2TbUyNOKvv2485TBHJfv3VjjQQwhfbTKC6Cya8PxrLKHavVe/0RhcbG4vJ5Q4clkIn0iW7d+exzJ7Sg24lUYoDlUESCoSTiF5XBSbUSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959037; c=relaxed/simple;
	bh=fDyqUYG96cnQY+L9W/+s4ilvkJlQdMXHRO6AeDHlCzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yms1R2HM0w1WAc2A1mAinG3VBE+IL/wWShUr4SjVRfZKEZIcOL+GRb/b+JiHxrk71lHLKpY1D7bjzZICP1VKTeVFsVaQks/B1stHYQArOzFgX89084ulE+Jr/JJPLuGjqL4gg6TWOALBI2bS2qFoGVM5bcFvLq6V4/q4kC/qUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enBY7x6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C317FC4CEF7;
	Wed, 12 Nov 2025 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762959036;
	bh=fDyqUYG96cnQY+L9W/+s4ilvkJlQdMXHRO6AeDHlCzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=enBY7x6YOWv87kpNak4NrFB8JtZ3UVXQuLOeCAaj6KUbV7onIs9gxe3f9AeakO/UD
	 P9eC6n1V+zD9y14jPBKQXNdiwFWCkIL/ENmV5k9VIeu7Q+Nq5Te9yLdQLMd2eAlUeg
	 oKk8bFYOfMrgnmuXhvcvdgjgoF+jv7G9Npc5uNdflqeXzjDoIFBF0ao7BlTFrDIBER
	 WPxW+kQ0/k5jeCxf4L1ZlrSQyoyW+ZUsbthCnokc6bNsq/ZCLUjXr6rvA/asAwvQ3B
	 dN3rWLyryTt87mMkUEJ5I8rcVupgRBgwiglVwJqgR9GZ4BNh0keKckGoqJaKn+y9Tw
	 PPXSl/G8Y5KVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE16739EFA4C;
	Wed, 12 Nov 2025 14:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176295900651.38875.8173375178181875394.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 14:50:06 +0000
References: <20251111064328.24440-1-nashuiliang@gmail.com>
In-Reply-To: <20251111064328.24440-1-nashuiliang@gmail.com>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Nov 2025 14:43:24 +0800 you wrote:
> The sit driver's packet transmission path calls: sit_tunnel_xmit() ->
> update_or_create_fnhe(), which lead to fnhe_remove_oldest() being called
> to delete entries exceeding FNHE_RECLAIM_DEPTH+random.
> 
> The race window is between fnhe_remove_oldest() selecting fnheX for
> deletion and the subsequent kfree_rcu(). During this time, the
> concurrent path's __mkroute_output() -> find_exception() can fetch the
> soon-to-be-deleted fnheX, and rt_bind_exception() then binds it with a
> new dst using a dst_hold(). When the original fnheX is freed via RCU,
> the dst reference remains permanently leaked.
> 
> [...]

Here is the summary with links:
  - [net,v1] ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe
    https://git.kernel.org/netdev/net/c/ac1499fcd40f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



