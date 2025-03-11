Return-Path: <stable+bounces-123229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F4A5C409
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7DA188D039
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667F25BAA0;
	Tue, 11 Mar 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi+dcDOd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB431BDCF;
	Tue, 11 Mar 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703997; cv=none; b=aI6jpLgHTmmNFpl4ZZ9KEo8rtxBne/AjhYvhEQFE6CQUsjEfODRerV7P37RfRKto9HyL2GA/Lnv19IHUq0aOQnW4HxuN4XV3RYYXwfj/Qpo2/VYiR2FGyYcWCVVz9cKmeirATULAnj1yaU48olVCSsuk7ifgBEEA2NFmdqyuBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703997; c=relaxed/simple;
	bh=O4Dyi8KB8hFhkudqC2SqL73zWlG6UJQcLWe6HmeNBDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ejZ8Rjtu2qTtBfWBSgm7LERDmhMt6Mai1bw5HjVV2pUoPJpxU69Z/W1QMNFlheKF774BKrS5VEqEBSVSopcI3vcrYbsOfDMCyspDTZjuHTvHmsDwEPjgZJsu3/EuOW+fYs4vwvbwxAj8F0g4CpldUxp/UHgoGJCB1UNY5gJLJrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi+dcDOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B58C4CEE9;
	Tue, 11 Mar 2025 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741703996;
	bh=O4Dyi8KB8hFhkudqC2SqL73zWlG6UJQcLWe6HmeNBDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hi+dcDOdoenNo2CiHC7WxxYWQgkGDhMGf0Km+P5WNqNeaT3tSljziDc7re13H3ai1
	 tV8mizkqULaoSHNM2ZBEKihPh4mCno54pHf8mPPaFwVuCH8zgEbGgHmxkTB6+e+iCw
	 xyMJ7LivxZLAXuH08Q4uf7jN8iCZSiyTL29dDeF+jCl5JAfCrwZ5nvxBvdhLtwz3UC
	 Qq+sK0a4OLcb2GShn0TfeVhJPKH2PO2+bKF4CCDiA3U+K+fhEmvBLLdg24cdEt1T5Z
	 6SbUc9JBkms+VIomlWZGTiq4Ai69fipK1ubA+xbiTB3KnWXVHyjSBUWRnSg0j5yMs1
	 7yuL4CPtsUcsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EFA380AC1C;
	Tue, 11 Mar 2025 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] qlcnic: fix memory leak issues in
 qlcnic_sriov_common.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174170403101.107108.228010103716402053.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 14:40:31 +0000
References: <20250307094952.14874-1-haoxiang_li2024@163.com>
In-Reply-To: <20250307094952.14874-1-haoxiang_li2024@163.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sucheta.chakraborty@qlogic.com,
 rajesh.borundia@qlogic.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Mar 2025 17:49:52 +0800 you wrote:
> Add qlcnic_sriov_free_vlans() in qlcnic_sriov_alloc_vlans() if
> any sriov_vlans fails to be allocated.
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if "sriov->allowed_vlans" fails to
> be allocated.
> 
> Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] qlcnic: fix memory leak issues in qlcnic_sriov_common.c
    https://git.kernel.org/netdev/net/c/d2b9d97e89c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



