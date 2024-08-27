Return-Path: <stable+bounces-71305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4037D9612C6
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C3E28210F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21321CEAD3;
	Tue, 27 Aug 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="otPBC6rC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F91CEAC8;
	Tue, 27 Aug 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772775; cv=none; b=omMBt9MhgKRWG8BAQt3tc3bIs+sG/2D5wgUJoZleLDGuir7mlgsNB29N+N33/zUHMkkID8ItjCNIXOhsCZJagRABI7PVk0QY5cphjjBz9wWSH/NHryeZFK4SS+cGwjtRCwKiM4ab/jH4xRjCkW35us5IC4eTEYq+7XxrvVQcUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772775; c=relaxed/simple;
	bh=qaBQCUu3FDUB+fYDXNOCtl3+JxS69aRyzQxyP2vFYXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka/s46cjixRSgU2m+oVTflarxndQCnn7x2dxVYyGspKAC7pK96YdI/h/w+S4/8aky/GdGajXYDvNgtt0AUbNSmBQhSDyfQEFsgBuNepTI1aILc3Nh/JplBBjyzW6+Dczgz8V6oOU4zjO+SRKk1dkKYd7hMEnCTP5hQpviYuoUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=otPBC6rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2C1C61043;
	Tue, 27 Aug 2024 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772775;
	bh=qaBQCUu3FDUB+fYDXNOCtl3+JxS69aRyzQxyP2vFYXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=otPBC6rC3L9qe2MSaVZtJbGg4yc4Kwk3y0+u4MJLEUXvpjDiQTBGxxtaANIoLJ5Ho
	 0BL6s8tjuVD0Yopp5f1SOPw6elUOQTTs5tAbZPR2+lNDOJSmjZw3Ra+zO51Pi4UcoE
	 vDqPg0+EcEZlXHXzRJ0CA3ar1p2r3e2w3mQPzDvc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 316/321] udp: fix receiving fraglist GSO packets
Date: Tue, 27 Aug 2024 16:40:24 +0200
Message-ID: <20240827143850.287114897@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

commit b128ed5ab27330deeeaf51ea8bb69f1442a96f7f upstream.

When assembling fraglist GSO packets, udp4_gro_complete does not set
skb->csum_start, which makes the extra validation in __udp_gso_segment fail.

Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20240819150621.59833-1-nbd@nbd.name
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp_offload.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -278,7 +278,8 @@ struct sk_buff *__udp_gso_segment(struct
 		return ERR_PTR(-EINVAL);
 
 	if (unlikely(skb_checksum_start(gso_skb) !=
-		     skb_transport_header(gso_skb)))
+		     skb_transport_header(gso_skb) &&
+		     !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)))
 		return ERR_PTR(-EINVAL);
 
 	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {



