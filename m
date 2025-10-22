Return-Path: <stable+bounces-189015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF9BFD14B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 18:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A141A0776F
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF43570CF;
	Wed, 22 Oct 2025 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNGbQ043"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC035503D
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149287; cv=none; b=jraTbZ/uCEfrfkRZEJTsZu5kTJt2DUFAtp4h7NOZptWZcP/6GvtflSVqLvSJWRvOVPOr7+40MOFaG2bya6oBZVZC9Br73v6MHKHQa3P7um1RUsH/JW1pQcPCFhLcgxFnK7nyJesXandhUA57YGRTZ4EIG64HiLS6epBTWr3n0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149287; c=relaxed/simple;
	bh=auzHCSUbL/L9ko4QwDjdjbZQ98SIJfRrjs+q/xktilk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGzyot5pLhruFPxXRxTxJxyrCvubLxtioLyQHzBlxS3nq3+X8vMjrX5WzQDWDFeTrGi6Ta+SlpZWzhgvrE1ZK7G9Rdh+Ism0QAgA+uSupHOt5L2W/281YhPf112VG7/QFzJJqCFf7xhzI0R6KRJp+WzGQ3euctxQR6F37/cGAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNGbQ043; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33e27cda4d7so988662a91.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761149285; x=1761754085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9ABbt3qgyLh4i74MVszWBEA6Z+Ea2lJZRM4Xy5gRb4=;
        b=GNGbQ043z3QPjKquCcurU5NH9CGwYuQKLTv5JKeu3s7xvdARXpIwxOkg7ZxLPd/cxy
         K+8c+T9s5eDYPQbMyiAaQlBUKO8hkJETqZ3u6n2ef+pL5KKpY5xL/xm+v2+Rdto2M9SS
         FnAnTZunby6Z81hOAf2tHWBzpXisMrybhYFYVtNW1ysiRl3UUNSiamhrlLlp4jZwDaeS
         I+dq/2cvrc06OLu/hDkmcO2oCmBKN46Tnn/Qu3iwDMfuZRGWMPrESVA4EcuiGbxhkc7o
         cwXOZ9/T7d+odgrTbYx3+lnnumTpOr3Q7HQyfYFF0yI5gYZX/TMNs2TwP88JbLC6zqRO
         b7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149285; x=1761754085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9ABbt3qgyLh4i74MVszWBEA6Z+Ea2lJZRM4Xy5gRb4=;
        b=FOgoXgw4k/ZWj/igaOASXQZfOT3MYGkqUHvT8t/IAPmRMI6/zC7yPMapLf/xczktaT
         Oa1dT1kGomqh7f9G+O6syIysUAZd5yzX71I08iiycWOlK2MaOdICnjeO7+RtGMOuY394
         JImo69qSw/lfmZF4s/6LN7W2RzMccMk86q2GaHh36ZKfBHmG9lW8F1e6LcNS0GtfLGdg
         6QjhfSYbhMfBOKfRgknI4YU5GocH3tysJCsMn6/XbDJQScHPbAQvySy0JtlgX/aOHhK5
         JDT0acRdYMqUnLW6JaDGBx3OosVDboCjeMf6XJ0JBavdY98/jS6s8Edfwa2lyrF3aGPj
         jI0g==
X-Forwarded-Encrypted: i=1; AJvYcCV2tfkX+VaqH+urhGAg66ryibRQG8kmxF8VYJNYG8kIWgvKwf3Zk1O9Z3E3w8BTe+qM5h/sSSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAWDn88TNNDFTT3ofYJ44cjyCTsJ4GtG6RjG3clvOhFHvONQW
	S1S0SnZ1HHFHOuJYfhP0Um6lX3sVKZvqCW8s5cbYY+Zakav2G42Kjp0G
X-Gm-Gg: ASbGncuUi6zg8rLfhZ26SpU1Xam2CjmjdfSVVSN4tqAleOsLIxhme7y3XfhbbPUHUmw
	XuWm5juBisb+yGLXHt9a9Mn7cgAoTd0SykJPKoMz7e++2ZQNbz+sHNwjB+O7IriKkCTSH62D1rq
	obljkWuO1ywwPWEJTg34zQ4OxXAJT05AyWgzPME1wB7W/dQIPpvcAca1dfIo1PnJrfrfYmU6n53
	i/BLZZturmAVQZihS6VEtxNGG843Z4oq6sSviFMOOujkBVQL2TFFWjbBy1LhxwfmBhhAVUjMnpV
	mzybIMYe3audjP+A9rYBZgBYLBgWx9XN/3zJNvyCL1u9WUdm5MGUEzJ+ccGjPoYoIHhQHlKEuqQ
	TWZpiAEUrURDAZWelpQvTf4j+XdWOZAA4g+XeprOINGYGANopq0RLnJZkuTvWvqxqZvzSR0Gij9
	1I1GJ7SD3zb/cr6gRAhwwp
X-Google-Smtp-Source: AGHT+IFKQtMp6Ai1uuAm7SgpDta9tGj5AFau6iGF+3bo3T12AjcV7wXz2cyGdxVGwafExfKv/O8axA==
X-Received: by 2002:a17:90b:3c09:b0:32b:d8a9:8725 with SMTP id 98e67ed59e1d1-33e91ba3198mr2672703a91.18.1761149284702;
        Wed, 22 Oct 2025 09:08:04 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:1e3:b1:dcbf:ab83])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33e2090eff6sm1771750a91.2.2025.10.22.09.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:08:04 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4] virtio-net: fix received length check in big packets
Date: Wed, 22 Oct 2025 23:06:23 +0700
Message-ID: <20251022160623.51191-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), when guest gso is off, the allocated size for big
packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
negotiated MTU. The number of allocated frags for big packets is stored
in vi->big_packets_num_skbfrags.

Because the host announced buffer length can be malicious (e.g. the host
vhost_net driver's get_rx_bufs is modified to announce incorrect
length), we need a check in virtio_net receive path. Currently, the
check is not adapted to the new change which can lead to NULL page
pointer dereference in the below while loop when receiving length that
is larger than the allocated one.

This commit fixes the received length check corresponding to the new
change.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v4:
- Remove unrelated changes, add more comments
Changes in v3:
- Convert BUG_ON to WARN_ON_ONCE
Changes in v2:
- Remove incorrect give_pages call
---
 drivers/net/virtio_net.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..0ffe78b3fd8d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 {
 	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
-	unsigned int copy, hdr_len, hdr_padded_len;
+	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
 	char *p, *hdr_p, *buf;
@@ -915,13 +915,23 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	 * This is here to handle cases when the device erroneously
 	 * tries to receive more than is possible. This is usually
 	 * the case of a broken device.
+	 *
+	 * The number of allocated pages for big packet is
+	 * vi->big_packets_num_skbfrags + 1, the start of first page is
+	 * for virtio header, the remaining is for data. We need to ensure
+	 * the remaining len does not go out of the allocated pages.
+	 * Please refer to add_recvbuf_big for more details on big packet
+	 * buffer allocation.
 	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
+	BUG_ON(offset >= PAGE_SIZE);
+	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
+	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_remaining_len)) {
 		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
 		dev_kfree_skb(skb);
 		return NULL;
 	}
-	BUG_ON(offset >= PAGE_SIZE);
+
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
-- 
2.43.0


