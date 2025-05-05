Return-Path: <stable+bounces-140892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA10AAAC3C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BAE163EC8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBF82FCA84;
	Mon,  5 May 2025 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsTovTg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65F2F1CCD;
	Mon,  5 May 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486762; cv=none; b=Yq1nVPFUaQMmAEGA0tNNK9NY/kFGtw1T4/AEUQYmWxgOl6tNDX0YSL8AbZKQMfe6BP2c5K7pT85Q1vDbk+AROt8CBa9tfxOcqoFOwXNTSMclNeC0YiMP/NGGIiWGGHTeWezfobSmuln0mesh3TkWl7NoB4cBPSd18eXG3VLNkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486762; c=relaxed/simple;
	bh=br+Mbv3A/bYJ0vyPTdvaWCJwXmFes9Pkihotvm54Mdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NaSP21wJXcLmdS45+KF7Njm4zR6gHqdugURd+gsupMh3WU5NMFMv93jZNISuBAjL/4R0DvST/rEAyJUQyGcugUnHfkvPBZ2pyObDAMRyK39cxyVNhkadlCIIR+KxzCmtjLGi0lgHu/osfFrhzbhbtAF46SS5AwhhoakcNBJlSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsTovTg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869D3C4CEED;
	Mon,  5 May 2025 23:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486761;
	bh=br+Mbv3A/bYJ0vyPTdvaWCJwXmFes9Pkihotvm54Mdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsTovTg3WYA/As4Ma4nKgHMgIBljLkJ0tI8KxYORhZ4O1Y+t/bd6i6+rJmPJ6OY0Q
	 x7MVS8Utr90/pPKcnCf1L4vQ7Q8Db2tLacUcYg7uIrPDlffE7YrnB1uHmil5J36ccb
	 yvIBx5VlEMEpX0BGqzNN3SFKgqPM4Y3POEkYAejq3+GcQmj+0goJOMDUxAk3Ha2Nv6
	 d1Ta3a+ArdCccY8W1sfxkNhg61usEn3HmR00TTdfqCcHmnbMS+hL+86Vj1AX8LtT7M
	 oYJudGkRxMi1QHsfsyJRJwd1MxbWSOYTQFT3m8EfFGBY/bYbRCr1dZQ9IvOFk9HJWC
	 Ke4ZUwYhI2zcA==
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
Subject: [PATCH AUTOSEL 6.1 189/212] net-sysfs: prevent uncleared queues from being re-added
Date: Mon,  5 May 2025 19:06:01 -0400
Message-Id: <20250505230624.2692522-189-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 8a06f97320e04..08d926cdd5804 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1052,6 +1052,22 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
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
@@ -1655,6 +1671,22 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
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


