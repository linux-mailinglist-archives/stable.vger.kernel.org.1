Return-Path: <stable+bounces-227461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEkPNMcKvWmy6AIAu9opvQ
	(envelope-from <stable+bounces-227461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:52:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF9C2D7835
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 582733033505
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAFB1A0728;
	Fri, 20 Mar 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PeVPTa0J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65C2F3C34
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996424; cv=none; b=TkMQ7PMA5LTWykzO168t0CBFvqY7w/DroG5VHuBwZECiX9aM9TQdXjoStqw3LRSgxogaRlQkpIy08Jw8WRZ0zBdyRia0+7VkVqibUJei0ieJBXhpQHPmTDHnddeIDN1Fsj5M7Yt/tHVDzXZlH0D06l+V7YI5wZ2jLDAW8R+xje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996424; c=relaxed/simple;
	bh=++hnylJRJwyr3FHL8e1GO5lF7J2tQI48Cv/2FaFEorg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EXUD2Ffay5D0y0YcUfpx7c5REyRvB3PBbEZFA1fWj72I9UHMKQH570+buZWKew+oujsTqt8HXDVQT4TsPvvztbozDXy08GqdSEqAkGy5qaD9wsezPM9DtKJDssXWtBzPXqi2thnSUhdQVoh1z9smvf4IcV+w878oQYuvL9Q8ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PeVPTa0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031EEC4CEF7;
	Fri, 20 Mar 2026 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773996424;
	bh=++hnylJRJwyr3FHL8e1GO5lF7J2tQI48Cv/2FaFEorg=;
	h=Subject:To:Cc:From:Date:From;
	b=PeVPTa0JXMFp3DdfWAWJrI9kHAF/2fiZEFv0/VuvzFQ6xj/xBmBwaphMUo10aLTWl
	 zKym57sH2ejKO8HnXRZLE9CeRWCKpQKfphsRlSev63A8w9UIm8Ye47dy9K1oILyo39
	 KSy2X0X7YOn3KEmcNBTegC0TaTlI0QcD5I/DmnJ4=
Subject: FAILED: patch "[PATCH] nfsd: fix heap overflow in NFSv4.0 LOCK replay cache" failed to apply to 6.6-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com,npc@anthropic.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2026 09:47:01 +0100
Message-ID: <2026032000-underling-groove-29b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227461-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.871];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 2EF9C2D7835
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5133b61aaf437e5f25b1b396b14242a6bb0508e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032000-underling-groove-29b4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5133b61aaf437e5f25b1b396b14242a6bb0508e2 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 24 Feb 2026 11:33:35 -0500
Subject: [PATCH] nfsd: fix heap overflow in NFSv4.0 LOCK replay cache

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

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5172dbd0cb05..fa16b34fae50 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -6281,9 +6281,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 		int len = xdr->buf->len - (op_status_offset + XDR_UNIT);
 
 		so->so_replay.rp_status = op->status;
-		so->so_replay.rp_buflen = len;
-		read_bytes_from_xdr_buf(xdr->buf, op_status_offset + XDR_UNIT,
+		if (len <= NFSD4_REPLAY_ISIZE) {
+			so->so_replay.rp_buflen = len;
+			read_bytes_from_xdr_buf(xdr->buf,
+						op_status_offset + XDR_UNIT,
 						so->so_replay.rp_buf, len);
+		} else {
+			so->so_replay.rp_buflen = 0;
+		}
 	}
 status:
 	op->status = nfsd4_map_status(op->status,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6fcbf1e427d4..c0ca115c3b74 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -541,11 +541,18 @@ struct nfs4_client_reclaim {
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


