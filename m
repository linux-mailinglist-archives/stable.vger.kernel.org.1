Return-Path: <stable+bounces-102699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D39EF324
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A120D28A36D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95F223C66;
	Thu, 12 Dec 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I9IOTv0s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485D222D74;
	Thu, 12 Dec 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022171; cv=none; b=EUYjeQD0z4+lyDRXev3QSK/9MK1k6ax0Z5c9vUhinw7LwDUmeTBPv/xFWWNSZNPDGxs4c/Fnc/ZI13yyN8KFsYsOHwzGh/H1nliDr3/07VfiGFonTPzZQjOt0s/3GvPjINYpHrW/4fvVoDaNf/dySwgrs8mksSWQioKm0wXfYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022171; c=relaxed/simple;
	bh=KGvIG2dbeJ0qLzIgvUd72wwjSTUcLHuGaz9TGWnV0ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0ueYpz8MI5Fkhdt8BmbhgcyutoMK/HnkNMmFFjf3plk+0HWeG505mFrsq3jhmoJTwwU0523w5YtjG87E8IOVGmwqlQ4ehdHwEX1XHbUEwmVz+ZEs7G7ALtjjKNr+JFci3OMYmfVFOwObrZcVMRfKElfBc6hREwRX1V2tLgVZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I9IOTv0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D753AC4CED3;
	Thu, 12 Dec 2024 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022171;
	bh=KGvIG2dbeJ0qLzIgvUd72wwjSTUcLHuGaz9TGWnV0ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9IOTv0sjePA0bdby+xar3/nfPtJKYoPPly2bLEGVL/paBm3MF4eMZdCAyNKHISle
	 BzE2cC0V10Emqcchrw0W4vE0Tl08zrqDDnzVkpGtlQfkSsb/GCIHKHscR/+5xc5BbY
	 QEEkgclcuK7cMSFw5EoKabCx87cPElwlV+iQohP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raed Salem <raeds@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 168/565] xfrm: store and rely on direction to construct offload flags
Date: Thu, 12 Dec 2024 15:56:03 +0100
Message-ID: <20241212144318.116392420@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 482db2f1dd211f73ad9d71e33ae15c1df6379982 ]

XFRM state doesn't need anything from flags except to understand
direction, so store it separately. For future patches, such change
will allow us to reuse xfrm_dev_offload for policy offload too, which
has three possible directions instead of two.

Reviewed-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Stable-dep-of: 2cf567f421db ("netdevsim: copy addresses for both in and out paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h     | 6 ++++++
 net/xfrm/xfrm_device.c | 8 +++++++-
 net/xfrm/xfrm_user.c   | 3 ++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 395d85eeb5d88..3232cdf1b4ef4 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -126,12 +126,18 @@ struct xfrm_state_walk {
 	struct xfrm_address_filter *filter;
 };
 
+enum {
+	XFRM_DEV_OFFLOAD_IN = 1,
+	XFRM_DEV_OFFLOAD_OUT,
+};
+
 struct xfrm_dev_offload {
 	struct net_device	*dev;
 	struct net_device	*real_dev;
 	unsigned long		offload_handle;
 	unsigned int		num_exthdrs;
 	u8			flags;
+	u8			dir : 2;
 };
 
 struct xfrm_mode {
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 61aa0fd9d2a0c..7690d23bcf8bb 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -129,7 +129,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 
 	sp = skb_sec_path(skb);
 	x = sp->xvec[sp->len - 1];
-	if (xo->flags & XFRM_GRO || x->xso.flags & XFRM_OFFLOAD_INBOUND)
+	if (xo->flags & XFRM_GRO || x->xso.dir == XFRM_DEV_OFFLOAD_IN)
 		return skb;
 
 	/* This skb was already validated on the upper/virtual dev */
@@ -285,11 +285,17 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	/* Don't forward bit that is not implemented */
 	xso->flags = xuo->flags & ~XFRM_OFFLOAD_IPV6;
 
+	if (xuo->flags & XFRM_OFFLOAD_INBOUND)
+		xso->dir = XFRM_DEV_OFFLOAD_IN;
+	else
+		xso->dir = XFRM_DEV_OFFLOAD_OUT;
+
 	err = dev->xfrmdev_ops->xdo_dev_state_add(x);
 	if (err) {
 		xso->num_exthdrs = 0;
 		xso->flags = 0;
 		xso->dev = NULL;
+		xso->dir = 0;
 		xso->real_dev = NULL;
 		dev_put(dev);
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index bb63b0dab87bd..1aa05b608ccf0 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -855,7 +855,8 @@ static int copy_user_offload(struct xfrm_dev_offload *xso, struct sk_buff *skb)
 	xuo = nla_data(attr);
 	memset(xuo, 0, sizeof(*xuo));
 	xuo->ifindex = xso->dev->ifindex;
-	xuo->flags = xso->flags;
+	if (xso->dir == XFRM_DEV_OFFLOAD_IN)
+		xuo->flags = XFRM_OFFLOAD_INBOUND;
 
 	return 0;
 }
-- 
2.43.0




