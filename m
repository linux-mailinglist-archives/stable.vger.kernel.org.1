Return-Path: <stable+bounces-53517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5204890D21C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AFB1F21239
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4F41AB522;
	Tue, 18 Jun 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eLIcBFw5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD51591E3;
	Tue, 18 Jun 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716564; cv=none; b=orujtFroGeGqpX4qidfftGRvxmiY4pHZ57c82aaP++hrzXEWARC2YremMxIOBWg1Y61qjA6C4bkZ83XiAirRYxQmkGdSrSK2YPlhADg//Xn6kz/G47hovuTkOQn6jVNjSTyxNcFjX0Zy2Yu/xY/PUR+C0fICnVPikmt5aGQwT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716564; c=relaxed/simple;
	bh=ZUT6Nm110PJDWXQhpTtR4IEhlHvZyKNwjCqSxjzQxl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cP9LzMCF/9UEvHYVHfPoP90xV7l43XFTPpZSmQcjgCwr0rhIGozgrUDqK7qsd/N7sJhWgPKpRIl4lk6iM6edNtypGh7Q4lwKsoVCBORpQ+cBSuXbxSZ1StYXKn9izIysqkJNhDbMrOIwYQBKO0zF0nlnc5ZlPZCYTiXl8N77pkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eLIcBFw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA7CC3277B;
	Tue, 18 Jun 2024 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716563;
	bh=ZUT6Nm110PJDWXQhpTtR4IEhlHvZyKNwjCqSxjzQxl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLIcBFw5f7ZUvNhrmysQT3Gdu7L+9xgc0WvxiBzWlJHTp1LQIoBmsK48TS4p3noVg
	 tJFy2KcHIMrV9u30FlRpS0+Kyup+LBliwcAxiOGZjnbTDdhhFm40KwBqd6uXVGWkAP
	 JYKbtN7bmUEilvhIu7TWYbg1Nsvx9ecaH33feq2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 655/770] NFSD: Remove "inline" directives on op_rsize_bop helpers
Date: Tue, 18 Jun 2024 14:38:28 +0200
Message-ID: <20240618123432.570507395@linuxfoundation.org>
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

[ Upstream commit 6604148cf961b57fc735e4204f8996536da9253c ]

These helpers are always invoked indirectly, so the compiler can't
inline these anyway. While we're updating the synopses of these
helpers, defensively convert their parameters to const pointers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 121 ++++++++++++++++++++++++++++-----------------
 fs/nfsd/xdr4.h     |   3 +-
 2 files changed, 77 insertions(+), 47 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 79f1990d40c44..1bb0fb917cf0d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2763,28 +2763,33 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
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
@@ -2795,10 +2800,10 @@ static inline u32 nfsd4_create_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op
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
 
@@ -2833,24 +2838,28 @@ static inline u32 nfsd4_getattr_rsize(struct svc_rqst *rqstp,
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
@@ -2858,7 +2867,8 @@ static inline u32 nfsd4_open_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 		+ op_encode_delegation_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_read_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
 
@@ -2868,7 +2878,8 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_read_plus_rsize(const struct svc_rqst *rqstp,
+				 const struct nfsd4_op *op)
 {
 	u32 maxcount = svc_max_payload(rqstp);
 	u32 rlen = min(op->u.read.rd_length, maxcount);
@@ -2882,7 +2893,8 @@ static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op
 	return (op_encode_hdr_size + 2 + seg_len + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_readdir_rsize(const struct svc_rqst *rqstp,
+			       const struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
 
@@ -2893,59 +2905,68 @@ static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *o
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
@@ -2959,14 +2980,16 @@ static inline u32 nfsd4_exchange_id_rsize(struct svc_rqst *rqstp, struct nfsd4_o
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
@@ -2975,7 +2998,8 @@ static inline u32 nfsd4_create_session_rsize(struct svc_rqst *rqstp, struct nfsd
 		op_encode_channel_attrs_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_copy_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_copy_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* wr_callback */ +
@@ -2987,16 +3011,16 @@ static inline u32 nfsd4_copy_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
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
@@ -3011,7 +3035,8 @@ static inline u32 nfsd4_copy_notify_rsize(struct svc_rqst *rqstp,
 }
 
 #ifdef CONFIG_NFSD_PNFS
-static inline u32 nfsd4_getdeviceinfo_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
+				     const struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
 
@@ -3029,7 +3054,8 @@ static inline u32 nfsd4_getdeviceinfo_rsize(struct svc_rqst *rqstp, struct nfsd4
  * so we need to define an arbitrary upper bound here.
  */
 #define MAX_LAYOUT_SIZE		128
-static inline u32 nfsd4_layoutget_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_layoutget_rsize(const struct svc_rqst *rqstp,
+				 const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* logr_return_on_close */ +
@@ -3038,14 +3064,16 @@ static inline u32 nfsd4_layoutget_rsize(struct svc_rqst *rqstp, struct nfsd4_op
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
@@ -3054,13 +3082,14 @@ static inline u32 nfsd4_layoutreturn_rsize(struct svc_rqst *rqstp, struct nfsd4_
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
 
@@ -3070,14 +3099,14 @@ static inline u32 nfsd4_getxattr_rsize(struct svc_rqst *rqstp,
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
 
@@ -3087,8 +3116,8 @@ static inline u32 nfsd4_listxattrs_rsize(struct svc_rqst *rqstp,
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
index 2a699e8ca1baf..1e83fda7601ab 100644
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




