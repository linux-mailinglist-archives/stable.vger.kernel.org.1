Return-Path: <stable+bounces-240700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOXuKIRy62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:39:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0037E45F51A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22F0C3056179
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08823D6CB3;
	Fri, 24 Apr 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SlCEaLAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8838837E;
	Fri, 24 Apr 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037613; cv=none; b=cBpDZmK1fU0cEqpWbqCksfiyG+P/D9oAdDr92iAyDSOFmxDVPo9OBXDzn1KTxIagAJFIrb0fuATmhSeFPBlcXbaDR0/uUQsYnqx8INpfjjxghSC7dR9QUvW9rZBNgsvQIHBVymI++DUxo6ZnYkuIhaPuyEjp3NeOtBKNkXscL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037613; c=relaxed/simple;
	bh=H+5r+DIW6TLVbazu8ZiECBUHt+T87Lgkxghx6Hd6I60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOXdB/iKItztUVo2QR2wgVXkaa+K3G3A/H88tYthsCdIVK7lH3OBcgmwgJJRTkpuUhxiqNEZrgSTKCEc6I3C/MZiBEr/4ZelLp1jwX+FwnkIFc8HXZkAlpkRzcYFUP4L6mLr/kPoGhe/McGPqEo77SZ/UPZWQ/eACyf2P91iCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SlCEaLAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37020C19425;
	Fri, 24 Apr 2026 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037613;
	bh=H+5r+DIW6TLVbazu8ZiECBUHt+T87Lgkxghx6Hd6I60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SlCEaLAJxnfQ7VsbUkStBzCh6sjsegZApe3MzWdQtknC1PPUe0/qdyYktpXWakMfr
	 fg/6XqQwPF/Y7xlyCnKA/bcdVUZDyQrs1q3E8516kBRq9/e3kuWguQVb8yVhq8IyxH
	 D6TgDYlrE/Qdj6ivIwEp3EyIkNVGS6IA8GRQoWHY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 7.0 31/42] ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()
Date: Fri, 24 Apr 2026 15:30:56 +0200
Message-ID: <20260424132426.940033632@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
References: <20260424132420.410310336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0037E45F51A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240700-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: DaeMyung Kang <charsyam@gmail.com>

commit def036ef87f8641c1c525d5ae17438d7a1006491 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/connection.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -237,7 +237,7 @@ int ksmbd_conn_wait_idle_sess_id(struct
 {
 	struct ksmbd_conn *conn;
 	int rc, retry_count = 0, max_timeout = 120;
-	int rcount = 1, bkt;
+	int rcount, bkt;
 
 retry_idle:
 	if (retry_count >= max_timeout)
@@ -246,8 +246,7 @@ retry_idle:
 	down_read(&conn_list_lock);
 	hash_for_each(conn_list, bkt, conn, hlist) {
 		if (conn->binding || xa_load(&conn->sessions, sess_id)) {
-			if (conn == curr_conn)
-				rcount = 2;
+			rcount = (conn == curr_conn) ? 2 : 1;
 			if (atomic_read(&conn->req_running) >= rcount) {
 				rc = wait_event_timeout(conn->req_running_q,
 					atomic_read(&conn->req_running) < rcount,



