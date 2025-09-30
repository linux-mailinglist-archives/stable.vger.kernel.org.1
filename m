Return-Path: <stable+bounces-182053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46DBAC0DF
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029133A40DF
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878CE244693;
	Tue, 30 Sep 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu1wj6xd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4092BB17;
	Tue, 30 Sep 2025 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221013; cv=none; b=cLCDe46MsUPOl1L+7tkU4UFG8KTmPIETXPpBIHGn3lTzKMZ7GjIE2uKnF02FZOAIWo+DEJli06PS2jf9q/MQp+tlmRaPYxtBnOvmmmIa1zLYtcDXCIgAdpuA6XVHW0EXi7pqh2caytX3HUGr48gaYPLQspTejImQVBQiYjt+DUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221013; c=relaxed/simple;
	bh=yMMeJdLx4XblKD8OQUJirZMZelXcwNUtF8vTNEGW8RU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=idZoc+/90qeFnhQ8fFU8UM9oWJs8soDlc905PzW3gPY1mOtmpFTbe+QalBkfbHSRDxqf56K/gOpqabeaGd8c6N0w5DGbEXu0CJ2FDVowAE5ynYzXCfbP9+6gSh0hIMWV8RSc7VbPVKxZL3zsValfUtUAVqZ/t9U3IG4voWHT+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu1wj6xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB72C4CEF0;
	Tue, 30 Sep 2025 08:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759221012;
	bh=yMMeJdLx4XblKD8OQUJirZMZelXcwNUtF8vTNEGW8RU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zu1wj6xdAb8IiLDQccASL9uWBNGPlOu5lN3gmENmgzVe16bVr0004/RxPu5qBMzPq
	 43NBkJ37E4Xg1HDRtmOkVBOxaGnfuit22zmRyqm3DAsx8HMz5buXNrm0wO7P5HEHI0
	 KHQe5Gk9EeZODb16/VPRaC1jEJ9risZP0JtJ7JaZXUqaiAiurnAPpIg4e0yLEAiBmL
	 7pyl/lVKXol0/IMA5E7pyruYPA3TpiELA6ChIwsA++DoqTW6TZmGOOfuWWRYlKrPRT
	 UGbRMoxIZWQuLCMkoNqoUr3BWeicbegefgq/bgh93F+f/G/HCSsTmMMx73DXjy0z/O
	 sI5RlYRP0xFzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF139D0C1A;
	Tue, 30 Sep 2025 08:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: nfc: nci: Add parameter validation for packet
 data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175922100601.1892773.12754446584125259059.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 08:30:06 +0000
References: <20250925132846.213425-1-deepak.sharma.472935@gmail.com>
In-Reply-To: <20250925132846.213425-1-deepak.sharma.472935@gmail.com>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>
Cc: krzk@kernel.org, vadim.fedorenko@linux.dev, linville@tuxdriver.com,
 kuba@kernel.org, edumazet@google.com, juraj@sarinay.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 25 Sep 2025 18:58:46 +0530 you wrote:
> Syzbot reported an uninitialized value bug in nci_init_req, which was
> introduced by commit 5aca7966d2a7 ("Merge tag
> 'perf-tools-fixes-for-v6.17-2025-09-16' of
> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools").
> 
> This bug arises due to very limited and poor input validation
> that was done at nic_valid_size(). This validation only
> validates the skb->len (directly reflects size provided at the
> userspace interface) with the length provided in the buffer
> itself (interpreted as NCI_HEADER). This leads to the processing
> of memory content at the address assuming the correct layout
> per what opcode requires there. This leads to the accesses to
> buffer of `skb_buff->data` which is not assigned anything yet.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: nfc: nci: Add parameter validation for packet data
    https://git.kernel.org/netdev/net/c/9c328f54741b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



