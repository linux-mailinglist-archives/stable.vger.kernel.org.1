Return-Path: <stable+bounces-192474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C41C33D27
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 04:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 344D34E306E
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D5F25A2B4;
	Wed,  5 Nov 2025 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWl39nlq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97728219319;
	Wed,  5 Nov 2025 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311632; cv=none; b=C1v5EpAJLIZ2ztfwb6NBOpAw+Tu45v4x7EWwYFCHNJzEMTXU6kT/sg9Mo2Sji8we3OvaPaHFIQKY1dHdR/BQWahS0Aa/X2YfBAMsT+3dnbwVqGfsGYyAIIU8ra17CFRi8UPYuYrqJhVvvzQMtU7oykMqYaBMxLXSP6SgXGWRVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311632; c=relaxed/simple;
	bh=uUjajcm7UBiwCcOtZqIGBc35CahMcR32TlE8zP8Fqzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EmNMZ7AUxYCT4leZzO0dKzbxEtDuyavakgVcRBKgb7HC26TYBclYSLlmxTkwgZW1ipChXSF/Y3zMcKh0xaIZUDm2ul/7iKG+8Es1FsR20IdRxmgUj4czxI1nf4eqi3V6Fyj7H7y/iQDJYer1FwTyBN81fXYND6rcPvYozqbwLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWl39nlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B79C4CEF7;
	Wed,  5 Nov 2025 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762311632;
	bh=uUjajcm7UBiwCcOtZqIGBc35CahMcR32TlE8zP8Fqzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CWl39nlqV2K1MWhVe2hrhVZ4+r0Q+YrfjXtq7mRLZ4HYQatGIowviegSRz2cpa8w9
	 TZdCEVqUCsInD1sIfJascNWaYPhau1phFO4PGqTCgI4iTJLRugOjtMeS7LjCZaW4TP
	 59ZPWwJXRYjNpueH6w/xK1wtagD+i/Uh1zfmdkcFGR/On5YbZwO9sGPVcFiltJZ6iz
	 p1KrVOoH0Ll42AnTjMEU13aeRmaeu63E5s508lEE/lJ4mv6dQ8PPBNg35yn7VfHIYw
	 YCSBmCbX5H5bqBhvKt2m9Ftz8Wv9ptnudKSQk7o/c90FSTQbOObPEVEWKFYgxktDje
	 pTzIKSTmjVVkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4C380AA57;
	Wed,  5 Nov 2025 03:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176231160601.3072163.11248648674740592024.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 03:00:06 +0000
References: <20251030144438.7582-1-minhquangbui99@gmail.com>
In-Reply-To: <20251030144438.7582-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gavinl@nvidia.com, gavi@nvidia.com, parav@nvidia.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 21:44:38 +0700 you wrote:
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), when guest gso is off, the allocated size for big
> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
> negotiated MTU. The number of allocated frags for big packets is stored
> in vi->big_packets_num_skbfrags.
> 
> Because the host announced buffer length can be malicious (e.g. the host
> vhost_net driver's get_rx_bufs is modified to announce incorrect
> length), we need a check in virtio_net receive path. Currently, the
> check is not adapted to the new change which can lead to NULL page
> pointer dereference in the below while loop when receiving length that
> is larger than the allocated one.
> 
> [...]

Here is the summary with links:
  - [net,v7] virtio-net: fix received length check in big packets
    https://git.kernel.org/netdev/net/c/0c716703965f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



