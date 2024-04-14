Return-Path: <stable+bounces-37512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9BD89C52D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E221C2238C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995CD76058;
	Mon,  8 Apr 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sYlQvAaP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8D6EB72;
	Mon,  8 Apr 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584451; cv=none; b=oOQ905sK+dnUewFd29seeYW3jydpgynHGeClcquAS3fao5OllqXNxe5XQPV8LmkG+YCXFJi+qEX08q4mzXA+g+fHUgRCMw6pGyLABhK0TDILgDMMQKyFzbqtpiSLoisWKUYIgA6Zchmo0apcy5k1hdASCiK3XHSthHwtlJWJgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584451; c=relaxed/simple;
	bh=ckfgjZKtUdNnK0hKK7MlrgIw5b/nLWkzUPKJEZZYJW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRjlWX3rXOss31PZ5WADd4zBRs4FXcraEDvO/8GknCceG2Lxdq6yn8CI3IHkcm/sD9kN2N78B6O2PtEth4bt6ZgsjjL/S0oFr4UyHRs1oZeVq/W2r8pO+TSSkex2zfnIrkdLPq1/Q1GytDMap1oqpQmg2lyl07YLWzqH6+Vltog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sYlQvAaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCDCC433C7;
	Mon,  8 Apr 2024 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584451;
	bh=ckfgjZKtUdNnK0hKK7MlrgIw5b/nLWkzUPKJEZZYJW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYlQvAaPtkFSK3od6PJMHBigJXhSsq2cQW6HzUUJlt/5hG6WE0NM9kaiMGvNA8QyO
	 HVNRE9nTO0oJgFqYbR8uV5bSceWX+6JgkGUCE5cdtoWUQcYVa6CHdJVCy6AQCv/8pN
	 21ta6m4VPO5pZOTwFsttpaAJ32C9lBfklz3FY4tc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 442/690] NFSD: Remove "inline" directives on op_rsize_bop helpers
Date: Mon,  8 Apr 2024 14:55:08 +0200
Message-ID: <20240408125415.654871291@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 6604148cf961b57fc735e4204f8996536da9253c ]

These helpers are always invoked indirectly, so the compiler can't
inline these anyway. While we're updating the synopses of these
helpers, defensively convert their parameters to const pointers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 121 ++++++++++++++++++++++++++++-----------------
 fs/nfsd/xdr4.h     |   3 +-
 2 files changed, 77 insertions(+), 47 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7fdede420e65b..c8d299bc9e55a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2765,28 +2765,33 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 #define op_encode_channel_attrs_maxsz	(6 + 1 + 1)
 
-static inline u32 nfsd4_only_status_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_only_status_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_status_stateid_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_status_stateid_rsize(const struct svc_rqst *rqstp,
+				      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_stateid_maxsz)* sizeof(__be32);
 }
 
-static inline u32 nfsd4_access_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_access_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	/* ac_supported, ac_resp_access */
 	return (op_encode_hdr_size + 2)* sizeof(__be32);
 }
 
-static inline u32 nfsd4_commit_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_commit_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_verifier_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_create_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_create_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz
 		+ nfs4_fattr_bitmap_maxsz) * sizeof(__be32);
@@ -2797,10 +2802,10 @@ static inline u32 nfsd4_create_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op
  * the op prematurely if the estimate is too large.  We may turn off splice
  * reads unnecessarily.
  */
-static inline u32 nfsd4_getattr_rsize(struct svc_rqst *rqstp,
-				      struct nfsd4_op *op)
+static u32 nfsd4_getattr_rsize(const struct svc_rqst *rqstp,
+			       const struct nfsd4_op *op)
 {
-	u32 *bmap = op->u.getattr.ga_bmval;
+	const u32 *bmap = op->u.getattr.ga_bmval;
 	u32 bmap0 = bmap[0], bmap1 = bmap[1], bmap2 = bmap[2];
 	u32 ret = 0;
 
@@ -2835,24 +2840,28 @@ static inline u32 nfsd4_getattr_rsize(struct svc_rqst *rqstp,
 	return ret;
 }
 
-static inline u32 nfsd4_getfh_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_getfh_rsize(const struct svc_rqst *rqstp,
+			     const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 1) * sizeof(__be32) + NFS4_FHSIZE;
 }
 
-static inline u32 nfsd4_link_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_link_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz)
 		* sizeof(__be32);
 }
 
-static inline u32 nfsd4_lock_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_lock_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_lock_denied_maxsz)
 		* sizeof(__be32);
 }
 
-static inline u32 nfsd4_open_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_open_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_stateid_maxsz
 		+ op_encode_change_info_maxsz + 1
@@ -2860,7 +2869,8 @@ static inline u32 nfsd4_open_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 		+ op_encode_delegation_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_read_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
 
@@ -2870,7 +2880,8 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_read_plus_rsize(const struct svc_rqst *rqstp,
+				 const struct nfsd4_op *op)
 {
 	u32 maxcount = svc_max_payload(rqstp);
 	u32 rlen = min(op->u.read.rd_length, maxcount);
@@ -2884,7 +2895,8 @@ static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op
 	return (op_encode_hdr_size + 2 + seg_len + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_readdir_rsize(const struct svc_rqst *rqstp,
+			       const struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
 
@@ -2895,59 +2907,68 @@ static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *o
 		XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_readlink_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_readlink_rsize(const struct svc_rqst *rqstp,
+				const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 1) * sizeof(__be32) + PAGE_SIZE;
 }
 
-static inline u32 nfsd4_remove_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_remove_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz)
 		* sizeof(__be32);
 }
 
-static inline u32 nfsd4_rename_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_rename_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz
 		+ op_encode_change_info_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_sequence_rsize(struct svc_rqst *rqstp,
-				       struct nfsd4_op *op)
+static u32 nfsd4_sequence_rsize(const struct svc_rqst *rqstp,
+				const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size
 		+ XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + 5) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_test_stateid_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_test_stateid_rsize(const struct svc_rqst *rqstp,
+				    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 1 + op->u.test_stateid.ts_num_ids)
 		* sizeof(__be32);
 }
 
-static inline u32 nfsd4_setattr_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_setattr_rsize(const struct svc_rqst *rqstp,
+			       const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + nfs4_fattr_bitmap_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_secinfo_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_secinfo_rsize(const struct svc_rqst *rqstp,
+			       const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + RPC_AUTH_MAXFLAVOR *
 		(4 + XDR_QUADLEN(GSS_OID_MAX_LEN))) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_setclientid_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_setclientid_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(NFS4_VERIFIER_SIZE)) *
 								sizeof(__be32);
 }
 
-static inline u32 nfsd4_write_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_write_rsize(const struct svc_rqst *rqstp,
+			     const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 2 + op_encode_verifier_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_exchange_id_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_exchange_id_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 2 + 1 + /* eir_clientid, eir_sequenceid */\
 		1 + 1 + /* eir_flags, spr_how */\
@@ -2961,14 +2982,16 @@ static inline u32 nfsd4_exchange_id_rsize(struct svc_rqst *rqstp, struct nfsd4_o
 		0 /* ignored eir_server_impl_id contents */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_bind_conn_to_session_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_bind_conn_to_session_rsize(const struct svc_rqst *rqstp,
+					    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + \
 		XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + /* bctsr_sessid */\
 		2 /* bctsr_dir, use_conn_in_rdma_mode */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_create_session_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_create_session_rsize(const struct svc_rqst *rqstp,
+				      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + \
 		XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + /* sessionid */\
@@ -2977,7 +3000,8 @@ static inline u32 nfsd4_create_session_rsize(struct svc_rqst *rqstp, struct nfsd
 		op_encode_channel_attrs_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_copy_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_copy_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* wr_callback */ +
@@ -2989,16 +3013,16 @@ static inline u32 nfsd4_copy_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 		1 /* cr_synchronous */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_offload_status_rsize(struct svc_rqst *rqstp,
-					     struct nfsd4_op *op)
+static u32 nfsd4_offload_status_rsize(const struct svc_rqst *rqstp,
+				      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		2 /* osr_count */ +
 		1 /* osr_complete<1> optional 0 for now */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_copy_notify_rsize(struct svc_rqst *rqstp,
-					struct nfsd4_op *op)
+static u32 nfsd4_copy_notify_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		3 /* cnr_lease_time */ +
@@ -3013,7 +3037,8 @@ static inline u32 nfsd4_copy_notify_rsize(struct svc_rqst *rqstp,
 }
 
 #ifdef CONFIG_NFSD_PNFS
-static inline u32 nfsd4_getdeviceinfo_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
+				     const struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
 
@@ -3031,7 +3056,8 @@ static inline u32 nfsd4_getdeviceinfo_rsize(struct svc_rqst *rqstp, struct nfsd4
  * so we need to define an arbitrary upper bound here.
  */
 #define MAX_LAYOUT_SIZE		128
-static inline u32 nfsd4_layoutget_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_layoutget_rsize(const struct svc_rqst *rqstp,
+				 const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* logr_return_on_close */ +
@@ -3040,14 +3066,16 @@ static inline u32 nfsd4_layoutget_rsize(struct svc_rqst *rqstp, struct nfsd4_op
 		MAX_LAYOUT_SIZE) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_layoutcommit_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_layoutcommit_rsize(const struct svc_rqst *rqstp,
+				    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* locr_newsize */ +
 		2 /* ns_size */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_layoutreturn_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_layoutreturn_rsize(const struct svc_rqst *rqstp,
+				    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* lrs_stateid */ +
@@ -3056,13 +3084,14 @@ static inline u32 nfsd4_layoutreturn_rsize(struct svc_rqst *rqstp, struct nfsd4_
 #endif /* CONFIG_NFSD_PNFS */
 
 
-static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_seek_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 3) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_getxattr_rsize(struct svc_rqst *rqstp,
-				       struct nfsd4_op *op)
+static u32 nfsd4_getxattr_rsize(const struct svc_rqst *rqstp,
+				const struct nfsd4_op *op)
 {
 	u32 maxcount, rlen;
 
@@ -3072,14 +3101,14 @@ static inline u32 nfsd4_getxattr_rsize(struct svc_rqst *rqstp,
 	return (op_encode_hdr_size + 1 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_setxattr_rsize(struct svc_rqst *rqstp,
-				       struct nfsd4_op *op)
+static u32 nfsd4_setxattr_rsize(const struct svc_rqst *rqstp,
+				const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz)
 		* sizeof(__be32);
 }
-static inline u32 nfsd4_listxattrs_rsize(struct svc_rqst *rqstp,
-					 struct nfsd4_op *op)
+static u32 nfsd4_listxattrs_rsize(const struct svc_rqst *rqstp,
+				  const struct nfsd4_op *op)
 {
 	u32 maxcount, rlen;
 
@@ -3089,8 +3118,8 @@ static inline u32 nfsd4_listxattrs_rsize(struct svc_rqst *rqstp,
 	return (op_encode_hdr_size + 4 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_removexattr_rsize(struct svc_rqst *rqstp,
-					  struct nfsd4_op *op)
+static u32 nfsd4_removexattr_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz)
 		* sizeof(__be32);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 466e2786fc976..7fcbc7a46c157 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -889,7 +889,8 @@ struct nfsd4_operation {
 	u32 op_flags;
 	char *op_name;
 	/* Try to get response size before operation */
-	u32 (*op_rsize_bop)(struct svc_rqst *, struct nfsd4_op *);
+	u32 (*op_rsize_bop)(const struct svc_rqst *rqstp,
+			const struct nfsd4_op *op);
 	void (*op_get_currentstateid)(struct nfsd4_compound_state *,
 			union nfsd4_op_u *);
 	void (*op_set_currentstateid)(struct nfsd4_compound_state *,
-- 
2.43.0




