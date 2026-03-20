Return-Path: <stable+bounces-227527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APonOBEyvWmI7QIAu9opvQ
	(envelope-from <stable+bounces-227527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:40:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12A2D9B85
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45643040457
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906839C004;
	Fri, 20 Mar 2026 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiZc9rgZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1AB32ED34
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006784; cv=none; b=TsTIM4Qi+NM5cb7Seoo+17HlGtO71Zp1El4F18zo+L8Rcq2L4XWHsVa2E6qvWX9mmRJZbkKvXUzXyAjsOrOtrlgFo+yIMpC2gpiI/ZUtY1nvwm5YUFiG37t8Y3SGxQWf6GSfLpxxa7lhmCPrWlZpH51OpwE0v9K0K88ED0yL7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006784; c=relaxed/simple;
	bh=ZwTsAoDc5qO2yX6984ElcNpjyNpsuXnZ1BK3DEOf3gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aC1NlCJ6efYBAEzt15cX2ekZ+a96ftZpCMjJEYSP7lBc+5sb35znVqm+Vrw/eFm/WK3zri5CSolMRVYEyJyb7fykaybs0IXKwHaK2zxUaQF9N05DNjSZ3kCRLPEBX9Tgv2xIRzYm+v6VJcjnq16DlmZO9rmmyWghlBoMR2T/UNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiZc9rgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8505C4CEF7;
	Fri, 20 Mar 2026 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774006784;
	bh=ZwTsAoDc5qO2yX6984ElcNpjyNpsuXnZ1BK3DEOf3gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiZc9rgZ+VUYbEcRxxJ3KRVwi7JHuPsNQ8pS7Ad8h94M1H5m/C3FzGkTCwK9c5xU1
	 Nwwy84Jg5wcr5DOjSdD4fTpBnOU6wMgF4UQ862cePCS/X1kEdkpZakylPPv7sTLUku
	 cv1tqa2h3KFSNzsKZMAiHwhSX4n5UOaZQw1WxK6bQd61FiEIQhdTAf5db3Tp0hYVkg
	 fabspnCgY7vtdcLnl1h8vZNjTQw6a7m9j++ZLuKObIIfpnxSqAiW7gJWP5Vedpo9tq
	 4qVSd3U8ekGWk7J1a+epmq4njaCFBVzfftewuSVMvwcXlLxg/YffbTA8py07j6pDfb
	 ImDWFwJ6dv5ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	stable@kernel.org,
	Nicholas Carlini <npc@anthropic.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
Date: Fri, 20 Mar 2026 07:39:41 -0400
Message-ID: <20260320113941.3971332-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032010-shredding-stargazer-b481@gregkh>
References: <2026032010-shredding-stargazer-b481@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227527-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3C12A2D9B85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 fs/nfsd/nfs4xdr.c |  9 +++++++--
 fs/nfsd/state.h   | 17 ++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 46a7fd731ba0a..e02c5650e2ac4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5439,9 +5439,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
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
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 477828dbfc665..53298bdcfb3d0 100644
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
-- 
2.51.0


