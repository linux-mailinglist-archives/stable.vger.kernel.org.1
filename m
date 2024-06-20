Return-Path: <stable+bounces-54696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5C910029
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2131F22945
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83900159565;
	Thu, 20 Jun 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7PLwHk8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A719885D;
	Thu, 20 Jun 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875229; cv=none; b=q2K/UTj1/4vsvO7bqmQRKwYbmfAkWOzYp3nge3FWCOtajjrjV/PBlcoIhOhTvknqcQ+ss2kTb0q8pcSFMfHTpLg1ilMGLsBMuL91W0OB0wvZlffQ2zs7R4DcQ3/xc6GiaXz+ydCrINiKtt6D2l1QKoT4wAQsRVVIA0lpcdboioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875229; c=relaxed/simple;
	bh=TsjBdco4WqPbFrfrhTHCNXVLt9W00g8TPhke9yxuoCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DDzqoVnlHeNeeTggAi2EAjs49zGBznjsvdhVIir2lLs2RPd5bKAdt/pCTEHUQQSHU1ZrIhGVQPKIfdB1jrSZkthD+wakGeL2z7svocRC64b2d886RAmR6nsrt+bFekPa1yk7vve5JowIUv5YmdynOJ6TPoK7cxVPRr1jlCvxB6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7PLwHk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9957C4AF07;
	Thu, 20 Jun 2024 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718875228;
	bh=TsjBdco4WqPbFrfrhTHCNXVLt9W00g8TPhke9yxuoCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H7PLwHk8U7P1HuQQurdNoJxJpAcaVnrUtDvG3IC+Zkz3t6XhR8Yh1MrWnFHHmxk8G
	 ZuIx44i2KgIvLjKJomfIRanjocgMkpY5hPGs9KVnqrD/8l9n+2zsyDSuvkK1MggAoE
	 la/sDKbT1BYtfA8LTF2Iz7IdXeN339pgH13xp7IkVy8KjAtp/feRk/7aa1hVC/nbfv
	 /sU3n3pjwuR4nZXBMzFm3FvyVr04WlHK1H+wjYmKjF1JX6JIjr55eRjPZSOCbAaf8H
	 tCySSPbZ25pM1AHnyioZYY0YAb9agqmq6SRPXWxiJAnqkIebCCjah6gcQfy9k4+/qo
	 IO3wIZ6hGkHAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95259C39563;
	Thu, 20 Jun 2024 09:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: do not leave a dangling sk pointer,
 when socket creation fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171887522859.13884.11995426221933987830.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 09:20:28 +0000
References: <20240617210205.67311-1-ignat@cloudflare.com>
In-Reply-To: <20240617210205.67311-1-ignat@cloudflare.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, revest@chromium.org,
 kernel-team@cloudflare.com, kuniyu@amazon.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 17 Jun 2024 22:02:05 +0100 you wrote:
> It is possible to trigger a use-after-free by:
>   * attaching an fentry probe to __sock_release() and the probe calling the
>     bpf_get_socket_cookie() helper
>   * running traceroute -I 1.1.1.1 on a freshly booted VM
> 
> A KASAN enabled kernel will log something like below (decoded and stripped):
> ==================================================================
> BUG: KASAN: slab-use-after-free in __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> Read of size 8 at addr ffff888007110dd8 by task traceroute/299
> 
> [...]

Here is the summary with links:
  - [net,v3] net: do not leave a dangling sk pointer, when socket creation fails
    https://git.kernel.org/netdev/net/c/6cd4a78d962b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



