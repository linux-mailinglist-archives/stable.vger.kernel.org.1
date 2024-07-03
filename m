Return-Path: <stable+bounces-56995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F36925A1B
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D289B1C25F3F
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB6183090;
	Wed,  3 Jul 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xAnF5m2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E2137910;
	Wed,  3 Jul 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003520; cv=none; b=jhENeuMPjb5++ZY/pL+kvX8aUxx29CEcFbBtgvoCmN0DecYBsbb3CyFWQzp/inukh4roXUF0s/9i7lZP4QhipQG9qcC9KzaF8jONMD6Wow39rZNtBCcxEpCn4fIp/kzUBXtAC2K3M4WZyjWCpUyyqt9Rj5avJsIQiHQqbfn2xKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003520; c=relaxed/simple;
	bh=8/QtBQpTN7q3BdMuBKEJn86BbMAo1iXxTPM3xjAXabc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ll1f9V3sKK75ZKQZ+TCrX9LE6Zm1aSGn5yGNFTUCBUf94/QdVJgdnzJM99YIJE4yxEdqfB58Xl77Ui7a8dlB0bwn/hiTTP+bYerIbg61KF4ERV0ENCDjVRBnBd7a2PPSremM4uEw/OvmUalpwnesgBNawjLjadV6mORA9cPaP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xAnF5m2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54D0C2BD10;
	Wed,  3 Jul 2024 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003520;
	bh=8/QtBQpTN7q3BdMuBKEJn86BbMAo1iXxTPM3xjAXabc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xAnF5m2eVwYuxG1d2/6FPg07UAVc6ErumXtHrJzALSPvc+9eve4bt6/nQNiMPJZ3W
	 KIqhokU4TxT6QwkU9FahPOu71LL/UjX5VR8/VT2KptcfxmH8VxRTSu/yp4x4gbRe7E
	 9aLAtE3ymhAU6V/x0wonxDnrren576omWEffF/cg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heng Qi <hengqi@linux.alibaba.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/139] virtio_net: checksum offloading handling fix
Date: Wed,  3 Jul 2024 12:39:32 +0200
Message-ID: <20240703102833.273805803@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>
References: <20240703102830.432293640@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heng Qi <hengqi@linux.alibaba.com>

[ Upstream commit 604141c036e1b636e2a71cf6e1aa09d1e45f40c2 ]

In virtio spec 0.95, VIRTIO_NET_F_GUEST_CSUM was designed to handle
partially checksummed packets, and the validation of fully checksummed
packets by the device is independent of VIRTIO_NET_F_GUEST_CSUM
negotiation. However, the specification erroneously stated:

  "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device MUST set flags
   to zero and SHOULD supply a fully checksummed packet to the driver."

This statement is inaccurate because even without VIRTIO_NET_F_GUEST_CSUM
negotiation, the device can still set the VIRTIO_NET_HDR_F_DATA_VALID flag.
Essentially, the device can facilitate the validation of these packets'
checksums - a process known as RX checksum offloading - removing the need
for the driver to do so.

This scenario is currently not implemented in the driver and requires
correction. The necessary specification correction[1] has been made and
approved in the virtio TC vote.
[1] https://lists.oasis-open.org/archives/virtio-comment/202401/msg00011.html

Fixes: 4f49129be6fa ("virtio-net: Set RXCSUM feature if GUEST_CSUM is available")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3020,8 +3020,15 @@ static int virtnet_probe(struct virtio_d
 			dev->features |= dev->hw_features & NETIF_F_ALL_TSO;
 		/* (!csum && gso) case will be fixed by register_netdev() */
 	}
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
-		dev->features |= NETIF_F_RXCSUM;
+
+	/* 1. With VIRTIO_NET_F_GUEST_CSUM negotiation, the driver doesn't
+	 * need to calculate checksums for partially checksummed packets,
+	 * as they're considered valid by the upper layer.
+	 * 2. Without VIRTIO_NET_F_GUEST_CSUM negotiation, the driver only
+	 * receives fully checksummed packets. The device may assist in
+	 * validating these packets' checksums, so the driver won't have to.
+	 */
+	dev->features |= NETIF_F_RXCSUM;
 
 	dev->vlan_features = dev->features;
 



