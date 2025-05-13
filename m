Return-Path: <stable+bounces-144246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0ECAB5CC3
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380C919E8717
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78602BEC5A;
	Tue, 13 May 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t25yjU+P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88508748F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162213; cv=none; b=CYzEyhs0pM4b6NB9Xtmfm2SNnkzFLQhorkc17AJ/Ed7jIb1TkV/whSqa93OkXkKwE7wHItzw0Xw219W78ZN1BvE2wDvGDp6Ig3n6QJbFPsj/20+UTYnZ5SoPSsExS47hFUcbim6CfuhN7VqznaXDoKIImKuRJAPnxce0poYRgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162213; c=relaxed/simple;
	bh=E3o6OC1r8L9l6rNV6l2Ammf5Klbf2OW9gLNKp+XdM3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNLhNb4llDI6WhKL8J4pooCfqMz/PnFSudVv0I2UjhZZHxDFT6Ebgpc8bNnwg3E+WSI8XTg4mzsqcJlvtOwB+u2/t1+IjcTGwnS4EPtkJ6oVCLPv3G04PdQSDrUhxpWXU513Mo/P3yvOQW+2zfxfRS9x8jKx2nUs4zl6OFPFPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t25yjU+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ECFC4CEE4;
	Tue, 13 May 2025 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162213;
	bh=E3o6OC1r8L9l6rNV6l2Ammf5Klbf2OW9gLNKp+XdM3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t25yjU+P7yKNFk6L8Q4XVH3ggDX2jSfuZddbSuWXx8eKk2W0WUEK5VdW5Rfo6NPrV
	 HPdjwVZ2N/96Z9AhdENy4ySjZTbe+p1D2jb3cBtsxxLzaIeGcJ07Tc6A/01lMe9mIp
	 tMlAWBTMKNED0U98l4CTWyV7ttyN+3dynsDA16vCtA51+kfvc179WNjh9iejuBG2h3
	 2tGvGed0VFDJ/kXthT38ReJf6SGNSTnecb8oxT77wZ8zMxeND0S9DRR4F4fi6W/UYw
	 2izpEL0WlqGlnMF6aUSoNw0NKQ/52nd6yjUGPjAwYZlDUzUkbV8rZtRI3qEL6mnHFC
	 b+lziA7j9HaaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] net: fec: remove .ndo_poll_controller to avoid deadlocks
Date: Tue, 13 May 2025 14:50:09 -0400
Message-Id: <20250513071842-506f25726da7a0a9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513084802.1705121-2-Feng.Liu3@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: c2e0c58b25a0a0c37ec643255558c5af4450c9f5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Wei Fang<wei.fang@nxp.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d38625f71950)
6.1.y | Present (different SHA1: e2348d8c61d0)

Note: The patch differs from the upstream commit:
---
1:  c2e0c58b25a0a ! 1:  a32e7777c7358 net: fec: remove .ndo_poll_controller to avoid deadlocks
    @@ Metadata
      ## Commit message ##
         net: fec: remove .ndo_poll_controller to avoid deadlocks
     
    +    [ Upstream commit c2e0c58b25a0a0c37ec643255558c5af4450c9f5 ]
    +
         There is a deadlock issue found in sungem driver, please refer to the
         commit ac0a230f719b ("eth: sungem: remove .ndo_poll_controller to avoid
         deadlocks"). The root cause of the issue is that netpoll is in atomic
    @@ Commit message
         Signed-off-by: Wei Fang <wei.fang@nxp.com>
         Link: https://lore.kernel.org/r/20240511062009.652918-1-wei.fang@nxp.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [Minor context change fixed]
    +    Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## drivers/net/ethernet/freescale/fec_main.c ##
     @@ drivers/net/ethernet/freescale/fec_main.c: fec_set_mac_address(struct net_device *ndev, void *p)
    @@ drivers/net/ethernet/freescale/fec_main.c: fec_set_mac_address(struct net_device
     @@ drivers/net/ethernet/freescale/fec_main.c: static const struct net_device_ops fec_netdev_ops = {
      	.ndo_tx_timeout		= fec_timeout,
      	.ndo_set_mac_address	= fec_set_mac_address,
    - 	.ndo_eth_ioctl		= phy_do_ioctl_running,
    + 	.ndo_eth_ioctl		= fec_enet_ioctl,
     -#ifdef CONFIG_NET_POLL_CONTROLLER
     -	.ndo_poll_controller	= fec_poll_controller,
     -#endif
      	.ndo_set_features	= fec_set_features,
    - 	.ndo_bpf		= fec_enet_bpf,
    - 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
    + };
    + 
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

