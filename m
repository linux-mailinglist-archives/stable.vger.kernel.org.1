Return-Path: <stable+bounces-189128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C34DC01CE9
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2DA3B03C2
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72C32D7D9;
	Thu, 23 Oct 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZRs9nyB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C861832D43E;
	Thu, 23 Oct 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229836; cv=none; b=bh3t3Bm91CC4SDjbBKWbIA9aBKxeMMf8L+m7qBwd+GFUp+x8Yg9Q0fgZCkrBRGzB8VWf84+1TMrMg6NDkysi+n3KVUWO49HcFdeKti/yZ+03FVGd7T4Y2qkZLntCkvOttmhHldyjaIbQ+jOC6Mx40pLr+R7S8qm95EDAJTwlJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229836; c=relaxed/simple;
	bh=AtBLuOu30wZ5DYW+wY+eKPBg8t1AvODpuADEttnpp0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uIaddGI9WO7PuvtEV4lKfEaYQLvBrccvB+zy9CbNWX1azHeqIu8x93H2YRfcLXBD4t4mEU1+fYscDFjHHjebyTv2yVi0ij1iRMAG9UkTY3W/2rzbWO1mNX/fQXszOyPcEP9Bnz6vA+bS5N6y6nT700/38WWmZDtXksv/juBNp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZRs9nyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45402C4CEE7;
	Thu, 23 Oct 2025 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229836;
	bh=AtBLuOu30wZ5DYW+wY+eKPBg8t1AvODpuADEttnpp0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RZRs9nyB4Mm8qPSdRmapwMQhcEGAnbIKs1FQHvXMqKipGanH43pui0FEd+bncs3Vb
	 Mjrgdm1+qS8SSkovcZgzwaWrxjrqOoQAcYzCUM5FS9Gs9fzKCBW0rFHtifGlzFDjj/
	 fgJhDiDw20y3Vbv6HqnIj2nJSy4nRWuhS9WC8/HbZvWB9pa6lyNO8FEuXAxoqZIEqh
	 ddb/dfpnpyju+Bas4o20bhOBatNv5gtRulaGTb+dclfmhpNroofIqGhxKuVQIUZfiY
	 cH5yXgevIgeyEO7dag94VfkzjGCUAgHbTNvbFBQ6Ms0fhInfRwOqLpDq0JLXi5ADoc
	 4ZBpo1Ec/1kTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2413809A97;
	Thu, 23 Oct 2025 14:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] virtio-net: zero unused hash fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176122981674.3105055.12862313802330532402.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 14:30:16 +0000
References: <20251022034421.70244-1-jasowang@redhat.com>
In-Reply-To: <20251022034421.70244-1-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Oct 2025 11:44:21 +0800 you wrote:
> When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> initialize the tunnel metadata but forget to zero unused rxhash
> fields. This may leak information to another side. Fixing this by
> zeroing the unused hash fields.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net,V2] virtio-net: zero unused hash fields
    https://git.kernel.org/netdev/net/c/b2284768c6b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



