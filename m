Return-Path: <stable+bounces-93955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F99D25D2
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EEBB293F8
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F281C2454;
	Tue, 19 Nov 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0Hj2gMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B513B780
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019437; cv=none; b=dfUsBL8Zzs4MWvPAibSOjjOuJ5PHjXAczh3Fwr2WzWbh60ma0Z1oeMAdyFt5Q5ZnnJbJte5AhN9weWruj41BDQvq+HKcGj7eFdKnWZTDAzdEqjkGsz5RH+8gZMNaStZ6JN+uwyqJntFj31P9IRmFeJP11UygpGjznAtlARXE46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019437; c=relaxed/simple;
	bh=40bTpCND5CaZu6fyyI/8Zn7RYyG9tU5D6RNYrLZeib4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzLm51UmYH8gOSukza/BzSnFow2fPmaBm9EtpHTtOSIGR9SxPRUhy9dWC50dNBnmo+DXFHyZ+DziXkj2t3DfEJdIYxxUl3q1Bhq4vnZ4oha0jqDMOQLH+9Mm+G/EtDar30OtbGGR4RxSX4uUyxyjKqPMgsJYomZc5EJSDaUD4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0Hj2gMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1930C4CECF;
	Tue, 19 Nov 2024 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019437;
	bh=40bTpCND5CaZu6fyyI/8Zn7RYyG9tU5D6RNYrLZeib4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0Hj2gMnphmkzvRSmmKXMKIHTsapkwBStcxrP80dgY+pqHs1uKXZXwZCzXsD6usHm
	 A2fDQABx8p5CXy9rLjXnI4RHQaIOhuMgboFSduEE9uTglc0zg34BVnwsbSg1WIraIr
	 XX10lYPjcSkpIm3rxtF5SPzIwFZAIULwt9y5CkorOU+Khd4kxC6szj0vZGit9YAAqY
	 Mq46S6bYxCppp85Mhw51q0rT/XFZL+jGHBFaAJPwcJrIrQEcWVjb8ZXYVStJAXXUR3
	 v9eo9GZxd1k5/cdxOvab7+5lN0l4irbGGFLYnHokeTKF1h2mxUwGXRxj8atFoZ5O18
	 fqOYvDfRJlZNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Tue, 19 Nov 2024 07:30:35 -0500
Message-ID: <20241119004732.4703-2-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119004732.4703-2-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 15d1975b7279693d6f09398e0e2e31aca2310275

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Dai Ngo <dai.ngo@oracle.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
| 5.15.y          |  Not found                                   |
| 5.10.y          |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 02:00:35.132231426 -0500
+++ /tmp/tmp.2OL4ABMh5G	2024-11-19 02:00:35.126441883 -0500
@@ -1,17 +1,20 @@
+[ Upstream commit 15d1975b7279693d6f09398e0e2e31aca2310275 ]
+
 Prepare for adding server copy trace points.
 
 Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
 Tested-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
+Stable-dep-of: 9ed666eba4e0 ("NFSD: Async COPY result needs to return a write verifier")
 Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
 ---
  fs/nfsd/nfs4proc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 4199ede0583c7..c27f2fdcea32c 100644
+index f10e70f37285..fbd42c1a3fcd 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1798,6 +1798,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1769,6 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	__be32 status;
  	struct nfsd4_copy *async_copy = NULL;
  
@@ -19,7 +22,7 @@
  	if (nfsd4_ssc_is_inter(copy)) {
  		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
  			status = nfserr_notsupp;
-@@ -1812,7 +1813,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1783,7 +1784,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  			return status;
  	}
  
@@ -27,3 +30,6 @@
  	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  		sizeof(struct knfsd_fh));
  	if (nfsd4_copy_is_async(copy)) {
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

