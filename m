Return-Path: <stable+bounces-93073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513C69CD5F0
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 04:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A9E282D38
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 03:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778BF1553AA;
	Fri, 15 Nov 2024 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLLh9SwC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6914A627;
	Fri, 15 Nov 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642020; cv=none; b=OQOsplfUT+kCmMwDvPL58Xr/tMJjzV3bX4B6WY50lRP9dSzI/LlSJTthA56c+kWiaPva5skrqUL0UIyW9GAXbh93H3qcjxAlsexikJIzYKItNt+LXa6Ky0kEBFhaRicEdOh8zOi6ypUvm/2a+3A9CawENAAJlOfGtxlwqAlLJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642020; c=relaxed/simple;
	bh=G2uInqF8/nQM1NBix6fscRtHpgYOItzsoI2/fH2Us7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CD2zmA33XoBucpQiXYnYTcYzgto2/92t0BswSggo3Ya8crtuBbKjXKZQfIL5jMwGZi4bwDPaEfQlhJZkyZFwQFBOaGZmWd2zb4bSGI4OZaPfI0Vh1Rz56hBgLQLl3Q7N/RqvpeLJVRAOIk5QvBAqhjBzqkpAJvom7MoHyND4xZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLLh9SwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8AEC4CECF;
	Fri, 15 Nov 2024 03:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731642017;
	bh=G2uInqF8/nQM1NBix6fscRtHpgYOItzsoI2/fH2Us7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VLLh9SwCUMPqEcsuP6K36BOtyZggNSmuPmN5boJvnZYtkH1yIp2PNqh+ZBWmy+AOS
	 ZnFt45bncUiP0ZT7JE8YEVtKjUNsUxOxiN8hdDcLswYrNppUKNU3WT/AdMdR5q5Nad
	 YxVVpUOjo8OSBsNheMt65oDAAfCZD2EO9o/vb/RJSGGbDkVJYSmgaMFASP/8Y88m1R
	 kaO1uhGOZsZLtPHwix+JDH5yAWKMsT6n98oMT+iqcYoi7HEOEG65PBbsL4WSOmd85z
	 S7nY1YzELwbuNvP48aEisyByrRemLfOh9F1JPzKCISdt+stYxotWjK7XnbvYIRw9hC
	 WkreS+5yx7wyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCC3809A80;
	Fri, 15 Nov 2024 03:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: Fix handling changed priv flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164202826.2141101.1147325263004116030.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 03:40:28 +0000
References: <20241113210705.1296408-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241113210705.1296408-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 pegro@friiks.de, przemyslaw.kitszel@intel.com, ivecera@redhat.com,
 stable@vger.kernel.org, pmenzel@molgen.mpg.de,
 himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 13:07:04 -0800 you wrote:
> From: Peter Große <pegro@friiks.de>
> 
> After assembling the new private flags on a PF, the operation to determine
> the changed flags uses the wrong bitmaps. Instead of xor-ing orig_flags
> with new_flags, it uses the still unchanged pf->flags, thus changed_flags
> is always 0.
> 
> [...]

Here is the summary with links:
  - [net] i40e: Fix handling changed priv flags
    https://git.kernel.org/netdev/net/c/ea301aec8bb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



