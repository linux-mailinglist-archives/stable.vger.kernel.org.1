Return-Path: <stable+bounces-57646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85215925D5C
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7011F24406
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2318133B;
	Wed,  3 Jul 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hTjuB2el"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01D180A99;
	Wed,  3 Jul 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005508; cv=none; b=jBxQL2krBUbmRtTaF5G3XZn0OwqQdFGq3FsS0gn+LI8DsxNadPyylkGIrRIbYqUHScAPLOFMF+CmClEvQW6lVCAH16dN3ipxMYcheQYNgb3hS3heWfJP8huOprvjemiKWPwoUMRPW/t2IQuUh8VTEs+ct9euj0YWy4KOn4MmcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005508; c=relaxed/simple;
	bh=JQcelS4OJ/9iM4MRux4ZeFVlCAHjM4sOKrv/R3fwrzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaeHDoNepGrHb6hdHLBR7e1IpXFC0zX+TU8y8Mdhoy/eCLeUgcMq5laqR6yw2DmC+Ge0MfNNWFVfXoAmtd3PvNGDeSJfkkzWUyhFEjNEQr6AyzBlh6uf0zfmx++KPI1Zf1fzQD9QmJxf7bnBVPog9pnzgjjd0jQZTAwVZpe1Na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hTjuB2el; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7994C2BD10;
	Wed,  3 Jul 2024 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005508;
	bh=JQcelS4OJ/9iM4MRux4ZeFVlCAHjM4sOKrv/R3fwrzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTjuB2elzCpmoedIhplWuUHzk7Jokk817JSSRvVvj027uh2cxwQR3Yp2Y2m/OpIPP
	 8fAtNS0Cw0xfE5VuNlOuvktejIUmGJZpLNpZ4P3sV73ViVb2eC+eyeKtkKKme0cLB8
	 M1gKadfBxo/tqfB7iVzMv4kxoTCRzvRdfMNWQRcM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 104/356] net/mlx5e: Fix features validation check for tunneled UDP (non-VXLAN) packets
Date: Wed,  3 Jul 2024 12:37:20 +0200
Message-ID: <20240703102917.034258697@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit 791b4089e326271424b78f2fae778b20e53d071b ]

Move the vxlan_features_check() call to after we verified the packet is
a tunneled VXLAN packet.

Without this, tunneled UDP non-VXLAN packets (for ex. GENENVE) might
wrongly not get offloaded.
In some cases, it worked by chance as GENEVE header is the same size as
VXLAN, but it is obviously incorrect.

Fixes: e3cfc7e6b7bd ("net/mlx5e: TX, Add geneve tunnel stateless offload support")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 79d687c663d54..a0870da414538 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3989,7 +3989,7 @@ static netdev_features_t mlx5e_tunnel_features_check(struct mlx5e_priv *priv,
 
 		/* Verify if UDP port is being offloaded by HW */
 		if (mlx5_vxlan_lookup_port(priv->mdev->vxlan, port))
-			return features;
+			return vxlan_features_check(skb, features);
 
 #if IS_ENABLED(CONFIG_GENEVE)
 		/* Support Geneve offload for default UDP port */
@@ -4015,7 +4015,6 @@ netdev_features_t mlx5e_features_check(struct sk_buff *skb,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
 	features = vlan_features_check(skb, features);
-	features = vxlan_features_check(skb, features);
 
 	/* Validate if the tunneled packet is being offloaded by HW */
 	if (skb->encapsulation &&
-- 
2.43.0




