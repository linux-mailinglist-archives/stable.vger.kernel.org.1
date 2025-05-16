Return-Path: <stable+bounces-144637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A21ABA661
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 01:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30357BBA01
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D24D281358;
	Fri, 16 May 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXBpW32j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3926281341;
	Fri, 16 May 2025 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436999; cv=none; b=ooHexJyjqUUw5zXxUfz4ttMau84BxpgTXkTQUj/nDWmPU2Wj7R3KAYbP+sJVNtzDIsyAY8CbpDjcEFNxngRqMkyRL3j5gggUiZM3jEyTbhaClywJrmmsXoMj3Y1nvkzCcbII2FLm14dd1uutzy7mtqDvDFQkFNUBVVFPjPq0/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436999; c=relaxed/simple;
	bh=0Vy5sVsDWeE1upI11kp7jf8llc1Sgop4vwX+lM3uqqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O9DGKW74mlsaRtvWwwvOmuN5CHy8eEO2NFcJ4mPp6X3rHwpePCbZysE+R4Ig5ra1Et2NMNFd12PBmsicHaSF6V0YP1MqvFp2LCmR1c7wKk9iRmhypW8Lx0s4uhcUQYwoJ0Fa5Bl9UATENAXwNy1iZtMDT5lRNalM/1UQbBzHD+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXBpW32j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F244C4CEE4;
	Fri, 16 May 2025 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747436999;
	bh=0Vy5sVsDWeE1upI11kp7jf8llc1Sgop4vwX+lM3uqqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rXBpW32jnG6dEgUMelOxf0P8M7pgwVkpQllW/tmkUXccZqOOWUCaujfR7V6WFiqII
	 +P2oKssOl9b4MyQgoAL56GhppRm+5FUtMWJqZZXqfPDbxF3cNQyXWfd7L6QCi2aonW
	 QNoZpP3UXHkhjZZxN1R0Y7xfT6QejpDRoZodv54iMruJTn0KMXnUKjPxcuGsjiFsH8
	 I/w+6xyXZFEF6XyPI9orwHf3A5MKww2uY4XcZsG992uS/lyENuEm3Li1zvmMeBru6d
	 03+S3nmXo+zRodS3jKgR6g1t8NbpByuAazu05PSQe8xwEBA2ZLSzutnoW/sTs0R65+
	 G3YZusIeFPJTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E903806659;
	Fri, 16 May 2025 23:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vmxnet3: update MTU after device quiesce
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743703575.4089123.13792303088374756172.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:10:35 +0000
References: <20250515190457.8597-1-ronak.doshi@broadcom.com>
In-Reply-To: <20250515190457.8597-1-ronak.doshi@broadcom.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, guolin.yang@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ronghua@vmware.com, sbhatewara@vmware.com, bhavesh@vmware.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 19:04:56 +0000 you wrote:
> Currently, when device mtu is updated, vmxnet3 updates netdev mtu, quiesces
> the device and then reactivates it for the ESXi to know about the new mtu.
> So, technically the OS stack can start using the new mtu before ESXi knows
> about the new mtu.
> 
> This can lead to issues for TSO packets which use mss as per the new mtu
> configured. This patch fixes this issue by moving the mtu write after
> device quiesce.
> 
> [...]

Here is the summary with links:
  - [net,v2] vmxnet3: update MTU after device quiesce
    https://git.kernel.org/netdev/net/c/43f0999af011

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



