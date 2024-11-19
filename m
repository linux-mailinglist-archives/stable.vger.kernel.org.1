Return-Path: <stable+bounces-93978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC89D25E9
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153FC1F24DCB
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9588E1CC14C;
	Tue, 19 Nov 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0RPGONA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663713B780
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019483; cv=none; b=m3rVtlQT2J+nEv33jnj5mwrAwYMcQGNz21KLksnw0slhErTo+SWW5uB+vyXptmo/1lo/4LRc6Hb77dyh4eZRKSNILxni5gXgBWPyAAZ5lQvFpvXXr6Ul4LwCvitnr0ONBNPg1t4NN5nZyKPobPo+1FXzGij0AROxb1PFedZ9aGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019483; c=relaxed/simple;
	bh=6hQi/Vzetu4yiWFJTuBOejUMlgUo+jKz5dCJ5OKqhJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d66FeO+yXmiRYdrQrEAMTE/X5EjnMDMXtwXM5NfhKRh5JN43tohZmZErD/9oVp3aF82ZhrelOZQoTpWISIvpv50hxm3Ce8XSeayTUS+HpNqDa1QYHTf24yaNU81HdTV5BPN5cRXpSqai28LaPTBXYuux8fgqtKT1dJuthPIz9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0RPGONA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649F0C4CECF;
	Tue, 19 Nov 2024 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019482;
	bh=6hQi/Vzetu4yiWFJTuBOejUMlgUo+jKz5dCJ5OKqhJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0RPGONAAwhh8u4ZjiOolC00x0GA3DPUlg8enrG5mMofAUudtGHJuFFThHDbvXeor
	 DWRm151y7TS8ng56XQRd5z0lQ/Inql0BiG1yIrLwUEi0pcJgIAsex7SUNwBDUTQ1Zs
	 l+LQYyqsA4G35NPD1E/K7LkdqPAe8B2RyGqRNvQDK2x1PL+5MSeSMAwYy1ez0U0+bF
	 4BdyvMT1hUa446AgPptxLDkIHBufWiVCTRwXx7ijVm8Xyp05NmPZt90GR4//ihglWo
	 ewAzpXPu+6xJto+jWf6qnEXh4UTo0VKHggNIbq+wnRXh2a/40aVxempv0Z6lmkBSa8
	 1xKOmvM2+wWNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Tue, 19 Nov 2024 07:31:20 -0500
Message-ID: <20241118212343.3935-2-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118212343.3935-2-cel@kernel.org>
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
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 00:34:46.562972386 -0500
+++ /tmp/tmp.dJ2FyvDKol	2024-11-19 00:34:46.560154414 -0500
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
+index 11dcf3debb1d..2b1fcf5b6bf8 100644
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
| stable/linux-5.15.y       |  Success    |  Success   |

