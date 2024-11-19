Return-Path: <stable+bounces-93984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FD9D25EF
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5E21F2416F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805ED1CACD9;
	Tue, 19 Nov 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSdxoi/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201D1BDABE
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019496; cv=none; b=MFdALYYqSImlYbHQ05ICknbXy3PCo1lrXiYAk1aRPFszhAxh3SyOAJgN+bTM/PijjQgDqmHrTvtBvJrEPp79H9I/FufZ/qx+ilVusX3m51DomCkZ37Buk/Qlgb+Y8gPhNEjWDHnOQ6nJ4OqU6eIHUL8ByKFOZqNUYGeFJ0b35u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019496; c=relaxed/simple;
	bh=/Nld003I2yXGwv3RvPd4oUqhz91Qdlmk7WaiDxVoiXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loYmjJTFLIm7NQ62TaAgtXYXwydp0KsJGDpUHKjn4qgUmrwLrXQMrKVzGB8ZCvINZOz2nYf6o7vj5/I1VyI5BmSFWTVco7TUab3ZP0RjTUWKy770zWZhaUr1cLCH1XJyTPKzQ/7zIj6YQrJxDLsj5DZjgFE0o18K7JPN2VwQwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSdxoi/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD1FC4CECF;
	Tue, 19 Nov 2024 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019494;
	bh=/Nld003I2yXGwv3RvPd4oUqhz91Qdlmk7WaiDxVoiXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSdxoi/6bTvRCqG0goWKMa0nDJK+Mi//UwLsdbeIgKg9WQPRbSiwv9cCspJ/ZGYKm
	 8NHL6r8dHUInfiF/VgnxeK4lFAwUXksMygcQrF6iqzPyhtsrnrTsjyPnmqIFjNbZqQ
	 dCl2mere980erW+sIG9l1vNUU0+BUB8oCHtDnod2oFk0tWZcTn3rJbCv9NvhgM8yOL
	 C+Wy2wJQ63Q36+iR4KQZJS72glxt63niZekAuCANc4Ja7OFJm0Td0AV0hxgsbNfK+C
	 eJNW5PtvkueNc+99Gd/GkWR9ZkeXohISNRGPPv3Edid2iHQEIlyiAklXvvVsjGFFeV
	 6L55ZIZy3QB8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 5/5] NFSD: Never decrement pending_async_copies on error
Date: Tue, 19 Nov 2024 07:31:32 -0500
Message-ID: <20241118212035.3848-10-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118212035.3848-10-cel@kernel.org>
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
| 5.15.y          |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 00:30:56.835091842 -0500
+++ /tmp/tmp.uWkVfqzE9j	2024-11-19 00:30:56.831399388 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 8286f8b622990194207df9ab852e0f87c60d35e9 ]
+
 The error flow in nfsd4_copy() calls cleanup_async_copy(), which
 already decrements nn->pending_async_copies.
 
@@ -9,10 +11,10 @@
  1 file changed, 1 insertion(+), 3 deletions(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 5fd1ce3fc8fb7..d32f2dfd148fe 100644
+index 6267a41092ae..0b698e25826f 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1845,10 +1845,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1791,10 +1791,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
| stable/linux-5.15.y       |  Success    |  Success   |

