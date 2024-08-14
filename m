Return-Path: <stable+bounces-67575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070EC951200
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7151C21363
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFEC558B7;
	Wed, 14 Aug 2024 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY0sKfd9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C8768EC;
	Wed, 14 Aug 2024 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601705; cv=none; b=swZ3IqxfAPu2VFA8IS8YH1Q0eOqz/H6njuO+5c2WC0iwTHhhP147CpSFAT49dypeRWxbCej4EcHC/8XqaSkVB7C4dAIPjBXpSf723kJ5c34SC2VZKJcrl575E64yrRhm3cMPv59itTDfIUk25PxNYzSFo/4/7365iXfgTK3KqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601705; c=relaxed/simple;
	bh=1DN7OE4XKRCrfF9fvqikmkCbAY0PdivoPjLfcJKBRFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAbB5oAOpV/rR0j74YokQXvxOaUtefUnupa6pO4h1nO89ewn4hDoBZUtOIdm54zEhACblFRIqsN/yjGzOaK6+KViz0Sb427Yjfms8vHDggVlumA6MJfPvqOoW08LPjunh8H1jWAyCofWF2HkIR8D1BMvemcmKCmmmCXNTIpDnRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY0sKfd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33CDC4AF09;
	Wed, 14 Aug 2024 02:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601705;
	bh=1DN7OE4XKRCrfF9fvqikmkCbAY0PdivoPjLfcJKBRFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sY0sKfd9CqRoSZJ8dOOrBwTMGCddSvHMg9MLlKN8r/1KaUQ+HOlyl2vd/A+av9Xe6
	 3zpEF3guwoa2C9tJPmI7OAI8uqJBrMZqPfR5VZq9RYNWvXqFnaMt9bpPfmrucHuiiN
	 j8oMWDSISisv9Vq+cwH33wUhGL2g1vSFt+5+yhga4gwv9sYW6uC2kvQeRLc6fKNrKy
	 hkSPS58ri7r/7aao1+aZklMjnimri5+iQfiLfbeqRBuMgDifeM6ip/xW2+oiol/3a0
	 sdMkyDeRYkufpkCutOnHKykr7iyxs0r67LUhZpZRjuGVoDsF/Ajk34j7ZcCBRtcZcQ
	 7BFrmP+eREIDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 09/13] virtio-net: check feature before configuring the vq coalescing command
Date: Tue, 13 Aug 2024 22:14:40 -0400
Message-ID: <20240814021451.4129952-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Heng Qi <hengqi@linux.alibaba.com>

[ Upstream commit b50f2af9fbc5c00103ca8b72752b15310bd77762 ]

Virtio spec says:

	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.

So we add the feature negotiation check to
virtnet_send_{r,t}x_ctrl_coal_vq_cmd as a basis for the next bugfix patch.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5161e7efda2cb..08a83944dcc0a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3172,6 +3172,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 {
 	int err;
 
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return -EOPNOTSUPP;
+
 	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
 					    max_usecs, max_packets);
 	if (err)
@@ -3189,6 +3192,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 {
 	int err;
 
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return -EOPNOTSUPP;
+
 	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
 					    max_usecs, max_packets);
 	if (err)
-- 
2.43.0


