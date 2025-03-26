Return-Path: <stable+bounces-126664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B7FA70EF8
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF563BD5D0
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FAB13633F;
	Wed, 26 Mar 2025 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp/ko+5y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C4DDD2
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955832; cv=none; b=eSjTQpif7WdkrYB/syMcFInXeeC01LXV6Kyr1/HzxzBznFahobtvKckhHcORMZSsvA759aKPbfl2oolFSo1HpsO7GPfiZuZJK+l6gOWTTMTOEpVhrZxEC2zUnmGuJh7lT6SR91LU4+Z9wS/K+/zx+s6U4hg9k38J0F/nQxtAaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955832; c=relaxed/simple;
	bh=M+KIHrfYZSRngIwqOjWbQl6u8A3pHkM/Xw9bH+gfjxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4KlmEgzNLSp0JP+8aLdWOyyS3FU1I3D5Zpmt35zPLc8L1jEKKLKuZ7BLuA5UwE/Y6x/tl/1Igxflz/sp07itiVN8kmEhmv4QqJq366QVW2PWQA4YHJ4RizvZFVVTtihVQ/XyW1u6Sv3A9x4xBky5EMz5Hr8zKk2KgkGgLf0fzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp/ko+5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68686C4CEE8;
	Wed, 26 Mar 2025 02:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742955831;
	bh=M+KIHrfYZSRngIwqOjWbQl6u8A3pHkM/Xw9bH+gfjxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gp/ko+5ynH5y3T3DVDZnDOH1MSkkmIbgEd6oAQQlau36JJ6W8XdhLiquaRxNP3fQu
	 XrTothGsLRg1NtA9sTwNZLydYuQMoQJe1TZqv/FguVjQ56waKgRuzXrJqRmrjGGtPl
	 0MyVeVe412h26P5XPhGLj+duL/zPV5Z+XP7jnyjXMjzAOYlhPrM0sHNGo5cP7G0vdu
	 EsjnIykEc2iqWxLq4skzZ2vnLeiCR1ca5JuntbiMahK5/zA0kUIsQNes9ldziXivmO
	 NM1wUSgJDpqSKv2KIs3+skk43aE0DrvFsY3cSNZuTw36Jjl6ZQVwLL50T9ddAPo8xc
	 qv/u0VaCYnS+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.15 v2 1/2] net: openvswitch: fix race on port output
Date: Tue, 25 Mar 2025 22:23:47 -0400
Message-Id: <20250325220025-bed957824b5de255@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325192246.1849981-2-florian.fainelli@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 066b86787fa3d97b7aefb5ac0a99a22dad2d15f8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Felix Huettner<felix.huettner@mail.schwarz>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 644b3051b06b)

Found fixes commits:
47e55e4b410f openvswitch: fix lockup on tx to unregistering netdev with carrier

Note: The patch differs from the upstream commit:
---
1:  066b86787fa3d ! 1:  b42660dab3ca4 net: openvswitch: fix race on port output
    @@ Metadata
      ## Commit message ##
         net: openvswitch: fix race on port output
     
    +    [ Upstream commit 066b86787fa3d97b7aefb5ac0a99a22dad2d15f8 ]
    +
         assume the following setup on a single machine:
         1. An openvswitch instance with one bridge and default flows
         2. two network namespaces "server" and "client"
    @@ Commit message
         Reviewed-by: Simon Horman <simon.horman@corigine.com>
         Link: https://lore.kernel.org/r/ZC0pBXBAgh7c76CA@kernel-bug-kernel-bug
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## net/core/dev.c ##
     @@ net/core/dev.c: static u16 skb_tx_hash(const struct net_device *dev,
      	}
      
      	if (skb_rx_queue_recorded(skb)) {
    -+		DEBUG_NET_WARN_ON_ONCE(qcount == 0);
    ++		BUILD_BUG_ON_INVALID(qcount == 0);
      		hash = skb_get_rx_queue(skb);
      		if (hash >= qoffset)
      			hash -= qoffset;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

