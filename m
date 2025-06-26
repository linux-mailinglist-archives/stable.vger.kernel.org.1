Return-Path: <stable+bounces-158673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3FCAE99A7
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 11:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7EE168283
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB6293C74;
	Thu, 26 Jun 2025 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eacZTog+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C11A8F94;
	Thu, 26 Jun 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928979; cv=none; b=NNOYWnriMgs5cqIZ0caGxsBc1dyxMYzAFGtXusLCmOY2tPym0Rt58O6Qvb8hT6siE9DxKIJFNuKpA53X1tte9ElF47/ZAlkYOm1DGv3yW7DUp6cNLgyJ7ejEMUwMyLoprNbrMOIA5SZ0lksJBhfHDQtNSSHPaUv04qLN6973IGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928979; c=relaxed/simple;
	bh=4Xxb+guqHcNMufJBQnIJUe0i2EPivcn8AN3+Ksw9Yiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BWgPABHvJBaLDUnVi8biYuEOhyxvA4orst6sW8JtfwdiO/GwmBut3kmh4KwZqKg+3UcjaqDym1TY/5mJ+7dO8Vfb1ej2JrJxxY3pHl8Wr2Qg240LpJooInp3KaRIXKt3DxRqdjdF2iZM9gnCLQRWpwyXTJiOecgzXczVPsCBmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eacZTog+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EE3C4CEEB;
	Thu, 26 Jun 2025 09:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750928979;
	bh=4Xxb+guqHcNMufJBQnIJUe0i2EPivcn8AN3+Ksw9Yiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eacZTog+DnYVg/MV/9hRQVE8a+74tcbBzNdLyBpNKi73t2KhC+vM0M3tpfrut98WI
	 1vsKca/WHW3DM+hp0bNbP0OAdvtLRsn2NZELkArVbN5cCvRSCbDESgkWQoml7PYQvE
	 PvCygxrcGpYReTJcbL1t/d/zHC3gthVfoNiwQFSjetDgjBjDpv3BH3MX2kOjPMRxaU
	 96j8+c89nxcyutMeBzpzCQH3UxoSyS4zOJBhAg/qKlgp6v3E2beQvXUqk9AOmJqdOC
	 9fOV2vMmC8a3thv1lVI1kn1CTozgySejvvqy5szk920P8hQubEbjZ59XZZxTW0rl8R
	 vOHwDCeuh17sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2943A40FCB;
	Thu, 26 Jun 2025 09:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: libwx: fix the creation of page_pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175092900575.1132640.17654281536870911249.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 09:10:05 +0000
References: <434C72BFB40E350A+20250625023924.21821-1-jiawenwu@trustnetic.com>
In-Reply-To: <434C72BFB40E350A+20250625023924.21821-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, duanqiangwen@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Jun 2025 10:39:24 +0800 you wrote:
> 'rx_ring->size' means the count of ring descriptors multiplied by the
> size of one descriptor. When increasing the count of ring descriptors,
> it may exceed the limit of pool size.
> 
> [ 864.209610] page_pool_create_percpu() gave up with errno -7
> [ 864.209613] txgbe 0000:11:00.0: Page pool creation failed: -7
> 
> [...]

Here is the summary with links:
  - [net] net: libwx: fix the creation of page_pool
    https://git.kernel.org/netdev/net/c/85720e04d9af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



