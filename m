Return-Path: <stable+bounces-141664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D6AAB56A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE608161C82
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD8347922;
	Tue,  6 May 2025 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUc4NJqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5162F6631;
	Mon,  5 May 2025 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487071; cv=none; b=tUD7BV6ebcFHQ0nd1TAfNRiEeLw8EFDR9j8E7bbdN48gGmEAGeo1MmQ3PfXgz5Hui1IhkRAa2rmW/BTxPjqjtkYD7Eemix3vZI96YKkM1u5dFiuC7FAzGeXmYTI5bmpn4Raj+Jift8DoEJco2YW1TTV0e/sKXbBth1lvuQGnTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487071; c=relaxed/simple;
	bh=WP6KHK2/0rnIE3gNHDNXEAUvma31iLJ4x0CdhCO4exE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtmN9VGqP/NztezZSw51ZWPwWQnNI++/xpRqql/hAPytFhyjHRJYjJos7n1BMR+Ojprp3B3VVWRCDWw5QvH/bTrPPdDHZfE/T6Zm4KeplVzezJVpGVEFWnz2NL8Ep0phvsohRPNGsjbuD/dU03O6BQoCCduFQsJY3O5ltKq8xYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUc4NJqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BE2C4CEEE;
	Mon,  5 May 2025 23:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487071;
	bh=WP6KHK2/0rnIE3gNHDNXEAUvma31iLJ4x0CdhCO4exE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUc4NJqKozpoGMXxIkiUi3uEre/89deYo7y+fDNjkQVRdSZR5Rn4ynuVvO6D4Dmnk
	 aFyy05GwC5Ly0u9YRWuaGDNEbL0eQtMFG90KRUJbK6A6yn8FfOA5K4qTOTQM/vUxKD
	 mBAsQzdbpkNsaYkE3gk/zGFISOC2gVrJdJ3QnQYgJGSlfjya/1zzMCxZoD8aiPJmwr
	 qAILZCpoaCBx0a5ZOcm4rNKaU1qUItO8rnzY7/A+Jr+QfwVikWVn/pRBjKWc7VdoY9
	 nufxQy14+4x95nn06FQE2ontnLrgEEcihH0sxwiejuFfEYfrndpVijaHU4SrtTVgBo
	 x5/Y0CnrCAQqA==
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
Subject: [PATCH AUTOSEL 5.15 138/153] net-sysfs: prevent uncleared queues from being re-added
Date: Mon,  5 May 2025 19:13:05 -0400
Message-Id: <20250505231320.2695319-138-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 173ea92124f8c..6e5ecab4ebb14 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1050,6 +1050,22 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
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
@@ -1657,6 +1673,22 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
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


