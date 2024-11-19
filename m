Return-Path: <stable+bounces-94033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F79D2889
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71711F231B7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C51CF7DE;
	Tue, 19 Nov 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJfUGcXp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FE1CF7C7
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027631; cv=none; b=mcOWY2y6oRTNT/lVXJE/6l/NWLuO0fCpbVCjxXh/TwfimSDuIpll945FmonLTCVzqy9rpGUfj5qQuONBEJacAijDUy58cUI3Yiux7vNcp3RlOPbgn/OiqtwhDDo56vQzlxdWmCDwyXfDf8+nt+4TJ6xLSlbfK5PumQQEZ21GgNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027631; c=relaxed/simple;
	bh=n1A4qKdCwCMxb176SJ/4DbSEUtTswTLh7cVpmN6QEAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6WxEZBd3H++2eNLDDQV1r8P/yU2rn2TGnbZVIbO+z3Hr7JOHz90RGMnutB7ynBaiEsmc9/3epoauXjCvB3kewk2aWFwhV7BQHlb3wcDoigLko+966qk23Q1jbgdJQuyUU8XpN9d0Sa2OxL/lviEj9KHmSnNl9dka0edqkynUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJfUGcXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF64C4CED2;
	Tue, 19 Nov 2024 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027631;
	bh=n1A4qKdCwCMxb176SJ/4DbSEUtTswTLh7cVpmN6QEAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJfUGcXpsPxES2CYwdd77rcpbHJSBokugi/z1uKX24cz5h+V0zh3pI23Qgc53ebOZ
	 8ZFK/5qFx6ZZPsEKfSLL/+tAl2oVMinA9fY3CDpYuVmsh6pVzjNHy5G/5KFbizoB4B
	 sgh7J2AdIS6/DJlHeCwAWx6wdNN8vA0kQ2Akp4AJJaRgoAJNFFbeNPHUW7rrW1VOS5
	 GIuuHlHwzY6RQLnZ/lRHxTch9p1FUPqBa9jkjW8Vo55NDSCBwpukJQvdWwPBpSYiyP
	 T93rrDhK8Gon9UWAi7y0dBcdIP8SCfHD3XZcP1aa7JP8EeVK287vVz0IVRAsc1P2g5
	 GM2pWn+Tvdb8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: fec: remove .ndo_poll_controller to avoid deadlocks
Date: Tue, 19 Nov 2024 09:47:09 -0500
Message-ID: <20241119074135.4005807-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119074135.4005807-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: c2e0c58b25a0a0c37ec643255558c5af4450c9f5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Wei Fang <wei.fang@nxp.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d38625f71950)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 08:03:02.310968054 -0500
+++ /tmp/tmp.8vAz2sLVW3	2024-11-19 08:03:02.303549904 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit c2e0c58b25a0a0c37ec643255558c5af4450c9f5 ]
+
 There is a deadlock issue found in sungem driver, please refer to the
 commit ac0a230f719b ("eth: sungem: remove .ndo_poll_controller to avoid
 deadlocks"). The root cause of the issue is that netpoll is in atomic
@@ -12,15 +14,17 @@
 Signed-off-by: Wei Fang <wei.fang@nxp.com>
 Link: https://lore.kernel.org/r/20240511062009.652918-1-wei.fang@nxp.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/net/ethernet/freescale/fec_main.c | 26 -----------------------
  1 file changed, 26 deletions(-)
 
 diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
-index 8bd213da8fb6f..a72d8a2eb0b31 100644
+index 0a5c3d27ed3b..aeab6c28892f 100644
 --- a/drivers/net/ethernet/freescale/fec_main.c
 +++ b/drivers/net/ethernet/freescale/fec_main.c
-@@ -3674,29 +3674,6 @@ fec_set_mac_address(struct net_device *ndev, void *p)
+@@ -3508,29 +3508,6 @@ fec_set_mac_address(struct net_device *ndev, void *p)
  	return 0;
  }
  
@@ -50,13 +54,16 @@
  static inline void fec_enet_set_netdev_features(struct net_device *netdev,
  	netdev_features_t features)
  {
-@@ -4003,9 +3980,6 @@ static const struct net_device_ops fec_netdev_ops = {
+@@ -3604,9 +3581,6 @@ static const struct net_device_ops fec_netdev_ops = {
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
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

