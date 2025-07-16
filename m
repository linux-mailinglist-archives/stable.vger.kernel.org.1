Return-Path: <stable+bounces-163054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64157B06A9E
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 02:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EE9173C80
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 00:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B48191F6A;
	Wed, 16 Jul 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak0Pzrpk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE11189919;
	Wed, 16 Jul 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626399; cv=none; b=tTGqHCg8XmU2tl6ffNlgvNJPkb5R5vBg3k/wsEqLnfUQgPFNH4vFcoVe5E3AD1k2Pay0quZ2gngZbZQsq22pUy8913IRe6VdHib/LSLfKo3CWOstrddYp2dIj4UrrGcfUhJ/jIs5CYQWmEdsS2GuswlgtpyVqer80wHCmlGarwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626399; c=relaxed/simple;
	bh=sGn/kh7UYq3CB7lRfd66Gr+cg8mX9X81H7GXODQBzEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PsXHh9W5Kz0jZi0dwPeK7Iw9dpsmj0G08psuZHoNpve3zGnbDfo9iAv/3yhoPcov/KRQrFLdOumQS8jmarOKBRJ8Ao3LqaKuyO+wFoZGELsah+SarJokfqR9hvrMut/VsQfct3GOWWn2PoKylIrcQdwkt6+1gAns6oS8td74Iu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak0Pzrpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79CAC4CEF1;
	Wed, 16 Jul 2025 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752626398;
	bh=sGn/kh7UYq3CB7lRfd66Gr+cg8mX9X81H7GXODQBzEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ak0PzrpkGTSCe+vQtMtNJ4jFZ0iIU+vrM+8JH7jv+2P8SHpoNcWyxqfcwMTQIMj7m
	 nq+kRCAn1Rv8ApFkaEQNbjdIrI3JDLzU3AQAbJ8yMaJu7azSznBsS29atBL/SkTNGX
	 b4alTNGdc36xMbaiTleNoiM2uA3b/dp3qJUuLq+4wgjz+owryAd7C+IRsG87TTS6qH
	 yOntSqnpUjkKdnZMwhmW1cgHN4y4sAuTkZ5TQL86XxqBejynCE9SsULKQZhFf1+61U
	 QZbxLCxJ5FkUootxXwr9K305aFLmWsX9JbAOPwHEyDte0/0KzfDy/DeFKx+LujKEkJ
	 OsnlajxJB92HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE05383BA30;
	Wed, 16 Jul 2025 00:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: libwx: fix multicast packets received count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175262641925.629458.3835429988961684615.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 00:40:19 +0000
References: <DA229A4F58B70E51+20250714015656.91772-1-jiawenwu@trustnetic.com>
In-Reply-To: <DA229A4F58B70E51+20250714015656.91772-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 09:56:56 +0800 you wrote:
> Multicast good packets received by PF rings that pass ethternet MAC
> address filtering are counted for rtnl_link_stats64.multicast. The
> counter is not cleared on read. Fix the duplicate counting on updating
> statistics.
> 
> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: libwx: fix multicast packets received count
    https://git.kernel.org/netdev/net/c/2b30a3d1ec25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



