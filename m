Return-Path: <stable+bounces-141040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7CAAB065
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB3E3A5C41
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BAA3F2896;
	Mon,  5 May 2025 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM4T5Ftp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D2376893;
	Mon,  5 May 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487292; cv=none; b=M/6v9MpOA1901LnMZaepnF320cYnJybF5T8OnSAGSqN0S1dSMgNCjkMNUXfzUJPO3DGhF9TwK8w7W+4dYud4a2JQuUL4a2tGAxXBYymx/Ncemr2DSH5bdSQ/aGbyhqYw5wRWvmjsx6Ml7apyvwTECWawCWGarHLGVFMVhsACECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487292; c=relaxed/simple;
	bh=y4Pj53jAwtoQSFNXGvoY0j5BE6CrNKP+k0sT9piGO4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=el9qZde5hiC7SGA1UGrICaeeIitiANe4/RKYT7pBl1VHAYgzLZAwyFWPST9xlolPSWRBExNUv67xCNYLyk2g8MDnZ2Y8EPdt3lAWHDnDut+3xT1D/ZiMSqPXY9V2bB69CLhzBzzIDrIqAw67I+07zlOZB3QA0je6GddyVoGlqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM4T5Ftp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DFEC4CEEE;
	Mon,  5 May 2025 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487290;
	bh=y4Pj53jAwtoQSFNXGvoY0j5BE6CrNKP+k0sT9piGO4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QM4T5FtprIk9MGMd4t/h8+q9J6FSvKHsnCyuheNropykqnsUO6nW1pWc9tmysG+N1
	 aEfFMq15bCBCYo1Dv4rIFy9zJpTL3QdXntrTZzdLxmPuLeKtiOTEz+k0J8otoKYNjm
	 1jC9NlJ840GfZUK3FwMVzZv+jK21Si0cLxEEX5ela62QyhpWBCftPLnj634PB4rOdr
	 BeVdAZ/+kSlefsrbKXgUbpjj9uhqJXEYc4AvwCoNEnXL5JFTbgAargPgtsjbrL7EZ8
	 Dg/EIJPTg+czCEFQCe+z94DoE2UcRC7UK+YUwrh6D6YTKiAV9izCjhFGQ0MyeF8ove
	 aaQE6YRJeamxQ==
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
Subject: [PATCH AUTOSEL 5.10 101/114] net-sysfs: prevent uncleared queues from being re-added
Date: Mon,  5 May 2025 19:18:04 -0400
Message-Id: <20250505231817.2697367-101-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 99303897b7bb7..bbcff7925f03f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1009,6 +1009,22 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
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
@@ -1640,6 +1656,22 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
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


