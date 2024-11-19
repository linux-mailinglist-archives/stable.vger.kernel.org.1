Return-Path: <stable+bounces-93902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D337E9D1F56
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994322825BA
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4253714C5AA;
	Tue, 19 Nov 2024 04:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYDqpVD8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC914B080
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990986; cv=none; b=dug7zrJDuNbQ4oMRerAipyN7dBII31mfF/rRhwnmsu52Nb16P9W0q7mG0TRsdduH2V93KnqeurhFTTKQI+aqkHvRwGJYpNqpWGNZm1iLsCE/uEumegjiLno2xDHdZcKUlZttiFpo4ry0HVtE/uIx21mXZqVGSsqmUU1TKU1zAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990986; c=relaxed/simple;
	bh=moG7By/6JuCi1q7964iEAVY/91tdUsiuFjyKaFMbGws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8pyxo0GUJR6kTy3ObjgoZ8H0G79LOZ0zQY11JyfvM6FA+lNrTRwimeNXyk+jRwxohQYtsqy+XH2UKqmd/V5iquv5bfVDcyIJgAMOCV2BMIkRR0Z8oSzZ7ERtVp1xPWspo/2zX1OtR/yboY6ENU9SyAfM4TxTUn+31kwJ6tt6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYDqpVD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19666C4CECF;
	Tue, 19 Nov 2024 04:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990985;
	bh=moG7By/6JuCi1q7964iEAVY/91tdUsiuFjyKaFMbGws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYDqpVD8HSnlXElUCPojYrpsWumm6aZcPADzJU8udpz/8iov5p29BdoBBgR7eg+v/
	 33RBZwo+WsNmh6rg5FywxQ6ww5aNnVZUH0ESxNfxZ/EMzk9uUJAzP4MkTv3p5Tzn9z
	 8XoWiN6bdYpn5XRTrSgaCr257vayETR8lzB8DBc90r3VXG/WvjzU0HPSHs3XyIjiFQ
	 wvHtNV0f6BYAZEgbBdnpDM3rsDFENKbTaqAA2CwjV3O3jMwl7gFZY4PKLB2QB5dPc1
	 st1Xxe05nkLZLQ3OQuBJu8qpOaxjDlaJj3SsyrsT4QSRxVV8EeqywYz76JxeM3kttX
	 CYLqnqXJpQ6aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 5/5] NFSD: Never decrement pending_async_copies on error
Date: Mon, 18 Nov 2024 23:36:23 -0500
Message-ID: <20241118211900.3808-6-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211900.3808-6-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 8286f8b622990194207df9ab852e0f87c60d35e9

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Chuck Lever <chuck.lever@oracle.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: 1421883aa30c)      |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:28:40.535829910 -0500
+++ /tmp/tmp.BGWnSDkmxq	2024-11-18 23:28:40.531234778 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 8286f8b622990194207df9ab852e0f87c60d35e9 ]
+
 The error flow in nfsd4_copy() calls cleanup_async_copy(), which
 already decrements nn->pending_async_copies.
 
@@ -9,10 +11,10 @@
  1 file changed, 1 insertion(+), 3 deletions(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 5fd1ce3fc8fb7..d32f2dfd148fe 100644
+index c0f13989bd24..0aebb2dc5776 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1845,10 +1845,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1790,10 +1790,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  		refcount_set(&async_copy->refcount, 1);
  		/* Arbitrary cap on number of pending async copy operations */
  		if (atomic_inc_return(&nn->pending_async_copies) >
@@ -24,3 +26,6 @@
  		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
  		if (!async_copy->cp_src)
  			goto out_err;
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

