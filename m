Return-Path: <stable+bounces-189097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F0AC00AF3
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 13:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD8918C8409
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB5630DD2A;
	Thu, 23 Oct 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMJMx3LK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779830DD05;
	Thu, 23 Oct 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218425; cv=none; b=gEKT4SOjeufyjkFbeRg9WFpzb5S116Gokn3TpgNmtzOmdgIDrAu7d5tZ1osgPr7sEowiWcJP+XcBtb4qv6r9P5RxmvttzPcNFpi/KORV1yk/wD6zp+hp9t5yMVGFOHcjD/DnSNi0kN6Pdyw8ZYkneC6fPG/480u8sba2yxtBnII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218425; c=relaxed/simple;
	bh=EACSA+aR9Zcp1Yk9oT27Z6eIKRKW6aqxFMAM4e4KET8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OJ4X52F35To7twMb7EmJ7Ziimqub5YJwCOiwVqSizb2asIiWKwNKoY2+fV0mducqmxT/uSLfGmlGhP9RGKfCY04BmfVY4ykdKg5cGI/C8FfbqMzCBovfvkAhj+UncEVSr8VLErRNVhWZ4+Ngy2iCkICss0cWY6XSPOmbLGxYHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMJMx3LK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73324C4CEE7;
	Thu, 23 Oct 2025 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761218425;
	bh=EACSA+aR9Zcp1Yk9oT27Z6eIKRKW6aqxFMAM4e4KET8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cMJMx3LKJDwxgQT3DSRQkV1Ftxp+AbI94yd8tsLlrvqOGrVfLiGAJieaC7CCfcx+s
	 P8WYJKe4DCHUi/cCLRHjMkw9N4vCfBgAs0d209aIIM0nAL0kiu6VICfCXNIWQbS41z
	 f+/3IFVqQXCX2sEA8RgBwReJEzsYAWz/bOpxZKiy/hAabtGqIb7RdoxO1H/qgaI+0c
	 Ric6SAsMlNq986ie9VJTV2OZN996F48DOJ/8GGhfMQdyeJZFfrCUZuhbt8bmeuGls8
	 JjnYXmw/gmm9yVETSw8fMj9YQ3EED6/jAHAdMNj9bgFIGAC3diOhJ7DohNTTz5hOKC
	 B9kbLt2cfkdMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF63809A31;
	Thu, 23 Oct 2025 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bonding: fix possible peer notify event loss or
 dup
 issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176121840586.3001126.18409474218756623058.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 11:20:05 +0000
References: <20251021050933.46412-1-tonghao@bamaicloud.com>
In-Reply-To: <20251021050933.46412-1-tonghao@bamaicloud.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 liuhangbin@gmail.com, razor@blackwall.org, vincent@bernat.ch,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Oct 2025 13:09:33 +0800 you wrote:
> If the send_peer_notif counter and the peer event notify are not synchronized.
> It may cause problems such as the loss or dup of peer notify event.
> 
> Before this patch:
> - If should_notify_peers is true and the lock for send_peer_notif-- fails, peer
>   event may be sent again in next mii_monitor loop, because should_notify_peers
>   is still true.
> - If should_notify_peers is true and the lock for send_peer_notif-- succeeded,
>   but the lock for peer event fails, the peer event will be lost.
> 
> [...]

Here is the summary with links:
  - [net] net: bonding: fix possible peer notify event loss or dup issue
    https://git.kernel.org/netdev/net/c/10843e1492e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



