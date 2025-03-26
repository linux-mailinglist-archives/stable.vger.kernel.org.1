Return-Path: <stable+bounces-126662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54BA70EF0
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBA51704E3
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AA676034;
	Wed, 26 Mar 2025 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIwjEPIA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456F137750
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955824; cv=none; b=Bn5VlpXtzCXKjl1pX/5Da027mfyPQ3QCpZ1+7M9OS0cdtFVrdeLNz7qIy024durElZ8fykLx5N0+VcZ/17u0SG6t5cM5MLDm/rxBbrHuSta1lpb5b2wHruo957HD9v2e0OhYwN+yWe0H86YwQE6UIDoG/OjgU1+6Kj9nf+zy6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955824; c=relaxed/simple;
	bh=IZNUKc0sELz0mIe+V93EiR7rS7xXl+fSvVO5G98SMHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TB+KziWvaXAX33LD3wr9yMceEPPhGNHc7cdOYwHDC/2JxIjCkfLB44crcW5+ecIMuGuWm1AKnmT+C+0z0h3Ita7AiM5dZq4PACFOXk7rJooNvHFGbePvIAPq2JazzQPsG5ZDu1HnOMRSYT0EceOsAtzNY5B/Vs3CjSovslH6vEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIwjEPIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F00C4CEE4;
	Wed, 26 Mar 2025 02:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742955823;
	bh=IZNUKc0sELz0mIe+V93EiR7rS7xXl+fSvVO5G98SMHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIwjEPIAKGAGAfimRcblwIWd0v9MH0pfyfIel67zQPRYrUpiVmeUQq0VSTRVf4xGD
	 envypqnVudeC2/tceyKLQmDpsKngI7B4qSqhXMqTokYLMZx3yg/OSrfv2kFnnL4JqX
	 DA8Dl7C4tYUsk1kFVSphZYs0q0Irq6JkL7cAy8kByJu9SDQduTSbM3weN6t/LjbUBH
	 YXpinAPLXRA80iNvBk+EkoXxkxaDSyDa2s8DXuy1OkbemaYlFfs67BJkt3PUizCw+D
	 iTLq3dkpaqaZNFLXbt9PvDlmUl/IV1JEWAuAfuGWfQx7JKIqDFFir2UUoXV+ePWQSI
	 yQ8AFainB/UfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.10 v2 1/2] net: openvswitch: fix race on port output
Date: Tue, 25 Mar 2025 22:23:40 -0400
Message-Id: <20250325204629-522e4dfadac1e567@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325192236.1849940-2-florian.fainelli@broadcom.com>
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
5.15.y | Not found

Found fixes commits:
47e55e4b410f openvswitch: fix lockup on tx to unregistering netdev with carrier

Note: The patch differs from the upstream commit:
---
1:  066b86787fa3d ! 1:  5a74abd455f78 net: openvswitch: fix race on port output
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
| stable/linux-5.10.y       |  Success    |  Success   |

