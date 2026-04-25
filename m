Return-Path: <stable+bounces-241113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCoeHE+F7GnvZQAAu9opvQ
	(envelope-from <stable+bounces-241113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:11:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D346465A07
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2955930134A9
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B633D6D5;
	Sat, 25 Apr 2026 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EINwQf7n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2337E2F5
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777108295; cv=none; b=UbaAEeb8gPxaUcrDqCZP7CZoE70L/HfU2bqUO5E07DY/1tsKQulMEP04g6p6o/hyLE47sGtRW6MeTjmoYRYA6lPvyhQXx2rrj4Diag4lpaIGlk8kPuEywtnxkjeZ+GoBtZxgv+nKvlHK4fYTNpzsnxlaEpqPWFzm5Ni/w+SUzII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777108295; c=relaxed/simple;
	bh=tuI51GDMx5anskkdW/x1fiCaSWGw72k4+7Uy2hw9MHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwfdC4zr1neuNZc6cmGcRHLUvGjzz4g+Yfs7e7lbpnOAcVrQcim5q4flfrXQWldbIWCyKaeuJemhVH9NkjEXCfw08tC1xqJIhzrZN0YebvCihaE88pAOyjvdl4jewxtxg6mMf46D/uaDjBMDtlZpkhNeFIp3I4Y6O/r+BXeuD9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EINwQf7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20E6C2BCB0;
	Sat, 25 Apr 2026 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777108294;
	bh=tuI51GDMx5anskkdW/x1fiCaSWGw72k4+7Uy2hw9MHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EINwQf7n3daDAf6V+MyCT3vlIEt4034Tx+1HLDNGrJ2ClTk8cKj8eaJfxb+ho8me0
	 IWkoZHm2z88eEkp/Otke5tjj9XFmI7zPZQPR54xjMRA3lbOThI8tEbdc78LfL5b1z+
	 TdbZlHpdiNoLb354a4mERmr6ubINaVJLqXKcSTIWVbbY+D/MNKJWX5cG4vyZUKtAWv
	 ZM9u84Sc4J7HER07SjXTKi5dTqoyOMKg7MW01/OmqzH+0BJPP6+2KrMljP1gkx8ou6
	 8WzINUnwD5do3+9Xo5VinFdwkFsCJ0Kx8W5Z1euL4S6rq470P4JcxvoQ7+8Vr2ZTzJ
	 E309nWR7ruaUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()
Date: Sat, 25 Apr 2026 05:11:30 -0400
Message-ID: <20260425091130.3330505-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425091130.3330505-1-sashal@kernel.org>
References: <2026042411-family-protrude-c6d7@gregkh>
 <20260425091130.3330505-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D346465A07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241113-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit def036ef87f8641c1c525d5ae17438d7a1006491 ]

rcount is intended to be connection-specific: 2 for curr_conn, 1 for
every other connection sharing the same session.  However, it is
initialised only once before the hash iteration and is never reset.
After the loop visits curr_conn, later sibling connections are also
checked against rcount == 2, so a sibling with req_running == 1 is
incorrectly treated as idle.  This makes the outcome depend on the
hash iteration order: whether a given sibling is checked against the
loose (< 2) or the strict (< 1) threshold is decided by whether it
happens to be visited before or after curr_conn.

The function's contract is "wait until every connection sharing this
session is idle" so that destroy_previous_session() can safely tear
the session down.  The latched rcount violates that contract and
reopens the teardown race window the wait logic was meant to close:
destroy_previous_session() may proceed before sibling channels have
actually quiesced, overlapping session teardown with in-flight work
on those connections.

Recompute rcount inside the loop so each connection is compared
against its own threshold regardless of iteration order.

This is a code-inspection fix for an iteration-order-dependent logic
error; a targeted reproducer would require SMB3 multichannel with
in-flight work on a sibling channel landing after curr_conn in hash
order, which is not something that can be triggered reliably.

Fixes: 76e98a158b20 ("ksmbd: fix race condition between destroy_previous_session() and smb2 operations()")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index d9cb2c3374b07..8bd6e56804a36 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -179,7 +179,7 @@ int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
 {
 	struct ksmbd_conn *conn;
 	int rc, retry_count = 0, max_timeout = 120;
-	int rcount = 1, bkt;
+	int rcount, bkt;
 
 retry_idle:
 	if (retry_count >= max_timeout)
@@ -188,8 +188,7 @@ int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
 	down_read(&conn_list_lock);
 	hash_for_each(conn_list, bkt, conn, hlist) {
 		if (conn->binding || xa_load(&conn->sessions, sess_id)) {
-			if (conn == curr_conn)
-				rcount = 2;
+			rcount = (conn == curr_conn) ? 2 : 1;
 			if (atomic_read(&conn->req_running) >= rcount) {
 				rc = wait_event_timeout(conn->req_running_q,
 					atomic_read(&conn->req_running) < rcount,
-- 
2.53.0


