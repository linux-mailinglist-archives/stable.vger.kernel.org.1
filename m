Return-Path: <stable+bounces-141440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72186AAB360
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF73C16D00F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07C823F41F;
	Tue,  6 May 2025 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjFS5akl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28D22DA0B;
	Mon,  5 May 2025 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486326; cv=none; b=JNWZYak7Hql2B96qvcP+w3up6AAWOhjcojIpNHBxzvIRCvsMVy1ESLKGXi1xv2O4p8eGQOo+qk4JzAmB8bKPOkni7FaTtFVviODWzw+JF4pB+Y4zfnfZmK9iwUCxSeqxO8Mp/M5hykZGgG5CvuzUrPylUJSZ0dEdhaa/4EZcl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486326; c=relaxed/simple;
	bh=FuUTa7qeVl1tru7h7FAYg3CCm3SlmL2bCM5XtGtIPQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlRLeS8Al9NJPG2q9JV+MIpNclIRzS++Q453KQ29KS8wFfJW6cGH7QJ6GTyTkXN1LTiYS3Jp2VEcztZ4cHf3n1AGEKK1gPsBERi+e8bzP+yl9frqJsYFp5uDVffdXiHcvDPG7601tSaqlYQiMErF0DlTSvwZE18+Z8ginYc6H2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjFS5akl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6C1C4CEE4;
	Mon,  5 May 2025 23:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486325;
	bh=FuUTa7qeVl1tru7h7FAYg3CCm3SlmL2bCM5XtGtIPQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjFS5aklkvsFLhvVln81hkvg++Q8lJNcgHZ/17vcYgimZzNNwDF6hen9mcXdjkoAx
	 4gP6/d/yYvgwOVVvrTeriAWF+Y13bsUruLR1/eO1AHNWbC9hsHih0Zd+VBQTI8Dr/V
	 VIxCxXTJeF5mZ1+e7B/cbpwuQQHD3v6KeTcuYTTOrEW0Wh6rCiDkC0mEqrMqkdiTSO
	 EvVK6Obb/QKQrcpta4mZ76cvkpqbOYjUvc99ys72lRiJetw01wuoND137Wrb0HQoj4
	 eszMJZ4p+PuXd8jgOY27p4evdDg+lzl10jgUOAEoD1cWWZv6VrbnyLsyfPq2W1zmPM
	 LhstnfNwvS2lw==
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
Subject: [PATCH AUTOSEL 6.6 260/294] net-sysfs: prevent uncleared queues from being re-added
Date: Mon,  5 May 2025 18:56:00 -0400
Message-Id: <20250505225634.2688578-260-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index f7404bc679746..d88682ae0e126 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1077,6 +1077,22 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
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
@@ -1684,6 +1700,22 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
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


