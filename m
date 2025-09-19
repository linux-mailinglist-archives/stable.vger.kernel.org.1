Return-Path: <stable+bounces-180663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB283B89FDD
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2976B16DE34
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4C63195E6;
	Fri, 19 Sep 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZJss6da"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C93164A7;
	Fri, 19 Sep 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292229; cv=none; b=Ltjzyw3ARImxxN9ju/U6i2YX7I+WTQf/vKqKp7JgVokpM5Duzsl1FH9KpfOeiVEU1ll28tUzB8Qj1f72tDINca+gOrt9FQU4AwEbk4wxvLTYha2JzkIZPRycBBBH1WxI6QfPugLx9gCSevA4gjh5VdDABV1gSHLNRdoctXtG6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292229; c=relaxed/simple;
	bh=vA9guvcgL927U5ffFZqiyBwAArQQdF916BNKlifkJAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LS5R/4cJkO4oxdD41SUA0hGqEtrmz+l3swcsHm26j2iaGtnRj/XDTgoRJrp1jgEUfJvTTCof4uBj8fjSpoSA6g59XktKtE/aPm6TaVi7Yew2gdeF7wkC5eQd76jMPlIfEDPvYE6tFRGZ0PgTwyqCSSHXXgBZ7ImPOE0OkDWFdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZJss6da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D65FC4CEF9;
	Fri, 19 Sep 2025 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292229;
	bh=vA9guvcgL927U5ffFZqiyBwAArQQdF916BNKlifkJAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eZJss6danaiwJMxxUfWVD4rBvhbrRPRLbPeS+4QZ61D+l1/zN3sWcYt/QZ9Hf+KRK
	 BP49Zn/yZOeCvLSVivthHkRXXbCDiOA1XlE8ImPSGVBNHH2Xjr9Nn+ZcYBATF8fBLx
	 dSwT73XomEFgVed2RT+JRkBgIRs7vDg1CB67V9v+sMK3nH2ZJviwwrrJljzNB42k9L
	 fvQRiD9wN0zCDzxA/B0qn+HPg83J4vELrKo/vyGgxZNVoMVAC0uUXk6+nIf/XuPYoa
	 NhShXVw6o2GEJfRm9otDUOHvkIrHLsuXnnPBU3Gras4kHAO1lE2zfs9H/AN/RBC8If
	 aiTaRGG64VYTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16B39D0C20;
	Fri, 19 Sep 2025 14:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: reset blackhole on success with
 non-loopback ifaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175829222874.3219626.13984058147860089030.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 14:30:28 +0000
References: 
 <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
In-Reply-To: 
 <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuniyu@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 10:50:18 +0200 you wrote:
> When a first MPTCP connection gets successfully established after a
> blackhole period, 'active_disable_times' was supposed to be reset when
> this connection was done via any non-loopback interfaces.
> 
> Unfortunately, the opposite condition was checked: only reset when the
> connection was established via a loopback interface. Fixing this by
> simply looking at the opposite.
> 
> [...]

Here is the summary with links:
  - [net-next] mptcp: reset blackhole on success with non-loopback ifaces
    https://git.kernel.org/netdev/net-next/c/833d4313bc1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



