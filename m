Return-Path: <stable+bounces-71220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D096125F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95287281532
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596191CFEBF;
	Tue, 27 Aug 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhhyozOI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AA1C8FCF;
	Tue, 27 Aug 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772493; cv=none; b=UDp1dtMsNVEFAzzJVo/FkLsxA7pHJ3mHid6CqeTlvlunkHNBsh+wLsSNvU+403PXuC//nzSRJbLfzRHyka02PAwLyUgqvIEDtmIyDkOnl1IFgvY6A0r7ZBSRDhUIDyWRnFtTcCae5wDz65swWe7RRrpdGcc+U1hiTGqQQR8p/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772493; c=relaxed/simple;
	bh=3STfJwyoJjCqND3uB9jvzgEwpDG+m1yMU3c47A6EwtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNXHsuRxATtcUL9C1EPIAxIlhu1shRIQTHEQIwx0Q96Cw3xL7tCvNOZFqSvnQlzwaJsDBRT/Tg+lO7ZPSNYyUcM70Wu4v1xkn9AzrRioSLNa7cPvnK6kmg1sIjluF+1ZHKmLRnUXNOSWdXMSsknXwwe8ad5wva5s1JM14UbXAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhhyozOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FDDC61047;
	Tue, 27 Aug 2024 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772492;
	bh=3STfJwyoJjCqND3uB9jvzgEwpDG+m1yMU3c47A6EwtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhhyozOI8mfMWDyl4rdaJImhOpZqTcm7spMNz4k5ecK9qW6lIjn0F+ed1GX+SFYIY
	 raxsGLmfJ+RguPsYBlnVEf27N9fG2KECReYyIo3E4JUhR/9H5phMmgXw3tGITciXN+
	 vNGBqGUoMAcsTmFSWB+dfBysUFH9mbuUFYMFihqs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 230/321] tcp/dccp: bypass empty buckets in inet_twsk_purge()
Date: Tue, 27 Aug 2024 16:38:58 +0200
Message-ID: <20240827143846.992496947@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 50e2907ef8bb52cf80ecde9eec5c4dac07177146 ]

TCP ehash table is often sparsely populated.

inet_twsk_purge() spends too much time calling cond_resched().

This patch can reduce time spent in inet_twsk_purge() by 20x.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240327191206.508114-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 565d121b6998 ("tcp: prevent concurrent execution of tcp_sk_exit_batch")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_timewait_sock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 340a8f0c29800..15d6ce41e5de7 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -284,12 +284,17 @@ EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
 /* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
 void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 {
+	struct inet_ehash_bucket *head = &hashinfo->ehash[0];
+	unsigned int ehash_mask = hashinfo->ehash_mask;
 	struct hlist_nulls_node *node;
 	unsigned int slot;
 	struct sock *sk;
 
-	for (slot = 0; slot <= hashinfo->ehash_mask; slot++) {
-		struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
+	for (slot = 0; slot <= ehash_mask; slot++, head++) {
+
+		if (hlist_nulls_empty(&head->chain))
+			continue;
+
 restart_rcu:
 		cond_resched();
 		rcu_read_lock();
-- 
2.43.0




