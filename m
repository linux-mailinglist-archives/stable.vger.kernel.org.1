Return-Path: <stable+bounces-166515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B24B1ABBE
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 02:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417307A7C2E
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 00:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603F81AA782;
	Tue,  5 Aug 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J11oGXkC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0377080D;
	Tue,  5 Aug 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353809; cv=none; b=G2NwhmKwYj9kk5ofO4TK2mPi5cFKbhv8u3jxXXuN3AjDDwYQdyVj2E3MxevKtwBh+d5NV1OgxByHOe32IoPjAfANQU0Ltu9sMMtnsmpJAqjERCVM2qbDyI6LqZtAWoXQWZ00h5V2stRNarmCrl3U6w5fuD8XDf3hHu9xyssFbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353809; c=relaxed/simple;
	bh=2V+bEXmMe2bJS3myCfudLocU+8udxvXfrm75O0IvY0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IidmU6CJH3Oby6ejHc39kFUGx+afwT6Pr1T7N3i+fgSPUJhBzkgjLP4OtvwaNxTyXdvaGd6Q5Z1mqY0vEpYZgiHJW9c5cmRImDRe1B5Hjb4NY87rFphrkbQ9KkiTgwQuX1W7uvjkUP+oDYfGxXqPKvRJ+lSvzdEMwkiLTCH0ZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J11oGXkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BB6C4CEF8;
	Tue,  5 Aug 2025 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353808;
	bh=2V+bEXmMe2bJS3myCfudLocU+8udxvXfrm75O0IvY0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J11oGXkCyfCiXvjyIA4osd6I/JVLwX6pCyuxzVCPg0x+zIelNgbKeUQ3oWePqo9oW
	 HJxIpkaPcGYI46U0SIbyQKCTA9znQe2+De5lHms+cFfXmqZ/MUGwj/LkEl1uYFI6P0
	 xIwqZZcVybFEBPjJpDAZ9jSZfXxQbWoeR9cks7aqs3JDGGQEAooQlDi5MucKbUQROM
	 ak2pAk+CD4kfhSVzF3deuWj05g6Z5GaKanPELckvDQjoa78N+ipRAXTjVS8k6LBNWE
	 YFxEGFuDcHmdaJdRQHkpmL8zERQY3jUnCFlbECs5OTdugjREQ3et/cS0koipVGgBaV
	 3dms9L5deLqMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E05383BF62;
	Tue,  5 Aug 2025 00:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/packet: fix a race in packet_set_ring() and
 packet_notifier()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175435382199.1400451.4567191514698404323.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 00:30:21 +0000
References: <20250801175423.2970334-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250801175423.2970334-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 quanglex97@gmail.com, stable@vger.kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Aug 2025 13:54:16 -0400 you wrote:
> From: Quang Le <quanglex97@gmail.com>
> 
> When packet_set_ring() releases po->bind_lock, another thread can
> run packet_notifier() and process an NETDEV_UP event.
> 
> This race and the fix are both similar to that of commit 15fe076edea7
> ("net/packet: fix a race in packet_bind() and packet_notifier()").
> 
> [...]

Here is the summary with links:
  - [net,v2] net/packet: fix a race in packet_set_ring() and packet_notifier()
    https://git.kernel.org/netdev/net/c/01d3c8417b9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



