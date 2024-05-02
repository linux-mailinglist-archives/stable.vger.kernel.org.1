Return-Path: <stable+bounces-42928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B106C8B9358
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0511F2339C
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 02:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084417BAF;
	Thu,  2 May 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0PCbwie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD010A24;
	Thu,  2 May 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616430; cv=none; b=JfKM8XEd9dyjNF38qSfMCmMsR6+Wf6kpf0MwHVEDx8+wQPlNBEH4vQA7yJWBYZkD0x42SRBaUDG4ezlInfCPRrXSOoxDH2eMXGCpS5BwVA+71Qpkx51ka8Qg9txFFP+OxviX7JwsRDmCnrPbsdZxadvoaS6mmnuYhai5aU4xpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616430; c=relaxed/simple;
	bh=EpoeCQTekKXnxryqY7Nzpu0h6u1MO41g+Il26PnqdeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LBjADU4AIPLM51D2KhBaJMnMjT/CKqspGiXBm7y6xD3VoAX4LHAkQAoi4xUzKP55klKZ57X6buihQesgIB8tms4zpMXH2Imc5VV1PM/0Aqz6w3TQtLdra4zHPIAefigvqrWRcpx9z+YgMDXdzcZccADc4vOBo2le0K2clUwpopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0PCbwie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43603C4AF18;
	Thu,  2 May 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714616430;
	bh=EpoeCQTekKXnxryqY7Nzpu0h6u1MO41g+Il26PnqdeY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R0PCbwiezEwfAQs3OcDMsSu/2qCVoqDZpikeuRO4h/PEU2AXrUddtrFNINXISHbhi
	 osbQpdTaCp4FvKmn3BhB3kl7HQpLnDXoeNqbfM6UZcEA2IqmtQhQLKy4RuaQhjrmZF
	 vjFzgaV5USq0QQtt2XNcwMRaX78fOcUf1tO01SBU7+48OG4Clcld1vHhvy70cCgkD+
	 6E6ElgKE1pm7ycMIFROplfYR+EULWN7PUcQR+8RfheKFRxAG2s/+7J5OazEG8InQpe
	 L6jlLDDwwIqpC5U7pLs9f15Zw99Ua9++VygGgjh0hucfLpVT4ZX5FR21ixQEMJoLF2
	 R2D0mOiqLyztA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C9E6C43444;
	Thu,  2 May 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix UAF in error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171461643017.4262.9641718304447428848.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 02:20:30 +0000
References: <752f1ccf762223d109845365d07f55414058e5a3.1714484273.git.pabeni@redhat.com>
In-Reply-To: <752f1ccf762223d109845365d07f55414058e5a3.1714484273.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, jmaloy@redhat.com, ying.xue@windriver.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 tipc-discussion@lists.sourceforge.net, lxin@redhat.com,
 stable@vger.kernel.org, zdi-disclosures@trendmicro.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 15:53:37 +0200 you wrote:
> Sam Page (sam4k) working with Trend Micro Zero Day Initiative reported
> a UAF in the tipc_buf_append() error path:
> 
> BUG: KASAN: slab-use-after-free in kfree_skb_list_reason+0x47e/0x4c0
> linux/net/core/skbuff.c:1183
> Read of size 8 at addr ffff88804d2a7c80 by task poc/8034
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix UAF in error path
    https://git.kernel.org/netdev/net/c/080cbb890286

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



