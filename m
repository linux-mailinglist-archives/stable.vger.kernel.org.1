Return-Path: <stable+bounces-83290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA4997AB7
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 04:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8884E1C21C57
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 02:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55374189919;
	Thu, 10 Oct 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNWEEi+h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C68188000;
	Thu, 10 Oct 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528629; cv=none; b=Bt/EfSbV29Mo/fA41y8kGvcn7d7xDoGl9oA6ZT0W5STs6LjGhE+6EKEmsQmfB9+cDFijauhT8M/HGm/Jej3DmSFxEVZ7rYMTavwtlc4InViD+35SXZQk5WQM5GcbcvdpRNO51jgOD2GQAzh8xChirOFN7CpjVYAjA4NFylCNA1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528629; c=relaxed/simple;
	bh=i+qyl4CRczxO+Wnas3t84So0uuLSVlqua8L8kuRqYMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ms/q4vL3IV10STh0XidwESnpZRYullD8CQQh4E5/c9U797FeGTq3M5R6QTbfSMLyOn9pBHDvo3Xqumf9t07xK0zL+QAaEPzuPceW66YHF1ranyV4CdQ9qSJBephr324uf4BrSQdLHZmnpznPcOlgklbR+I+JJSIH9ZeyjAtcGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNWEEi+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E5CC4CECD;
	Thu, 10 Oct 2024 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528627;
	bh=i+qyl4CRczxO+Wnas3t84So0uuLSVlqua8L8kuRqYMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VNWEEi+h7XQSuh/DYzPldjZcFDzBT0iO/+dU/8xs8TSKXLVnVOashH5VJJdcgrLPM
	 FfPHON4vb4TTqXoEeBk8cSfnQtgUaOvFdPtTIM+ig+mvwkiPf8IBtXQqvav7eDi6Tl
	 etpwn1MitngiXR1py4bqF1Bz+3CsRAsoa9hhTA9zs7Q3hHqv5AA3L1vXKmIT2HSTg4
	 nmF6Mms4kDTQZREykBs0agtUsxTdW6GzsgigPPmdARYswo5b1sudugXS21wKtRJIo4
	 FX+Sa2xzyMyw66tSOzbx7T7uYwjkFR20BJZodpdrLsc0+vP74a5Pd54t8/Z3Yu5LML
	 FBo40qtayrdUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF63806644;
	Thu, 10 Oct 2024 02:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: misc. fixes involving fallback to TCP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852863148.1545809.14189962333547846785.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:50:31 +0000
References: <20241008-net-mptcp-fallback-fixes-v1-0-c6fb8e93e551@kernel.org>
In-Reply-To: <20241008-net-mptcp-fallback-fixes-v1-0-c6fb8e93e551@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 fw@strlen.de, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com, cpaasch@apple.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Oct 2024 13:04:51 +0200 you wrote:
> - Patch 1: better handle DSS corruptions from a bugged peer: reducing
>   warnings, doing a fallback or a reset depending on the subflow state.
>   For >= v5.7.
> 
> - Patch 2: fix DSS corruption due to large pmtu xmit, where MPTCP was
>   not taken into account. For >= v5.6.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: handle consistently DSS corruption
    https://git.kernel.org/netdev/net/c/e32d262c89e2
  - [net,2/4] tcp: fix mptcp DSS corruption due to large pmtu xmit
    https://git.kernel.org/netdev/net/c/4dabcdf58121
  - [net,3/4] mptcp: fallback when MPTCP opts are dropped after 1st data
    https://git.kernel.org/netdev/net/c/119d51e225fe
  - [net,4/4] mptcp: pm: do not remove closing subflows
    https://git.kernel.org/netdev/net/c/db0a37b7ac27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



