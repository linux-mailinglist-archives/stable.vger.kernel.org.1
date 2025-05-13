Return-Path: <stable+bounces-144222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C1AB5CA5
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1303B90F1
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EDC2BE0FB;
	Tue, 13 May 2025 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BigUmQgL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FFF1E521A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162109; cv=none; b=dSiu9WLR3HCxs/+6H4iKrKzZMTLQ/13vHsXhLvD1pwWurvoiD3CUYR8xYu8QTMq/l49JRlqt++73luUweNOP3+Q3ZDSJb6SgpKOkJ8/U4szM+/9MupsehFoRIY7hEV6BbtUGN0nCoao02J8hahVUfzMrto7VmjT5VM30celEKdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162109; c=relaxed/simple;
	bh=FQAcM9sLLoSDXfCch3D9x5qhEDsHyYDnO93HrLq8NHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB6+cbrgRnptBc7k5H/8YL7gg3UfE020+Uz+rtgk+uh9/D2xCXR6CEKREmtr/sTWxEoUxQVRzlJ5TQDG4A3zPGvrsB2uIT6UG8t99J3kkkb/USuHCM8b7BFJT/3uzXUTPEJuXB8Ea1v6ebfagXljCYXJ5DuFPgn928Uau/KhdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BigUmQgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0CC4CEE4;
	Tue, 13 May 2025 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162109;
	bh=FQAcM9sLLoSDXfCch3D9x5qhEDsHyYDnO93HrLq8NHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BigUmQgL3HVhSYsx3DOYqCsC69l0kJ2L77HTdBXYAAdJAfDwya0QckS/KqnXp0XQN
	 0jsrBCMo1oNns+dkAiNWqFACplGBOxBFkn2iDCyStYV+ouJNOSF2ZnoMDIdA+PCYEB
	 pCpO0/2cTLF2CB4KF8gu7jgM1i8e1lrzx8AH8rpt7F5CHwA3TT2/gaBsNvvJjfBghY
	 2zp6qU3ZVaAz3uoXkfbMK/0E+ewgVjjNIn4Edn3hzERbnVyMhOcoLcW+BTScDs8TCb
	 6R7fjfXh8zREiCZSyHkxRVoqU4DL4ueWRiwFhPNInF/MFm434wgaDokRFTOTDGzX+r
	 CBqWHg+svjPIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] net: fec: remove .ndo_poll_controller to avoid deadlocks
Date: Tue, 13 May 2025 14:48:26 -0400
Message-Id: <20250513111424-985c3934689e6c58@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513084802.1705121-1-Feng.Liu3@windriver.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c2e0c58b25a0a ! 1:  4c81ce68d2ac2 net: fec: remove .ndo_poll_controller to avoid deadlocks
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
    + 	.ndo_do_ioctl		= fec_enet_ioctl,
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
| stable/linux-5.10.y       |  Success    |  Success   |

