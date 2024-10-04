Return-Path: <stable+bounces-81140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80828991298
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 01:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99D21C22392
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 23:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BEB14C592;
	Fri,  4 Oct 2024 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4R3ocJ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5214830D;
	Fri,  4 Oct 2024 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082825; cv=none; b=fi87LcmXzhdf6t4vsBBxpw2S9FYYVGuLvJoMqaM/goa7ytrYZbkrYlTYuphJD2rA4SlR4pquEy3L6H8H+fyrB9KqLC5bvRmr5dQJ3XhIlxvELZJWBYXCJ0vLncnNp3r5ehpJmO9+b8I9w8pUfTkYhzFiTD4QCU3Hqsl+ErhK+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082825; c=relaxed/simple;
	bh=R+gjNRVfnr4b2QguWnPQ9uHVId7P1lEKP2S90CyBzhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bn74eaqfBkquw/YyqW2Np7DJZFgafZn2bElEtDudsA8rmuTzd4m25UX3ZVFW6yH+fVOYK8PuIe1VIYVfb/wujwqQB/zVMf13ykmVzBuTpJHN9DyelRiw2N4GBq6j7ViaPUGCw3F7mHejuvb1pAjyUVFUv2s2qnyGzQZQl+ckozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4R3ocJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24F7C4CEC6;
	Fri,  4 Oct 2024 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728082824;
	bh=R+gjNRVfnr4b2QguWnPQ9uHVId7P1lEKP2S90CyBzhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t4R3ocJ9fOU/I45zZsL3p660lfKMej+QTupOTnig2vYJBqxuKMbTKxBUdEPxuE2fr
	 CRanUAUHy5dL2L+Q9Di4ArVVDtNTZvuDB31WDgT6Np2auqVMb9nLj7ijggzattYybB
	 aoy3JaKjTAIV+j3h4BtrHnbCh0Mu0dUmebNM2hlebudfFndaLLM5GGwlPszJGkqS/B
	 g5STQxgL0NHhtI0/pLnazFxXmS3eoHm9pwPuvGsP9+s4h+hWAcVhOYkrc/CfFJAwxv
	 QTIhGLmegbWTvUvXT1qcZU+0yH0p3zsKQGM3583+8OjJ9URLbGiaIVkZf/y3glqBSr
	 fasMJVvxjy1tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEAE39F76FF;
	Fri,  4 Oct 2024 23:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: Fix an unsafe loop on the list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808282853.2768008.14264278350772828485.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:00:28 +0000
References: <20241003104431.12391-1-a.kovaleva@yadro.com>
In-Reply-To: <20241003104431.12391-1-a.kovaleva@yadro.com>
To: Anastasia Kovaleva <a.kovaleva@yadro.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux@yadro.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 johannes@sipsolutions.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Oct 2024 13:44:31 +0300 you wrote:
> The kernel may crash when deleting a genetlink family if there are still
> listeners for that family:
> 
> Oops: Kernel access of bad area, sig: 11 [#1]
>   ...
>   NIP [c000000000c080bc] netlink_update_socket_mc+0x3c/0xc0
>   LR [c000000000c0f764] __netlink_clear_multicast_users+0x74/0xc0
>   Call Trace:
> __netlink_clear_multicast_users+0x74/0xc0
> genl_unregister_family+0xd4/0x2d0
> 
> [...]

Here is the summary with links:
  - [v3,net] net: Fix an unsafe loop on the list
    https://git.kernel.org/netdev/net/c/1dae9f118718

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



