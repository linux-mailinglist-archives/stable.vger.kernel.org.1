Return-Path: <stable+bounces-206388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F072D04B17
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47E5D30408EB
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717B2E5B2D;
	Thu,  8 Jan 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqN81H+W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A02E1F01;
	Thu,  8 Jan 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891222; cv=none; b=qMGA45k6ZEs3IQmUyzpX1XF31/UUEdJQwMbWF5791kwPyZpqQck7IWll0pbJuBVzGfAS0lBbBRFEo4TiZAUJ6rSyebRC9NcXuU/K6qhBG9/15sjky2KYCbP2JrfuKlOFYEtLxbiJs7OmZFp7aGWTmK6DyXdnirxzEE63kPBoh2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891222; c=relaxed/simple;
	bh=3qnzxfcYWJ/SWhTQ0XWNB02H89mQltdgFWT92U4UBGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iBlXBtGMjdmFta2bPyVHEeUY3TYWjV7QaIP9AleEaGYMz5DNSwnRfiqCZytsFL08jvGXPYaHjPBSibQit5UMrfSm8LtSUqGBbw+PAZdxFBOJ9HSJpjX5SIn2mkuAJO/fTvmzh14Uq0a9GrAQbPLumfWUudX3njxBUJmfYTUlkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqN81H+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD03C116D0;
	Thu,  8 Jan 2026 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891222;
	bh=3qnzxfcYWJ/SWhTQ0XWNB02H89mQltdgFWT92U4UBGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UqN81H+Wd5WFthQuX3EtAy1KoAKK7qAqrynXWJX1X6tdHCOnr/uhdTz2qZreg2eXQ
	 Rxo1/5Kf07RCuVbfFN8h6cjI4SvcSHtRLbaeBkwF8WZCbcb3DmsycWdCyjTMLxrpPD
	 tdRGsZrZ6epa0mu5sPjFwGfxRyuJg3vokbiUnMwIA7ShfFE51uB6MOeX/ku1XWR54q
	 gxcLFC7H0ceW/+lfOTDvrFTtkpXyJISJJtGFW9l/sZhljvtVgDMFerEaYG8wat8PUp
	 bXUXNCnQdavTj55b1jy0L2332cpq9PZWIdaXQcQCeIJsJEBVuHNh68CfKE1YqpAcA4
	 tH6WTqqJdJIvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5FB53A54A3D;
	Thu,  8 Jan 2026 16:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: do not write to msg_get_inq in callee
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789101852.3716059.12022265639018336150.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:50:18 +0000
References: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, axboe@kernel.dk,
 kuniyu@google.com, willemb@google.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 10:05:46 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> NULL pointer dereference fix.
> 
> msg_get_inq is an input field from caller to callee. Don't set it in
> the callee, as the caller may not clear it on struct reuse.
> 
> [...]

Here is the summary with links:
  - [net] net: do not write to msg_get_inq in callee
    https://git.kernel.org/netdev/net/c/7d11e047eda5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



