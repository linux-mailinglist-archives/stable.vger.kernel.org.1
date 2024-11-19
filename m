Return-Path: <stable+bounces-93900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C789D1F54
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA93281612
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26370148857;
	Tue, 19 Nov 2024 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoP3huem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA114B945
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990981; cv=none; b=bNBGoWfrFnPa4O3qUy3Jx8+J/fVNQ8WUycHR/LnQ6I/FEULhX3wNcQm1N/4Nyl1S5/WO+wRZDGW9hAjznSPTi8RR6eg4ehrQuXvXNFjpH6xTqaLNCl3mhYwRYsWy1O1YH4gKwLueD9Ngb59BU3z4DFS+q1z0w1P73T/CB79Y4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990981; c=relaxed/simple;
	bh=7R7nek5v7WiEYVJKgkWnyWSR4D81aqKwGiKzcnt9ha4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA41YS8UZ1Px8UG8tS1x33uEL+TIQXPPQrtSvP3ZDKNIwgufPNwdK1kBse/1BZKwS0CNdT2M/Wfa1EUBTbwauLYDIPpVmc5CWrYoQS13PZDFrpH3FopMgOJ8sxb/Y/j6Cc5JPB7fh54kVOGrGuEJBOPFUzysqIRrG/ANAbA2cos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoP3huem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A869C4CECF;
	Tue, 19 Nov 2024 04:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990981;
	bh=7R7nek5v7WiEYVJKgkWnyWSR4D81aqKwGiKzcnt9ha4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NoP3huemVTToKYhl2iQ0b90s+eNpMpa3QxWvnP45DIM5y5BTicL1oDy050RxXizb4
	 ndI2md/4WEhZshDIa5dZQ0z/WIOwXrguqSkF1KmhiX7ItuDIiGgpo/dZZywRtECnP9
	 99KyFNKCF2vhlxeyuM8/7bwuj8xACTeND/uQeet/licD4IHHnKUAIE/2dLDNeXDfme
	 M43ICipEWm78GjuSk3mH4uEWw2dX6bfq3/vW3KmsL32hpHOgPoZKXLjhxtL/qW2OUy
	 7fJF6kZec1YkRStIbfLE7ewWw9S1mHqmddQjTHlFb7z4KHXAlVV2SevlbnIAtmox5i
	 9FCBUEOo3liww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 3/5] NFSD: Limit the number of concurrent async COPY operations
Date: Mon, 18 Nov 2024 23:36:19 -0500
Message-ID: <20241118211900.3808-4-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211900.3808-4-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: aadc3bbea163b6caaaebfdd2b6c4667fbc726752

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Chuck Lever <chuck.lever@oracle.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: 6a488ad7745b)      |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:18:37.386016213 -0500
+++ /tmp/tmp.rpn5VJDsdI	2024-11-18 23:18:37.379324086 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit aadc3bbea163b6caaaebfdd2b6c4667fbc726752 ]
+
 Nothing appears to limit the number of concurrent async COPY
 operations that clients can start. In addition, AFAICT each async
 COPY can copy an unlimited number of 4MB chunks, so can run for a
@@ -17,6 +19,7 @@
 
 Cc: stable@vger.kernel.org
 Reviewed-by: Jeff Layton <jlayton@kernel.org>
+Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49974
 Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
 ---
  fs/nfsd/netns.h     |  1 +
@@ -26,10 +29,10 @@
  4 files changed, 12 insertions(+), 2 deletions(-)
 
 diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
-index 238fc4e56e539..37b8bfdcfeea8 100644
+index 548422b24a7d..41c750f34473 100644
 --- a/fs/nfsd/netns.h
 +++ b/fs/nfsd/netns.h
-@@ -148,6 +148,7 @@ struct nfsd_net {
+@@ -152,6 +152,7 @@ struct nfsd_net {
  	u32		s2s_cp_cl_id;
  	struct idr	s2s_cp_stateids;
  	spinlock_t	s2s_cp_lock;
@@ -38,10 +41,10 @@
  	/*
  	 * Version information
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 231c6035602f6..9655acb407b72 100644
+index b8fb37cc59c4..6637a7ef974b 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1280,6 +1280,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
+@@ -1243,6 +1243,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
  {
  	if (!refcount_dec_and_test(&copy->refcount))
  		return;
@@ -49,7 +52,7 @@
  	kfree(copy->cp_src);
  	kfree(copy);
  }
-@@ -1835,10 +1836,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1781,10 +1782,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  		sizeof(struct knfsd_fh));
  	if (nfsd4_copy_is_async(copy)) {
@@ -67,7 +70,7 @@
  		INIT_LIST_HEAD(&async_copy->copies);
  		refcount_set(&async_copy->refcount, 1);
  		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
-@@ -1878,7 +1885,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1823,7 +1830,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	}
  	if (async_copy)
  		cleanup_async_copy(async_copy);
@@ -77,10 +80,10 @@
  }
  
 diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
-index 7ade551bc0221..a49aa75bc0b79 100644
+index 893d099e0099..e195012db48e 100644
 --- a/fs/nfsd/nfs4state.c
 +++ b/fs/nfsd/nfs4state.c
-@@ -8554,6 +8554,7 @@ static int nfs4_state_create_net(struct net *net)
+@@ -8076,6 +8076,7 @@ static int nfs4_state_create_net(struct net *net)
  	spin_lock_init(&nn->client_lock);
  	spin_lock_init(&nn->s2s_cp_lock);
  	idr_init(&nn->s2s_cp_stateids);
@@ -89,10 +92,10 @@
  	spin_lock_init(&nn->blocked_locks_lock);
  	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
-index fbdd42cde1fa5..2a21a7662e030 100644
+index 510978e602da..9bd1ade6ba54 100644
 --- a/fs/nfsd/xdr4.h
 +++ b/fs/nfsd/xdr4.h
-@@ -713,6 +713,7 @@ struct nfsd4_copy {
+@@ -574,6 +574,7 @@ struct nfsd4_copy {
  	struct nfsd4_ssc_umount_item *ss_nsui;
  	struct nfs_fh		c_fh;
  	nfs4_stateid		stateid;
@@ -100,3 +103,6 @@
  };
  
  static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

