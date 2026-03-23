Return-Path: <stable+bounces-229384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFo8KPVfwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 029652F6D34
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2E2733AD3AF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176BD3B531B;
	Mon, 23 Mar 2026 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nls1/j9U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF74241C8C;
	Mon, 23 Mar 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278945; cv=none; b=gjh2wobO9oJhBRwWPXncHsYTdOCOVwhizvyTe7+wsgxmlmGXu7mWtnnzCAk861h1IQGEJS5klPBOD4p4Kv33TocWj1svTcpEysp85UdlgvxCq4oNJqU5V5kPmR4vUJ3O2VpKRNYUOw95itoKq/q4CUmRwoeP7YQv8bOVulghYTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278945; c=relaxed/simple;
	bh=uuUsQr6BWKe1JiK9K7S7JPAsjwOSZcJ1NsNkM5bIsjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTeEr2LT2uW2baVeTqWG1BfmwvOyE4K8ZE0/AsHOthdzuqHViPqyNcurt/9hEB4YKFRoYDsdUFakTz+GYRsXCNxdfVY7TtybTFKINZb49AGV7IIyM+LBaPGaEw8jOA8KefWNm5MAFVT5N/9ozJqKHBiDoaJELpy7IUiYcpjaPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nls1/j9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A23C2BCB1;
	Mon, 23 Mar 2026 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278945;
	bh=uuUsQr6BWKe1JiK9K7S7JPAsjwOSZcJ1NsNkM5bIsjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nls1/j9UHG/y1yH/MDa8t0U+k/j4TWMobiETC2lRHJXvJbBliZeUTaNe6o+QtA0xJ
	 FS230PwMPwnpGmcApBfvqtyzDkxq+3+/KXOI7OLjFFyUZvNxg4dCi+t/kxqZx1vpKt
	 FfL/2wFXA3FNjFtx9TRBvdxkHs+tshBW0AhFyqw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Nicholas Carlini <npc@anthropic.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 470/567] nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
Date: Mon, 23 Mar 2026 14:46:30 +0100
Message-ID: <20260323134545.614796685@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229384-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 029652F6D34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 5133b61aaf437e5f25b1b396b14242a6bb0508e2 ]

The NFSv4.0 replay cache uses a fixed 112-byte inline buffer
(rp_ibuf[NFSD4_REPLAY_ISIZE]) to store encoded operation responses.
This size was calculated based on OPEN responses and does not account
for LOCK denied responses, which include the conflicting lock owner as
a variable-length field up to 1024 bytes (NFS4_OPAQUE_LIMIT).

When a LOCK operation is denied due to a conflict with an existing lock
that has a large owner, nfsd4_encode_operation() copies the full encoded
response into the undersized replay buffer via read_bytes_from_xdr_buf()
with no bounds check. This results in a slab-out-of-bounds write of up
to 944 bytes past the end of the buffer, corrupting adjacent heap memory.

This can be triggered remotely by an unauthenticated attacker with two
cooperating NFSv4.0 clients: one sets a lock with a large owner string,
then the other requests a conflicting lock to provoke the denial.

We could fix this by increasing NFSD4_REPLAY_ISIZE to allow for a full
opaque, but that would increase the size of every stateowner, when most
lockowners are not that large.

Instead, fix this by checking the encoded response length against
NFSD4_REPLAY_ISIZE before copying into the replay buffer. If the
response is too large, set rp_buflen to 0 to skip caching the replay
payload. The status is still cached, and the client already received the
correct response on the original request.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Reported-by: Nicholas Carlini <npc@anthropic.com>
Tested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ replaced `op_status_offset + XDR_UNIT` with existing `post_err_offset` variable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4xdr.c |    9 +++++++--
 fs/nfsd/state.h   |   17 ++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5425,9 +5425,14 @@ nfsd4_encode_operation(struct nfsd4_comp
 		int len = xdr->buf->len - post_err_offset;
 
 		so->so_replay.rp_status = op->status;
-		so->so_replay.rp_buflen = len;
-		read_bytes_from_xdr_buf(xdr->buf, post_err_offset,
+		if (len <= NFSD4_REPLAY_ISIZE) {
+			so->so_replay.rp_buflen = len;
+			read_bytes_from_xdr_buf(xdr->buf,
+						post_err_offset,
 						so->so_replay.rp_buf, len);
+		} else {
+			so->so_replay.rp_buflen = 0;
+		}
 	}
 status:
 	*p = op->status;
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -430,11 +430,18 @@ struct nfs4_client_reclaim {
 	struct xdr_netobj	cr_princhash;
 };
 
-/* A reasonable value for REPLAY_ISIZE was estimated as follows:  
- * The OPEN response, typically the largest, requires 
- *   4(status) + 8(stateid) + 20(changeinfo) + 4(rflags) +  8(verifier) + 
- *   4(deleg. type) + 8(deleg. stateid) + 4(deleg. recall flag) + 
- *   20(deleg. space limit) + ~32(deleg. ace) = 112 bytes 
+/*
+ * REPLAY_ISIZE is sized for an OPEN response with delegation:
+ *   4(status) + 8(stateid) + 20(changeinfo) + 4(rflags) +
+ *   8(verifier) + 4(deleg. type) + 8(deleg. stateid) +
+ *   4(deleg. recall flag) + 20(deleg. space limit) +
+ *   ~32(deleg. ace) = 112 bytes
+ *
+ * Some responses can exceed this. A LOCK denial includes the conflicting
+ * lock owner, which can be up to 1024 bytes (NFS4_OPAQUE_LIMIT). Responses
+ * larger than REPLAY_ISIZE are not cached in rp_ibuf; only rp_status is
+ * saved. Enlarging this constant increases the size of every
+ * nfs4_stateowner.
  */
 
 #define NFSD4_REPLAY_ISIZE       112 



