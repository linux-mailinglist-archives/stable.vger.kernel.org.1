Return-Path: <stable+bounces-176910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63294B3EFC8
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 22:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41431205CB8
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774C2271476;
	Mon,  1 Sep 2025 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSlYBQxd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3354E270541;
	Mon,  1 Sep 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759205; cv=none; b=XmLXvtGblRqQGAs6zTY6ocDE/H9y4rcz4pID3CqdbBr2N6VBhHdN1RCwxBzYWI0oHJtvyrYFFeXlGeypsfSwwxhy41dpfDJuBPLYCMNHageiW/QlIiIuzvvwlu5+t3iSrwYIKXAv/nLNcP9HrqAbCyN5uKVVBb1zM0e4gmQ2Sek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759205; c=relaxed/simple;
	bh=TQsdXo/XjaLSUYqZV3CzXaSVUVIWdgIM5Dg3GPo1Rgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D93HoteFQajLwsl8Uuk1qML6SRD+RWVj8y9iuGQw4aDLQgK1B78WEXqNrQcz0bRj83tSJYqtrhIKDZ/AtMMeblYn7S0UTs3ieDjOS7PqYSIkmbqZvpafQjUArni+j7C51k4pY/Xf8ONR5zzIRnZQzAWHHVs7vtPUkp6xvkDapMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSlYBQxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8603C4CEF5;
	Mon,  1 Sep 2025 20:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756759202;
	bh=TQsdXo/XjaLSUYqZV3CzXaSVUVIWdgIM5Dg3GPo1Rgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GSlYBQxdV+8/WnyxgORuHiGxvzWeCpSSokTgD2Mgxxu40Pn7CF6Dsb1UYmKflWOn0
	 DwjQnk7is3+ea38Ny71PNUqvttWjIWHVLS+HB1q5v+ynGMRwsLXIGhypnTNS7+VNs5
	 t1QVlB4ArRHoiJnSG4uhp9W3wk/5H3yJysmDRBy5HiZG3HQ3zvH4LbaQSBsN9iJxfX
	 pJNr+9KDwZjI4YZpiwAdUCgA6t/hPwo91GFI1fkFaPEZ+kvsP5GLdCJkUWQ7QSfH7B
	 Ou6m8/nRJkB4KM3M1uWsqdc3AVPvvGhQMeAgy2PzsZJ5OEBPhvIfZST0hrdj5yyvLE
	 VLojkphQrmATQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6A15383BF4E;
	Mon,  1 Sep 2025 20:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: fix OOB read/write in network-coding
 decode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675920849.3877324.13775233533723046808.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:40:08 +0000
References: <20250901161546.1463690-2-sw@simonwunderlich.de>
In-Reply-To: <20250901161546.1463690-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, stanislav.fort@aisle.com,
 stable@vger.kernel.org, disclosure@aisle.com, sven@narfation.org

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Mon,  1 Sep 2025 18:15:46 +0200 you wrote:
> From: Stanislav Fort <stanislav.fort@aisle.com>
> 
> batadv_nc_skb_decode_packet() trusts coded_len and checks only against
> skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
> payload headroom, and the source skb length is not verified, allowing an
> out-of-bounds read and a small out-of-bounds write.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: fix OOB read/write in network-coding decode
    https://git.kernel.org/netdev/net/c/d77b6ff0ce35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



