Return-Path: <stable+bounces-93898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4945C9D1F52
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC16D1F21866
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B615278E;
	Tue, 19 Nov 2024 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVRIJpdN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8AF15252D
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990978; cv=none; b=JBi+AFROiAun/vY/iNZc/my1yBx/kHYESoYTHC4HPZ5tLpm8OTfNdeAPN1v1PTIjiNQ1pyL1rxfzFkBLawPy7evYp7HAKFzL9afByZZtgOAqH4L35EaWr/P5QD9/U86HD82yn10nAQ9i3L3hgzK0JrLtOcMO/97D9efBeQh0504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990978; c=relaxed/simple;
	bh=FOkWe1BSdBm9DUz2SFey9h5o9GKVZXx1xYtQwy0wehU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5vaDGYWUS0PrsEPtxUzjsTleVx4G6Qo6VfShzK0lFd5dD0YSm2PvMwzwf6tgoOifKRVqfPVEfNknATQpSX5Gbk1918kmfyXLN75T1WFrYHJZWIm8VmiOfBHeKZwchRo/AcMLMavE1qv3eIX0bylQwObp5tRnwcl7SRPwnRhE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVRIJpdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03558C4CECF;
	Tue, 19 Nov 2024 04:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990977;
	bh=FOkWe1BSdBm9DUz2SFey9h5o9GKVZXx1xYtQwy0wehU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVRIJpdN7JC243XcTFgSU+Kx5+fBsvNyYu1eB2GjuxGWIXdM+qXZwY7r1IBsoJ+7B
	 Na0SpKtQRO1znudSBh8b2IariZyN7h+LDmoGPVekwbOLzF32RF/BA2B+e9Ncvv+jv9
	 9tB7diE3FnNR0LiDJsQpPqzuP98DoCeDoeXxM7Z8B7S5AP+gVXd1bm9YF/gvEmbdKh
	 81C8zhds0Jz5EprUIqDnc86tTBq1OMaWbzzuAcWwUMMQTXccou/Q1DHOwEzHPcsKNj
	 8nAoHRe6fjLJ/qNOvEp7aekjmu8pazaDDrSKJTX6Ex7O6C2ZdeOi/+VbLR5od5VHtL
	 1Ti2vX75cSKiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Mon, 18 Nov 2024 23:36:15 -0500
Message-ID: <20241118211900.3808-2-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211900.3808-2-cel@kernel.org>
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
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:00:36.794064423 -0500
+++ /tmp/tmp.6a2P3hH3a2	2024-11-18 23:00:36.786070330 -0500
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
+index df9dbd93663e..50f17cee8bcf 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1798,6 +1798,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1768,6 +1768,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	__be32 status;
  	struct nfsd4_copy *async_copy = NULL;
  
@@ -19,7 +22,7 @@
  	if (nfsd4_ssc_is_inter(copy)) {
  		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
  			status = nfserr_notsupp;
-@@ -1812,7 +1813,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1782,7 +1783,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
| stable/linux-6.1.y        |  Success    |  Success   |

