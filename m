Return-Path: <stable+bounces-163053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806A4B06A9B
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 02:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B3F3BA5B9
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 00:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6ED136672;
	Wed, 16 Jul 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsiFkweh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1DEACE;
	Wed, 16 Jul 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626397; cv=none; b=C6C9jlpPfbGlmQwXZWM5h2rxqiSqCv1xhyWBA8RnQKuCxyZ4W74QuqOYE7EpWSyktdr2OKtCtDMqxsVHAcnzBZZhlzY6ArVUWZFurmR+CjVlOOpQCAH43sRPSdtWLPEAsB1+u8GsZ7V8DF2Nu0F3zMxyOFAkZevIf8EQghZ4UzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626397; c=relaxed/simple;
	bh=2jvDQ7D/joRUgBAMi1PNempDhuHm6nOs68Sd7roppcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PrhRXI9wRVaLmJ9Q1rMhZX6A8h4rHnhxSUW1TNopHoali+Dc686amF8mLbl/mlF6YyP1TdQSg833P5EFigeYr8t+pOYIlB4g2cVP9bSh9w42vENCjHdUN5xNwvvPgH0oFXFlgKg03PyrAnrdImEIFxnzTTkILununXPXdVBXM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsiFkweh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37282C4CEE3;
	Wed, 16 Jul 2025 00:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752626396;
	bh=2jvDQ7D/joRUgBAMi1PNempDhuHm6nOs68Sd7roppcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EsiFkwehWj0aZE3h2RMY8MISbHf5OiT8nNVWeFXKYEFFP7J0oqaONdvZiZ1eQnjAJ
	 juv+Xisoondbqcon/eKduiqv993Kb9IOBA6XZfhSP8qzRGISTk7EnlvybMYanwHj5X
	 XTc5NcwXAPUL4aYz50sw+chjiX2bEwpo2kwan7J9ViKDSjeFD42rBjI7VcqMeZ3h4y
	 j4bCQnmQwE1kfyiPlKabHQ+bSHkOJjKW3JLiAIW+dDxIH8tjQFOSPWQwRAonrmBVyl
	 QzUwfVM+8DQsbFxMo53IDMV10owx+1PZZc6S05d7MjV1xRV1qFG1oLI+/CCtaoiQZD
	 iTXKPM8U8Tu0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE11383BA30;
	Wed, 16 Jul 2025 00:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: fix fallback-related races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175262641675.629458.14397813490608443353.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 00:40:16 +0000
References: <20250714-net-mptcp-fallback-races-v1-0-391aff963322@kernel.org>
In-Reply-To: <20250714-net-mptcp-fallback-races-v1-0-391aff963322@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 18:41:43 +0200 you wrote:
> This series contains 3 fixes somewhat related to various races we have
> while handling fallback.
> 
> The root cause of the issues addressed here is that the check for
> "we can fallback to tcp now" and the related action are not atomic. That
> also applies to fallback due to MP_FAIL -- where the window race is even
> wider.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: make fallback action and fallback decision atomic
    https://git.kernel.org/netdev/net/c/f8a1d9b18c5e
  - [net,2/3] mptcp: plug races between subflow fail and subflow creation
    https://git.kernel.org/netdev/net/c/def5b7b2643e
  - [net,3/3] mptcp: reset fallback status gracefully at disconnect() time
    https://git.kernel.org/netdev/net/c/da9b2fc7b73d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



