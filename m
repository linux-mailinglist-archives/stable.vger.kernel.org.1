Return-Path: <stable+bounces-93982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA529D25EE
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAD1B298D4
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE701CB30A;
	Tue, 19 Nov 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr6odyha"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23F1BDABE
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019490; cv=none; b=EeLqkcnb1UkETg9IqW8K1F+Q/cDwpzz+Cbpc1Sb4JQ+HErZCSwaSDYU69oJeoUdfETBPcr/UNk0dHPCFCx4FmRQuVS8VVgnSe3KPuSfjDlymUUil8uPbgKYKul4fK67YVeZ2HBBRnSZZOxpBtbM8oTNqVx0IfzVmHu6goSw27to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019490; c=relaxed/simple;
	bh=FlUsR6rKbPLmLxnTiUzLVuiUX0l+QsVmGU2XxF2729U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqOollw01EbIyO4C4c3PD0hxYe80y++/JyEb9bNxsPE7llEBJyI7g2Moc5+Mbps9+TqwCfI2HxrD8IHoEnQjz/mAK5iQc6W8H8SRbzyXl31vUBPx4ZbepmiJXrENz41Eh3mCY4rp8elFtsKLxb8ix6t1E2WUSkCUG/BviE15Fpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr6odyha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B28C4CECF;
	Tue, 19 Nov 2024 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019490;
	bh=FlUsR6rKbPLmLxnTiUzLVuiUX0l+QsVmGU2XxF2729U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zr6odyhakI2Vk/5VYtMZn63tTxIA2atHvxBJVJ8uIHkhGCcWHGb3roodjjbhLky8e
	 ozWO+M1lRZZdtwnpXdXRURuXG563RCJAJHrzyXGKej2MzL7KrolwED4tl1zG2AF+d0
	 CNdfNz9QNHyNHJ9FPCCf0/g2Q/XM9MODuPlA0DLInNdv8Tt3v9c+y4s2G4myLelVjt
	 vbCxohkafAhTO6V3UCoNcAl7AcGqoejIAJs+LDUg09UMyb/WA3ifuGWFFZl6u1G7TP
	 IumhLRe14cUM3rjONI0sg8cXE45d5Eli1PE4L6lnyL3JaBveIny0DkoREOqBD7piQW
	 eJKl0qwGBQKdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 2/5] NFSD: Async COPY result needs to return a write verifier
Date: Tue, 19 Nov 2024 07:31:28 -0500
Message-ID: <20241118212035.3848-4-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118212035.3848-4-cel@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 9ed666eba4e0a2bb8ffaa3739d830b64d4f2aaad

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Chuck Lever <chuck.lever@oracle.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: ea5fb07d126d)      |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
| 5.15.y          |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 00:16:27.668243687 -0500
+++ /tmp/tmp.m9YY6SNo0E	2024-11-19 00:16:27.663676492 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 9ed666eba4e0a2bb8ffaa3739d830b64d4f2aaad ]
+
 Currently, when NFSD handles an asynchronous COPY, it returns a
 zero write verifier, relying on the subsequent CB_OFFLOAD callback
 to pass the write verifier and a stable_how4 value to the client.
@@ -25,16 +27,17 @@
 is needed.
 
 Reviewed-by: Jeff Layton <jlayton@kernel.org>
+[ cel: adjusted to apply to origin/linux-5.15.y ]
 Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
 ---
- fs/nfsd/nfs4proc.c | 23 ++++++++---------------
- 1 file changed, 8 insertions(+), 15 deletions(-)
+ fs/nfsd/nfs4proc.c | 25 +++++++++----------------
+ 1 file changed, 9 insertions(+), 16 deletions(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 963a02e179a0a..231c6035602f6 100644
+index 2b1fcf5b6bf8..08d90e0e8fae 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -752,15 +752,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -718,15 +718,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  			   &access->ac_supported);
  }
  
@@ -50,7 +53,7 @@
  static __be32
  nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	     union nfsd4_op_u *u)
-@@ -1632,7 +1623,6 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
+@@ -1594,7 +1585,6 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
  		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
  			NFS_FILE_SYNC : NFS_UNSTABLE;
  	nfsd4_copy_set_sync(copy, sync);
@@ -58,30 +61,24 @@
  }
  
  static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
-@@ -1805,9 +1795,11 @@ static __be32
+@@ -1765,9 +1755,14 @@ static __be32
  nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  		union nfsd4_op_u *u)
  {
+-	struct nfsd4_copy *copy = &u->copy;
+-	__be32 status;
 +	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-+	struct nfsd4_copy *async_copy = NULL;
- 	struct nfsd4_copy *copy = &u->copy;
+ 	struct nfsd4_copy *async_copy = NULL;
++	struct nfsd4_copy *copy = &u->copy;
 +	struct nfsd42_write_res *result;
- 	__be32 status;
--	struct nfsd4_copy *async_copy = NULL;
- 
- 	/*
- 	 * Currently, async COPY is not reliable. Force all COPY
-@@ -1816,6 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
- 	 */
- 	nfsd4_copy_set_sync(copy, true);
- 
++	__be32 status;
++
 +	result = &copy->cp_res;
 +	nfsd_copy_write_verifier((__be32 *)&result->wr_verifier.data, nn);
-+
+ 
  	copy->cp_clp = cstate->clp;
  	if (nfsd4_ssc_is_inter(copy)) {
- 		trace_nfsd_copy_inter(copy);
-@@ -1840,8 +1835,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1787,8 +1782,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  		sizeof(struct knfsd_fh));
  	if (nfsd4_copy_is_async(copy)) {
@@ -90,7 +87,7 @@
  		status = nfserrno(-ENOMEM);
  		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
  		if (!async_copy)
-@@ -1853,8 +1846,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1800,8 +1793,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  			goto out_err;
  		if (!nfs4_init_copy_state(nn, copy))
  			goto out_err;
@@ -101,3 +98,6 @@
  		dup_copy_fields(copy, async_copy);
  		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
  				async_copy, "%s", "copy thread");
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

