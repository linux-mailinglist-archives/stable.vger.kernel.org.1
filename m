Return-Path: <stable+bounces-204119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60427CE7CD7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 807C43001BC5
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4254032C932;
	Mon, 29 Dec 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huvdEHwI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD142D63FC;
	Mon, 29 Dec 2025 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767032004; cv=none; b=LhDMZKLTcnjihy6wAHoJC26omCEtl39038oSbBIALrdwF1hjW7dJgL7EyFCZhBZ+7k7CV0hJ+R/nEmcvvlXTNG4retRQ4LKe1LwQF8oo8k4+vG3IOTachSo1e8PTIGp8eg0DDtb9tZ31tU1AlqSbNm9UhnDEhytfLMLFyQ18YZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767032004; c=relaxed/simple;
	bh=Sx6td9lE4hKxIcubYKlGUxkmTnJwqHdVst8KiyaS81A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OceEzLZj0WKNNLKjwbVU5OxwQxaYnvtkBxc4JkWHgI0mwi5EaWCqsLbedESuNlUTQtOyGeeygMqF1tEGUYBDMg0hd2SamIF7JF4rW3jx9xuGqk+0kd2aNZLqsSSUQ+BZw2d3/dK4ySCJLgFPax+xWHS8svuGrGvZKnNcATuc/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huvdEHwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73859C4CEF7;
	Mon, 29 Dec 2025 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767032003;
	bh=Sx6td9lE4hKxIcubYKlGUxkmTnJwqHdVst8KiyaS81A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=huvdEHwIRCJ2VkVIhQ0zScq24SMYFzZDkePcd1jlMCYsxfn2uqOOG79smJ6OA6Nky
	 cvmf4lR/b07bg1NkKR5CG+pLP4oLM0oQnRqlL3kVXd3TeBZqorleISKOWor3AAcTXO
	 OpObe8NNmxcr0VL6ahH1d2Yrh81+398pkhGHJHazLjuKrW1OguahZYo4IpUF0dOUHp
	 eRItZ3UxWVmHNVFChU1dal4jce8vM0xV5N+t+KWk9ewypmBwCGbSfDTxDVUpuP95Ol
	 8xoLsDDatRtYbSAqijptvkcbAT8M/tZtT7BSe/r0tYq4u/yi3jZ51tnd0F48yiCl5+
	 ukspwNOBvkODQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7BD3808200;
	Mon, 29 Dec 2025 18:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: defer interrupt enabling until NAPI registration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176703180604.3020297.10151848837603097522.git-patchwork-notify@kernel.org>
Date: Mon, 29 Dec 2025 18:10:06 +0000
References: <20251219102945.2193617-1-hramamurthy@google.com>
In-Reply-To: <20251219102945.2193617-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, pkaligineedi@google.com, sdf@fomichev.me,
 jordanrhee@google.com, nktgrg@google.com, shailend@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Dec 2025 10:29:45 +0000 you wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> Currently, interrupts are automatically enabled immediately upon
> request. This allows interrupt to fire before the associated NAPI
> context is fully initialized and cause failures like below:
> 
> [    0.946369] Call Trace:
> [    0.946369]  <IRQ>
> [    0.946369]  __napi_poll+0x2a/0x1e0
> [    0.946369]  net_rx_action+0x2f9/0x3f0
> [    0.946369]  handle_softirqs+0xd6/0x2c0
> [    0.946369]  ? handle_edge_irq+0xc1/0x1b0
> [    0.946369]  __irq_exit_rcu+0xc3/0xe0
> [    0.946369]  common_interrupt+0x81/0xa0
> [    0.946369]  </IRQ>
> [    0.946369]  <TASK>
> [    0.946369]  asm_common_interrupt+0x22/0x40
> [    0.946369] RIP: 0010:pv_native_safe_halt+0xb/0x10
> 
> [...]

Here is the summary with links:
  - [net] gve: defer interrupt enabling until NAPI registration
    https://git.kernel.org/netdev/net/c/3d970eda0034

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



