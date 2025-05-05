Return-Path: <stable+bounces-141090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD697AAADCE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B11516AABA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A83BEEF8;
	Mon,  5 May 2025 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+Uidgvn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BF2F10A3;
	Mon,  5 May 2025 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487435; cv=none; b=AE6Kh7Sj2FTPeyPVLrfBHLykmCg/y+KzsQGY2LCGYgq6nz2iolZo/VIgXZV661zws6DoxfboRx3vBPynjyxHq4BVzPzWulEjlQ6bJhRzkMS8UIM84lGd7BamUBW0vEKyVzqiTmLpb1n9Sy87re2W97FS4su6bvupErWb2HL+Vds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487435; c=relaxed/simple;
	bh=Xqo5iZ4YGVxrB/Rap8N1HtW9HTVyu1H5uyH8lcgaPPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKEDLkLPDvtRpgsY9wVEQTLVxsFvPW75jBzup4nJA9XJ7lvH4ddXjErE2mrZGkxXv03DsEKJhd2HUIBjjXNa68qKJI990rG5nfPRTjGO+QSrp7MaaSDoLzsO8kWfJX1bkSaBgd76m55Xj0phw7eVGih6dk3Jf02Q+2ThF91nz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+Uidgvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D019FC4CEED;
	Mon,  5 May 2025 23:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487434;
	bh=Xqo5iZ4YGVxrB/Rap8N1HtW9HTVyu1H5uyH8lcgaPPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+UidgvnIT1ExCwe+1KvCS7WGDMJUoZFaleqdkLzOMsa0KUSwuQ2nYIV/izxYPco/
	 u+u1rz6fqS3k2s77dxX0EAfWM+0z6F0r4GITc6DS9pEhAHOBnT1gmWEpRj02UWOf/j
	 c2uJxdivejAJBtVdT40QRxr5cfXDylwyd+bYlvqejb5tPFNNhczqw1XX/Kgrj9nnN+
	 Y1Swo8jdXFEXiZ0BgkPhHQopx1ar5m5eFS3o+qb1xlTVJOvaYYc8ltPPS89rQ20REk
	 DGixy+f+P0uT+n7VR0O57D3HXBRcWBSuDrTAfTEsk5rg8nEx4AxCPJYuMUE+yGy05L
	 jikEmw/Vudg9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 69/79] net-sysfs: prevent uncleared queues from being re-added
Date: Mon,  5 May 2025 19:21:41 -0400
Message-Id: <20250505232151.2698893-69-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Antoine Tenart <atenart@kernel.org>

[ Upstream commit 7e54f85c60828842be27e0149f3533357225090e ]

With the (upcoming) removal of the rtnl_trylock/restart_syscall logic
and because of how Tx/Rx queues are implemented (and their
requirements), it might happen that a queue is re-added before having
the chance to be cleared. In such rare case, do not complete the queue
addition operation.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
Link: https://patch.msgid.link/20250204170314.146022-4-atenart@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/net-sysfs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index bcad7028bbf45..6b0c682e5ea70 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -968,6 +968,22 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
 	struct kobject *kobj = &queue->kobj;
 	int error = 0;
 
+	/* Rx queues are cleared in rx_queue_release to allow later
+	 * re-registration. This is triggered when their kobj refcount is
+	 * dropped.
+	 *
+	 * If a queue is removed while both a read (or write) operation and a
+	 * the re-addition of the same queue are pending (waiting on rntl_lock)
+	 * it might happen that the re-addition will execute before the read,
+	 * making the initial removal to never happen (queue's kobj refcount
+	 * won't drop enough because of the pending read). In such rare case,
+	 * return to allow the removal operation to complete.
+	 */
+	if (unlikely(kobj->state_initialized)) {
+		netdev_warn_once(dev, "Cannot re-add rx queues before their removal completed");
+		return -EAGAIN;
+	}
+
 	/* Kobject_put later will trigger rx_queue_release call which
 	 * decreases dev refcount: Take that reference here
 	 */
@@ -1558,6 +1574,22 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 	struct kobject *kobj = &queue->kobj;
 	int error = 0;
 
+	/* Tx queues are cleared in netdev_queue_release to allow later
+	 * re-registration. This is triggered when their kobj refcount is
+	 * dropped.
+	 *
+	 * If a queue is removed while both a read (or write) operation and a
+	 * the re-addition of the same queue are pending (waiting on rntl_lock)
+	 * it might happen that the re-addition will execute before the read,
+	 * making the initial removal to never happen (queue's kobj refcount
+	 * won't drop enough because of the pending read). In such rare case,
+	 * return to allow the removal operation to complete.
+	 */
+	if (unlikely(kobj->state_initialized)) {
+		netdev_warn_once(dev, "Cannot re-add tx queues before their removal completed");
+		return -EAGAIN;
+	}
+
 	/* Kobject_put later will trigger netdev_queue_release call
 	 * which decreases dev refcount: Take that reference here
 	 */
-- 
2.39.5


