Return-Path: <stable+bounces-71637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8CA96615E
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 14:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF12A1C22AFC
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2319259F;
	Fri, 30 Aug 2024 12:14:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3131384B3
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020089; cv=none; b=MOUmIKzHWKmclX0UsiSbhMeBkQW2b4R8VN79qOi5hA0KEAVG4zbaJ2hFFiSQRC6O+qqbU2ezOR60pE138PhkCtxqygycI9CWegz7zxLC2HaruyM/qjbyrnXR2ZuIvaain+2pqszsVekT3BF0zH64bNr5v5fdtGAa85SNMxrvKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020089; c=relaxed/simple;
	bh=VaQyDrv96TmtJXPXFR4IbuZmlM/ThUfA5p7OjDji2S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQ9xM9sIh598bkOGHs/jtDZKY5m/Q6AzAzOIUrJCnTgZz5sa/bEK2GKtbd89y/01ZXkrblbtVfr+IOHexmJffxf1JAqutHvt1x2mF4LfBXkH8aYjP3LXvmLK68ni/AwLDchClXFTMX2K9wBxoPi9ulRqIeHynczvSvWoFm1Ffb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id DC7B62F2022A; Fri, 30 Aug 2024 12:06:35 +0000 (UTC)
X-Spam-Level: 
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 9A3A82F20226;
	Fri, 30 Aug 2024 12:06:35 +0000 (UTC)
From: gerben@altlinux.org
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15] net:rds: Fix possible deadlock in rds_message_put
Date: Fri, 30 Aug 2024 15:06:35 +0300
Message-ID: <20240830120635.59682-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

commit f1acf1ac84d2ae97b7889b87223c1064df850069 upstream.

Functions rds_still_queued and rds_clear_recv_queue lock a given socket
in order to safely iterate over the incoming rds messages. However
calling rds_inc_put while under this lock creates a potential deadlock.
rds_inc_put may eventually call rds_message_purge, which will lock
m_rs_lock. This is the incorrect locking order since m_rs_lock is
meant to be locked before the socket. To fix this, we move the message
item to a local list or variable that wont need rs_recv_lock protection.
Then we can safely call rds_inc_put on any item stored locally after
rs_recv_lock is released.

Fixes: bdbe6fbc6a2f ("RDS: recv.c")
Reported-by: syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com
Reported-by: syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Link: https://lore.kernel.org/r/20240209022854.200292-1-allison.henderson@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 net/rds/recv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/rds/recv.c b/net/rds/recv.c
index 967d115f97ef..f570d64367a4 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -424,6 +424,7 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 	struct sock *sk = rds_rs_to_sk(rs);
 	int ret = 0;
 	unsigned long flags;
+	struct rds_incoming *to_drop = NULL;
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	if (!list_empty(&inc->i_item)) {
@@ -434,11 +435,14 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 					      -be32_to_cpu(inc->i_hdr.h_len),
 					      inc->i_hdr.h_dport);
 			list_del_init(&inc->i_item);
-			rds_inc_put(inc);
+			to_drop = inc;
 		}
 	}
 	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 
+	if (to_drop)
+		rds_inc_put(to_drop);
+
 	rdsdebug("inc %p rs %p still %d dropped %d\n", inc, rs, ret, drop);
 	return ret;
 }
@@ -761,16 +765,21 @@ void rds_clear_recv_queue(struct rds_sock *rs)
 	struct sock *sk = rds_rs_to_sk(rs);
 	struct rds_incoming *inc, *tmp;
 	unsigned long flags;
+	LIST_HEAD(to_drop);
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	list_for_each_entry_safe(inc, tmp, &rs->rs_recv_queue, i_item) {
 		rds_recv_rcvbuf_delta(rs, sk, inc->i_conn->c_lcong,
 				      -be32_to_cpu(inc->i_hdr.h_len),
 				      inc->i_hdr.h_dport);
+		list_move(&inc->i_item, &to_drop);
+	}
+	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
+
+	list_for_each_entry_safe(inc, tmp, &to_drop, i_item) {
 		list_del_init(&inc->i_item);
 		rds_inc_put(inc);
 	}
-	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 }
 
 /*
-- 
2.42.2


