Return-Path: <stable+bounces-116313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6F9A34ACA
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF077A6373
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963F242928;
	Thu, 13 Feb 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/mO1hzW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22328A2A8;
	Thu, 13 Feb 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465405; cv=none; b=juAM0nKQOUhEPTA8nyQWZKcNzQOTAEnPH/dRFGB3dbGZCUW0BtWRtxqh2biGnep/PuLqOtHTFB06Kp41GM/xKT5hob8UuouE9AMqLIw19+JLjlVOMRH3K0mPFfxw4rTfhSR85VIWaY0B2PBkfCbR/phgpk5quUosS/PiYNF2SsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465405; c=relaxed/simple;
	bh=vWc8VKBxp9o18AQbWPY+q8CPpm+dcXnTK5NFlS4VvS8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LwcmF+dE0eZbPXVgGyoiQqkLhs+ttOxuz5WdV0fY4p3PHNL3M7Ac6Vl17ZF6EOSB4zf1XH3aSvxTvRN6eL6LHXrQ+ey31WZCpEGrgxOHbJlZz4KkDdgVoJsnGgqQ89smdoSYURsHFmDSLG5LRRdNtiXgHFuZgIMdf/STFB+UvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/mO1hzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CE8C4CED1;
	Thu, 13 Feb 2025 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465404;
	bh=vWc8VKBxp9o18AQbWPY+q8CPpm+dcXnTK5NFlS4VvS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i/mO1hzWbXLsKolCeYD/qTERCl+u/4XCY8eQkko6o8kLWPf+elrjpiH6B25qLcCsV
	 cC3P9s/aDm/Ss9Hn+4Unuz3BXfp1HoHxVf1M1xLPbThdvW5YfuvQBIsh7xXRRxZ8Qj
	 jfI95o1XzcNx4SsaDc47vqt1yg3YpByt400T2go07GA57SZRs9iQ1klAJqAiI8oTVO
	 frkCgnDgohm/efty09pFsE6IBjTw82c5dXvwvWlwhR/OYoBFkfLVwMUa212JAXIIe6
	 mk56LcEnOhBhlWFykWhiKUPmdXKj5fEE7zvKJUl48oVvCseNsLIshUoPrIaxXNAbDI
	 wsPyNd4MYBGlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FB7380CEEF;
	Thu, 13 Feb 2025 16:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mlxsw: Add return value check for
 mlxsw_sp_port_get_stats_raw()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173946543381.1295234.12436241481892534091.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 16:50:33 +0000
References: <20250212152311.1332-1-vulab@iscas.ac.cn>
In-Reply-To: <20250212152311.1332-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 23:23:11 +0800 you wrote:
> Add a check for the return value of mlxsw_sp_port_get_stats_raw()
> in __mlxsw_sp_port_get_stats(). If mlxsw_sp_port_get_stats_raw()
> returns an error, exit the function to prevent further processing
> with potentially invalid data.
> 
> Fixes: 614d509aa1e7 ("mlxsw: Move ethtool_ops to spectrum_ethtool.c")
> Cc: stable@vger.kernel.org # 5.9+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()
    https://git.kernel.org/netdev/net/c/fee5d6889406

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



