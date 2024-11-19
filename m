Return-Path: <stable+bounces-93973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E09D25E4
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360972853B5
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80C11CBE80;
	Tue, 19 Nov 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ5oqg+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD01C2454
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019472; cv=none; b=SL9XkG7Q/mqjHMR5T/tHkgbdcfCxBb7SpblHVa0ItJxUzlscF7OwANHdoXV1cXTWshmh8VWOztUgVoYuvpclNWJLVdlvDqrkE6Q6emZVVnH6F3E10HRD4P5wTOIiIN6SABxtWcSetB3aHalhLFu6knqUMDYUcSzNrGFa8WfjBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019472; c=relaxed/simple;
	bh=VOk0/daMZbpJTCx9axUbHelIIPwWMm+/1Lc4SQ/bDWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQhLlyeA1F/s+vdcfRSVv7ASh11qiCWJc6kueQNVP6WDSPnyZadROMXoADpsVrDBLUxCgUA5RTTacqbRCLQl41aodqB186wt9TQ9ySxE1TFRsmVG3GlkcvLCeF25BzasiL2hkR6VDi1U9OOFzcrhIkZnUbm4jjCK8aVcxb5RNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ5oqg+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEB1C4CECF;
	Tue, 19 Nov 2024 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019472;
	bh=VOk0/daMZbpJTCx9axUbHelIIPwWMm+/1Lc4SQ/bDWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQ5oqg+oKT3mfunxa7CTyqAy6Z+GqR1mC/yc5AhtwImC4YOgAkvyLwveCv/Rtw5dE
	 Bs6Gccq6aGCUnLwmWNvbQOCxCABaZEIhkoIuTOLNSs8SR7Itip/eWE2hc9wyFPaeCK
	 sVnH94LjJI4ozyFsGEsYu97YN3M6QwP4nz4ff7mqVbby19BL765HHxofLFedjmL9yT
	 tcXzk37BY6OXk5Rrsu0DWk/8JnmP0slsEup1S2lN36nn8RSykHtsSLSdlP7Ki15vd4
	 qgSE7/SZJM3TzibqGkCF8JruRkcTeS+6IxvjduO5JrcnaUsI0ryWxEF3ymP5+zWwiv
	 4CZ/tir0K1bKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 2/5] NFSD: Async COPY result needs to return a write verifier
Date: Tue, 19 Nov 2024 07:31:10 -0500
Message-ID: <20241118211413.3756-3-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211413.3756-3-cel@kernel.org>
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
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:44:09.011704681 -0500
+++ /tmp/tmp.CoFPxIg2l1	2024-11-18 23:44:09.002532643 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 9ed666eba4e0a2bb8ffaa3739d830b64d4f2aaad ]
+
 Currently, when NFSD handles an asynchronous COPY, it returns a
 zero write verifier, relying on the subsequent CB_OFFLOAD callback
 to pass the write verifier and a stable_how4 value to the client.
@@ -25,16 +27,17 @@
 is needed.
 
 Reviewed-by: Jeff Layton <jlayton@kernel.org>
+[ cel: adjusted to apply to origin/linux-6.6.y ]
 Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
 ---
- fs/nfsd/nfs4proc.c | 23 ++++++++---------------
- 1 file changed, 8 insertions(+), 15 deletions(-)
+ fs/nfsd/nfs4proc.c | 25 +++++++++----------------
+ 1 file changed, 9 insertions(+), 16 deletions(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 963a02e179a0a..231c6035602f6 100644
+index a378dcb2ceb2..3e35f8688426 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -752,15 +752,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -751,15 +751,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  			   &access->ac_supported);
  }
  
@@ -50,7 +53,7 @@
  static __be32
  nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	     union nfsd4_op_u *u)
-@@ -1632,7 +1623,6 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
+@@ -1623,7 +1614,6 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
  		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
  			NFS_FILE_SYNC : NFS_UNSTABLE;
  	nfsd4_copy_set_sync(copy, sync);
@@ -58,30 +61,24 @@
  }
  
  static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
-@@ -1805,9 +1795,11 @@ static __be32
+@@ -1794,9 +1784,14 @@ static __be32
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
+@@ -1816,8 +1811,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  		sizeof(struct knfsd_fh));
  	if (nfsd4_copy_is_async(copy)) {
@@ -90,7 +87,7 @@
  		status = nfserrno(-ENOMEM);
  		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
  		if (!async_copy)
-@@ -1853,8 +1846,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1829,8 +1822,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
| stable/linux-6.6.y        |  Success    |  Success   |

