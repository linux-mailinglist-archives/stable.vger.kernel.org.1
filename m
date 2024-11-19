Return-Path: <stable+bounces-93965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5AA9D25DD
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7823B295D6
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50051CC17D;
	Tue, 19 Nov 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F49amnNh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B011CC174
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019457; cv=none; b=tdgWjC/Q8xEcZdWJqa74bEA9CkkRlQBLkT0Wbc0vGMjbrCgLCvq5ehiPN05E7cy645K6tV+xbBCplSfdR4cwtCIzUkz4lTvwJ/Qv6fKI+6uKugbtYhJefMIHOSZD8fqCBpn67w6Kftpwjb7G09XrCAVb43Rp4LtSFO20d8A0Vwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019457; c=relaxed/simple;
	bh=QyWjT85MOMWRMABcaPj+vodgRcSlwxmtr+XzjXx1W8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6zYvzx/8rlnhuEXfxfpSa1Y0jPAMLlRP3kqG8cmx0R507wvjHoOw+6hL7U55nCJFH0wwaWiNbcbSoRR2dXoyZq2fAq7Tpfo3fJArZxrWPfcR0xPVEqmyWptc+TzCMOLsBBv1vszlIG5mOShyxsW4oZ9TkWoyHT0zdLpNpqeTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F49amnNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FD4C4CECF;
	Tue, 19 Nov 2024 12:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019457;
	bh=QyWjT85MOMWRMABcaPj+vodgRcSlwxmtr+XzjXx1W8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F49amnNhAFF11FNoVaViX46sglYxXdLrSnreBcvP52SLFxwxnrdft4SEOMSCPa6P3
	 YWfgOyGL70uBSVxUDUOsI9MK1afTFtAJ6j/u7mi4SF+Uv8Q0qYVBUqwRUmM7F82bVD
	 O8FVyHy8Fe6FvUf+wMc0tRlA7s1ZCnkJ0dlxpxrE/LyCJSFfaJrfJd+JXZ28chfxzh
	 79KOP+7PPoFvlquLSR4+8o31SoizOVCjTXxc7xkpCUOc4+FUwL/RxEZUCS+Vz8pB4+
	 TLVkxaco5AbkOezpgbrvKaJdXnFhEYMDT4ZWZdlkp4BVOx03+H3z4hyzyd8fgMLneL
	 YnxXlMbw0UNoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 5/5] NFSD: Never decrement pending_async_copies on error
Date: Tue, 19 Nov 2024 07:30:55 -0500
Message-ID: <20241118212343.3935-6-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118212343.3935-6-cel@kernel.org>
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
--- -	2024-11-19 00:52:27.986555873 -0500
+++ /tmp/tmp.B39I9zfOoW	2024-11-19 00:52:27.981078429 -0500
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

