Return-Path: <stable+bounces-75918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C2F975DA2
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 01:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B7D1C2294A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 23:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893EC1BBBD2;
	Wed, 11 Sep 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofhhvw4U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA01BBBC4;
	Wed, 11 Sep 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096832; cv=none; b=mvTskAyUr1AXclkO/UF465WWE8zQytc0XNuzZleDTkVgZ8mYDL3OfOlomCvLWtq2TdjPoUxDgJ9gcZ6LryTiljVfvlORXkg+hv3Js0b0Xzb6lTxiOtF/7K1mbQLH1n5Qg8cCWllingCi3kakIFTIMqb0uXYKI1yt1ZT+HknctaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096832; c=relaxed/simple;
	bh=Sm3+Z+imOoXao+PAzfYmKfln/1ivm+b8/7oJQ3m6sJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gCMkhyhUYPCSeSzysQ1O28EXEs5J7JJftJq6jJtVEeBuHhs/0fqqU2udmAM+EUrNfE0QpGSEr+5ki+/8fuzpdAtf6Zamb3ONLkedlWn950OlhSgosuXD6vtwSWLypU40sR2VzxmJMvYYEEcU7JibFBNSGS813k0wkkJiECy8Qtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofhhvw4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F3FC4CECD;
	Wed, 11 Sep 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726096830;
	bh=Sm3+Z+imOoXao+PAzfYmKfln/1ivm+b8/7oJQ3m6sJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ofhhvw4U5wu2RZyQWobuayOJED8RqKbpup14POEn0uhdkbnvGeQqXsLu2wBCVWYR4
	 8X0VGMlERAC1lcF7QADPf801Xnlsq7YVL12OmPpJdNI1bieRgnPcy5wcAFkGyoIMsF
	 tLnR5m1Q+grC1KF5Hm9XggZIxd5/PQkmiM6qI7gCZMPT6fdKcmZ3duyxbehpWjCl+s
	 T6X+2dN8OsnKIo+wjyd3SbSLUv0lLDCpEB/Wy8DWq3dFozyXRVQiqGkiDvDSVS8O9C
	 1N4ICY3xjLJT8CRCXnW+eGot6gGv9+gVJqVK9tIL9/WvDyisYvaAA6EH39wfqbuIhX
	 +vFX5HzJR//ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C743806656;
	Wed, 11 Sep 2024 23:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: libwx: fix number of Rx and Tx descriptors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609683169.1105624.13880705408167470260.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 23:20:31 +0000
References: <20240910095629.570674-1-jiawenwu@trustnetic.com>
In-Reply-To: <20240910095629.570674-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 rmk+kernel@armlinux.org.uk, mengyuanlou@net-swift.com,
 duanqiangwen@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 17:56:29 +0800 you wrote:
> The number of transmit and receive descriptors must be a multiple of 128
> due to the hardware limitation. If it is set to a multiple of 8 instead of
> a multiple 128, the queues will easily be hung.
> 
> Cc: stable@vger.kernel.org
> Fixes: 883b5984a5d2 ("net: wangxun: add ethtool_ops for ring parameters")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net] net: libwx: fix number of Rx and Tx descriptors
    https://git.kernel.org/netdev/net/c/077ee7e6b13a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



