Return-Path: <stable+bounces-126666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202BA70EF3
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D844916F054
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994CB13633F;
	Wed, 26 Mar 2025 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqAZOi3a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2ADDD2
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955839; cv=none; b=VjUHicIo1V+AYCy4W6MzyasvotFEq1YiPfTVxAGQ1WxCK0JPffbT8lDnpXklPsxs92Ej62uufWsEIuBIjQqupBYK+eHKAksQufijN211yuAI0DYQnqyitCVAT8rTjfMTwBMeEpkU1Ae2sFv2V9ufymEQTmTcNySkLSNafEXPQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955839; c=relaxed/simple;
	bh=1mFruKXRtRIn5j3vqjgKWiEYNitdgxlLp1DKvYBtwoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAYaPkvpVeRGAUxKMCeRSkaB6C61Y3SZmHaKPdF1s5IlXd9q/uAynrB1rWSLCwXA9dJ3C3R5uCvGvV2R7reMwNAYr44gjP6JyC64iFhllDCJpscFpNx4A6NCl+g4j6z403k+/Q9LYx1rdJFxF8mLKMHd+pqqYxEsPc7GMOzK+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqAZOi3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EF5C4CEE4;
	Wed, 26 Mar 2025 02:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742955838;
	bh=1mFruKXRtRIn5j3vqjgKWiEYNitdgxlLp1DKvYBtwoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqAZOi3a51/TAkVsk0JdTh4WHhkUMVjeQJQBOieCQNynjU8jZqUwip1Bogp4OLOIh
	 BIqxZsZKoF3mxosSglMq3iMYXDpX3rVi9OMYqUl7Y51eAR08fToAtt4ZmPlXZsUKXZ
	 c/sB6rIb0PG1LFdihz17lDPH16vivRPYgY139kPg9cyGuLwDYE8+SVXNwKf/9PN+X0
	 NxC9fWSOmPU8lIrkEtIMIiCW46sSHzYXgtAskIrg+nHrw/+E+BdxOs+j93SXPZ3X6y
	 vqd8svnUu2gin5Rra9PXwEsmppKQC/UpBXnpDemVGDoq6fM3Ngaiy2Sypq8Mx5NpQB
	 Mv3a8/gD63stQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.4 v2 1/2] net: openvswitch: fix race on port output
Date: Tue, 25 Mar 2025 22:23:55 -0400
Message-Id: <20250325213715-a20399e1a17fadbc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325192220.1849902-2-florian.fainelli@broadcom.com>
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
5.10.y | Not found

Found fixes commits:
47e55e4b410f openvswitch: fix lockup on tx to unregistering netdev with carrier

Note: The patch differs from the upstream commit:
---
1:  066b86787fa3d ! 1:  4a240c30b5802 net: openvswitch: fix race on port output
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
| stable/linux-5.4.y        |  Success    |  Success   |

