Return-Path: <stable+bounces-93964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A269D25DB
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D74E284F36
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8651CC165;
	Tue, 19 Nov 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8b5cjy+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C261146D6A
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019455; cv=none; b=k5bv1Le1D2bNUbUz4LAWYDKIIkPAvFLmtR11Ow/+y8fp3TTfDc+NoEbvFZmqsiUL4xYeMeyP6mqRmGjsDOUvmHPBDmO+4gegbYQGvF8tJs9/ANyy5eDc4yRAybOJwnRcidjDCHtNRnWknH+gB+j0jyHoY5gv6AHmkwnC0TMAj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019455; c=relaxed/simple;
	bh=51Vxv6TisewzHJoe5tQ/Tj8WhNhFOIP/nx0I7YRrjRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9F1Rp9PZn15Pi6b5EddBJqTuTUL7s5mqpLgPh2/MrXmnTgoYXskf/2af0BxiMASQv4WnKXGkWb6xtipxqtV3HHW9rw5kTTPL04ZY+TL949BxWbmd69u/A6IHG1Dr5RApKqbLq41z5P1NlH3UpV0iub/cbwM+LbfMt+K7qXP4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8b5cjy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F59C4CECF;
	Tue, 19 Nov 2024 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019455;
	bh=51Vxv6TisewzHJoe5tQ/Tj8WhNhFOIP/nx0I7YRrjRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8b5cjy+9rPzcmhwOTihukcoIcrx1+pRieZpoVNwFKhPtcr7l8aoC8lTrVoa0LYcg
	 9PjXi2jszlVYM3k9zVBbeOiq3z2jJpDsvUIafknKOxFlib8oHu3VZrmgYfHBKjDVjP
	 c0+RqW41HZ24scSc+Oi/x/MXn2BHcdPhV5dg8QHV6XmOfOI1pptBID8kgQuBi8C85q
	 M5vtQ3f2eb6Sea3H1k7jtEHTPvqx6T/QCZ6FeoCwTcje77q988RYQn59ZHSPaitHlM
	 sg/sybSMp5i3QaKsWHXDNQ6BryUtS7FDnty4PJf4js/Sd/24eq0KcrVufBWsQEEXvb
	 0lZOQCae3vk9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 3/5] NFSD: Limit the number of concurrent async COPY operations
Date: Tue, 19 Nov 2024 07:30:53 -0500
Message-ID: <20241118212035.3848-6-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118212035.3848-6-cel@kernel.org>
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
| 5.15.y          |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 00:21:15.890891404 -0500
+++ /tmp/tmp.y7YMnBfnA8	2024-11-19 00:21:15.887605316 -0500
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
+index 08d90e0e8fae..54f43501fed9 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1280,6 +1280,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
+@@ -1244,6 +1244,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
  {
  	if (!refcount_dec_and_test(&copy->refcount))
  		return;
@@ -49,7 +52,7 @@
  	kfree(copy->cp_src);
  	kfree(copy);
  }
-@@ -1835,10 +1836,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1782,10 +1783,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  		sizeof(struct knfsd_fh));
  	if (nfsd4_copy_is_async(copy)) {
@@ -67,7 +70,7 @@
  		INIT_LIST_HEAD(&async_copy->copies);
  		refcount_set(&async_copy->refcount, 1);
  		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
-@@ -1878,7 +1885,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1824,7 +1831,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	}
  	if (async_copy)
  		cleanup_async_copy(async_copy);
@@ -77,10 +80,10 @@
  }
  
 diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
-index 7ade551bc0221..a49aa75bc0b79 100644
+index 5ab3045c649f..a7016f738647 100644
 --- a/fs/nfsd/nfs4state.c
 +++ b/fs/nfsd/nfs4state.c
-@@ -8554,6 +8554,7 @@ static int nfs4_state_create_net(struct net *net)
+@@ -8079,6 +8079,7 @@ static int nfs4_state_create_net(struct net *net)
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
| stable/linux-5.15.y       |  Success    |  Success   |

