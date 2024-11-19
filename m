Return-Path: <stable+bounces-93976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE3E9D25E7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539DC28555C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D61CBE95;
	Tue, 19 Nov 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORby+o/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43E1CBEA7
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019478; cv=none; b=sbmPtjGqXX5bSAw/XB4G3jZ4CxjvLjoCuGwj8Qfq5R2W8+PAhnlD7C4nl28CvC/8UUb/FtYFSRh/RCtY+RgsaKl4yiSrZRiRG+mMW06sFy3cgrBVNKf04nxTJ3XMSihHtMzCGpLlaqh9y8QiDHVSkq01caHku61Lje48TI2ARO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019478; c=relaxed/simple;
	bh=4o22Gn4RnLOpEFjmzxE4YqslY+WjN+zjLysdloOx1jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQt7CQrNj/QFMkO2zCsoUf4KQMTtHX53Ueaj9nPZRx5usZnRopibD9c5wl9EOtqpM4+bWwWJdT6W3DlsjCJaNDaHd8qB5bbQIW5B429GQFev6jvN1kEQZJx8fJMpUk4wYSSzG2hZZQdPatPA8ENHjW2bsF0A4IUEfgdxbDvQ+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORby+o/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83D2C4CECF;
	Tue, 19 Nov 2024 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019478;
	bh=4o22Gn4RnLOpEFjmzxE4YqslY+WjN+zjLysdloOx1jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORby+o/+i+GDwTgQJ/9HrwmI5+lJswZOB2v5pW5FQ9p/lZhhPWRVf0mcEDyL2E3Oi
	 kbP0IkxLecAU0VaR1NXi52r+Rg2fEEr6/NEZOsJ/vvKmEBFckQuH7PvetU+St3vY3H
	 YNjTEucY041Povk6gpDjGcGcJX2VXCWF+PGOlhs1nOafplhhPGKdU0Uf1kI7v9Rcrf
	 a14UHpmEByXqTwPY9dtXUUD3I3dqqGU5yVi0kO9cQtVZHbKThcO4I09hM2pWRCRq3p
	 /fjdL+nktrh7Tw+2N3EJywoMIvDPfdYguSnRSv/vjZLtBcTgZmYJIfI2/dtzDFuShK
	 zaCxL7Tyd5Y5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 5/5] NFSD: Never decrement pending_async_copies on error
Date: Tue, 19 Nov 2024 07:31:16 -0500
Message-ID: <20241118211413.3756-6-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211413.3756-6-cel@kernel.org>
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
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:59:31.421354519 -0500
+++ /tmp/tmp.lcSzHSawOv	2024-11-18 23:59:31.413848668 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 8286f8b622990194207df9ab852e0f87c60d35e9 ]
+
 The error flow in nfsd4_copy() calls cleanup_async_copy(), which
 already decrements nn->pending_async_copies.
 
@@ -9,10 +11,10 @@
  1 file changed, 1 insertion(+), 3 deletions(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 5fd1ce3fc8fb7..d32f2dfd148fe 100644
+index 444f68ade80c..d64f792964e1 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1845,10 +1845,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1820,10 +1820,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
| stable/linux-6.6.y        |  Success    |  Success   |

