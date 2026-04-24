Return-Path: <stable+bounces-240615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGuCN3E762mMKAAAu9opvQ
	(envelope-from <stable+bounces-240615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:44:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A859345C695
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B26B30010DA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F138B15F;
	Fri, 24 Apr 2026 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iii1icZA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D038B131
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023853; cv=none; b=KfERJ/IC1h8HsSptOyI8e+pLQRfsML0qC4kwtgwIbzmkZI/gICeob2dQ4u5Cdf5SvFd6snRNyRha6GsHN3iMGuL4P8gWFjO5YVmfxB0IGhOR6p3QtQRT66vWlYv/ZNrTTxtzjBKzACH5Kd4zNccXdptH+GxquvUPzvlmA3iExRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023853; c=relaxed/simple;
	bh=2RSNoPu7la/qy/xIXxi26NwXgUwxKo5RtmIG6hNa6Os=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dpEyuF3fy06dQfCwT5/+T2JrAvqQ/p6zXz/fCx9bkMRH+H4j2B0tuUit37oA5TaPhhLmQw56gOohlJ3fBQI4MooBiMNqQ6yNEy3AMpJXfgic522YZ1Ugufh1wWMXBJRmTQkkixVtLen8CTEO5Z4l67f6XNfBb2DpQ2UnmZNsMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iii1icZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058ECC19425;
	Fri, 24 Apr 2026 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023853;
	bh=2RSNoPu7la/qy/xIXxi26NwXgUwxKo5RtmIG6hNa6Os=;
	h=Subject:To:Cc:From:Date:From;
	b=Iii1icZA68OxiPxaLG0ff/6ao/+hltiW07JmgW0t0coyOybEsJKiBavF/F4cq2RxT
	 ISLdxPBrZxueylFnQUnnTQ1dQnazGGXLrbdhkNb7Detzl3ypdvRsIcMyGa0JshfXQ3
	 87k5hnNMnFy+9+3UvQ/iXg9p/in9l3lPPy7S3Vg8=
Subject: FAILED: patch "[PATCH] ksmbd: reset rcount per connection in" failed to apply to 6.12-stable tree
To: charsyam@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:44:10 +0200
Message-ID: <2026042410-cinch-frostbite-b760@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A859345C695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240615-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x def036ef87f8641c1c525d5ae17438d7a1006491
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042410-cinch-frostbite-b760@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From def036ef87f8641c1c525d5ae17438d7a1006491 Mon Sep 17 00:00:00 2001
From: DaeMyung Kang <charsyam@gmail.com>
Date: Sun, 19 Apr 2026 02:28:44 +0900
Subject: [PATCH] ksmbd: reset rcount per connection in
 ksmbd_conn_wait_idle_sess_id()

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

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index a26899d12df1..b5e077f272cf 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -237,7 +237,7 @@ int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
 {
 	struct ksmbd_conn *conn;
 	int rc, retry_count = 0, max_timeout = 120;
-	int rcount = 1, bkt;
+	int rcount, bkt;
 
 retry_idle:
 	if (retry_count >= max_timeout)
@@ -246,8 +246,7 @@ int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
 	down_read(&conn_list_lock);
 	hash_for_each(conn_list, bkt, conn, hlist) {
 		if (conn->binding || xa_load(&conn->sessions, sess_id)) {
-			if (conn == curr_conn)
-				rcount = 2;
+			rcount = (conn == curr_conn) ? 2 : 1;
 			if (atomic_read(&conn->req_running) >= rcount) {
 				rc = wait_event_timeout(conn->req_running_q,
 					atomic_read(&conn->req_running) < rcount,


