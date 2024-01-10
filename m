Return-Path: <stable+bounces-9486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E825A823296
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F44C281C6C
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9241BDFF;
	Wed,  3 Jan 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rmXArEx7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF61BDF1;
	Wed,  3 Jan 2024 17:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E47C433C8;
	Wed,  3 Jan 2024 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301744;
	bh=16vf15VCvczniSb5DLhhHnUWMbYd92TxBmtWOWxqT0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rmXArEx7+rQfMtNvmeo3I00jscwr7Md3v0xzUIclK8xKitDREvb71ptyRzvb6cKnG
	 XHryVqxXRVLeExb1SJB7e+3/s47r+jMez8AWN/+Fqm3IxPDLrKcSXZvhBoz2v3J1vR
	 ZjMW/e2DYfpwKIOZivrikeTlfZOWC3bv1qMdoOiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 18/75] net: check dev->gso_max_size in gso_features_check()
Date: Wed,  3 Jan 2024 17:54:59 +0100
Message-ID: <20240103164845.966439896@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
References: <20240103164842.953224409@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 24ab059d2ebd62fdccc43794796f6ffbabe49ebc ]

Some drivers might misbehave if TSO packets get too big.

GVE for instance uses a 16bit field in its TX descriptor,
and will do bad things if a packet is bigger than 2^16 bytes.

Linux TCP stack honors dev->gso_max_size, but there are
other ways for too big packets to reach an ndo_start_xmit()
handler : virtio_net, af_packet, GRO...

Add a generic check in gso_features_check() and fallback
to GSO when needed.

gso_max_size was added in the blamed commit.

Fixes: 82cc1a7a5687 ("[NET]: Add per-connection option to set max TSO frame size")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20231219125331.4127498-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 34f80946d2c72..fc881d60a9dcc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3523,6 +3523,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	if (gso_segs > dev->gso_max_segs)
 		return features & ~NETIF_F_GSO_MASK;
 
+	if (unlikely(skb->len >= READ_ONCE(dev->gso_max_size)))
+		return features & ~NETIF_F_GSO_MASK;
+
 	if (!skb_shinfo(skb)->gso_type) {
 		skb_warn_bad_offload(skb);
 		return features & ~NETIF_F_GSO_MASK;
-- 
2.43.0




