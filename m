Return-Path: <stable+bounces-126773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73797A71DC1
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674B7188EB56
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549D217730;
	Wed, 26 Mar 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2VytbPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3123FC74
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011678; cv=none; b=WHO74/C+28Xh0W+Di9eBXAhNiJVYRNpDgBnIGjTrUve/0eqhVpObPnt1Zlih0C6XWlAM+npbsPIdgd4TPDlCJcBWs99n6eGAVod0VAtwWAk/9KeYSL+zifX9xM6nkAlOTaMduHDD2Tysx8GNXX9BK1JOYl6Pc0WikhFKqIIAF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011678; c=relaxed/simple;
	bh=i4esRH3afJ3otq9v4ydtTKgS1pPCtvdj1yPdSPUEs4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpZEt1CAk4tHV8G7Ed6spw3jDpxfyRxlXiOi0OTa896H1xX3DgSm/2vwggi4X5IYkkXcPfuBTDM+ifDESkf74ASmHKUbWWp4ius1AO+w7Kj8TRQx+7T/o+qMZCttc32+YTGLCyGSdXRPRj5XLMwxh1DZspSrBI4x5USxsP5h8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2VytbPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67F9C4CEE2;
	Wed, 26 Mar 2025 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011678;
	bh=i4esRH3afJ3otq9v4ydtTKgS1pPCtvdj1yPdSPUEs4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2VytbPgGnLT2BkBTfNUzqsmh8nJjDw8iN9CiHIbvfUkpmzOBxDL6ZWagyFITrAL9
	 Mlbge7loioV/s5Kb6tsFIsp625w1uZl2vMH+k7WDV34zhZqlIuu6an4Ld/BvunQxXh
	 +i6RF86gYrvF/D488H4cGdxtOfeAj4IaLa2Omkdt7X7HpsliBNiYH6FsLzya3PjWCz
	 agiNshPMOLz/Yui0SK4QyBIFe2Ab5mP1gi+eDpSvMXev/4eS1OjwEQn1225YBQx3ON
	 C9zod7RNfGu8sL4UNorGgqOV5zpMUjj/LqO4WOyRe1pCSGl8AStEsOKmyzaqdh39kI
	 XuG5cFyDv47tA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.4 v3 1/2] net: openvswitch: fix race on port output
Date: Wed, 26 Mar 2025 13:54:33 -0400
Message-Id: <20250326133751-ad046c9d34baf2ce@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326155800.4133904-2-florian.fainelli@broadcom.com>
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
1:  066b86787fa3d ! 1:  096bab5f76d8c net: openvswitch: fix race on port output
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

