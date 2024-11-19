Return-Path: <stable+bounces-93966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9149D25DC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102C6283FA3
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE01CC16D;
	Tue, 19 Nov 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV4vDxX1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172C1C4A30
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019459; cv=none; b=ZuA7OoLFOH+rp1eyGk61+U67+VUKjf66gk3XEbdSryc/cwZAOyXv8mVUEQSMkmYjZTZlxUuteLzRcpwtmMIlFSECU1Ye3PaLi9a0Px0fz8bQGOk0z6Cg13g7gIwr1Kxt3A4EKif/pgbhHg+UJpfu+IY11x6pN8CVzlrKlIC2Jlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019459; c=relaxed/simple;
	bh=eyfiGpZpQXZ2fS0KlEvY5+rCGugv0+c6QD0Uv0zU4Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAAMFrQg6wKcv82ppgf5htYrQu2vIideG5NdDL2ky+z8GH1XsrgtBU7pyDhJMypIde5bjiBOIbgnAw+6Kclh25MDThhhvob3CkUL5zwa+6ZCoI2Hwjj/RPqcUqeXq4zzf5mgb7SQL8Xk+bLO9pTu2ImfkvC6cPEZKcT55v8PNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV4vDxX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F55C4CECF;
	Tue, 19 Nov 2024 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019458;
	bh=eyfiGpZpQXZ2fS0KlEvY5+rCGugv0+c6QD0Uv0zU4Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rV4vDxX10U6URz3SYC0CKlzRpmfA4PpNIVbyJNYzEDxiJ3YMF6VSH2rFYiQXzejmU
	 L7t7wXaOgRkBxblf6sz1rcTpDz7T0aJxSIMCp6dRQvRAE6+LEH879oyNMYtT6qoC41
	 E9h+9UKsr895YIOE9Xt3NhZ1lGCWfNwZ5pJPySyHFRUeNg4BsEHcYlJZK3x9WOJjeZ
	 BQ+BH2YVUvqbo/YDY3qIAFZQ3RJ5d5p/lzl6qCJOqVHvMU14bhhWe4Vnh9JAecnZ4c
	 vukva2j7jf+85VVYkRHNAjkTY7+0Efl6OPagubUzyhCKDm0OUrG6i+Ynrk2m4qddH5
	 rTIEXkiAWIwjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 4/5] NFSD: Initialize struct nfsd4_copy earlier
Date: Tue, 19 Nov 2024 07:30:57 -0500
Message-ID: <20241118211413.3756-5-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211413.3756-5-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 63fab04cbd0f96191b6e5beedc3b643b01c15889

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Chuck Lever <chuck.lever@oracle.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: e30a9a2f69c3)      |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:54:29.489312431 -0500
+++ /tmp/tmp.oVuvgY7enX	2024-11-18 23:54:29.481985187 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 63fab04cbd0f96191b6e5beedc3b643b01c15889 ]
+
 Ensure the refcount and async_copies fields are initialized early.
 cleanup_async_copy() will reference these fields if an error occurs
 in nfsd4_copy(). If they are not correctly initialized, at the very
@@ -13,10 +15,10 @@
  1 file changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index b5a6bf4f459fb..5fd1ce3fc8fb7 100644
+index e74462fb480f..444f68ade80c 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1841,14 +1841,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1816,14 +1816,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  		if (!async_copy)
  			goto out_err;
  		async_copy->cp_nn = nn;
@@ -33,3 +35,6 @@
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
| stable/linux-6.6.y        |  Success    |  Success   |

