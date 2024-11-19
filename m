Return-Path: <stable+bounces-93968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FC9D25E0
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088DEB295ED
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC71C4A30;
	Tue, 19 Nov 2024 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSApDd3b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBCC1C2317
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019462; cv=none; b=SDOApSeD33Top31DOn96l2o09cAQZIPGnvBDWaLCcXH8ykWR6H7rDxOg1Z7uExm4nv8+4KIaSVhjlKDY2MT1rys8qAbLXZ6s6451bkFbbRsm74rmHXuBcsl+rGnXe3RYuxOItWN9jOSM1V/UaMG+NOSMBVCYoPPZDFii5ggEfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019462; c=relaxed/simple;
	bh=IKGXcLjXDp2YBzjzCjQ2cK7cqDh/jkQsUgJw3yO47E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRtIy2b2q6FWLCJnb5Zw/iGz/7QfQREoXOVESnRhvM72rJpwG4jWoXOHJjVEiu5LiFrAjsbYvPK7ZM828peF0QS3o58ET2r3xtUjjODL5BtoC1aLyKTLe6qetRpbIdLbc9BCADU0MxuITLDdjqbOu6/0mxYH44SxAWWG/ZyYb6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSApDd3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D3CC4CECF;
	Tue, 19 Nov 2024 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019462;
	bh=IKGXcLjXDp2YBzjzCjQ2cK7cqDh/jkQsUgJw3yO47E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSApDd3bym34R9lkKh50dxSmRZ+RVcenj3LwDeJ36aHqaziUmh4L/E+ZPlHiopW0a
	 /lD9vfokM6bo8lXcPxudORyoEJFTal4MQniliZxgbQeLKlJeCE0rJuJyy9SOfPr2Mj
	 gLKpq1dAKlLyC15HvcM2xWxOdKF/ycPImzP1IxfHOVoya33j3Yce1BJPD7YHLWRdrr
	 HlciGilto/xgC6KOU9I2ah3hiY7UHoa0HT7uOZ2B8EsmpPpXkukYuzmMAlAZP5ofjB
	 tU6rR5h3CfdKzrDNNFgXCc52AlrvGxIZxBXBITHTeI+lH0OKUbTi3atIccQzHugsvr
	 c4i6jWEnHEwmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Tue, 19 Nov 2024 07:31:01 -0500
Message-ID: <20241118212035.3848-2-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118212035.3848-2-cel@kernel.org>
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
--- -	2024-11-19 00:11:35.759043416 -0500
+++ /tmp/tmp.rRdpdVF2eU	2024-11-19 00:11:35.755799683 -0500
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

