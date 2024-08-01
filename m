Return-Path: <stable+bounces-65238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91C944985
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 12:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF07B25CEF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A945187FEF;
	Thu,  1 Aug 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZugL1Je"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A03187FE0;
	Thu,  1 Aug 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508833; cv=none; b=WeqAAJQNYqDZPipoFHJMKuN6LDUHZVRVt2hODzLQLx+mHD8DLtWUq7gC3URhfw5vQUtfbqEIPwTM5uKmzAAed6QmYFeksXITZrT1VVYPzdexHJ05VK3c0O990U46B6U1yGkJPbZxVKhIiZyMWW8D1klkuQ5yk2CUvvoe7Yh2MoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508833; c=relaxed/simple;
	bh=2q2T8OdrEq27C9ZKfvlSIrAmUo4Eh2cDSpGER21hlxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zh7HdsPBknrcbhPcamtGtCM7JfCiB5cKNFEvJPycKFmqnWjAMoRNw5JiSX1PO3Hj3R9qZjecZUeKOXUIc6qSQchWZBjlCa6mCqzIVJBtiqj7rz5kOVwjCPM/bGEDuetZzRaMoKgqatNGwNasgidQw4ExSBZiWwFIS41+wGG05LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZugL1Je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E01DC4AF0A;
	Thu,  1 Aug 2024 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722508833;
	bh=2q2T8OdrEq27C9ZKfvlSIrAmUo4Eh2cDSpGER21hlxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hZugL1JewChLc3ZuuFazc3pa8bK+4sdXrBNT86yIj4krgfADFI+klXnexoWqBwDcp
	 08/qPuN6kongh7n+IkI9cy17HpLL6jf2F4kWIUtll8/JN5qJZewfRzxS2MqwMJ5DaB
	 sw8LeSJK+98Dn/t4bsdV/39/1SYGDNbTsKyI2RL6xNd51ilPvn4Il1OSdW7YrdF048
	 BZ8L23NXAoX4LdJFXQBZgWDuEFsUswjINwKlBEmO8bd6sDNvZsTWaOkgA1LQseU8dT
	 4zAsQySJdrMfYjKhZZDukSgHhJJ68PIId818yUWecKodtZpP+T5QWNb0x22fkc2+66
	 TmKHICkzpZeQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4012EC4332F;
	Thu,  1 Aug 2024 10:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: fix duplicate data handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172250883325.19369.10430286155918787795.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 10:40:33 +0000
References: <20240731-upstream-net-20240731-mptcp-dup-data-v1-0-bde833fa628a@kernel.org>
In-Reply-To: <20240731-upstream-net-20240731-mptcp-dup-data-v1-0-bde833fa628a@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 31 Jul 2024 12:10:13 +0200 you wrote:
> In some cases, the subflow-level's copied_seq counter was incorrectly
> increased, leading to an unexpected subflow reset.
> 
> Patch 1/2 fixes the RCVPRUNED MIB counter that was attached to the wrong
> event since its introduction in v5.14, backported to v5.11.
> 
> Patch 2/2 fixes the copied_seq counter issues, is present since v5.10.
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: fix bad RCVPRUNED mib accounting
    https://git.kernel.org/netdev/net/c/0a567c2a1003
  - [net,2/2] mptcp: fix duplicate data handling
    https://git.kernel.org/netdev/net/c/68cc924729ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



