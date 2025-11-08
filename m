Return-Path: <stable+bounces-192764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D9C424C7
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 03:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0BE3B7A06
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CF8146593;
	Sat,  8 Nov 2025 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX+6staN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F1A55;
	Sat,  8 Nov 2025 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569034; cv=none; b=u9hCUYvYgCU1I+66ciBh45pBCmVYuGOTajId7VVh+dTfPF+O82oX+NlAvyCcSw3EDqi5luBTdRfzo0Y1IGhRIMOEULl2RLaqJaC5OQAhpvOoJpoXF5GgXspX/sdwzJg2A/grH3XRBzenXOrtPQyqw7Amzd//HNMczJWpmOGBNxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569034; c=relaxed/simple;
	bh=utwwffiLOvL0IhGPzMNLUizCj0nUQvI+q5LRTM2t5pk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JALRtHNc2kCoKMbW7zLQ0QmXwmLQJGuQcQLqkJD5YUuaiJvhTj/Xcuu5/2EIvxJlPknboqPAujLAhnZSAxI0OgMHuwl7jWNqEfrEWz2EUhmAn+Rgg9si2o0WdH6THqnZ8rl8wHX6kZjVxJlBDn9+frzU6naGqoOsyLkwqbTyq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX+6staN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2E8C4CEF7;
	Sat,  8 Nov 2025 02:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762569034;
	bh=utwwffiLOvL0IhGPzMNLUizCj0nUQvI+q5LRTM2t5pk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kX+6staNnHZB8qrXlfo6rcJBnWn8B2z790HtZ/ElnkR0LawYNZOXhkFMxN2FbBUhY
	 N2wwZguDcsgoysmp+jd9AoAz6VOekDYXzXX5WrN6tZeKs9OBpVFbaHKZPvzlHkcWti
	 dOJi5UhfI8kBPQYbtZeUm6eWFllmdgv79WwmF3GtU85g0nsgXMfeoMWCVfo7DepWmf
	 IMPFHlvc8ZFp2imAsELn9aBeMTkt7b4yoJLTqy0ctafb1JNQVBYcIO3fU7Do9y8AdU
	 k1KcVNSciAHM7VCVgSJ0Q3mQQle/7iR8FwNZMphUCLGGq5oFeOFmd3H12NURPumzXu
	 qUnhzTmxzA+tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D533A40FCA;
	Sat,  8 Nov 2025 02:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] strparser: Fix signed/unsigned mismatch bug
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176256900601.1226704.4652843459879323361.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 02:30:06 +0000
References: <20251106222835.1871628-1-nate.karstens@garmin.com>
In-Reply-To: <20251106222835.1871628-1-nate.karstens@garmin.com>
To: Nate Karstens <nate.karstens@garmin.com>
Cc: netdev@vger.kernel.org, nate.karstens@gmail.com, tom@quantonium.net,
 sd@queasysnail.net, jacob.e.keller@intel.com, stable@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, martin.lau@kernel.org, jakub@cloudflare.com, mrpre@163.com,
 linux@treblig.org, tom@herbertland.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Nov 2025 16:28:33 -0600 you wrote:
> The `len` member of the sk_buff is an unsigned int. This is cast to
> `ssize_t` (a signed type) for the first sk_buff in the comparison,
> but not the second sk_buff. On 32-bit systems, this can result in
> an integer underflow for certain values because unsigned arithmetic
> is being used.
> 
> This appears to be an oversight: if the intention was to use unsigned
> arithmetic, then the first cast would have been omitted. The change
> ensures both len values are cast to `ssize_t`.
> 
> [...]

Here is the summary with links:
  - [net,v2] strparser: Fix signed/unsigned mismatch bug
    https://git.kernel.org/netdev/net/c/4da4e4bde1c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



