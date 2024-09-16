Return-Path: <stable+bounces-76234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF197A0B7
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2511C22DB4
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18551156250;
	Mon, 16 Sep 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgHRsiDh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D715667E;
	Mon, 16 Sep 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488011; cv=none; b=gEYhcatvnZqbslm8MLK7q+FCw5HCUH2dNUH7gCyNWZMl6PYLMzogFFCja/SzjT103hf8QgVgcYO0zY6Etnp6yyPGUTOq5PWv5MVTF/fBk7EMJUN0X4GaVfkIbOKgYZCDZZ5c4iTDgTT93jZUlS7Z6yn4L1houPf7ah6THZwM/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488011; c=relaxed/simple;
	bh=INGJk12e3mBv4m6QOm86Ag38mtjUkOXk7IHkroGvIMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAUELEwKlcRZnd1yxlhCcwRereIBNVEU5IxBYStnXUCFCMi89IA1vrueMwtVjkzc6MKaIqLonN7SC99Htii3pdtDCRQO1wt35luAeO1Id9uhmiUnTcTySVg+AOqEsnglW20K6cOL8/YKId2ROG2t/89qz6pn0w284BzcyG91WZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VgHRsiDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4F6C4CEC4;
	Mon, 16 Sep 2024 12:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488011;
	bh=INGJk12e3mBv4m6QOm86Ag38mtjUkOXk7IHkroGvIMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgHRsiDh7+WJXQWLsBCSvwqj+QZoEXIsaqnX2USNb4g8HP2z1b3bmux6YbGBA93Xx
	 Bi3vB4Sik3sJ8fwXQIlUksyP96+cBfPzIn5dRFN7oZt4IltxPn9GjtZQpOMbvPLURc
	 ozeVxViXF5iKH5Goog8WvXdfnKa/ULis7dzcsg0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 27/63] net: tighten bad gso csum offset check in virtio_net_hdr
Date: Mon, 16 Sep 2024 13:44:06 +0200
Message-ID: <20240916114222.036740955@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114221.021192667@linuxfoundation.org>
References: <20240916114221.021192667@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>

commit 6513eb3d3191574b58859ef2d6dc26c0277c6f81 upstream.

The referenced commit drops bad input, but has false positives.
Tighten the check to avoid these.

The check detects illegal checksum offload requests, which produce
csum_start/csum_off beyond end of packet after segmentation.

But it is based on two incorrect assumptions:

1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GSO.
True in callers that inject into the tx path, such as tap.
But false in callers that inject into rx, like virtio-net.
Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.

2. TSO requires checksum offload, i.e., ip_summed == CHECKSUM_PARTIAL.
False, as tcp[46]_gso_segment will fix up csum_start and offset for
all other ip_summed by calling __tcp_v4_send_check.

Because of 2, we can limit the scope of the fix to virtio_net_hdr
that do try to set these fields, with a bogus value.

Link: https://lore.kernel.org/netdev/20240909094527.GA3048202@port70.net/
Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20240910213553.839926-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/virtio_net.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -161,7 +161,8 @@ retry:
 			break;
 		case SKB_GSO_TCPV4:
 		case SKB_GSO_TCPV6:
-			if (skb->csum_offset != offsetof(struct tcphdr, check))
+			if (skb->ip_summed == CHECKSUM_PARTIAL &&
+			    skb->csum_offset != offsetof(struct tcphdr, check))
 				return -EINVAL;
 			break;
 		}



