Return-Path: <stable+bounces-111778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BD3A23AA3
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 09:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A0A3A996D
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694F161302;
	Fri, 31 Jan 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="eYrS+97Z"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886D1487E9;
	Fri, 31 Jan 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312292; cv=none; b=jvNQDp/wCFknvfiww04FJR8NlpDX9ElZ4Z1Aacua1kQj84SfnrBLoCfvip3K4y395xFrJ+TSoH71cO521rxwlkqmnFQGbJsX6+HTdh4OWRo20gpBTm0Yj/9EbLAthtQVM+KNap/mcra7ZiE50s0jESzHiO0MG73PTPBz805hsUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312292; c=relaxed/simple;
	bh=AByGzPZFCZg2nnvpayFZflvZL2RQLHf8zm5g6xZBZ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eT5WI7WUEcpIF8htylI6siCeDRUh/gmUXHNiOz+Q5765Vfr8zrw+Px5z7G9+UIphSe2i2D3KKmggf4/lGPycZCNEkePFHpKPx/kqj0urrRdlHgm3pvLXCvvkmUX0WrYouWnUcmzuZZfbGjFLPS/iA2y7Py3zUmw689qZPfHRWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=eYrS+97Z; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1738312287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wu5giTMaFtSko/rPqNi1xr1VxojhCVJ+Uc0s4BPi43k=;
	b=eYrS+97Z/5DwP3cZB5Tz8GHJRD13exocQJ+QPr8rN/f/cHiEFvQbl2x0IBAWQyfTlrxiFy
	qQmWt7WJtznmi0UGH/gdyYs/g+8oqLn91bBC8Zh5z7lQ2fpv3/5X9RhLU9ih7pC93N0MN2
	tcRPP09adLsOM2EgDMSd07mXRZBitPg=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 3/5] net: tighten bad gso csum offset check in virtio_net_hdr
Date: Fri, 31 Jan 2025 11:31:25 +0300
Message-ID: <20250131083127.4204-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
[Denis: minor fix to resolve merge conflict.]                                           
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2024-43817
Link: https://nvd.nist.gov/vuln/detail/cve-2024-43817
---
 include/linux/virtio_net.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 823e28042f41..62613d4d84b7 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -161,7 +161,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			break;
 		case SKB_GSO_TCPV4:
 		case SKB_GSO_TCPV6:
-			if (skb->csum_offset != offsetof(struct tcphdr, check))
+			if (skb->ip_summed == CHECKSUM_PARTIAL &&
+			    skb->csum_offset != offsetof(struct tcphdr, check))
 				return -EINVAL;
 			break;
 		}
-- 
2.43.0


