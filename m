Return-Path: <stable+bounces-161862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9988DB043B3
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8091A4E0060
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40222264A89;
	Mon, 14 Jul 2025 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFQcd8iz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0126462E;
	Mon, 14 Jul 2025 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506478; cv=none; b=FXyRlehl6IMFJAa5ce/xEe6sIld/jjpFw3zArHvrqLv5+11QtcLo5jku701s507lUOt+lDppAlVHAfWc1k9O8s2XsqhTbO0N/EhDrw1wGnisvZNkVSUEdA3VjPj+EmmQT7CiwEX6LLn/8YCgFBmue2KhaAdK/ilqlgNUzq3Z21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506478; c=relaxed/simple;
	bh=oKf208jR2snmwBDg9o+AlVnnid4IgiStTjfyVYgKtp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApipDRbO4+9PfsDP4mHV5yVOhkSpcpldQtBAimodG/FSyCztYbdE4w8rNQulmBaAC6wQbFsk9inuVgEFF2k3b97aMhwzxZk2Nsv5nLTK5/wHFqid2+EGyj+HUy2sxOVCv7uhJl/UNFAy21NGwx0NcsHaawkmnkMRokpJ1dLsHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFQcd8iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60278C4CEF5;
	Mon, 14 Jul 2025 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506477;
	bh=oKf208jR2snmwBDg9o+AlVnnid4IgiStTjfyVYgKtp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFQcd8izY8tenB38W6DzhOcXP2i3ZQLYLWqpDlBlnBQIhbyiBhsJqUo/uuhJy62+l
	 n/4mnE90DP+7YeflVKcA4DalJ1BHNPFVENQTgRRj9FYh6g7KeFswzk21m55YrPkTsl
	 NF1S+cwYi4o8qPrf+kBFgBd8fjzUmGg6sxYjOIl35E+sh+IE1DFGyJs9O3cIKjKfeZ
	 vyjNzRguNaVladnJ7HxjhR932uM/L26KqYMoxQiKvfsCT02FFoB1/egVHFICmtPFfi
	 6sXUDtXTDWp9OG6RlcSTz5wgj1HlNPhaGOvli31yRIJJneOrz0PC9m4jHk/99A91Md
	 DqPegSk3ECUSg==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 2/9] vsock/virtio: Validate length in packet header before skb_put()
Date: Mon, 14 Jul 2025 16:20:56 +0100
Message-Id: <20250714152103.6949-3-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250714152103.6949-1-will@kernel.org>
References: <20250714152103.6949-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving a vsock packet in the guest, only the virtqueue buffer
size is validated prior to virtio_vsock_skb_rx_put(). Unfortunately,
virtio_vsock_skb_rx_put() uses the length from the packet header as the
length argument to skb_put(), potentially resulting in SKB overflow if
the host has gone wonky.

Validate the length as advertised by the packet header before calling
virtio_vsock_skb_rx_put().

Cc: <stable@vger.kernel.org>
Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/vmw_vsock/virtio_transport.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..bd2c6aaa1a93 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -624,8 +624,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
+			unsigned int len, payload_len;
+			struct virtio_vsock_hdr *hdr;
 			struct sk_buff *skb;
-			unsigned int len;
 
 			if (!virtio_transport_more_replies(vsock)) {
 				/* Stop rx until the device processes already
@@ -642,12 +643,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			vsock->rx_buf_nr--;
 
 			/* Drop short/long packets */
-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
+			if (unlikely(len < sizeof(*hdr) ||
 				     len > virtio_vsock_skb_len(skb))) {
 				kfree_skb(skb);
 				continue;
 			}
 
+			hdr = virtio_vsock_hdr(skb);
+			payload_len = le32_to_cpu(hdr->len);
+			if (payload_len > len - sizeof(*hdr)) {
+				kfree_skb(skb);
+				continue;
+			}
+
 			virtio_vsock_skb_rx_put(skb);
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
-- 
2.50.0.727.gbf7dc18ff4-goog


