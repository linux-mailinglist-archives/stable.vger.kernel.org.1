Return-Path: <stable+bounces-192944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C7C46753
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8453B0BA1
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F9030C609;
	Mon, 10 Nov 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loFdneUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467030C36F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776370; cv=none; b=QCDgV/CnVtVBoBHSCmAx8llppvyRCtpTZAINqSv6f3z5jnTxCsEFYI+vHUnYNQx8WmhJPwHdkmysXEZajm9siDTPgYhaUU/onXJjQk5Oe1fEmCIlYhFwkZvJGUlqSRd0CvbRuQHhyKhocANeRE1fQoU+ThGkKdvz9DzsHtrFyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776370; c=relaxed/simple;
	bh=JRzxjgkbcA/4/USqBhs0OvR08A32ZNGEwiUzUjgyIKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg7j2NA6ltoqxsjj75JsZiIlhSPBqpwG0NUEXBaAh7fQ8uJDknQe8Fdc3ZXhaZ03I2tbmfefVOnjstESuN+pbXqehXztHKet16GAQcOs4Hb3j5LfccGqjYDccgpHTPDax7OPMNMVklOP6Zi3EUW6dUbwqxWoV/gFhRbTKHT+btY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loFdneUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200ECC4CEF5;
	Mon, 10 Nov 2025 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762776368;
	bh=JRzxjgkbcA/4/USqBhs0OvR08A32ZNGEwiUzUjgyIKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=loFdneUdNSTEc3LmqzbZCJElEQtQOlBijLbidJZTELozpwYVJZiMRCBlilCWCRR4g
	 pKSuPft0xayUYmjZr49VrCp7Qicg6DHxxUBFDS51wWhzalctv5mQpioMcKQn+1Sv1f
	 IgMZvrlbfNxVh4S+apNRvOiyepcl8ESiO8aT+DvgpuaMj7xZBle9fYUjFSnvvl+zeO
	 SrZpf6GnTlLPinaxyqD/7b4Gw7jYzqUuIrLzBFauT76HkVcMjrMzuiXC/8ZOmxDJda
	 vxe/WUSxD+M4PlTHzo4LMXDjkpYFfZviMTE8l0LYg8JpuWCrdHQMWiObPlS97P2xH+
	 iLeJhSM2jYJdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Lei Yang <leiyang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] virtio-net: fix received length check in big packets
Date: Mon, 10 Nov 2025 07:06:04 -0500
Message-ID: <20251110120604.655678-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110954-lunacy-murkiness-7783@gregkh>
References: <2025110954-lunacy-murkiness-7783@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bui Quang Minh <minhquangbui99@gmail.com>

[ Upstream commit 0c716703965ffc5ef4311b65cb5d84a703784717 ]

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
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Link: https://patch.msgid.link/20251030144438.7582-1-minhquangbui99@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted page_to_skb() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1b4cf8eb7e136..9ee3465082c5a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -542,17 +542,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		goto ok;
 	}
 
-	/*
-	 * Verify that we can indeed put this data into a skb.
-	 * This is here to handle cases when the device erroneously
-	 * tries to receive more than is possible. This is usually
-	 * the case of a broken device.
-	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
-		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
-		dev_kfree_skb(skb);
-		return NULL;
-	}
 	BUG_ON(offset >= PAGE_SIZE);
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
@@ -955,8 +944,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb =
-		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, true, 0, 0);
+	struct sk_buff *skb;
+
+	/* Make sure that len does not exceed the size allocated in
+	 * add_recvbuf_big.
+	 */
+	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
+			 dev->name, len,
+			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+		goto err;
+	}
+
+	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, true, 0, 0);
 
 	stats->bytes += len - vi->hdr_len;
 	if (unlikely(!skb))
-- 
2.51.0


