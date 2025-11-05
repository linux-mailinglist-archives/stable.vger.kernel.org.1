Return-Path: <stable+bounces-192467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531A9C33A9F
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 02:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8399A18C5FC4
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 01:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D837233155;
	Wed,  5 Nov 2025 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I30xFna2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7C22333B;
	Wed,  5 Nov 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306241; cv=none; b=pdYtRDpiqe2EXdX4ZDrGFrVcyL8C27ZU4CNnw5RPpvzWUibd44V6gRN08NrdBAnVwFLJRB4ZLmVUM1kStLPxV/VI20ErplcFNUu0NfPpl6ATxFOQ6IKF0DaoHHKTCWzlteXuwh3n8Aqe0rqxsNQzCcrHa52ONgFUnLFNY3Sit+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306241; c=relaxed/simple;
	bh=m9CPZcYZOOI/nQBexZwcz/64lD79NljFqckfJOXcEjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ffpx1cliqJse+DMN9DYfCRTc5+8gKdQRawkqgcrDeH25Fh1FBDgjTzoy0DYv5FoFLQpBw4mdC0vQr0/5iwpWJr7F36IZeaG5gDd/+BCviLk1RLdE+aiKH+JSxt2A1PV2g6YWLaOJx4LwP7YMUQMzndMRWOwVsaomD25taFgWKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I30xFna2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D69DC4CEF7;
	Wed,  5 Nov 2025 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306241;
	bh=m9CPZcYZOOI/nQBexZwcz/64lD79NljFqckfJOXcEjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I30xFna2DPSgdjczbL7e+ZdHQuM16VQfE3M3AS9DOOPrKbnTbCOp+2L223TWSl+4P
	 WxtLNcE1fXma4eQRQWIdyLCJIfV4JeMAz97dNFc/8l4SSyQhMFdrIH0jSOd6ftWSch
	 ZoACrXqSvGohdS/qOpw91p4KQ6PcEp80Aaw8ItAyBcvsPhSEgNRDEi0sIT8wBRItlG
	 1ygXwb6HyaUBxbZOVt3XlmXJZV6DcrM8LFngL/KZdTEH2yv264K22S99mHiehnd5ZO
	 IFB9WUYhGFinU5a65kWuTfRWHlbEhlnctZl1PfYeQhOEFRSngw8Iu/QGQj2sWxe41X
	 VsvAD+lWao6tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3412B380AA54;
	Wed,  5 Nov 2025 01:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] virtio_net: fix alignment for
 virtio_net_hdr_v1_hash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230621499.3052151.14134188371623590372.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:30:14 +0000
References: <20251031060551.126-1-jasowang@redhat.com>
In-Reply-To: <20251031060551.126-1-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Oct 2025 14:05:51 +0800 you wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Changing alignment of header would mean it's no longer safe to cast a
> 2 byte aligned pointer between formats. Use two 16 bit fields to make
> it 2 byte aligned as previously.
> 
> This fixes the performance regression since
> commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> virtio_net_hdr_v1_hash_tunnel which embeds
> virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> 
> [...]

Here is the summary with links:
  - [net,V2] virtio_net: fix alignment for virtio_net_hdr_v1_hash
    https://git.kernel.org/netdev/net/c/c3838262b824

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



