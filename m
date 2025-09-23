Return-Path: <stable+bounces-181419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659A4B93A8C
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 02:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2076A3A922B
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 00:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149591DF247;
	Tue, 23 Sep 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsLxTdPo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E8D4A0C;
	Tue, 23 Sep 2025 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585623; cv=none; b=N4m/6Os0WRdZIPOv3qhPA6GxtoWnYDo5XgGcI9hIhGOz0omran5T2epNKAQIy+6ErMcJmlB/Ilb/iDitvp2YZ4GUaA+IGrV58NjlCWDFbxD+4UWN3sXfwwPCQ+7zncZ7Orib/3NPvl8/dWJB08lo3XFPFrZ+p23nr551fq615/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585623; c=relaxed/simple;
	bh=aTWqzVPJp0tVTroXybp1dWR20hXFzK6CE/cu3gnsP2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MtXnn6Ixj0KqhQcKS9Xy0IBVOU8tJB+4PSJpCAqTHuFGn5NNneF9oIllbjwvJfj5LY1wjVIfdhNeMEs+skrh6RaOoPpv2VlmhiH54Y4+CoqxTbBLKFsCn6SM2ieiWpzRe2/4Ny3rfjlRwn618FD5KNMxD0NXc9cyLpzre8H4SrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsLxTdPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44884C4CEF0;
	Tue, 23 Sep 2025 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758585622;
	bh=aTWqzVPJp0tVTroXybp1dWR20hXFzK6CE/cu3gnsP2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UsLxTdPoIVxjiuhJ6oZeR9qTPblPBR9Y9z0Uhe4K2JHa2zoy5Y0LxePt8G+Ba6edM
	 1+imKt2kjzsUvRHujnNO9AQFxx0L6g2Ujs3FLew/ASwe+WJFfszmmIBQ2FSVo3dbVB
	 5t0myHcoi7VsSnx3p9UMYu3xZqmySNC2WRqO6/LI14d5FbznNTr50x+WcQ+LEh2NdY
	 fpNXvAc5ZxhE09Kq3M6VPAL2PYKKS8173UX7XLhyEEjpVMfXyd/DJGUOcZN0xBY5+2
	 XVpptoHs+nFYI+anTVs93w7sIVNwDcdivN2MEJIW5JFQdv5qA0iEAts7y3gIX6nXGa
	 qYL7ip2lq7rAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1D39D0C20;
	Tue, 23 Sep 2025 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8][pull request] i40e: virtchnl improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858561975.1199974.11092135002090778258.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 00:00:19 +0000
References: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, przemyslaw.kitszel@intel.com,
 leszek.pepiak@intel.com, jeremiah.kyle@intel.com, gregkh@linuxfoundation.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 19 Sep 2025 11:49:50 -0700 you wrote:
> Przemek Kitszel says:
> 
> Improvements hardening PF-VF communication for i40e driver.
> This patchset targets several issues that can cause undefined behavior
> or be exploited in some other way.
> ---
> IWL: https://lore.kernel.org/intel-wired-lan/20250813104552.61027-1-przemyslaw.kitszel@intel.com/
> 
> [...]

Here is the summary with links:
  - [net,1/8] i40e: add validation for ring_len param
    https://git.kernel.org/netdev/net/c/55d225670def
  - [net,2/8] i40e: fix idx validation in i40e_validate_queue_map
    https://git.kernel.org/netdev/net/c/aa68d3c3ac8d
  - [net,3/8] i40e: fix idx validation in config queues msg
    https://git.kernel.org/netdev/net/c/f1ad24c5abe1
  - [net,4/8] i40e: fix input validation logic for action_meta
    https://git.kernel.org/netdev/net/c/9739d5830497
  - [net,5/8] i40e: fix validation of VF state in get resources
    https://git.kernel.org/netdev/net/c/877b7e6ffc23
  - [net,6/8] i40e: add max boundary check for VF filters
    https://git.kernel.org/netdev/net/c/cb79fa7118c1
  - [net,7/8] i40e: add mask to apply valid bits for itr_idx
    https://git.kernel.org/netdev/net/c/eac04428abe9
  - [net,8/8] i40e: improve VF MAC filters accounting
    https://git.kernel.org/netdev/net/c/b99dd77076bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



