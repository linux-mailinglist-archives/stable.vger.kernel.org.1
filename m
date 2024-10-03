Return-Path: <stable+bounces-80616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB5798E7D7
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 02:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95677286B5D
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0E1946B;
	Thu,  3 Oct 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1VzH+vJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBE182A0;
	Thu,  3 Oct 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916038; cv=none; b=VcQjJNR2hoi2/1wUjFrQQvIO8n1NZxW06ic49wlx6F3Zi7BSlZ08tfPd4tdBIkh7m6aHjHZ7E8r7hUiKWiWszsl6VehLw3tuuNYrihRn9T+T3jHSBm+95w7dbl1cY2HBflyUpRn+ZFCXhES4vFHVdR0fDarr6EhRIa4R8iRUEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916038; c=relaxed/simple;
	bh=lDV08hzljrTxLhH9CuWgALe4JPCaHJuezhELr4bgUnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f7tyqvLnOYUkUy9QDZrmT2ookXkaf5Rdz9eRg6F5bwuTlffzy82N51hIs4jfBEQRIa+ZPw4DWNuIIHkUGYT7EJh0zce679DM92P0yVbKcqjsR4O+VREl6AesbC3ZgzFqTopAaVOtb1Mhdwr3CpQGPEsXzxLnpYWZBFnGq5WQtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1VzH+vJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52E3C4CEC2;
	Thu,  3 Oct 2024 00:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916037;
	bh=lDV08hzljrTxLhH9CuWgALe4JPCaHJuezhELr4bgUnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S1VzH+vJ+Sj0nZyJFBjI8a4SE73PGcfNlJBxEtbHfwDBWgfLDsG6sTTQ9l9wU4U4z
	 mcZxYgTU7HU6yQDbClinxVEEBbiggdNf4TAoC3yR5DE5JFVlDogFDg0mNBPRzaV6yJ
	 NcX6VDwHa0FLEFu1vFJlla+W1DMTblHpJH+lL5lzjJkXt9zIo8EZy69KRMUsNY9iWK
	 PKFSFurHYjKXRdQUa2ECxHSr4+w4YEwap3b9AuUKV9cnxdrR1/kg4wPYGMjjRc1uDy
	 WgoLcA/Pf2IvPR8hyXGj4rYsJiIaiuNDqpMkJ28LHTVquuEwwLty++FthR5AUW6QYl
	 EuXq3P+ycjIlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7127F380DBD1;
	Thu,  3 Oct 2024 00:40:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] gso: fix udp gso fraglist segmentation after pull from
 frag_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791604100.1387504.10419958148594855947.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:41 +0000
References: <20241001171752.107580-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20241001171752.107580-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
 maze@google.com, shiming.cheng@mediatek.com, daniel@iogearbox.net,
 lena.wang@mediatek.com, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Oct 2024 13:17:46 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Detect gso fraglist skbs with corrupted geometry (see below) and
> pass these to skb_segment instead of skb_segment_list, as the first
> can segment them correctly.
> 
> Valid SKB_GSO_FRAGLIST skbs
> - consist of two or more segments
> - the head_skb holds the protocol headers plus first gso_size
> - one or more frag_list skbs hold exactly one segment
> - all but the last must be gso_size
> 
> [...]

Here is the summary with links:
  - [net,v2] gso: fix udp gso fraglist segmentation after pull from frag_list
    https://git.kernel.org/netdev/net/c/a1e40ac5b5e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



