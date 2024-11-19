Return-Path: <stable+bounces-93901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EE69D1F55
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28197282311
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9A14F9ED;
	Tue, 19 Nov 2024 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flSS6jD0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31514D6ED
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990984; cv=none; b=YKyRAx0HtdrkOiQOdgHm2oKp/p963lSGkTxsFyR8Kmns0K5V7+aaSIfQrSv8rbCLdtTuzw04/3gyVU2MBUFq+s3WIgIANcbVarnaCQ0N5lwPoD5Yzf4i6yi43JLkBbM5tg2qTVBPD+2Q3cDjH5AYfp+7ob3pE+Exr0dtKJvc6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990984; c=relaxed/simple;
	bh=98JDXaQO4DElD9zHMEdORbZUR+GPySPqhJ30q7tiHKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKOsuGwVYcQWkE41b+rSekx0/SOCCGDDQcd8wAl/uDmF6lW+ba+a3xDEhdnY5+b+6hz316HdIuUUU0XGxVM5HJf34GVVxpre1VEu+2QC9myOr1akU+ZwHH7d7S5lATWDvWDQ++c6kq6qiFrobu7q3w4QzbETYW7aWn7Z/cZ3GJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flSS6jD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1382CC4CECF;
	Tue, 19 Nov 2024 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990983;
	bh=98JDXaQO4DElD9zHMEdORbZUR+GPySPqhJ30q7tiHKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flSS6jD0AMAvQt/xbky5pBfRxiEpHAuL+NzIRvrToGg6hqZRvIqXf9f4+EWIlarlE
	 N/hnIoftEckX5Q7lXjZJlB/u3cTVGeSlXkdok15YEik1BBepvUef/NQhDZJNoEU6rK
	 pfKGWXGqSBboQmgMkuorLDLc8YBlqsnsGFbR+FMs8kIK1S19zgnLHGSDM+CSf8keHg
	 JwrdEYtulIiEol4F6rZCkUgyN3Ztp6Uos1TdTSCWSvnRKpJphZfK/U3mRfo55JF82q
	 JGmQpa7Pnv8qfrFWoPLqxhbIfuC8CLZu7v/M+aQtCp61Ig5+9CIwe5hf8jcB+e4r+l
	 Km8tRg066y+aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 4/5] NFSD: Initialize struct nfsd4_copy earlier
Date: Mon, 18 Nov 2024 23:36:21 -0500
Message-ID: <20241118211900.3808-5-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211900.3808-5-cel@kernel.org>
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
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:23:41.896354873 -0500
+++ /tmp/tmp.rnK3cOwU64	2024-11-18 23:23:41.891259346 -0500
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
+index 6637a7ef974b..c0f13989bd24 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1841,14 +1841,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1786,14 +1786,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
| stable/linux-6.1.y        |  Success    |  Success   |

