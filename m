Return-Path: <stable+bounces-120397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D77A4F3FB
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 02:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2843B16C4C9
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42AF14A0A3;
	Wed,  5 Mar 2025 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opu1XT/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D51465AD;
	Wed,  5 Mar 2025 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138801; cv=none; b=HptR0/XoMc7Fo2POM7RtAZ36iPFhAsNwnAj3NzmvVD/9BEmcpgE5kNng1qCM2+wiola4EgQPGbbM+l4OVFMBR6r4GoC+PC9SWmyVfgw+ue6nPtCB2bDJPAhE6R/Bq58NNMdFq8aWQmB+kWQYzRF0CV5zvS/ZsYx7iMtK+nJA73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138801; c=relaxed/simple;
	bh=oOvMUUvzPlSI6Esbr6v90IW10CKv7Um1KVExyPBcoiA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kQW9vS+JmxlmO3HrNChlVWEKfLlqJCJGTJokyGT43io4/6oOzQzIZOAT0P9H14LbTUsEIUV6x7rn4fCm5uao7aGddj/QHKBDpANuCudNZNNeqQ4V+S7BFwA3VeKOhrYItegP+mIcr9uHTOhhE7bPDzjDoW73zBdKc8Lwj1pKM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opu1XT/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7568C4CEE5;
	Wed,  5 Mar 2025 01:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741138800;
	bh=oOvMUUvzPlSI6Esbr6v90IW10CKv7Um1KVExyPBcoiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=opu1XT/+NNdWPD3XQjRKQLHAPbK/5ZrqNDJb/KqwDGlC6wf1KUZJm/4FqL58wjBAj
	 p2ECPfhCEbd36cOrF8JGfY5hU1XLuSXFEYvDX/1TkpN7kZiFG18zlz41jfWWswyGJZ
	 IY3ZB0XMoSFPU5TYofiBd9Ytpn/S2mqlHr0luqfQKSdAAyGd7xLrTl+KakhpYgWQtV
	 WOhxxusGUWhj+WvSPEnIR+uH+Oo7Zwg2McMdg/XKN0rsOGAtRg/btZL8iWZ3kmd8ni
	 p6RE6gKJi2OUpx40lBoacblDdMIroL7wBhqBvyeqW+Mx3+6JHRIvdE+SVIXEb3GnYq
	 7WxXLjkVOFsoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB152380CFEB;
	Wed,  5 Mar 2025 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113883377.363569.807347823586416499.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:40:33 +0000
References: <20250303-net-mptcp-fix-sched-while-atomic-v1-1-f6a216c5a74c@kernel.org>
In-Reply-To: <20250303-net-mptcp-fix-sched-while-atomic-v1-1-f6a216c5a74c@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kjlx@templeofstupid.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 03 Mar 2025 18:10:13 +0100 you wrote:
> From: Krister Johansen <kjlx@templeofstupid.com>
> 
> If multiple connection requests attempt to create an implicit mptcp
> endpoint in parallel, more than one caller may end up in
> mptcp_pm_nl_append_new_local_addr because none found the address in
> local_addr_list during their call to mptcp_pm_nl_get_local_id.  In this
> case, the concurrent new_local_addr calls may delete the address entry
> created by the previous caller.  These deletes use synchronize_rcu, but
> this is not permitted in some of the contexts where this function may be
> called.  During packet recv, the caller may be in a rcu read critical
> section and have preemption disabled.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: fix 'scheduling while atomic' in mptcp_pm_nl_append_new_local_addr
    https://git.kernel.org/netdev/net/c/022bfe24aad8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



