Return-Path: <stable+bounces-17548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 742D9844DC1
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 01:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE3B22F0D
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6E652;
	Thu,  1 Feb 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQGgOwQa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28428374;
	Thu,  1 Feb 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746829; cv=none; b=I0BhytaiRuAnJfvjKHos1AmEZ4xUSdqUiqt7AbCBQ6ywd/I23VAPuppLlvtITxBsm4wVUIF25LUtMShQiOizfQ3s00zH7lUNMbR+6BU0CvRsHi15csMnzA5/5bdEJ6fK1D/2w2RE88cAkkKG9sXXikWpVQ30UgDgG8IqX/fyY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746829; c=relaxed/simple;
	bh=/VxkoqMjoE7DN9wE2kVN+Q8l8JnStP2ePctt+C58hR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jdECWYcYrnE3wjgqGlnxwPZYa2I/CoGoFNQDqHUT6XSWBCRZE8/84DMdwEoM6r9dnm8P4uhgs78sKRT57rcs8gO5H9Kt9UKzf5+R6pNlNFOft1Wqj2WC+JNRI2J7zz7zf/uT+eAqx01LM82bUCEm9HqX/aWx9rKin40ibAqytok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQGgOwQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BB30C43390;
	Thu,  1 Feb 2024 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706746828;
	bh=/VxkoqMjoE7DN9wE2kVN+Q8l8JnStP2ePctt+C58hR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TQGgOwQa1HrFRfb0GCdlXjNRLwUXX2nxq1RmI0+RAdkhkHWUgZaRNWAwb0Jw2GH9T
	 U8nChjyD7uioUW6+aeLJsKbvvW3HiFTqYvZNIE1TsYjJZV2OC3m6TXQE2v5u7sR0+u
	 g1rU/oBOxm2CZu5SwaC9gDdkMMU9H6gsITZjHTL1sIgYlIsQRym8KF4GlpY++TNLBs
	 noNUyVD6GF22GY9kmXXRkK2UBm8zmNIP4c/1AEmh3U3TstXcYGfzg04Q/liINj5qXj
	 SOVkjQxK8fSNTAGHtZmeQ3l1LEH6nLIwGG3SlrOns575RhuMME0iOANKPKV6SlZlQs
	 KBfIc2vQ8tr2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D8CCDC99E6;
	Thu,  1 Feb 2024 00:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: mv88e6xxx: Fix failed probe due to
 unsupported C45 reads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674682844.10400.9428070571469992334.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 00:20:28 +0000
References: <20240129224948.1531452-1-andrew@lunn.ch>
In-Reply-To: <20240129224948.1531452-1-andrew@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, vladimir.oltean@nxp.com, netdev@vger.kernel.org,
 stable@vger.kernel.org, tmenninger@purestorage.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 23:49:48 +0100 you wrote:
> Not all mv88e6xxx device support C45 read/write operations. Those
> which do not return -EOPNOTSUPP. However, when phylib scans the bus,
> it considers this fatal, and the probe of the MDIO bus fails, which in
> term causes the mv88e6xxx probe as a whole to fail.
> 
> When there is no device on the bus for a given address, the pull up
> resistor on the data line results in the read returning 0xffff. The
> phylib core code understands this when scanning for devices on the
> bus. C45 allows multiple devices to be supported at one address, so
> phylib will perform a few reads at each address, so although thought
> not the most efficient solution, it is a way to avoid fatal
> errors. Make use of this as a minimal fix for stable to fix the
> probing problems.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: mv88e6xxx: Fix failed probe due to unsupported C45 reads
    https://git.kernel.org/netdev/net/c/585b40e25dc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



