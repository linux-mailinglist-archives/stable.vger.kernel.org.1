Return-Path: <stable+bounces-93899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2999D1F53
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40619283049
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2850D14D2A0;
	Tue, 19 Nov 2024 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSCXp5xK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA914D2A3
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990979; cv=none; b=pp//lbRZfeztOZlsDk8xwwLnD2r8o+FLErsGs/m4FtsSajVwj+y/Iw4+M8F2+ZndMviYrEAa54vMadsHmswq+F0aQaVP+DUn3vuuBiVbVTwwWxg/TTDNsD5m6u72VwPpMz0vl7yF9TGoehtJr5xySQqdVaEYRMwYjVlXUn7oeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990979; c=relaxed/simple;
	bh=5OeTZEjogVamaJqNf3Vn3WIJS2sF/6VICcYgwtJuaNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rpcwu4bXuYj2KVzr0b7IO0UJnLECx4LIXHqXrjX3DX2hNRzVqcGTGy4jGDScflRyERTtNhELBCKmz7oWmWkYjGLGfjNwjDJNAM+AXyuBe4paLa8RfTAakIbfNjm0VUryC97PVWq80A5NEZFLRZedhTWZDqx+1KrU0Zplep5gZQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSCXp5xK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C890C4CED1;
	Tue, 19 Nov 2024 04:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990979;
	bh=5OeTZEjogVamaJqNf3Vn3WIJS2sF/6VICcYgwtJuaNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSCXp5xKCo5Xpubzux+khdaL2r1cqRAPn83ycD8ADvlM8/F+wNGfI70oKsiAtSs0H
	 6QQRR+HBjEcRLAORQiaCB7HM8PTVX69A2iog2lPkrRwmikEdUI04iYNfTvJgAq8O9P
	 gOg/7yNLpLnGYNzuPme8gZURYAmkD6xM5DoIL3Nq+gLP1nuj3/RBY2+2NfSbuHEPqa
	 xYghE0xXnrYJw4U1WA74o1JkxXvXyJAsWA0WnIl6qswSMbpbN7hSqzyxIFAfZOTHhV
	 5O19tABeXdNHKQPLjXg4984X2ssjb6CKAQpa7lOVHLZfZmcyRrfz0dWO0z/hcGKp3m
	 I04gmf3gKm4SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 2/5] NFSD: Async COPY result needs to return a write verifier
Date: Mon, 18 Nov 2024 23:36:17 -0500
Message-ID: <20241118211900.3808-3-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211900.3808-3-cel@kernel.org>
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
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:09:20.596467234 -0500
+++ /tmp/tmp.hSLD74MWP5	2024-11-18 23:09:20.590908718 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 9ed666eba4e0a2bb8ffaa3739d830b64d4f2aaad ]
+
 Currently, when NFSD handles an asynchronous COPY, it returns a
 zero write verifier, relying on the subsequent CB_OFFLOAD callback
 to pass the write verifier and a stable_how4 value to the client.
@@ -25,16 +27,17 @@
 is needed.
 
 Reviewed-by: Jeff Layton <jlayton@kernel.org>
+[ cel: adjusted to apply to origin/linux-6.1.y ]
 Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
 ---
- fs/nfsd/nfs4proc.c | 23 ++++++++---------------
- 1 file changed, 8 insertions(+), 15 deletions(-)
+ fs/nfsd/nfs4proc.c | 25 +++++++++----------------
+ 1 file changed, 9 insertions(+), 16 deletions(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 963a02e179a0a..231c6035602f6 100644
+index 50f17cee8bcf..b8fb37cc59c4 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -752,15 +752,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -717,15 +717,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  			   &access->ac_supported);
  }
  
@@ -50,7 +53,7 @@
  static __be32
  nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	     union nfsd4_op_u *u)
-@@ -1632,7 +1623,6 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
+@@ -1593,7 +1584,6 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
  		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
  			NFS_FILE_SYNC : NFS_UNSTABLE;
  	nfsd4_copy_set_sync(copy, sync);
@@ -58,30 +61,24 @@
  }
  
  static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
-@@ -1805,9 +1795,11 @@ static __be32
+@@ -1764,9 +1754,14 @@ static __be32
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
+@@ -1786,8 +1781,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  		sizeof(struct knfsd_fh));
  	if (nfsd4_copy_is_async(copy)) {
@@ -90,7 +87,7 @@
  		status = nfserrno(-ENOMEM);
  		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
  		if (!async_copy)
-@@ -1853,8 +1846,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1799,8 +1792,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
| stable/linux-6.1.y        |  Success    |  Success   |

