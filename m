Return-Path: <stable+bounces-23313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FAB85F529
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 11:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7091C2483B
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A1D39867;
	Thu, 22 Feb 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbI24Rlr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47D38FAA;
	Thu, 22 Feb 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596028; cv=none; b=G8QldbFl5dEiDvT4rqzEScqQX+LULdW7EKp+bot6wdLNKtHkocDHfDFMzJ6ujA7CdIBxeqnoSw5/YV5w79SAHdetR0bhqD0cMH4ZTFV/JQE1RFqi+gGQkExH+Euh1RaGOb0oveeRpQW+ZJPkOgdOYxmC32klefIxfSVAD8Zr/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596028; c=relaxed/simple;
	bh=MgZBWQD+UuU/Rm53/wCaKNuLGJYzcd2Wp9TE7JUDEfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ktpj5AjWFcy6abPq0Hauf38YuqRiKa6M2VrdeXLaVXnn1BVvH979hiQGYUrEEatCY7pPLV9n9SmPaTQHaq6A7AM/eMv530bVjM6ER1ZrSuNoffruD8XrjRkqmQU6zaj8/m5E4H9xPxUvIs00HGKgwFTcQwfZGmKf8BeK4rcH/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbI24Rlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3C3AC43394;
	Thu, 22 Feb 2024 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708596027;
	bh=MgZBWQD+UuU/Rm53/wCaKNuLGJYzcd2Wp9TE7JUDEfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cbI24Rlr7Yw5qxE7JE6IulEcKnE0r1Nk1mWY4Ub0100X1YTCPSef7PEPjIgytmE7y
	 LCBJmeeGg7uP99wgN4LqFLohg7yAan4rE1CTxUuJkdVlMjEwgafU5CmXkYeqIgsZXA
	 MvaiglOW48Bh5h37iu3+i4BMHv069B450fG/8U+moiJCOrkM8tqGKYrVqfH6F8bZT6
	 2jhjMQWDhrLHRhD5sXiU668jVZ/e9b0bSJWgCZXz2x+A8vphAgZyMYpT0A74D0OPWJ
	 +IRrwbfNS6n8OYFBV/JVIiFwfGV1xt2Sgrfe3Z39qql802RH20mKABX+TIQXN1oWs+
	 EJXSQo8hanrmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCF33D84BBB;
	Thu, 22 Feb 2024 10:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: pass correct message length to ip6_append_data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170859602783.9205.8776466838961050149.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 10:00:27 +0000
References: <20240220122156.43131-1-tparkin@katalix.com>
In-Reply-To: <20240220122156.43131-1-tparkin@katalix.com>
To: Tom Parkin <tparkin@katalix.com>
Cc: netdev@vger.kernel.org, dhowells@redhat.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Feb 2024 12:21:56 +0000 you wrote:
> l2tp_ip6_sendmsg needs to avoid accounting for the transport header
> twice when splicing more data into an already partially-occupied skbuff.
> 
> To manage this, we check whether the skbuff contains data using
> skb_queue_empty when deciding how much data to append using
> ip6_append_data.
> 
> [...]

Here is the summary with links:
  - [net] l2tp: pass correct message length to ip6_append_data
    https://git.kernel.org/netdev/net/c/359e54a93ab4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



