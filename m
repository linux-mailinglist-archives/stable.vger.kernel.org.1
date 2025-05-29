Return-Path: <stable+bounces-148050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3AAC76F6
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 06:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5551C017F3
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 04:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0FE2512C3;
	Thu, 29 May 2025 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+syvm7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E069324E4C3;
	Thu, 29 May 2025 04:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491799; cv=none; b=t+gh+qxe25DZfnsfJonmSE3z9kE2aOLwKAofDyY/QEf2G49BayPRTO7DBKzaCylf7ft+wjvDGDJjFdoOn08TsBzGxYx1xbH6x55g3kNcqs1qaq1W85tLcPwYXu87wABXt1gxDjtUPgoiJGkgxcbeJsCTyn8vlGzDQqCboqxaZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491799; c=relaxed/simple;
	bh=ppHJj1wehewDhrTkPX00hTSLAwFfky3YuwU3TAq27t8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YsKnjChZWGVvGOsLBODqhOnP+7ilm1bCGBk8Mn2/dmMHQzE7B7gi0Ibw0yQxzkl4vus2NAtW0DINNX2qt0BOVYFzJKxudUXW/jJQX92zK6FuJveTKpud2Qovltt/+N6GQe2XJrZdfpKHAcn5GLzHmEq33lsVkKoIVWA9qr4Rzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+syvm7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D336C4CEEA;
	Thu, 29 May 2025 04:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748491798;
	bh=ppHJj1wehewDhrTkPX00hTSLAwFfky3YuwU3TAq27t8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S+syvm7KFrzIGCRBKR+3rOF1SJwp+j/MY0fngxyuv8Mbi/5lXPdA6mhkraGhqti88
	 LmGhdc86a10qde9SwkTNJxYnXnujszLwNqJWpGj/FhEjBcBLtIt2+ccm6tvbMWyzZF
	 jmENeoWO0hJk7srz/GZgVegdZlZzl0UVhxiNAP1qT8ZBhGM5ggpAv3zHZDKU+l6gT6
	 0Tpk8tpX5sRrjtWOD03t2L+f45J3nE4sg0z3B+kjbBGDruMW36E62TOfHXRsxhDWlb
	 JXcWL6xSOGcufZY1jP97Kfkg/rSPhvodRrgH4jtguox7vTfxsPMwviLuxBbfB4HePI
	 EFMBfZ72F/ToA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB13822D1A;
	Thu, 29 May 2025 04:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ch9200: fix uninitialised access during mii_nway_restart
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174849183224.2759302.15819072408324196883.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 04:10:32 +0000
References: <20250526183607.66527-1-qasdev00@gmail.com>
In-Reply-To: <20250526183607.66527-1-qasdev00@gmail.com>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 May 2025 19:36:07 +0100 you wrote:
> In mii_nway_restart() the code attempts to call
> mii->mdio_read which is ch9200_mdio_read(). ch9200_mdio_read()
> utilises a local buffer called "buff", which is initialised
> with control_read(). However "buff" is conditionally
> initialised inside control_read():
> 
>         if (err == size) {
>                 memcpy(data, buf, size);
>         }
> 
> [...]

Here is the summary with links:
  - net: ch9200: fix uninitialised access during mii_nway_restart
    https://git.kernel.org/netdev/net/c/9ad0452c0277

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



