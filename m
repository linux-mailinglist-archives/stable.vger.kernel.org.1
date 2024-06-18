Return-Path: <stable+bounces-52888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D85A90CF2B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207E61F20FF5
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777C976036;
	Tue, 18 Jun 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t4A6wD8g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A50139D12;
	Tue, 18 Jun 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714708; cv=none; b=MHVv5J0ByFVLfyUpR2KC9xuNJsR23FQX7rexUBf31CVB7qEqAYYroQ78sGRvZeMYN6hVbF8tzKsXOkrh+JtCp8AId3478HbMTrPV9GP2ouO4NEuYQZmyTOE+SMmIDKdscU+9c4IP2EjpiKWWxrKbN83TVIzdDq/RwUjLMzvPcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714708; c=relaxed/simple;
	bh=OCLA+p9XBg/H/BqhkuJq+ExJhfo5jZsN0mf93DRPw9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3fmaeIBNQfca7Qxxzzs2Px9IP8OmwJu3p086MIYwasRKyzEbku6KojFzdMExHnwk2hfGnT8c6adkm5gYSL1uS9S3GTI5W5AyC0rSL0yvCy/bfIOBNZ7u86aQKuxeGsoXl6cpSqIruffjH5NMsDDufuNTLcv2KKM+ztnFE2tuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t4A6wD8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B169CC3277B;
	Tue, 18 Jun 2024 12:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714708;
	bh=OCLA+p9XBg/H/BqhkuJq+ExJhfo5jZsN0mf93DRPw9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4A6wD8ghmtj1UdvlDBBbWBhEvsgLu3xBExubd8icPcMuVbsRLlhmX+FxzQNg4FZj
	 98MvJ3YuLP1EhlOr4K13fvwMWDj96I8lQdtOoE+wtIqs87QLpq//OoIA7O+pYbITv5
	 OU6YzioZhtloWhMrOAdNKepJbgsXLPEF/PJVacec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 061/770] NFSD: Replace READ* macros in nfsd4_decode_cb_sec()
Date: Tue, 18 Jun 2024 14:28:34 +0200
Message-ID: <20240618123409.640548100@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 1a99440807bfc66597aaa2e0f0213c319b023e34 ]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 165 ++++++++++++++++++++++++++++++----------------
 1 file changed, 107 insertions(+), 58 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index cc406b7a530b6..6f3c86bee6211 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -212,6 +212,25 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
  * NFSv4 basic data type decoders
  */
 
+/*
+ * This helper handles variable-length opaques which belong to protocol
+ * elements that this implementation does not support.
+ */
+static __be32
+nfsd4_decode_ignored_string(struct nfsd4_compoundargs *argp, u32 maxlen)
+{
+	u32 len;
+
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		return nfserr_bad_xdr;
+	if (maxlen && len > maxlen)
+		return nfserr_bad_xdr;
+	if (!xdr_inline_decode(argp->xdr, len))
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
 {
@@ -645,87 +664,117 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_opaque(argp, owner);
 }
 
-static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
+/* Defined in Appendix A of RFC 5531 */
+static __be32
+nfsd4_decode_authsys_parms(struct nfsd4_compoundargs *argp,
+			   struct nfsd4_cb_sec *cbs)
 {
-	DECODE_HEAD;
-	struct user_namespace *userns = nfsd_user_namespace(argp->rqstp);
-	u32 dummy, uid, gid;
-	char *machine_name;
-	int i;
-	int nr_secflavs;
+	u32 stamp, gidcount, uid, gid;
+	__be32 *p, status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &stamp) < 0)
+		return nfserr_bad_xdr;
+	/* machine name */
+	status = nfsd4_decode_ignored_string(argp, 255);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &uid) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &gid) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &gidcount) < 0)
+		return nfserr_bad_xdr;
+	if (gidcount > 16)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, gidcount << 2);
+	if (!p)
+		return nfserr_bad_xdr;
+	if (cbs->flavor == (u32)(-1)) {
+		struct user_namespace *userns = nfsd_user_namespace(argp->rqstp);
+
+		kuid_t kuid = make_kuid(userns, uid);
+		kgid_t kgid = make_kgid(userns, gid);
+		if (uid_valid(kuid) && gid_valid(kgid)) {
+			cbs->uid = kuid;
+			cbs->gid = kgid;
+			cbs->flavor = RPC_AUTH_UNIX;
+		} else {
+			dprintk("RPC_AUTH_UNIX with invalid uid or gid, ignoring!\n");
+		}
+	}
+
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_decode_gss_cb_handles4(struct nfsd4_compoundargs *argp,
+			     struct nfsd4_cb_sec *cbs)
+{
+	__be32 status;
+	u32 service;
+
+	dprintk("RPC_AUTH_GSS callback secflavor not supported!\n");
+
+	if (xdr_stream_decode_u32(argp->xdr, &service) < 0)
+		return nfserr_bad_xdr;
+	if (service < RPC_GSS_SVC_NONE || service > RPC_GSS_SVC_PRIVACY)
+		return nfserr_bad_xdr;
+	/* gcbp_handle_from_server */
+	status = nfsd4_decode_ignored_string(argp, 0);
+	if (status)
+		return status;
+	/* gcbp_handle_from_client */
+	status = nfsd4_decode_ignored_string(argp, 0);
+	if (status)
+		return status;
+
+	return nfs_ok;
+}
+
+/* a counted array of callback_sec_parms4 items */
+static __be32
+nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
+{
+	u32 i, secflavor, nr_secflavs;
+	__be32 status;
 
 	/* callback_sec_params4 */
-	READ_BUF(4);
-	nr_secflavs = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &nr_secflavs) < 0)
+		return nfserr_bad_xdr;
 	if (nr_secflavs)
 		cbs->flavor = (u32)(-1);
 	else
 		/* Is this legal? Be generous, take it to mean AUTH_NONE: */
 		cbs->flavor = 0;
+
 	for (i = 0; i < nr_secflavs; ++i) {
-		READ_BUF(4);
-		dummy = be32_to_cpup(p++);
-		switch (dummy) {
+		if (xdr_stream_decode_u32(argp->xdr, &secflavor) < 0)
+			return nfserr_bad_xdr;
+		switch (secflavor) {
 		case RPC_AUTH_NULL:
-			/* Nothing to read */
+			/* void */
 			if (cbs->flavor == (u32)(-1))
 				cbs->flavor = RPC_AUTH_NULL;
 			break;
 		case RPC_AUTH_UNIX:
-			READ_BUF(8);
-			/* stamp */
-			dummy = be32_to_cpup(p++);
-
-			/* machine name */
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			SAVEMEM(machine_name, dummy);
-
-			/* uid, gid */
-			READ_BUF(8);
-			uid = be32_to_cpup(p++);
-			gid = be32_to_cpup(p++);
-
-			/* more gids */
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy * 4);
-			if (cbs->flavor == (u32)(-1)) {
-				kuid_t kuid = make_kuid(userns, uid);
-				kgid_t kgid = make_kgid(userns, gid);
-				if (uid_valid(kuid) && gid_valid(kgid)) {
-					cbs->uid = kuid;
-					cbs->gid = kgid;
-					cbs->flavor = RPC_AUTH_UNIX;
-				} else {
-					dprintk("RPC_AUTH_UNIX with invalid"
-						"uid or gid ignoring!\n");
-				}
-			}
+			status = nfsd4_decode_authsys_parms(argp, cbs);
+			if (status)
+				return status;
 			break;
 		case RPC_AUTH_GSS:
-			dprintk("RPC_AUTH_GSS callback secflavor "
-				"not supported!\n");
-			READ_BUF(8);
-			/* gcbp_service */
-			dummy = be32_to_cpup(p++);
-			/* gcbp_handle_from_server */
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			p += XDR_QUADLEN(dummy);
-			/* gcbp_handle_from_client */
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
+			status = nfsd4_decode_gss_cb_handles4(argp, cbs);
+			if (status)
+				return status;
 			break;
 		default:
-			dprintk("Illegal callback secflavor\n");
 			return nfserr_inval;
 		}
 	}
-	DECODE_TAIL;
+
+	return nfs_ok;
 }
 
+
 /*
  * NFSv4 operation argument decoders
  */
-- 
2.43.0




