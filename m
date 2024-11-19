Return-Path: <stable+bounces-93967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE639D25DE
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AEEB29669
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823871CC171;
	Tue, 19 Nov 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYd1idXf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EE146D6A
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019461; cv=none; b=cHNmD8D5NJJ6tAcQiZE2VDZHkhZGx2jPPh0OgLP4zfliOxQ3olGYArZUu+oSQ0sf6GldBtpD18kje9GWpEftWstgl0FGVC6YkAiFJ6opo0EQocpf4jDDo7E/Gk72aXIPdSKVQl7I3i5r99Kl4hsoXFMEU7O7lvYednBZBso1Gjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019461; c=relaxed/simple;
	bh=0kwi89dqPEbnwMbXslkvndDIGJN3CR8c/kByXPcxn2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPFKyMbiaOCm6dt+p2c3ZWYy8yYue8H0FcdgnWofmYNBBLdMPN0MZhZbdCpNwD1VH8EtvT1Ftk+xHX8N1g1UJL5f4BnJTrKRjXClxhx7xTM3eZvTqJQP31Xggp/Y/wWdFOV284tqMH9cWPZk1s2L3ygOAp1BbR445sZfUdNYqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYd1idXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A58C4CECF;
	Tue, 19 Nov 2024 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019460;
	bh=0kwi89dqPEbnwMbXslkvndDIGJN3CR8c/kByXPcxn2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYd1idXf3PK7pnMe67km7fCzlew2nfvizQUYMpKNVFUtTfD1Ax37yzhTyB4N8zgnp
	 GApP8DZcs4r8uU9Zag4StPU9q+1XJQAlWVhfIqAvoxWPBvk3uiZaRIAjE69TauTzLm
	 zjyV+LfeS9fjx6AouJIwGKvgiv+Jor8nuAEZc/trDqAjDNZ2rAockByzJuHOk9yXEn
	 qXKtCV0LGwmDajBZmvSyLCRfnznJLvR+uuyLCbm2iTmFrj3Xh4SKNt8kA1at/GSzZ4
	 nhxSBFm9BT+G/6KINq4BeUbksA905pD4hYNiM4M0z+CPuZ0+ZTgfDnV367GYNpnYER
	 E3VEPxqbVfHtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 3/5] NFSD: Limit the number of concurrent async COPY operations
Date: Tue, 19 Nov 2024 07:30:59 -0500
Message-ID: <20241118211413.3756-4-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211413.3756-4-cel@kernel.org>
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
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:49:22.177363456 -0500
+++ /tmp/tmp.X9bA4eHS8l	2024-11-18 23:49:22.170197920 -0500
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
+index 9bfca3dda63d..77d4f82096c9 100644
 --- a/fs/nfsd/netns.h
 +++ b/fs/nfsd/netns.h
-@@ -148,6 +148,7 @@ struct nfsd_net {
+@@ -153,6 +153,7 @@ struct nfsd_net {
  	u32		s2s_cp_cl_id;
  	struct idr	s2s_cp_stateids;
  	spinlock_t	s2s_cp_lock;
@@ -38,10 +41,10 @@
  	/*
  	 * Version information
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 231c6035602f6..9655acb407b72 100644
+index 3e35f8688426..e74462fb480f 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1280,6 +1280,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
+@@ -1273,6 +1273,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
  {
  	if (!refcount_dec_and_test(&copy->refcount))
  		return;
@@ -49,7 +52,7 @@
  	kfree(copy->cp_src);
  	kfree(copy);
  }
-@@ -1835,10 +1836,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1811,10 +1812,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  		sizeof(struct knfsd_fh));
  	if (nfsd4_copy_is_async(copy)) {
@@ -67,7 +70,7 @@
  		INIT_LIST_HEAD(&async_copy->copies);
  		refcount_set(&async_copy->refcount, 1);
  		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
-@@ -1878,7 +1885,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1853,7 +1860,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	}
  	if (async_copy)
  		cleanup_async_copy(async_copy);
@@ -77,10 +80,10 @@
  }
  
 diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
-index 7ade551bc0221..a49aa75bc0b79 100644
+index 975dd74a7a4d..901fc68636cd 100644
 --- a/fs/nfsd/nfs4state.c
 +++ b/fs/nfsd/nfs4state.c
-@@ -8554,6 +8554,7 @@ static int nfs4_state_create_net(struct net *net)
+@@ -8142,6 +8142,7 @@ static int nfs4_state_create_net(struct net *net)
  	spin_lock_init(&nn->client_lock);
  	spin_lock_init(&nn->s2s_cp_lock);
  	idr_init(&nn->s2s_cp_stateids);
@@ -89,10 +92,10 @@
  	spin_lock_init(&nn->blocked_locks_lock);
  	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
-index fbdd42cde1fa5..2a21a7662e030 100644
+index 9d918a79dc16..144e05efd14c 100644
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
| stable/linux-6.6.y        |  Success    |  Success   |

