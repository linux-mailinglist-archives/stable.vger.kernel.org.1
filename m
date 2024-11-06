Return-Path: <stable+bounces-91132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CD9BECA1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37067285D75
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFF51E5712;
	Wed,  6 Nov 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGKL9QHp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29D1E3DEE;
	Wed,  6 Nov 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897832; cv=none; b=RuGBa4YUrnPXNPNI3Mybs16NZjWib4e+aOT2PJVBXt/byrx0zbeKM5NTetaLD6Ua1kziizJVzqkDEwDRJgtNZvue2obk1eDjowqu9i3SXQPDGO9YXf5OcFmuv9yADrrDEi8slGOApGGfsMWEwEZsmiI2Es7dOvGFB1d3GOrNnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897832; c=relaxed/simple;
	bh=8vDgYi0vlD+H9cU166WtENZHSo7FN0JqHw9yVLAlKV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwmi3tN1cbIiN6qKsdYcOL3lATK3YLKQdgYmivQI2erBGRQ4oguPG+93PzcGib3Jjdr69KvsoGmC47t/UlOtViA/T3cpkc5X77ZW011bGWCzLJ3HUgzNLt8WgxYCGpw6/G1UIJAhyj3Ck3fpMDqmNwXZIr9fwY3izj2BirFQRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGKL9QHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BE8C4CECD;
	Wed,  6 Nov 2024 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897832;
	bh=8vDgYi0vlD+H9cU166WtENZHSo7FN0JqHw9yVLAlKV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGKL9QHprAK75Gz03mIyT0PzBwqDZDJoGyX7HVnPAxERytqDAKI9XIc+0FdYqTBVH
	 ejdmQmRG0Qv56Wf1kdBcZvPDcU2QW1jJmQhWgthl61ZDoCXoCn4BRMn39TZ48RSVu0
	 68m0PtQTQd9NSQbn5+7tX/xM1xZSSQO+OxVqbkcM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 009/462] net: dpaa: Pad packets to ETH_ZLEN
Date: Wed,  6 Nov 2024 12:58:22 +0100
Message-ID: <20241106120331.737533882@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Anderson <sean.anderson@linux.dev>

[ Upstream commit cbd7ec083413c6a2e0c326d49e24ec7d12c7a9e0 ]

When sending packets under 60 bytes, up to three bytes of the buffer
following the data may be leaked. Avoid this by extending all packets to
ETH_ZLEN, ensuring nothing is leaked in the padding. This bug can be
reproduced by running

	$ ping -s 11 destination

Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20240910143144.1439910-1-sean.anderson@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 00c4beb760c3..1d18556f1767 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2053,12 +2053,12 @@ static netdev_tx_t
 dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
 	const int queue_mapping = skb_get_queue_mapping(skb);
-	bool nonlinear = skb_is_nonlinear(skb);
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa_percpu_priv *percpu_priv;
 	struct netdev_queue *txq;
 	struct dpaa_priv *priv;
 	struct qm_fd fd;
+	bool nonlinear;
 	int offset = 0;
 	int err = 0;
 
@@ -2068,6 +2068,13 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 
 	qm_fd_clear_fd(&fd);
 
+	/* Packet data is always read as 32-bit words, so zero out any part of
+	 * the skb which might be sent if we have to pad the packet
+	 */
+	if (__skb_put_padto(skb, ETH_ZLEN, false))
+		goto enomem;
+
+	nonlinear = skb_is_nonlinear(skb);
 	if (!nonlinear) {
 		/* We're going to store the skb backpointer at the beginning
 		 * of the data buffer, so we need a privately owned skb
-- 
2.43.0




