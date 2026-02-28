Return-Path: <stable+bounces-220130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPIZFewqo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AF1C5225
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92A71304758C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3689481664;
	Sat, 28 Feb 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyANpNji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438048167D;
	Sat, 28 Feb 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300040; cv=none; b=eylPcTIyvDOGuiQWqriQ0hvWeoQjolor90x+1J0+Xi3pz8LSfwx0UgFhADD6qxYvQuaWo9zIpNbbZKzJFzJOqBJD2QCfX3XKwttCzIwddz8hbzuxciGkew6qdI/XwayeWwQaMkzJEzUQW0xsjesVf9K8qli1V+S9LE+s93G6pj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300040; c=relaxed/simple;
	bh=xGS7k8bup1A3BByGv4uqYT1BPnXWLFgBjfkOw8FyJj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kch+xk4SXXUMV/qK4rNP995pYUnIYDDECr91+EAjaXVPa7dDU8yzTLxxhL7Vs4nNJG0Cz06p0Olzrj4N528Jl5EGSwa97CnTKlviPiyhKJ5f/Y2OvI/4y5OVz9PxsKlqaueVg9iYNWc9ZAR4v9CVWaUnMj+bwWeivFFPFITtNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyANpNji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2547C19424;
	Sat, 28 Feb 2026 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300040;
	bh=xGS7k8bup1A3BByGv4uqYT1BPnXWLFgBjfkOw8FyJj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyANpNjio0vzmIMXqX6c4MPCefIJVj/0n8vVpnCy/ISzjuHI4dWeaFACpHl6970jp
	 EpHOcmY/nFciXWa/aM1najmLfjLgMx6/zMCm4Tu1FJE2qr8ZeGswR3mPu41OJy6pmU
	 a68gn0sCRoSNiAuQ3N7ikoOFvmmUTmOyL+R3dXgBqJA7+JzX1C7V8o35DqY3ur8LAU
	 64D5fgToTRjoCU/glAt0XLmLcfWZrufGQ6cN/cBg9FrZGPtk1D8QE/m66+5D6qQSyZ
	 mj5uu3I88u+pZ1y6jgcwsn+BnVUG1Ig4CbbxALgiOfCB+ayxtZ875o142Bn5ybOK4j
	 h73mnPZBVLHZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 052/844] netfs: when subreq is marked for retry, do not check if it faced an error
Date: Sat, 28 Feb 2026 12:19:25 -0500
Message-ID: <20260228173244.1509663-53-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220130-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 659AF1C5225
X-Rspamd-Action: no action

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 82e8885bd7633a36ee9050e6d7f348a4155eed5f ]

The *_subreq_terminated functions today only process the NEED_RETRY
flag when the subreq was successful or failed with EAGAIN error.
However, there could be other retriable errors for network filesystems.

Avoid this by processing the NEED_RETRY irrespective of the error
code faced by the subreq. If it was specifically marked for retry,
the error code must not matter.

Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_collect.c  | 10 ++++++++++
 fs/netfs/read_retry.c    |  4 ++--
 fs/netfs/write_collect.c |  8 ++++----
 fs/netfs/write_issue.c   |  1 +
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 7a0ffa675fb17..137f0e28a44c5 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -546,6 +546,15 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 		}
 	}
 
+	/* If need retry is set, error should not matter unless we hit too many
+	 * retries. Pause the generation of new subreqs
+	 */
+	if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
+		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
+		goto skip_error_checks;
+	}
+
 	if (unlikely(subreq->error < 0)) {
 		trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
 		if (subreq->source == NETFS_READ_FROM_CACHE) {
@@ -559,6 +568,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
 	}
 
+skip_error_checks:
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 	netfs_subreq_clear_in_progress(subreq);
 	netfs_put_subrequest(subreq, netfs_sreq_trace_put_terminated);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index b99e84a8170af..7793ba5e3e8fc 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -12,6 +12,7 @@
 static void netfs_reissue_read(struct netfs_io_request *rreq,
 			       struct netfs_io_subrequest *subreq)
 {
+	subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_stat(&netfs_n_rh_retry_read_subreq);
@@ -242,8 +243,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	subreq = list_next_entry(subreq, rreq_link);
 abandon:
 	list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
-		if (!subreq->error &&
-		    !test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
+		if (!test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
 		    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
 			continue;
 		subreq->error = -ENOMEM;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index cbf3d9194c7bf..61eab34ea67ef 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -492,11 +492,11 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error)
 
 	if (IS_ERR_VALUE(transferred_or_error)) {
 		subreq->error = transferred_or_error;
-		if (subreq->error == -EAGAIN)
-			set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-		else
+		/* if need retry is set, error should not matter */
+		if (!test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
 			set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-		trace_netfs_failure(wreq, subreq, transferred_or_error, netfs_fail_write);
+			trace_netfs_failure(wreq, subreq, transferred_or_error, netfs_fail_write);
+		}
 
 		switch (subreq->source) {
 		case NETFS_WRITE_TO_CACHE:
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index dd8743bc8d7fe..34894da5a23ec 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -250,6 +250,7 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 	iov_iter_truncate(&subreq->io_iter, size);
 
 	subreq->retry_count++;
+	subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_stat(&netfs_n_wh_retry_write_subreq);
-- 
2.51.0


